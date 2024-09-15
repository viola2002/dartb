use practice;

/******************** 제품 성장률 분석 ********************/
/***** 제품 성장률 분석용 데이터 마트 *****/
create table product_growth as
select A.mem_no
	   ,B.category
       ,B.brand
       ,A.sales_qty * B.price as 구매금액
       ,case when date_format(order_date, '%Y-%m') between '2020-01' and '2020-03' then '2020_1분기'
			 when date_format(order_date, '%Y-%m') between '2020-04' and '2020-06' then '2020_2분기'
             end as 분기
from sales as A
left join product as B
on A.product_code = B.product_code
where date_format(order_date, '%Y-%m') between '2020-01' and '2020-06';

/* 확인 */
select * from product_growth;



/* 1. 카테고리별 구매금액 성장률(2020년 1분기 -> 2020년 2분기) */
select *
	   ,2020_2분기_구매금액 / 2020_1분기_구매금액 - 1 as 성장률
from (
	  select category
			 ,sum(case when 분기 = '2020_1분기' then 구매금액 end) as 2020_1분기_구매금액
             ,sum(case when 분기 = '2020_2분기' then 구매금액 end) as 2020_2분기_구매금액
	  from product_growth
      group by category
	 )as A
order by 4 desc;

/* 2. Beauty 카테고리 중, 브랜드별 구매지표 */
select brand
	   ,count(distinct mem_no) as 구매자수
       ,sum(구매금액) as 구매금액_합계
       ,sum(구매금액) / count(distinct mem_no) as 인당_구매금액
from product_growth
where category = 'beauty'
group by brand
order by 4 desc;