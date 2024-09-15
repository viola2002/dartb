use practice;

/******************** 단원 정리 ********************/
/*************** 연산자 및 함수 ***************/
/* 1. customer 테이블을 활용하여, 가입일지가 2019년이며 생일이 4~6월생인 회원수를 조회하시오. */
select count(mem_no)
from customer
where year(join_date) = 2019
and month(birthday) between 4 and 6;

/* 2. sales와 product 테이블을 활용하여, 1회 주문시 평균 구매금액을 구하시오. (비회원 9999999 제외) */
select A.mem_no
		, avg(A.sales_qty * B.price) as 평균_구매금액
from sales as A
left join product as B
on A.product_code = B.product_code
where A.mem_no <> '9999999'
group by A.mem_no;

/* 3. sales 테이블을 활용하여, 구매수량이 높은 상위 10명을 조회하시오. (비회원 9999999 제외) */
select *
from (
	  select mem_no
			 , sum(sales_qty) as 구매수량
			 , row_number() over (order by sum(sales_qty) asc) as 구매수량_순위
	  from sales
	  where mem_no <> '9999999'
	  group by mem_no
      ) as A
where 구매수량_순위 <= 10;



/*************** View 및 Procedure ***************/
/* 1. view를 활용하여, sales 테이블 기준으로 customer 및 product 테이블을 left join 결합한 가상 테이블을 생성하시오. */
/* 열은 sales 테이블의 모든 열 + customer 테이블의 gender + product 테이블의 brand */
create view sales_gender_brand as
select A.*
		, B.gender
        , C.brand
from sales as A
left join customer as B
on A.mem_no = B.mem_no
left join product as C
on A.product_code = C.product_code;

/* 확인 */
select * from sales_gender_brand;

/* 2. procedure를 활용하여, customer의 몇월부터 몇월까지의 생일인 회원을 조회하는 작업을 저장하시오. */
delimiter //
create procedure cst_birth_month_in( in input_A int, input_B int )
begin
	select *
    from customer
    where month(birthday) between input_A and input_B;
end //
delimiter ;

/* 확인 */
call cst_birth_month_in(3, 4);



/*************** 데이터 마트 ***************/
/* 1. sales 및 product 테이블을 활용하여, sales 테이블 기준으로 product 테이블을 left join 결합한 테이블을 생성하시오 */
/* 열은 sales 테이블의 모든 열 + product 테이블의 category, type + sales_qty * price 구매금액 */
create table sales_mart as
select A.*
		, B.category
        , B.type
        , A.sales_qty * B.price as 구매금액
from sales as A
left join product as B
on A.product_code = B.product_code;

/* 확인 */
select *
from sales_mart;

/* 2. (1)에서 생성한 데이터 마트를 활용하여, category 및 type별 구매금액 합계를 구하시오. */
select category
		, type
        , sum(구매금액) as 구매금액_합계
from sales_mart
group by category
			, type;