/* PRACTICE 데이터베이스 사용 */
USE practice;

/********** 테이블 생성 (CREATE)  **********/
/* 회원테이블 생성 */
create table 회원테이블 (
회원번호 int primary key,
이름 varchar(20),
가입일자 date not null,
수신동의 bit
);



/********** 데이터 삽입  **********/
insert into 회원테이블 values (1001, '홍길동', '2020-01-02', 1);
insert into 회원테이블 values (1002, '이순신', '2020-01-03', 0);
insert into 회원테이블 values (1003, '장영실', '2020-01-04', 1);
insert into 회원테이블 values (1004, '유관순', '2020-01-05', 0);

/* 회원테이블 조회 */
select * from 회원테이블;



/********** 조건 위반  **********/
/* PRIMARY KEY 제약 조건 위반 */
insert into 회원테이블 values (1004, '장보고', '2020-01-06', 0);

/* NOT NULL 제약 조건 위반 */
insert into 회원테이블 values (1005, '장보고', null, 0);

/* 데이터 타입 조건 위반 */
insert into 회원테이블 values (1005, '장보고', 1, 0);



/********** 데이터 조회  **********/
/* 모든 열 조회 */
select *
from 회원테이블;

/* 특정 열 조회 */
select 회원번호
		, 이름
from 회원테이블;

/* 특정 열 이름 변경하여 조회 */
select 회원번호
		, 이름 as 성명
from 회원테이블;



/********** 데이터 수정  **********/
/* 모든 데이터 수정 */
update 회원테이블
set 수신동의 = 0;

/* 회원테이블 조회 */
select * from 회원테이블;

/* 특정 조건 데이터 수정 */
update 회원테이블
set 수신동의 = 1
where 이름 = '홍길동';

/* 회원테이블 조회 */
select * from 회원테이블;



/********** 데이터 삭제  **********/
/* 특정 데이터 삭제 */
delete
from 회원테이블
where 이름 = '홍길동';

/* 회원테이블 조회 */
select * from 회원테이블;

/* 모든 데이터 삭제 */
delete
from 회원테이블;

/* 회원테이블 조회 */
select * from 회원테이블;