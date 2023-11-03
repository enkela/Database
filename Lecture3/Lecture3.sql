
INSERT INTO customers(customer#,lastname,firstname,region)
    VALUES(1020,'PADDY','JACK','NE');
SELECT * FROM EMP2;
select * from DEPARTMENTS1;
--violating constraint
UPDATE employees
SET department_id=55
where department_id=110;
DELETE FROM departments
WHERE department_id = 60;

