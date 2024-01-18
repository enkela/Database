-----------------------------------------------
-------------Procedure to determine shipping cost-------
------------------------
/*CREATE OR REPLACE PROCEDURE ship_cost_sp 
(p_qty IN number,
p_ship OUT number
)
is begin
IF p_qty>10 then p_ship:=11.00;
elsIF p_qty>5 then p_ship:=8.00;
ELSE p_ship:=5;
end if;
end;
*/
-------------Test created procedure----------------
/*
Variable g_ship_cost number;
execute ship_cost_sp(7,:g_ship_cost);
print g_ship_cost
*/
------------CALL PROCEDURE BY POSITIONAL METHOD
/*
declare
lv_ship_num number(6,2);
begin
ship_cost_sp(7,lv_ship_num);
DBMS_OUTPUT.PUT_LINE('SHIP_COST IS= '||LV_SHIP_NUM);
end;
*/
----------------
---------CALL PROCEDURE BY NAMED ASSOCIATION METHOD
/*
declare
lv_ship_num number(6,2);
begin
ship_cost_sp(P_SHIP=>lv_ship_num,P_QTY=>7);
DBMS_OUTPUT.PUT_LINE('SHIP_COST IS= '||LV_SHIP_NUM);
end;*/
-------------------
/*------------IN AND OUT PARAMETERS-------------------
CREATE OR REPLACE PROCEDURE phone_fmt_sp
   (p_phone IN OUT VARCHAR2)
  IS
BEGIN
  p_phone := '(' || SUBSTR(p_phone,1,3) || ')' ||
                    SUBSTR(p_phone,4,3) || '-' ||
                    SUBSTR(p_phone,7,4);
END;
---tEST pROCEDURE
declare
lv_PHONE_TXT VARCHAR2(13):='11122223333';
begin
PHONE_FMT_SP(LV_PHONE_TXT);
DBMS_OUTPUT.PUT_LINE('SHIP_COST IS= '||LV_PHONE_TXT);
end;
*/
--Calculate an order subtotal and shipping cost---
/* 
The procedure, named
ORDER_TOTAL_SP, needs to retrieve basket items from the database and perform four
tasks for the basket: Identify the total quantity of items ordered, calculate the subtotal
for products ordered, check for the shipping cost, and calculate the overall order total,
including products and shipping. You have already created a procedure to calculate the
shipping cost, so you can recall this stored program unit from the new procedure
*/
/*
CREATE OR REPLACE PROCEDURE ORDER_TOTAL_sp 
(
P_BSKTID IN NUMBER,
P_CNT OUT NUMBER,
P_SUB OUT NUMBER,
p_TOTAL OUT number,
p_ship OUT number
)
IS 
BEGIN
SELECT SUM(QUANTITY), SUM(QUANTITY*PRICE)
INTO P_CNT,P_SUB
FROM BB_BASKETITEM
WHERE IDBASKET=p_bsktid;
ship_cost_sp(P_CNT,P_SHIP);
p_total:=NVL(P_SUB,0)+NVL(P_SHIP,0);
DBMS_OUTPUT.PUT_LINE('        -------'||P_TOTAL);
end;
*/
/*
declare
lv_BASKETID NUMBER:=3;
LV_CNT NUMBER;
LV_SUB NUMBER;
LV_TOTAL  number;
LV_ship number;
begin
DBMS_OUTPUT.PUT_LINE('Anonymous block started');
ORDER_TOTAL_SP(lv_basketid,LV_CNT,LV_SUB,lv_total,LV_SHIP);
DBMS_OUTPUT.PUT_LINE('Anonymous block ended');
END;
*/
-----------------Sum the total of all items in the basket-----
-------------BASKET NUMBER PROVIDED AS INPUT PARAM---------------
/*
CREATE OR REPLACE PROCEDURE total_calc_sp
(p_basket IN bb_basket.idbasket%TYPE,
p_total OUT bb_basket.total%TYPE := 0)
IS
*/
-- PL/SQL block coded here --
--describe order_total_sp;
--Slide 16-----------------
-------------Variable scope continued----------------
/*Working with Variable Scope
Nesting blocks raises a new issue with variable scope, which specifies the area of a block
that can identify a particular variable. A nested block can be placed inside another block
wherever an executable statement is allowed, which includes the BEGIN and EXCEPTION
sections. A block first looks for a variable inside itself. If a nested block is searching for a
variable and can’t locate it, the block searches its enclosing block for the variable. */
/*
DECLARE
lv_one NUMBER(2):=10;
lv_two NUMBER(2):=20;
BEGIN
    DECLARE
            lv_one NUMBER(2):=30;
            lv_three NUMBER(2):=40;
        begin
            LV_ONE :=LV_ONE+10;--40
            lv_two:=lv_two+10;--30
            dbms_output.put_line('Nested lv_one= '||lv_one);
            dbms_output.put_line('Nested lv_two= '||lv_two);
            dbms_output.put_line('Nested lv_three= '||lv_three);
            end;
        LV_ONE :=LV_ONE+10;--10=>20
        lv_two:=lv_two+10;--20 po u ndryshua siper u be 40=>30
        dbms_output.put_line('Nested lv_one= '||lv_one);
        dbms_output.put_line('Nested lv_two= '||lv_two);
        end;
    */
    
    /*Exception-Handling Flow
As you learned in Chapter 4, the exception-handling area of a block determines what
happens if an error occurs. Developers must recognize when a procedure is called from
another procedure because the flow of exception handling can cross over multiple
program units. If an exception is raised in procedure B (which has been called from
procedure A), control first moves to the EXCEPTION section of procedure B. If the
exception is handled, control returns to procedure A, in the next statement after the
call to procedure .*/
Create or replace procedure stock_ck_sp
(p_qty in number,
p_prod In number)
is 
lv_stock_num number(4);
begin 
select stock
into lv_stock_num from bb_product
where idproduct=p_prod;
if p_qty>lv_stock_num then
RAISE_APPLICATION_ERROR(-20000, 'not enough in stock.'||p_qty||' and stock level '||lv_stock_num);
end if;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE ('no stock found');
end;