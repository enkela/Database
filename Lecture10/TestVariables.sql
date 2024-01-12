DECLARE
lv_ord_date DATE;
lv_last_txt VARCHAR2(25);
lv_qty_num NUMBER(2);
lv_shipflag_bln BOOLEAN;
BEGIN
lv_ord_date:='12-jul-2006';
lv_last_txt:='BROWN';
lv_qty_num :=3;
lv_shipflag_bln :=FALSE;
dbms_output.put_line(lv_ord_date);
dbms_output.put_line(lv_last_txt);
dbms_output.put_line(lv_qty_num);

  
END;