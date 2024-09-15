use practice;

/*************** 비교 연산자 ***************/
/* = */
select *
from customer
where gender = 'man';

/* <> */
select *
from customer
where gender <> 'man';

/* >= */
select *
from customer
where year(join_date) >= 2020;

/* <= */
select *
from customer
where year(join_date) <= 2020;

/* > */
select *
from customer
where year(join_date) > 2020;

/* < */
select *
from customer
where year(join_date) < 2020;



/*************** 논리 연산자 ***************/
/* AND */
select *
from customer
where gender = 'man'
and addr = 'Gyeonggi';

/* NOT */
select *
from customer
where not gender = 'man'
and addr = 'Gyeonggi';

/* OR */
select *
from customer
where gender = 'man'
or addr = 'Gyeonggi';



/*************** 특수 연산자 ***************/
/* BETWEEN AND */
select *
from customer
where year(birthday) between 2010 and 2011;

/* NOT BETWEEN AND */
select *
from customer
where year(birthday) not between 2010 and 2011;

/* IN */
select *
from customer
where year(birthday) in (2010, 2011);

/* NOT IN */
select *
from customer
where year(birthday) not in (2010, 2011);

/* LIKE */
select *
from customer
where addr like 'D%'; /* ~로 시작하는 */

select *
from customer
where addr like '%N'; /* ~로 끝나는 */

select *
from customer
where addr like '%EO%'; /* ~를 포함하는 */

/* NOT LIKE */
select *
from customer
where addr not like '%EO%'; /* ~를 제외하는 */

/* IS NULL */
select *
from customer as A
left join sales as B
on A.mem_no = B.mem_no
where B.mem_no is null;

/* IS NOT NULL */
select *
from customer as A
left join sales as B
on A.mem_no = B.mem_no
where B.mem_no is not null;



/*************** 산술 연산자 ***************/
select *
		, A. sales_qty * price as 결제금액
from sales as A
left join product as B
on A.product_code = B.product_code;



/*************** 집합 연산자 ***************/
create temporary table sales_2019
select *
from sales
where year(order_date) = '2019';

/* UNION */
select *
from sales_2019
union
select *
from sales;

/* UNION ALL */
select *
from sales_2019
union all
select *
from sales;