use practice;

/******************** VIEW ********************/
/********** 테이블 결합 **********/
/* sales 테이블 기준, product 테이블 LEFT JOIN 결합 */
select A.*
		, A.sales_qty * B.price as 결제금액
from sales as A
left join product as B
on A.product_code = B.product_code;


/********** VIEW 생성 **********/
create view sales_product as
select A.*
		, A.sales_qty * B.price as 결제금액
from sales as A
left join product as B
on A.product_code = B.product_code;


/********** VIEW 실행 **********/
select *
from sales_product;


/********** VIEW 수정 **********/
alter view sales_product as
select A.*
		, A.sales_qty * B.price * 1.1 as 결제금액_수수료포함
from sales as A
left join product as B
on A.product_code = B.product_code;

/* 확인 */
select *
from sales_product;


/********** VIEW 삭제 **********/
drop view sales_product;


/********** VIEW 특징(중복되는 열 저장 안됨) **********/
create view sales_product as
select *
from sales as A
left join product as B
on A.product_code = B.product_code;



/******************** PROCEDURE ********************/
/********** IN 매개변수 **********/
delimiter //
create procedure cst_gen_addr_in( in input_A varchar(20), input_B varchar(20) )
begin
	select *
    from customer
    where gender = input_A
    and addr = input_B;
end //
delimiter ; /* DELIMITER: 여러 명렁어들을 하나로 묶어줄 때 사용 */

/***** PROCEDURE 실행 *****/
call cst_gen_addr_in('man', 'seoul');
call cst_gen_addr_in('women', 'incheon');

/***** PROCEDURE 삭제 *****/
drop procedure cst_gen_addr_in;


/********** OUT 매개변수 **********/
delimiter //
create procedure cst_gen_addr_in_cnt_mem_out( in input_A varchar(20), input_B varchar(20), out cnt_mem int )
begin
	select count(mem_no)
    into cnt_mem
    from customer
    where gender = input_A
    and addr = input_B;
end //
delimiter ;

/***** PROCEDURE 실행 *****/
call cst_gen_addr_in_cnt_mem_out('women', 'incheon', @cnt_mem);
select @cnt_mem;


/********** INOUT 매개변수 **********/
delimiter //
create procedure in_out_parameter( inout count int )
begin
	set count = count + 10;
end //
delimiter ;

/***** PROCEDURE 실행 *****/
set @counter = 1;
call in_out_parameter(@counter);
select @counter;