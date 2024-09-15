use practice;

/******************** 재구매율 및 구매주기 분석 ********************/
/***** 재구매율 및 구매주기 분석용 데이터 마트 *****/
create table re_pur_cycle as
select *
	   ,case when date_add(최초구매일자, interval + 1 day) <= 최근구매일자 then 'Y' else 'N' end as 재구매여부
       
	   ,datediff(최근구매일자, 최초구매일자) as 구매간격
       ,case when 구매횟수 - 1 = 0 or datediff(최근구매일자, 최초구매일자) = 0 then 0
			 else datediff(최근구매일자, 최초구매일자) / (구매횟수 - 1) end as 구매주기
from (
	  select mem_no
			 ,min(order_date) as 최초구매일자
             ,max(order_date) as 최근구매일자
			 ,count(order_no) as 구매횟수
	  from sales
	  where mem_no <> '9999999' /* 비회원 제외 */
	  group by mem_no
	 )as A;

/* 확인 */
select * from re_pur_cycle;

/* 회원(1000021)의 구매정보 */
/* 최초구매일자: 2019-05-07, 최근구매일자: 2019-05-21, 구매횟수: 3 */
select *
from re_pur_cycle
where mem_no = '1000021';

select *
from sales
where mem_no = '1000021';



/* 1. 재구매 회원수 비중(%) */
select count(distinct mem_no) as 구매회원수
	   ,count(distinct case when 재구매여부='Y' then mem_no end) as 재구매회원수
from re_pur_cycle;

/* 2. 평균 구매주기 및 구매주기 구간별 회원수 */
select avg(구매주기)
from re_pur_cycle
where 구매주기 > 0;

select *
	   ,case when 구매주기 <= 7 then '7일 이내'
			 when 구매주기 <= 14 then '14일 이내'
             when 구매주기 <= 21 then '21일 이내'
             when 구매주기 <= 28 then '28일 이내'
             else '29일 이후' end as 구매주기_구간
from re_pur_cycle
where 구매주기 > 0;

select 구매주기_구간
	   ,count(mem_no) as 회원수
from (
	  select *
			  ,case when 구매주기 <= 7 then '7일 이내'
					when 구매주기 <= 14 then '14일 이내'
					when 구매주기 <= 21 then '21일 이내'
					when 구매주기 <= 28 then '28일 이내'
					else '29일 이후' end as 구매주기_구간
	  from re_pur_cycle
	  where 구매주기 > 0
	 )as A
group by 구매주기_구간;