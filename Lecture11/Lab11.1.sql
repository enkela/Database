

--1 first method---
--------steps in executing an exlicit cursor-------- declare open fetch close
--select first_name||' '||last_name,salary from emp2 where department_id=10;
declare
cursor cur_employee is
select bi.first_name,bi.last_name,bi.salary
from emp2 bi where bi.department_id=50;
Type type_emp2 is record
(fname emp2.first_name%TYPE,
lname emp2.last_name%TYPE,
sal emp2.salary%TYPE);
rec_emp type_emp2;
begin
open  cur_employee;--process the query and creates the active set of rows;
loop
fetch -- retreives a current row from cursor into block var
cur_employee into rec_emp;
DBMS_OUTPUT.PUT_LINE('Employee name'||rec_emp.fname||' '||rec_emp.lname);
EXIT when cur_employee%NOTFOUND;
dbms_output.put_line(rec_emp.lname||'*'||rec_emp.fname||'*' ||'SALARY:'||rec_emp.sal);
END LOOP;
CLOSE cur_employee;--clears the active set of rows and frees the memory area used
--DBMS_OUTPUT.PUT_LINE(lv_tax_num);
END;
--1--- second method
--******************************************************************************
declare
cursor cur_employee is
select bi.first_name fname,bi.last_name lname ,bi.salary sal
from emp2 bi 
where bi.department_id=50;
begin for rec_emp in cur_employee --process the query and creates the active set of rows;
loop -- retreives a current row from cursor into block var
DBMS_OUTPUT.PUT_LINE('Employee name'||rec_emp.fname||' '||rec_emp.lname);
dbms_output.put_line(rec_emp.lname||'*'||rec_emp.fname||'*' ||'SALARY:'||rec_emp.sal);
END LOOP;
---2----
-----------------
--Cursor for loop
declare CURSOR cur_basket IS
select bi.idbasket,p.stock,bi.price,bi.quantity
from bb_basketitem bi inner join bb_product p using(idproduct)
where bi.idbasket=6;
lv_flag boolean:=TRUE;
lv_tax_num number(4,2):=0;
begin
    for rec_basket in cur_basket loop --process the query and creates the active set of rows; rec_basket is notdeclared in the block declaration st.
    --it is created to hold one row of the table coming on the cur_basket
  --DBMS_OUTPUT.PUT_LINE('recbasket.type'||rec_basket.type);
        IF rec_basket.quantity>rec_basket.stock THEN LV_FLAG:=FALSE;
        dbms_output.put_line('THIS ITEM IS  NOT   IN STOCK'||rec_basket.price||'*'||rec_basket.quantity||'*'||REC_BASKET.STOCK);
           ELSIF rec_basket.quantity<rec_basket.stock THEN  
           dbms_output.put_line('THIS ITEM IS IN STOCK'||rec_basket.price||'*'||rec_basket.quantity||'*'||REC_BASKET.STOCK);
           END IF;
    END LOOP;
IF LV_FLAG THEN DBMS_OUTPUT.PUT_LINE('All items are in stock!');
    ELSE DBMS_OUTPUT.PUT_LINE('Some items are not in stock');
    END IF;
END;
---3---
DECLARE
  CURSOR cur_shopper IS
    SELECT idshopper, promo,( select sum(bb.total) from bb_basket bb where bb.idshopper=bb_shopper.idshopper)tot
    FROM bb_shopper
    FOR UPDATE NOWAIT;-- this is an oracle feature that instructs oracle to freeze the rows coming out at cur_product in order that they can be updated
    --we have also "WHERE CURRENT OF" option
   lv_sale number;
   lv_promo bb_shopper.promo%TYPE;
BEGIN
  FOR rec_shopper IN cur_shopper LOOP-- all the cursor actions are done here open fetch empty and close
  lv_sale:=rec_shopper.tot;
      IF lv_sale<50 THEN lv_promo := NULL;  END IF;
      IF lv_sale>=50 THEN lv_promo := 'B';  END IF;
   IF lv_sale>=100 THEN lv_promo:='A'; END IF;
   DBMS_OUTPUT.put_line(rec_shopper.idshopper||'*************'||lv_promo);
   UPDATE bb_shopper
    SET promo = lv_promo
    WHERE CURRENT OF cur_shopper;
  END LOOP;
  COMMIT;
END;
---4---
DECLARE
  g_state VARCHAR2(2) := 'No';
  tax_percentage NUMBER;
  check_message VARCHAR2(100);
BEGIN
  CASE g_state     WHEN 'VA' THEN       tax_percentage := 4;
    WHEN 'NC' THEN       tax_percentage := 2;
    WHEN 'NY' THEN      tax_percentage := 6;
    --ELSE      tax_percentage := 0;
      DBMS_OUTPUT.PUT_LINE('Invalid state!');
  END CASE;
  DBMS_OUTPUT.PUT_LINE('Tax Percentage: '|| tax_percentage || '%');
END;
--1 first the error case not found is being raised
--step 2 to catch the error
----5---------
DECLARE
    v_customer_no NUMBER := :customer_no; 
    v_first_name  VARCHAR2(50);
    v_last_name   VARCHAR2(50);
BEGIN
    SELECT first_name, last_name
    INTO v_first_name, v_last_name
    FROM customers
    WHERE customer_number = v_customer_no;

    DBMS_OUTPUT.PUT_LINE('Customer Name: ' || v_first_name || ' ' || v_last_name);

 EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No state is found ' || g_state);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END;
--7---------
DECLARE
    v_empno           NUMBER;
    v_job             VARCHAR2(50);
    v_monthly_salary  NUMBER;
    v_annual_salary   NUMBER;
    v_raise           NUMBER;
    v_new_annual_salary NUMBER;
    v_total_increase  NUMBER := 0;    
    CURSOR emp_cursor IS
        SELECT employee_id, job_id, salary
        FROM emp2
        FOR UPDATE OF salary; 
BEGIN
    FOR emp_rec IN emp_cursor 
    LOOP
        v_empno := emp_rec.employee_id;
        v_job := emp_rec.job_id;
        v_monthly_salary := emp_rec.salary;
        v_annual_salary := v_monthly_salary * 12;

        IF v_job = 'PRESIDENT' THEN        v_raise := 0; 
        ELSE
            v_raise := LEAST(v_annual_salary * 0.06, 2000); 
        END IF;
        v_new_annual_salary := v_annual_salary + v_raise;

               DBMS_OUTPUT.PUT_LINE('EmpNo: ' || v_empno ||   ', Current Annual Salary: ' || v_annual_salary ||   ', Raise: ' || v_raise || ', New Annual Salary: ' || v_new_annual_salary);
      
        UPDATE emp2
        SET salary = v_new_annual_salary / 12
        WHERE employee_id= v_empno;
      
        v_total_increase := v_total_increase + v_raise;
    END LOOP;
