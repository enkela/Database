--Sql statemnets 
select * from bb_product p, bb_department D
WHERE p.iddepartment=d.iddepartment;
----aNSI jOIN
select * from bb_product INNER JOIN  bb_department D
   USING (iddepartment)
;
--AGGREGATE AND WHERE
SELECT AVG(PRICE)FROM BB_PRODUCT WHERE TYPE='C';

CREATE TABLE AUTOS
(AUTO_ID NUMBER(5),
ACQUIRE_DATE DATE,
COLOR VARCHAR2(15),
CONSTRAINT AUTO_ID_PK PRIMARY KEY(AUTO_ID)
);
--INSERT INTO AUTOS VALUES (45321,'05-MAY-07','GRAY');
COMMIT;
INSERT INTO AUTOS (AUTO_ID,acquire_date,color)VALUES (45321,'05-MAY-07','GRAY');
INSERT INTO AUTOS (AUTO_ID,acquire_date,color)VALUES (81433,'12-OCT-07','RED');
SELECT * FROM AUTOS;
--Chapter 2
