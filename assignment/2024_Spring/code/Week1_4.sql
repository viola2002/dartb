/* PRACTICE 데이터베이스 사용 */
USE practice;

/********** 테이블 생성 (CREATE)  **********/
/* (회원테이블 존재할 시, 회원테이블 삭제) */
drop table 회원테이블;

/* 회원테이블 생성 */
create table 회원테이블 (
회원번호 int primary key,
이름 varchar(20),
가입일자 date not null,
수신동의 bit
);

/* 회원테이블 조회 */
select * from 회원테이블;



/********** BEGIN + 취소(ROLLBACK)  **********/
/* 트랜젝션 시작 */
begin;

/* 데이터 삽입 */
insert into 회원테이블 values (1001, '홍길동', '2020-01-02', 1);

/* 회원테이블 조회 */
select * from 회원테이블;

/* 취소 */
rollback;

/* 회원테이블 조회 */
select * from 회원테이블;



/********** BEGIN + 실행(COMMIT)  **********/
/* 트랜젝션 시작 */
begin;

/* 데이터 삽입 */
insert into 회원테이블 values (1005, '장보고', '2020-01-06', 1);

/* 실행 */
commit;

/* 회원테이블 조회 */
select * from 회원테이블;



/********** 임시 저장(SAVEPOINT)  **********/
/* (회원테이블에 데이터 존재할 시, 데이터 모두 삭제) */
delete from 회원테이블;

/* 회원테이블 조회 */
select * from 회원테이블;

/* 트랜젝션 시작 */
begin;

/* 데이터 삽입 */
insert into 회원테이블 values (1005, '장보고', '2020-01-06', 1);

/* savepoint 지정 */
savepoint S1;

/* 1005 회원 이름 수정 */
update 회원테이블
set 이름 = '이순신';

/* savepoint 지정 */
savepoint S2;

/* 1005 회원 데이터 삭제 */
delete from 회원테이블;

/* savepoint 지정 */
savepoint S3;

/* 회원테이블 조회 */
select * from 회원테이블;

/* savepoint S2 저장점으로 rollback */
rollback to S2;

/* 회원테이블 조회 */
select * from 회원테이블;

/* 실행 */
commit;

/* 회원테이블 조회 */
select * from 회원테이블;