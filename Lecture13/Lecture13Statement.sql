
declare
lv_ship_num number(5,2) ;
begin
lv_ship_num:=ship_calc_sf(11);
DBMS_OUTPUT.put_line(lv_ship_num);
end;
execute ship_calc_sf(12);
begin ship_calc_sf(12);end;
--slide21
desc ship_calc_sf;
select text from user_source where name=SHIP_CALC_SF;
create or replace function ship_calc_sf
(p_qty IN number)
return number
is 
lv_ship_num number(5,2);

begin
    if p_qty>10 then
       lv_ship_num:=11.00;
        elsif p_qty>5 then
       lv_ship_num:=8.00;
        else
        lv_ship_num:=5.00;
     end if;

return lv_ship_num;
end;

declare
lv_ship_num number(5,2) ;
begin
lv_ship_num:=ship_calc_sf(11);
DBMS_OUTPUT.put_line(lv_ship_num);
end;
execute ship_calc_sf(12);
begin ship_calc_sf(12);end;
--slide21
desc ship_calc_sf;
select text from user_source where name='SHIP_CALC_SF';
CREATE  OR REPLACE PACKAGE ORDERING_PKG
IS
PV_TOTAL_NUM NUMBER(3,2);
PROCEDURE ORDER_TOTAL_PP(
P_BSKTID IN NUMBER,
P_CNT OUT NUMBER,
P_SUB OUT NUMBER,
p_TOTAL OUT number,
p_ship OUT number
);
FUNCTION SHIP
---------------------------------------
create or replace trigger product_inventory_trg
after update of orderplaced on bb_basket
for each row
when (old.orderplaced<>1 and new.orderplaced=1)
declare
 cursor basketitem_cur is  
 select idproduct,quantity,option1
 from bb_basketitem
 where idbasket=:NEW.idbasket;
 lv_chg_num number(3,1);
 begin
 for basketitem_rec in basketitem_cur LOOP
 if basketitem_rec.option1=1 then
 lv_chg_num:=(.5*basketitem_rec.quantity);
 else
 lv_chg_num:=(basketitem_rec.quantity);
 end if;
 update bb_product
 set stock=stock-lv_chg_num
 where idproduct=basketitem_rec.idproduct;
 end loop;
 end;