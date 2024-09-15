use practice;

/******************** 회원 분석용 데이터 마트 ********************/
/********** 회원 구매정보 **********/
/* 회원 구매정보 */
select A.mem_no, A.gender, A.birthday, A.addr, A.join_date
		, sum(B.sales_qty * C.price) as 구매금액
        , count(B.order_no) as 구매횟수
        , sum(B.sales_qty) as 구매수량
from customer as A
left join sales as B
on A.mem_no = B.mem_no
left join product as C
on B.product_code = C.product_code
group by A.mem_no, A.gender, A.birthday, A.addr, A.join_date;

/* 회원 구매정보 임시테이블 */
create temporary table customer_pur_info as
select A.mem_no, A.gender, A.birthday, A.addr, A.join_date
		, sum(B.sales_qty * C.price) as 구매금액
        , count(B.order_no) as 구매횟수
        , sum(B.sales_qty) as 구매수량
from customer as A
left join sales as B
on A.mem_no = B.mem_no
left join product as C
on B.product_code = C.product_code
group by A.mem_no, A.gender, A.birthday, A.addr, A.join_date;

/* 확인 */
select * from customer_pur_info;


/********** 회원 연령대 **********/
/* 생년월일 -> 나이 */
select *
		, 2024 - year(birthday) + 1 as 나이
from customer;

/* 생년월일 -> 나이 -> 연령대 */
select *
		, case when 나이 < 10 then '10대 미만'
			   when 나이 < 20 then '10대'
               when 나이 < 30 then '20대'
               when 나이 < 40 then '30대'
               when 나이 < 50 then '40대'
               else '50대 이상' end as 연령대
from (
	  select *
				, 2024 - year(birthday) + 1 as 나이
	  from customer
      )as A;
      
/* CASE WHEN 함수 사용시 주의점 (순차적) */
select *
		, case when 나이 < 50 then '40대'
			   when 나이 < 10 then '10대 미만'
			   when 나이 < 20 then '10대'
               when 나이 < 30 then '20대'
               when 나이 < 40 then '30대'
               else '50대 이상' end as 연령대
from (
	  select *
				, 2024 - year(birthday) + 1 as 나이
	  from customer
      )as A;

/* 회원 연령대 임시테이블 */
create temporary table customer_ageband as
select *
		, case when 나이 < 10 then '10대 미만'
			   when 나이 < 20 then '10대'
               when 나이 < 30 then '20대'
               when 나이 < 40 then '30대'
               when 나이 < 50 then '40대'
               else '50대 이상' end as 연령대
from (
	  select *
				, 2024 - year(birthday) + 1 as 나이
	  from customer
      )as A;
      
/* 확인 */
select * from customer_ageband;


/********** 회원 구매정보 + 연령대 임시테이블 **********/
create temporary table customer_pur_info_ageband as
select A.*
		, B.연령대
from customer_pur_info as A
left join customer_ageband as B
on A.mem_no = B.mem_no;

/* 확인 */
select * from customer_pur_info_ageband;


/********** 회원 선호 카테고리 **********/
/* 회원 및 카테고리별 구매횟수 순위 */
select A.mem_no
		, B.category
        , count(A.order_no) as 구매횟수
        , row_number() over(partition by A.mem_no order by count(A.order_no) desc) as 구매횟수_순위
from sales as A
left join product as B
on A.product_code = B.product_code
group by A.mem_no, B.category;

/* 회원 및 카테고리별 구매횟수 순위 + 구매횟수 순위 1위만 필터링 */
select *
from (
	 select A.mem_no
			, B.category
            , count(A.order_no) as 구매횟수
            , row_number() over(partition by A.mem_no order by count(A.order_no) desc) as 구매횟수_순위
	 from sales as A
     left join product as B
     on A.product_code = B.product_code
     group by A.mem_no, B.category
     )as A
where 구매횟수_순위 = 1;

/* 회원 선호 카테고리 임시테이블 */
create temporary table customer_pre_category as
select *
from (
	 select A.mem_no
			, B.category
            , count(A.order_no) as 구매횟수
            , row_number() over(partition by A.mem_no order by count(A.order_no) desc) as 구매횟수_순위
	 from sales as A
     left join product as B
     on A.product_code = B.product_code
     group by A.mem_no, B.category
     )as A
where 구매횟수_순위 = 1;

/* 확인 */
select * from customer_pre_category;

/********** 회원 구매정보 + 연령대 + 선호 카테고리 임시테이블 **********/
create temporary table customer_pur_info_ageband_pre_category as
select A.*
		, B. category as pre_category
from customer_pur_info_ageband as A
left join customer_pre_category as B
on A.mem_no = B.mem_no;

/* 확인 */
select * from customer_pur_info_ageband_pre_category;


/********** 회원 분석용 데이터 마트 생성 (회원 구매정보 + 연령대 + 선호 카테고리 임시테이블) **********/
create table customer_mart as
select *
from customer_pur_info_ageband_pre_category;

/* 확인 */
select * from customer_mart;



/******************** 데이터 정합성 ********************/
/********** 회원 수의 중복은 없는가? **********/
select *
from customer_mart;

select count(mem_no)
		, count(distinct(mem_no))
from customer_mart;


/********** 요약 변수 및 파생 변수의 오류는 없는가? **********/
select *
from customer_mart;

/* 회원(1000005)의 구매정보 */
/* 구매금액: 408000, 구매횟수: 3, 구매수량: 14 */
select sum(A.sales_qty * B.price) as 구매금액
		, count(A.order_no) as 구매횟수
        , sum(A.sales_qty) as 구매수량
from sales as A
left join product as B
on A.product_code = B.product_code
where mem_no = '1000005';

/* 회원(1000005)의 선호 카테고리 */
/* pre_category: home */
select *
from sales as A
left join product as B
on A.product_code = B.product_code
where mem_no = '1000005';


/********** 구매자 비중(%)의 오류는 없는가? **********/
/* customer 테이블 기준, sales 테이블 구매 회원번호 LEFT JOIN */
select *
from customer as A
left join (
			select distinct mem_no
            from sales
            )as B
on A.mem_no = B.mem_no;

/* 구매여부 추가 */
select *
		, case when B.mem_no is not null then '구매'
			   else '미구매' end as 구매여부
from customer as A
left join (
			select distinct mem_no
            from sales
            )as B
on A.mem_no = B.mem_no;

/* 구매여부별 회원수 */
select 구매여부
		, count(mem_no) as 회원수
from (
	  select A.*
				, case when B.mem_no is not null then '구매'
			   else '미구매' end as 구매여부
	  from customer as A
      left join (
				select distinct mem_no
				from sales
				)as B
	  on A.mem_no = B.mem_no
      )as A
group by 구매여부;

/* 확인(미구매: 1459, 구매: 1202) */
select *
from customer_mart
where 구매금액 is null;

select *
from customer_mart
where 구매금액 is not null;