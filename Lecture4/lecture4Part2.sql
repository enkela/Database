select order#,orderdate,shipdate,
NVL2(shipdate,'Shiped','Not shipped')"Ship Days"
FROM orders
WHERE orderdate>='03-APR-09';
SELECT * from employees;

SELECT  employee_id,first_name,last_name,
        ROUND(MONTHS_BETWEEN('01-JUL-09',hire_date)/12,2)"Years",
    CASE
        WHEN (MONTHS_BETWEEN('01-JUL-09',hire_date)/12)<4 then 'Level 1'
        WHEN (MONTHS_BETWEEN('01-JUL-09',hire_date)/12)<8 then 'Level 2'
        WHEN (MONTHS_BETWEEN('01-JUL-09',hire_date)/12)<11 then 'Level 3'
        WHEN (MONTHS_BETWEEN('01-JUL-09',hire_date)/12)<15 then 'Level 4'
    ELSE 'Level 5'
    END "Retire level"
FROM Employees;
SELECT customer#,lastname,firstname 
    FROM    customers
WHERE SOUNDEX(lastname)=SOUNDEX('smyth');
SELECT 
    title ,pubdate,
    TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-TO_NUMBER(TO_CHAR(PUBDATE,'YYYY'))
    "Years"
    FROM books 
    WHERE category='COMPUTER';
SELECT ROUND(4769.43,-2),LENGTH('Hello')
    FROM DUAL;
--GROUP Functions
SELECT SUM((paideach-cost)*quantity)"Total Profit"
        FROM orderitems JOIN books USING(isbn)
        WHERE order#=1007;
SELECT AVG(retail-cost)"Average Profit"
FROM books
WHERE category='COMPUTER';
SELECT COUNT(DISTINCT category)
FROM books;
SELECT count(*)
    FROM orders
    WHERE shipdate IS NULL;
SELECT MAX(retail-cost)"Highest Profit"
        FROM books;
        
SELECT MIN(pubdate)
FROM books;
--Group by

SELECT category,To_char(AVG(retail-cost),'999.99')"Profit"
        FROM books
        GROUP BY category;    
--Restricting aggregated OUTPUT
SELECT category,To_char(AVG(retail-cost),'999.99')"Profit"
        FROM books
        GROUP BY category
        HAVING AVG(retail-cost)>15;    
SELECT category,To_char(AVG(retail-cost),'999.99')"Profit"
        FROM books
        WHERE pubdate>'01-JAN=05'
        GROUP BY category
        HAVING AVG(retail-cost)>15;  
SELECT order#,SUM((paideach-cost)*quantity)"Total Profit"
        FROM orderitems JOIN books USING(isbn)
        GROUP BY order#;    
--statistical Group Functions;
SELECT  category,COUNT(*),
        TO_CHAR(AVG(retail-cost),'999.99')"AVG",
        TO_CHAR(STDDEV(retail-cost),'999.99')"Stddev"
        From books
        GROUP BY category;
SELECT  category,COUNT(*),
        TO_CHAR(VARIANCE(retail-cost),'999.99')"Var",
        MIN(retail-cost)"MIN",MAX(retail-cost)"MAX"
    From books
    GROUP BY category;