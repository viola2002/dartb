/* PRACTICE 이름으로 데이터 베이스 생성 */
CREATE DATABASE practice;
/* PRACTICE 이름으로 데이터 베이스 사용 */
USE practice;


/********** 테이블 생성 (CREATE)  **********/
/* 회원테이블 생성 */
create table 회원테이블 (
회원번호 int primary key,
이름 varchar(20),
가입일자 date not null,
수신동의 bit
);
/* 기본키(primary key): 중복되어 나타날 수 없는 단일 값 + not null */
/* not null: null 허용하지 않음 */

/* 회원테이블 조회 */
select * from 회원테이블;



/********** 테이블 열 추가  **********/
/* 성별 열 추가 */
alter table 회원테이블 add 성별 varchar(2);

/* 회원테이블 조회 */
select * from 회원테이블;



/********** 테이블 열 데이터 타입 변경  **********/
/* 성별 열 타입 변경 */
alter table 회원테이블 modify 성별 varchar(20);



/********** 테이블 열 이름 변경  **********/
/* 성별 -> 성 열 이름 변경 */
alter table 회원테이블 change 성별 성 varchar(2);



/********** 테이블명 변경  **********/
/* 테이블명 변경 */
alter table 회원테이블 rename 회원정보;

/* 회원테이블 조회 --> 이름이 변경되었기 때문에 조회되지 않음 */
select * from 회원테이블;

/* 회원정보 조회 */
select * from 회원정보;



/********** 테이블 삭제  **********/
/* 테이블 삭제 */
drop table 회원정보;

/* 회원정보 조회 --> 삭제되었기 때문에 조회되지 않음 */
select * from 회원정보;