use practice;

/******************** RFM 분석 ********************/
/***** RFM 프로파일 분석용 데이터 마트 *****/
create table RFM as
select A.*
	   ,B.구매금액
	   ,B.구매횟수
from customer as A
left join (
		   select A.mem_no
                  ,sum(A.sales_qty * B.price) as 구매금액 /* monetary */
                  ,count(A.order_no) as 구매횟수 /* frequency */
           from sales as A
           left join product as B
           on A.product_code = B.product_code
           where year(A.order_date) = '2020' /* recency */
           group by A.mem_no
		  )as B
on A.mem_no = B.mem_no;

/* 확인 */
select * from RFM;



/* 1. RFM 세분화별 회원수 */
select *
	   ,case when 구매금액 > 5000000 then 'VIP'
             when 구매금액 > 1000000 or 구매횟수 > 3 then '우수회원'
             when 구매금액 > 0 then '일반회원'
             else '잠재회원' end as 회원세분화
from RFM;

select 회원세분화
	   ,count(mem_no) as 회원수
from (
	  select *
		     ,case when 구매금액 > 5000000 then 'VIP'
             when 구매금액 > 1000000 or 구매횟수 > 3 then '우수회원'
             when 구매금액 > 0 then '일반회원'
             else '잠재회원' end as 회원세분화
	  from RFM
	 )as A
group by 회원세분화
order by 회원수 asc;

/* 2. RFM 세분화별 매출액 */
select 회원세분화
	   ,sum(구매금액) as 구매금액
from (
	  select *
		     ,case when 구매금액 > 5000000 then 'VIP'
             when 구매금액 > 1000000 or 구매횟수 > 3 then '우수회원'
             when 구매금액 > 0 then '일반회원'
             else '잠재회원' end as 회원세분화
	  from RFM
	 )as A
group by 회원세분화
order by 구매금액 desc;

/* 3. RFM 세분화별 인당 구매금액 */
select 회원세분화
	   ,sum(구매금액) / count(mem_no) as 인당_구매금액
from (
	  select *
		     ,case when 구매금액 > 5000000 then 'VIP'
             when 구매금액 > 1000000 or 구매횟수 > 3 then '우수회원'
             when 구매금액 > 0 then '일반회원'
             else '잠재회원' end as 회원세분화
	  from RFM
	 )as A
group by 회원세분화
order by 인당_구매금액 desc;