use practice;

/***************** INNER JOIN *****************/
/* customer + sales inner join */
select * from customer as A
inner join sales as B
on A.mem_no = B.mem_no; /* customer 및 sales 테이블은 mem_no(회원번호) 기준으로 1:N 관계 */

select * from customer as A
inner join sales as B
on A.mem_no = B.mem_no
where A.mem_no = '1000970';

/***************** LEFT JOIN *****************/
/* customer + sales left join */
select * from customer as A
left join sales as B
on A.mem_no = B.mem_no; /* NULL은 회원가입만 하고 주문은 하지 않은 회원 의미 */

/***************** RIGHT JOIN *****************/
/* customer + sales right join */
select * from customer as A
right join sales as B
on A.mem_no = B.mem_no
where A.mem_no is null; /* 회원번호(9999999)는 비회원 */
/* is null: 비교 연산자 */


    
/***************** 테이블 결합(JOIN) + 데이터 조회(SELECT) *****************/
/* 회원(customer) 및 주문(sales) 테이블 INNER JOIN 결합 */
select *
from customer as A
inner join sales as B
on A.mem_no = B.mem_no;

/* 임시테이블 생성 */
create temporary table customer_sales_inner_join
select A.*, B.order_no
from customer as A
inner join sales as B
on A.mem_no = B.mem_no;

/* 임시테이블 조회 */
select * from customer_sales_inner_join;

/* 성별이 남성 조건으로 필터링 */
select *
from customer_sales_inner_join
where gender = 'man';

/* 거주지역별로 구매 횟수 집계 */
select addr, count(order_no) as 구매횟수
from customer_sales_inner_join
where gender = 'man'
group by addr;

/* 구매 횟수 100회 미만 조건으로 필터링 */
select addr, count(order_no) as 구매횟수
from customer_sales_inner_join
where gender = 'man'
group by addr
having count(order_no) < 100;

/* 구매 횟수 낮은 순으로 모든 열 조회 */
select addr, count(order_no) as 구매횟수
from customer_sales_inner_join
where gender = 'man'
group by addr
having count(order_no) < 100
order by count(order_no) asc;



/***************** 3개 이상 테이블 결합 *****************/
/* sales 기준으로 customer 및 product LEFT JOIN 결합 */
select *
from sales as A
left join customer as B
on A.mem_no = B.mem_no
left join product as C
on A.product_code = C.product_code;