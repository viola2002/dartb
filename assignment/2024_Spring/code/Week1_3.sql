/********** 사용자 확인  **********/
/* MYSQL 데이터베이스 사용 */
USE MYSQL;

/* 사용자 확인 */
select * from user;



/********** 사용자 추가  **********/
/* 사용자 아이디 및 비밀번호 생성 */
create user 'test'@localhost identified by 'test';

/* 사용자 확인 */
select * from user;

/* 사용자 비밀번호 변경 */
set password for 'test'@localhost = '1234';



/********** 권한 부여 및 제거  **********/
/** 권한: CREATE, ALTER, DROP, INSERT, DELETE, UPDATE, SELECT 등 **/

/* 특정 권한 부여 */
grant select, delete on practice.회원테이블 to 'test'@localhost;

/* 특정 권한 제거 */
revoke delete on practice.회원테이블 from 'test'@localhost;

/* 모든 권한 부여 */
grant all on practice.회원테이블 to 'test'@localhost;

/* 모든 권한 제거 */
revoke all on practice.회원테이블 from 'test'@localhost;



/********** 사용자 삭제  **********/
/* 사용자 삭제 */
drop user 'test'@localhost;

/* 사용자 확인 */
select * from user;