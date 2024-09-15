use practice;

/*************** SQL 데이터 분석 단원 정리 ***************/
/***** SQL 데이터 분석 단원 분석용 데이터 마트 *****/
create table sql_data_analysis as
select A.*

	   /* 1. 회원 프로파일 분석용 */		
	   ,date_format(A.join_date, '%Y-%m') as 가입년월
	   ,2024 - year(A.birthday) + 1 as 나이
	   ,case when 2024 - year(A.birthday) + 1 < 20 then '10대 이하'
			 when 2024 - year(A.birthday) + 1 < 30 then '20대'
			 when 2024 - year(A.birthday) + 1 < 40 then '30대'
			 when 2024 - year(A.birthday) + 1 < 50 then '40대'
			 else '50대 이상' end as 연령대
        ,case when C.mem_no is not null then '구매'
              else '미구매' end as 구매여부
        
        /* 2. RFM 분석용 */
        ,B.구매금액 as 2020_구매금액
	    ,B.구매횟수 as 2020_구매횟수
        ,case when B.구매금액 > 5000000 then 'VIP'
              when B.구매금액 > 1000000 or B.구매횟수 > 3 then '우수회원'
              when B.구매금액 > 0 then '일반회원'
              else '잠재회원' end as 2020_회원세분화

		/* 3. 재구매율 및 구매주기 분석용 */
		,case when date_add(C.최초구매일자, interval + 1 day) <= C.최근구매일자 then 'Y' else 'N' end as 재구매여부
	    ,datediff(C.최근구매일자, C.최초구매일자) as 구매간격
        ,case when C.구매횟수 - 1 = 0 or datediff(C.최근구매일자, C.최초구매일자) = 0 then 0
			  else datediff(C.최근구매일자, C.최초구매일자) / (C.구매횟수 - 1) end as 구매주기
from customer as A
left join (
		   /* 1. RFM 분석용 */
           select A.mem_no
                  ,sum(A.sales_qty * B.price) as 구매금액 /* monetary */
                  ,count(A.order_no) as 구매횟수 /* frequency */
           from sales as A
           left join product as B
           on A.product_code = B.product_code
           where year(A.order_date) = '2020' /* recency */
           group by A.mem_no
		  )as B
on A.mem_no = B.mem_no
left join (
		   /* 2. 재구매율 및 구매주기 분석용 */
           select mem_no
				  ,min(order_date) as 최초구매일자
				  ,max(order_date) as 최근구매일자
				  ,count(order_no) as 구매횟수
		   from sales
		   group by mem_no
		  )as C
on A.mem_no = C.mem_no;
           
/* 확인 */
select * from sql_data_analysis;

/* 데이터 마트 정합성 체크 */
select count(distinct mem_no)
	   ,count(mem_no)
from sql_data_analysis;

  

/***** 회원 프로파일 분석 *****/
/* 1. 가입년월별 회원수 */
select 가입년월
	   ,count(mem_no) as 회원수
from sql_data_analysis
group by 가입년월;

/* 2. 성별 평균 연령 / 성별 및 연령대별 회원수 */
select gender as 성별
	   ,avg(나이) as 평균나이
from sql_data_analysis
group by gender;

select gender as 성별
	   ,연령대
       ,count(mem_no) as 회원수
from sql_data_analysis
group by gender, 연령대
order by gender, 연령대;

/* 3. 성별 및 연령대별 회원수(+구매여부) */
select gender as 성별
	   ,연령대
       ,구매여부
       ,count(mem_no) as 회원수
from sql_data_analysis
group by gender, 연령대, 구매여부
order by 구매여부, gender, 연령대;

  

/***** RFM 분석 *****/
/* 1. RFM 세분화별 회원수 */
select 2020_회원세분화
	   ,count(mem_no) as 회원수
from sql_data_analysis
group by 2020_회원세분화
order by 회원수 asc;
    
/* 2. RFM 세분화별 매출액 */
select 2020_회원세분화
	   ,sum(2020_구매금액) as 구매금액
from sql_data_analysis
group by 2020_회원세분화
order by 구매금액 desc;

/* 3. RFM 세분화별 인당 구매금액 */
select 2020_회원세분화
	   ,sum(2020_구매금액) / count(mem_no) as 인당_구매금액
from sql_data_analysis
group by 2020_회원세분화
order by 인당_구매금액 desc;


/***** 재구매율 및 구매주기 분석 *****/
/* 1. 재구매 회원수 비중(%) */
select count(distinct case when 구매여부 = '구매' then mem_no end) as 구매회원수
	   ,count(distinct case when 재구매여부='Y' then mem_no end) as 재구매회원수
from sql_data_analysis;

/* 2. 평균 구매주기 및 구매주기 구간별 회원수 */
select avg(구매주기)
from sql_data_analysis
where 구매주기 > 0;

select *
	   ,case when 구매주기 <= 7 then '7일 이내'
			 when 구매주기 <= 14 then '14일 이내'
             when 구매주기 <= 21 then '21일 이내'
             when 구매주기 <= 28 then '28일 이내'
             else '29일 이후' end as 구매주기_구간
from sql_data_analysis
where 구매주기 > 0;

     
     
/***** 회원 프로파일 + RFM + 재구매율 및 구매주기 분석 *****/
/* 1. RFM 세분화별 평균 나이 및 구매주기 */
select 2020_회원세분화
	   ,avg(나이) as 평균_나이
       ,avg(case when 구매주기 > 0 then 구매주기 end) as 평균_구매주기
from sql_data_analysis
group by 2020_회원세분화;

/* 2. 연령대별 재구매 회원수 비중(%) */
select 연령대
	   ,count(distinct case when 구매여부 = '구매' then mem_no end) as 구매회원수
       ,count(distinct case when 재구매여부 = 'Y' then mem_no end) as 재구매회원수
from sql_data_analysis
group by 연령대;