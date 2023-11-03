ALTER TABLE CUSTOMERS 
ADD CONSTRAINT CUSTOMERS_CUSTOMER#_PK PRIMARY KEY(CUSTOMER#);
ALTER TABLE orderitems
    ADD CONSTRAINT orderitems_order#item#_pk PRIMARY KEY(order#,item#);

ALTER TABLE employees READ ONLY;
----PERFORM OPERATION ON TABLE ADD CONSTRAINTS /..
ALTER TABLE employees READ WRITE;
--table creation sql is generated by employee table in HR schema
ALTER TABLE EMP2
MODIFY EMPLOYEE_ID PRIMARY KEY;
ALTER TABLE EMP2
--ADD A REFERENCE TO ITSELF
ADD CONSTRAINT EMP_MGR_FK FOREIGN KEY (manager_id)
REFERENCES emp2 (employee_id);
--ADD A RELATIONSHIP WITH DEPARTMENTS1
--MAKE A PRIMARY KEY FOR DEPARTMENTS1
ALTER TABLE departments1 ADD CONSTRAINT department1_id_pk PRIMARY KEY(DEPARTMENT_ID);
ALTER TABLE Emp2 ADD CONSTRAINT emp_dt_fk 
FOREIGN KEY (Department_id) 
REFERENCES DEPARTMENTS1(department_id) ON DELETE CASCADE;
ALTER TABLE ORDERITEMS ADD CONSTRAINT orderitems_order#item#_pk
PRIMARY KEY (order#,item#);
--dropConstraints
ALTER TABLE DEPARTMENTS DROP CONSTRAINT DEPARTMENT1_ID_PK;