/*
-----------------
begin   
update bb_product
set stock=stock+25
where idproduct=15;
DBMS_OUTPUT.put_line(SQL%ROWCOUNT);

if SQL%NOTFOUND then DBMS_OUTPUT.PUT_LINE('not found');
end if;
end;

--------------

--select * from bb_product;

-----------------
declare
lv_tot_num bb_basket.total%TYPE;
begin   
select total into lv_tot_num from bb_basket where idbasket=12;
DBMS_OUTPUT.put_line(SQL%ROWCOUNT);
update bb_product
set stock=stock+25
where idproduct=15;
DBMS_OUTPUT.put_line(SQL%ROWCOUNT);--A select statement that returns no rows results in a "no data found" error
end;
--------------------------
--------------
--exception raised

declare
lv_tot_num bb_basket.total%TYPE;
begin   
select total into lv_tot_num from bb_basket where idbasket=199;
DBMS_OUTPUT.put_line(SQL%ROWCOUNT);
update bb_product
set stock=stock+25
where idproduct=15;
DBMS_OUTPUT.put_line(SQL%ROWCOUNT);--A select statement that returns no rows results in a "no data found" error
end;
------------------
-----explicit cursors---------------
declare
lv_created_date DATE;
lv_basket_num number(3);
lv_qty_num number(3);
lv_sub_num number(5,2);
lv_days_num number(3);
lv_shopper_num number(3):=26;
begin
Select idbasket,dtcreated,quantity,subtotal
into lv_basket_num,lv_created_date,lv_qty_num,lv_sub_num
from bb_basket
where idshopper=lv_shopper_num
and orderplaced=0;
lv_days_num:=TO_DATE('02/28/12','mm/dd/yy')-lv_created_date;
dbms_output.put_line(lv_basket_num||'*'||lv_created_date||'*'||lv_qty_num);
end; --error exact fetch returned more than requested number of rows

-------
--commit;
--------steps in executing an exlicit cursor-------- declare open fetch close
declare
cursor cur_basket is
select bi.idbasket,p.type,bi.price,bi.quantity
from bb_basketitem bi inner join bb_product p using(idproduct)
where bi.idbasket=6;
Type type_basket is record
(basket bb_basketitem.idbasket%TYPE,
type bb_product.type%TYPE,
price bb_basketitem.price%TYPE,
qty bb_basketitem.quantity%TYPE
);
rec_basket type_basket;
lv_rate_num number(2,2);
lv_tax_num number(4,2):=0;
begin
open  cur_basket;--process the query and creates the active set of rows;
loop
fetch -- retreives a current row from cursor into block var
cur_basket into rec_basket;
DBMS_OUTPUT.PUT_LINE('u fut te fect');
DBMS_OUTPUT.PUT_LINE('recbasket.type'||rec_basket.type);
EXIT when cur_basket%NOTFOUND;
IF rec_basket.type = 'E' THEN lv_rate_num := .05;
ELSIF rec_basket.type = 'C' THEN lv_rate_num := .03;
END IF;
lv_tax_num := lv_tax_num +
((rec_basket.price * rec_basket.qty) * lv_rate_num);
dbms_output.put_line(rec_basket.price||'*'||rec_basket.qty||'*'||lv_rate_num);
DBMS_OUTPUT.PUT_LINE('brenda loop tax num'||'*'||lv_tax_num);
END LOOP;
CLOSE cur_basket;--clears the active set of rows and frees the memory area used
DBMS_OUTPUT.PUT_LINE(lv_tax_num);
END;

-----------------
--Cursor for loop
declare
CURSOR cur_basket IS
select bi.idbasket,p.type,bi.price,bi.quantity
from bb_basketitem bi inner join bb_product p using(idproduct)
where bi.idbasket=6;
lv_rate_num number(2,2);
lv_tax_num number(4,2):=0;
begin
    for rec_basket in cur_basket loop --process the query and creates the active set of rows; rec_basket is notdeclared in the block declaration st.
    --it is created to hold one row of the table coming on the cur_basket
--DBMS_OUTPUT.PUT_LINE('recbasket.type'||rec_basket.type);
        IF rec_basket.type = 'E' THEN lv_rate_num := .05;
            ELSIF rec_basket.type = 'C' THEN lv_rate_num := .03;
        END IF;
    lv_tax_num := lv_tax_num +((rec_basket.price * rec_basket.quantity) * lv_rate_num);
dbms_output.put_line(rec_basket.price||'*'||rec_basket.quantity||'*'||lv_rate_num);
DBMS_OUTPUT.PUT_LINE('brenda loop tax num'||'*'||lv_tax_num);
    END LOOP;
DBMS_OUTPUT.PUT_LINE(lv_tax_num);
END;
------------------------------------
--cursor with locking for update feature-------------
DECLARE
  CURSOR cur_prod IS
    SELECT type, price
    FROM bb_product
    WHERE active = 1
    FOR UPDATE NOWAIT;-- this is an oracle feature that instructs oracle to freeze the rows coming out at cur_product in order that they can be updated
    --we have also "WHERE CURRENT OF" option
  lv_sale bb_product.saleprice%TYPE;
BEGIN
  FOR rec_prod IN cur_prod LOOP-- all the cursor actions are done here open fetch empty and close
   IF rec_prod.type = 'C' THEN lv_sale := rec_prod.price * .9;  END IF;
   IF rec_prod.type = 'E' THEN lv_sale := rec_prod.price * .95; END IF;
   UPDATE bb_product
    SET saleprice = lv_sale
    WHERE CURRENT OF cur_prod;
  END LOOP;
  COMMIT;
END;
select * from bb_product

--select * from bb_basketitem;
DECLARE
CURSOR cur_order (p_basket NUMBER) IS
SELECT idBasket, idProduct, price, quantity
FROM bb_basketitem
WHERE idBasket = p_basket;
lv_bask1_num bb_basket.idbasket%TYPE := 6;
lv_bask2_num bb_basket.idbasket%TYPE := 10;
BEGIN
FOR rec_order IN cur_order(lv_bask1_num) LOOP
DBMS_OUTPUT.PUT_LINE(rec_order.idBasket || ' - ' ||
rec_order.idProduct || ' - ' || rec_order.price);
END LOOP;
FOR rec_order IN cur_order(lv_bask2_num) LOOP
DBMS_OUTPUT.PUT_LINE(rec_order.idBasket || ' - ' ||
rec_order.idProduct || ' - ' || rec_order.price);
END LOOP;
END;
------------------------------------------
-----------------variable cursor-------------------------

---uncomplete cursor variable from power points data do not use it
DECLARE
   --TYPE type_curvar IS REF CURSOR;
   --cv_prod type_curvar;
   cv_prod SYS_REFCURSOR;
   rec_coff  bb_product%ROWTYPE;
   rec_equip  bb_shop_sales%ROWTYPE;
BEGIN
   IF :g_choice = 1 THEN 
     OPEN cv_prod FOR SELECT * FROM bb_product;
     FETCH cv_prod INTO rec_coff;
     --dbms_output.put_line('entered here, '||rec_cofee);
   END IF;
   IF :g_choice = 2 THEN 
     OPEN cv_prod FOR SELECT * FROM bb_shop_sales;
     FETCH cv_prod INTO rec_equip;
    
   END IF;
END;
--
---assume that the brewbeans has a web page that will display basket items and status
--this need an input from the user and based on that info will be displayed
DECLARE
cv_prod SYS_REFCURSOR;
rec_item bb_basketitem%ROWTYPE;
rec_status bb_basketstatus%ROWTYPE;
lv_input1_num NUMBER(2) := 2; lv_input2_num NUMBER(2) := 3;
BEGIN
IF lv_input1_num = 1 THEN
OPEN cv_prod FOR SELECT * FROM bb_basketitem WHERE idBasket = lv_input2_num;
LOOP
FETCH cv_prod INTO rec_item;
EXIT WHEN cv_prod%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(rec_item.idProduct);
END LOOP;
ELSIF lv_input1_num = 2 THEN
OPEN cv_prod FOR SELECT * FROM bb_basketstatus
WHERE idBasket = lv_input2_num;
LOOP
FETCH cv_prod INTO rec_status;
EXIT WHEN cv_prod%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(rec_status.idStage || ' - '
|| rec_status.dtstage);
END LOOP;
END IF;
END;

---------------------------------------------------
--PREDEFINED ERRORS EXCEPTION HANDLING--
------------------------------------------
--if product is 0 ok if shopper num 25 ok no data found
DECLARE
TYPE type_basket IS RECORD
(basket bb_basket.idBasket%TYPE,
created bb_basket.dtcreated%TYPE,
qty bb_basket.quantity%TYPE,
sub bb_basket.subtotal%TYPE);
rec_basket type_basket;
lv_days_num NUMBER(3);
lv_shopper_num NUMBER(3) := 25;
BEGIN
SELECT idBasket, dtcreated, quantity, subtotal
INTO rec_basket
FROM bb_basket
WHERE idShopper = lv_shopper_num
AND orderplaced = 0;
lv_days_num := TO_DATE('02/28/12','mm/dd/yy') - rec_basket.created;
DBMS_OUTPUT.PUT_LINE(rec_basket.basket);
DBMS_OUTPUT.PUT_LINE(rec_basket.created);
DBMS_OUTPUT.PUT_LINE(rec_basket.qty);
DBMS_OUTPUT.PUT_LINE(rec_basket.sub);
DBMS_OUTPUT.PUT_LINE(lv_days_num);
END;

-----------------------------------------
-----------------------------------------
--ADD EXCEPTION HANDLING-----------------
--if product is 0 ok if shopper num 25 ok no data found
DECLARE
TYPE type_basket IS RECORD
(basket bb_basket.idBasket%TYPE,
created bb_basket.dtcreated%TYPE,
qty bb_basket.quantity%TYPE,
sub bb_basket.subtotal%TYPE);
rec_basket type_basket;
lv_days_num NUMBER(3);
lv_shopper_num NUMBER(3) := 22;
BEGIN
SELECT idBasket, dtcreated, quantity, subtotal
INTO rec_basket
FROM bb_basket
WHERE idShopper = lv_shopper_num
AND orderplaced = 0;
lv_days_num := TO_DATE('02/28/12','mm/dd/yy') - rec_basket.created;
DBMS_OUTPUT.PUT_LINE(rec_basket.basket);
DBMS_OUTPUT.PUT_LINE(rec_basket.created);
DBMS_OUTPUT.PUT_LINE(rec_basket.qty);
DBMS_OUTPUT.PUT_LINE(rec_basket.sub);
DBMS_OUTPUT.PUT_LINE(lv_days_num);
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE(' You have no saved baskets!');
when too_many_rows then
DBMS_OUTPUT.PUT_LINE(' You have tooo many rows saved baskets!');
END;
--------------------------------------------------
---UNDEFINED EXCEPTIONS UNANAMED oRACLE ERRORS
-------------HANDLING---------------
-------------------------------------
--DELETE FROM BB_BASKET WHERE idbasket=4;
DECLARE
ex_basket_fk EXCEPTION;
PRAGMA EXCEPTION_INIT (ex_basket_fk,-02292);
BEGIN
DELETE FROM BB_BASKET WHERE idbasket=4;
EXCEPTION
when ex_basket_fk then
DBMS_OUTPUT.PUT_LINE('Items still in baskets!');
END;

--------------------------------------------------
---User DEFINED EXCEPTIONS --idproduct=30
-------------HANDLING---------------
-------------------------------------
--DELETE FROM BB_BASKET WHERE idbasket=4;
DECLARE
ex_prod_update EXCEPTION;
--PRAGMA EXCEPTION_INIT (ex_basket_fk,-02292);
BEGIN
Update bb_product set description='Mill grinder with ............' WHERE idproduct=30;
if SQL%NOTFOUND THEN RAISE EX_PROD_UPDATE;
END IF;
EXCEPTION
when ex_PROD_UPDATE then
DBMS_OUTPUT.PUT_LINE('INVALID PROD ID IS ENTERED!');
END;*/
-----------------------------------------
--OTHER ERRORS EXCEPTION HANDLING---
DECLARE
TYPE type_basket IS RECORD
(basket bb_basket.idBasket%TYPE,
created bb_basket.dtcreated%TYPE,
qty bb_basket.quantity%TYPE,
sub bb_basket.subtotal%TYPE);
rec_basket type_basket;
lv_days_num NUMBER(3);
lv_shopper_num NUMBER(3) := 26;
lv_errmsg_txt VARCHAR2(80);
lv_errnum_txt VARCHAR2(100);
BEGIN
SELECT idBasket, dtcreated, quantity, subtotal
INTO rec_basket
FROM bb_basket
WHERE idShopper = lv_shopper_num
AND orderplaced = 0;
lv_days_num := TO_DATE('02/28/12','mm/dd/yy') - rec_basket.created;
DBMS_OUTPUT.PUT_LINE(rec_basket.basket);
DBMS_OUTPUT.PUT_LINE(rec_basket.created);
DBMS_OUTPUT.PUT_LINE(rec_basket.qty);
DBMS_OUTPUT.PUT_LINE(rec_basket.sub);
DBMS_OUTPUT.PUT_LINE(lv_days_num);
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('You have no saved baskets!');
--WHEN TOO_MANY_ROWS THEN `DBMS_OUTPUT.PUT_LINE('You have TOO MANY no saved baskets!');
WHEN OTHERS THEN
lv_errmsg_txt:=SUBSTR(Sqlerrm,1,80);
lv_errnum_txt:=substr(sqlcode,1,100);
insert into bb_trans_log(shopper,errcode,errmsg)
values(lv_shopper_num,substr(lv_errmsg_txt,1,10),substr(lv_errnum_txt,1,80));
DBMS_OUTPUT.PUT_LINE('A problem has occurred'||'-'||lv_errmsg_txt||' '||'    '||lv_errnum_txt);
DBMS_OUTPUT.PUT_LINE('Tech support will be notified and contact you');
END;