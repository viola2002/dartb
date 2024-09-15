use practice;

/******************** 회원 프로파일 분석 ********************/
/***** 회원 프로파일 분석용 데이터 마트 *****/
create table customer_profile as
select A.*
		,date_format(join_date, '%Y-%m') as 가입년월
        
        ,2024 - year(birthday) + 1 as 나이
        ,case when 2024 - year(birthday) + 1 < 20 then '10대 이하'
			  when 2024 - year(birthday) + 1 < 30 then '20대'
              when 2024 - year(birthday) + 1 < 40 then '30대'
              when 2024 - year(birthday) + 1 < 50 then '40대'
              else '50대 이상' end as 연령대
		
        ,case when B.mem_no is not null then '구매'
              else '미구매' end as 구매여부
from customer as A
left join (
		   select distinct mem_no /* distinct로 중복 제거 */
           from sales
		  )as B
on A.mem_no = B.mem_no;

/* 확인 */
select * from customer_profile;


/* 1. 가입년월별 회원수 */
select 가입년월
	   ,count(mem_no) as 회원수
from customer_profile
group by 가입년월;

/* 2. 성별 평균 연령 & 성별 및 연령대별 회원수 */
select gender as 성별
	   ,avg(나이) as 평균나이
from customer_profile
group by gender;

select gender as 성별
	   ,연령대
       ,count(mem_no) as 회원수
from customer_profile
group by gender, 연령대
order by gender, 연령대;

/* 3. 성별 및 연령대별 회원수(+구매여부) */
select gender as 성별
	   ,연령대
       ,구매여부
       ,count(mem_no) as 회원수
from customer_profile
group by gender, 연령대, 구매여부
order by 구매여부, gender, 연령대;