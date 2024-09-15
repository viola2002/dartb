use practice;

/***************** SELECT절 서브 쿼리 *****************/
/* select 명령문 안에 select 명령문 */
select *, (select gender from customer where A.mem_no = mem_no) as gender
from sales as A;

/* 확인 */
select *
from customer
where mem_no = '1000970';

/* SELECT절 서브 쿼리 vs 테이블 결합(JOIN) 처리 속도 비교 */
select A.*, B.gender
from sales as A
left join customer as B
on A.mem_no = B.mem_no;

/***************** FROM절 서브 쿼리 *****************/
/* from 명령문 안에 select 명령문 */
select *
from (
	  select mem_no, count(order_no) as 주문횟수
	  from sales
	  group by mem_no
	  ) as A;
/* FROM절 서브 쿼리: 열 및 테이블명 지정 */

/***************** WHERE절 서브 쿼리 *****************/
/* where 명령문 안에 select 명령문 */
select count(order_no) as 주문횟수
from sales
where mem_no in (select mem_no from customer where year(join_date) = 2019); /* year: 날짜형 변수 */

/* 연도 변환 */
select *, year(join_date)
from customer;

/* 리스트 */
select mem_no from customer where year(join_date) = 2019;

/* where절 서브 쿼리 vs 데이터 결합(JOIN) 결과 값 비교 */
select count(A.order_no) as 주문횟수
from sales as A
inner join customer as B
on A.mem_no = B.mem_no
where year(B.join_date) = 2019;



/***************** 서브 쿼리(Sub Query) + 테이블 결합(JOIN) *****************/
/* 임시테이블 생성 */
create temporary table sales_sub_query
select A.구매횟수, B.*
from (
	  select mem_no, count(order_no) as 구매횟수
      from sales
      group by mem_no
      ) as A
inner join customer as B
on A.mem_no = B.mem_no;

/* 성별이 남성 조건으로 필터링 */
select *
from sales_sub_query
where gender = 'man';

/* 거주지역별로 구매횟수 집계 */
select addr, sum(구매횟수) as 구매횟수
from sales_sub_query
where gender = 'man'
group by addr;

/* 모든 열 조회 */
/* 구매횟수가 낮은 순으로 */
select addr, sum(구매횟수) as 구매횟수
from sales_sub_query
where gender = 'man'
group by addr
having sum(구매횟수) < 100
order by sum(구매횟수) asc;