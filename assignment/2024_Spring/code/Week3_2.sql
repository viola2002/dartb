use practice;

/*************** 단일 행 함수 ***************/
/***** 숫자형 함수 *****/
/* ABS */
select abs(- 200);

/* ROUND */
select round(2.18, 1);

/* SQRT */
select sqrt(9);


/***** 문자형 함수 *****/
/* LOWER, UPPER */
select lower('AB');
select upper('ab');

/* LEFT, RIGHT */
select left('AB', 1);
select right('AB', 1);

/* LENGTH */
select length('AB');


/***** 날짜형 함수 *****/
/* YEAR, MONTH, DAY */
select year('2022-12-31');
select month('2022-12-31');
select day('2022-12-31');

/* DATE_ADD */
select date_add('2022-12-31', interval -1 month);

/* DATEDIFF */
select datediff('2022-12-31', '2022-12-1');


/***** 형변환 함수 *****/
/* DATE_FORMAT */
select date_format('2022-12-31', '%m-%d-%y');
select date_format('2022-12-31', '%M-%D-%Y');

/* CAST */
select cast('2022-12-31 12:00:00' as date);


/***** 일반 함수 *****/
/* IF NULL */
select ifnull(null, 0);
select ifnull('null이 아님', 0);

/* CASE WHEN THEN ELSE END */
select *
		, case when gender = 'man' then '남성'
          else '여성' end
from customer;


/***** 함수 중첩 사용 *****/
select *
		, year(join_date) as 가입연도
		, length(year(join_date)) as 가입연도_문자수
from customer;



/*************** 복수 행 함수 ***************/
/***** 집계 함수 *****/
select count(order_no) as 구매횟수 /* 행수 */
		, count(distinct mem_no) as 구매자수 /* 중복 제거된 행수 */
        , sum(sales_qty) as 구매수량 /* 합계 */
        , avg(sales_qty) as 평균구매수량 /* 평균 */
        , max(order_date) as 최근구매일자 /* 최대 */
        , min(order_date) as 최초구매일자 /* 최소 */
from sales;

/***** 그룹 함수 *****/
/* WITH ROLLUP */
select year(join_date) as 가입연도
		, addr
        , count(mem_no) as 회원수
from customer
group by year(join_date), addr
with rollup;


/***** 집계 함수 + GROUP BY *****/
select mem_no
		, sum(sales_qty) as 구매수량
from sales
group by mem_no;



/*************** 윈도우 함수 ***************/
/***** 순위 함수 *****/
/* ROW_NUMBER, RANK, DENSE_RANK */
select order_date
		, row_number() over (order by order_date asc) as 고유한_순위_반환
        , rank() over (order by order_date asc) as 동일한_순위_반환
        , dense_rank() over (order by order_date asc) as 동일한_순위_반환_하나의등수
from sales;

/* 순위 함수 + PARTITION BY */
select mem_no
		, order_date
		, row_number() over (partition by mem_no order by order_date asc) as 고유한_순위_반환
        , rank() over (partition by mem_no order by order_date asc) as 동일한_순위_반환
        , dense_rank() over (partition by mem_no order by order_date asc) as 동일한_순위_반환_하나의등수
from sales;


/***** 집계 함수 (누적)  *****/
select  order_date
		, sales_qty
        , '-' as 구분
		, count(order_no) over (order by order_date asc) as 누적_구매횟수
        , sum(sales_qty) over (order by order_date asc) as 누적_구매수량
        , avg(sales_qty) over (order by order_date asc) as 누적_평균구매수량
        , max(sales_qty) over (order by order_date asc) as 누적_가장높은구매수량
        , min(sales_qty) over (order by order_date asc) as 누적_가장낮은구매수량
from sales;