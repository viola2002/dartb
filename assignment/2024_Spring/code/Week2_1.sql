use practice;

/***************** FROM *****************/
/* customer 테이블 모든 열 조회 */
select * from customer;

/***************** WHERE *****************/
/* 성별이 남성 조건으로 필터링 */
select * 
	from customer
    where gender = 'man';

/***************** GROUP BY *****************/
/* 지역 별로 회원 수 집계 */
select addr
		,count(mem_no) as 회원수 /* COUNT: 행들의 개수를 구하는 집계함수 */
	from customer
    where gender = 'man'
    group by addr;
    
/***************** HAVING *****************/
/* 집계 회원수 100명 미만 조건으로 필터링 */
select addr
		,count(mem_no) as 회원수
	from customer
    where gender = 'man'
    group by addr
    having count(mem_no) < 100; /* 비교 연산자 사용 */
    
/***************** ORDER BY *****************/
/* 집계 회원수가 높은 순으로 */
select addr
		,count(mem_no) as 회원수
	from customer
    where gender = 'man'
    group by addr
    having count(mem_no) < 100
    order by count(mem_no) desc; /* desc: 내림차순 asc: 오름차순 */


/***************** FROM -> (WHERE) -> GROUP BY *****************/
/* FROM -> GROUP BY 순으로 작성 가능 */
select addr, count(mem_no) as 회원수
from customer
/* where gender = 'man' */
group by addr;

/***************** GROUP BY + 집계함수 *****************/
/* 거주지역을 '서울', '인천' 조건으로 필터링 */
/* 거주지역와 성별로 회원수 집계 */
select addr, gender, count(mem_no) as 회원수
from customer
where addr in ('seoul', 'incheon')
group by addr, gender; /* in: 특수 연산자 */

/* group by에 있는 열들을 select에도 작성해야 원하는 분석 결과를 확인할 수 있습니다. */
select gender
		,count(mem_no) as 회원수
from customer
where addr in ('seoul', 'incheon')
group by addr, gender;