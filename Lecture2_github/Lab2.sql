--1. Create a table named &#39;BOOKS&#39; with the following columns:
--drop table books;
--SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'BOOKS';BOOKS_ISBN_PK ,BOOKS_PUBID_FK, PUBLISHER_PUBID_PK

create table books (BookID Number(4) UNIQUE,
Title varchar2(40) ,
Author varchar2(20) ,
PublicationYear Number(4),
 Price Number(6,2))
--2. Create a table named &#39;STUDENTS2&#39; with the following columns: 
--drop table students;
--drop table registration;
create table STUDENTS (StudentID Number(4) UNIQUE,
FirstName varchar2(20) ,
LastName varchar2(20) ,
DOB date);

--3. Create a table named &#39;ORDERS&#39; with the following columns:
create table orders( OrderID Number(4),
ProductName varchar2(20),
Quantity Number(3),
OrderDate Date );

--4. Create a table named &#39;EMPLOYEES2&#39; with the following columns:
create table employees
(EmployeeID Number(4) UNIQUE,
FirstName varchar2(20),
LastName varchar2(20),
HireDate Date);
--5. Create a table named &#39;MOVIES&#39; with the following columns:
create table Movie( MovieID Number(4) Unique,
 MovieName varchar2(30),
Genre varchar2(30),
ReleaseYear number(4));
--6. Using the `BOOKS` table you created earlier, insert the following 5 records. Write the SQL statements to insert these records into the `BOOKS` table.:
insert into books values(101,'Harry Potter and the Sorcerer''s Stone','J.N. Rowling',1997,19.99);
insert into books values(102,'The Hobbit',' J.R.R. Tolkien',1937,14.99);
insert into books values(103,'1984','George Orwell',1949,9.99);
insert into books values( 104,'The Great Gatsby','F. Scott Fitzgerald',1925,22.99);
insert into books values(105,'To Kill a Mockingbird','Harper Lee',1960, 7.99);
commit;

--7. Using the `STUDENTS2` table you created earlier, insert the following 5 student records. Write the SQL statements to insert these records into the `STUDENTS2` table:
desc students;
commit;
ALTER SESSION SET NLS_DATE_FORMAT = 'MONTH-DD-YYYY';
select sysdate from dual
 insert into students values(501,'Johnn','Doe',To_date('1995-05-15','yyyy-mm-dd'));
 insert into students values(502,'Jane','Smith',To_date('1997-08-22','yyyy-mm-dd'));
 insert into students values(503,'Emily','Clark',To_date('1996-11-03','yyyy-mm-dd'));
 insert into students values(504,'Michael','Johnson',To_date('1998-02-20','yyyy-mm-dd'));
insert into students values(505,'Olivia','Brown',To_date('1999-04-30','yyyy-mm-dd'));

--8. Using the `ORDERS` table you previously created, insert the following 5 order records.Compose the SQL statements to insert these records into the `ORDERS` table:
insert into ORDERS  values(1001,'Laptop',5,To_date('2023-08-01','yyyy-mm-dd'));
insert into ORDERS  values(1002,'Smartphone',3,To_date('2023-07-28','yyyy-mm-dd'));
insert into ORDERS  values(1003,'Keyboard',10,To_date('2023-07-15','yyyy-mm-dd'));
insert into ORDERS  values(1004,'Headphones',7,To_date('2023-07-10','yyyy-mm-dd'));
insert into ORDERS  values(1005,'Smartwatch',4,To_date('2023-08-05','yyyy-mm-dd'));
create table employees2 as (select * from employees);
--9. Using the `EMPLOYEES2` table you established earlier, insert the following 5 employee records. Write the SQL statements to insert these records into the `EMPLOYEES2` table:
insert into EMPLOYEES2  values(201,'Alice','Turner',To_date('2021-01-10','yyyy-mm-dd'));
insert into EMPLOYEES2  values(202,'Brian','Wallace',To_date('2020-06-15','yyyy-mm-dd'));
insert into EMPLOYEES2  values(203,'Catherine','Hill',To_date('2019-10-05','yyyy-mm-dd'));
insert into EMPLOYEES2  values(204,'David','Cruz',To_date('2018-12-12','yyyy-mm-dd'));
insert into EMPLOYEES2  values(205,'Eleanor','Smithson',To_date('2023-04-22','yyyy-mm-dd'));

--10. Utilizing the `MOVIES` table you created earlier, please insert the following 5 movie
--records. Compose the SQL statements to insert these records into the `MOVIES` table:
create table movies as select * from movie;
insert into movies values(301,'Inception','Sci-Fi',2010);
insert into movies values(302,'The Shawshank','Drama',1994);
insert into movies values(303,'Jurassic Park','Adventure',1993);
insert into movies values(304,'The Dark Knight','Action',2008);
insert into movies values(305,'The Matrix','Sci-Fi',2022);
--- create table students 2 as dublicate from students
create table students2 as( select * from students)
--11. Books Table: 
--a. Add Genre Column: Write a SQL statement to add a new column named `Genre`to the `BOOKS` table which can store up to 20 characters. Update the existingrecords accordingly to add Genre for each book (you can use values such as
--Thriller, Action, History etc. as you seem fit).
alter table books add (genre varchar2(20));
--b. Modify Price Column: Write a SQL statement to modify the `Price` column in the `BOOKS` table from (6,2) to (8,2).
alter table books modify (price number(8,2));
--12. Students2 Table:a. Add Email Column: Write a SQL statement to add a new column named `Email`
--to the `STUDENTS2` table which can store up to 20 characters. Update theexisting records with values for the new column.
alter Table students2 add (mail varchar2(20));
update students2 set mail='@unyt.edu.al';
savepoint ab;
commit;
--b. Modify Email Column: Write a SQL statement to change the `Email` column in the `STUDENTS2` table to be of type `VARCHAR2` with a maximum length of
--30 characters, it was 20 characters.
alter Table students2 modify (mail varchar2(30));
--13. Orders Table: a. Add CustomerName Column: Write a SQL statement to add a new column named
--`CustomerName` to the `ORDERS` table which can store up to 20 characters.
alter table orders add (customername varchar2(20));
--Update the existing records with values for this new column.
/*select  o.orderid,min(o.rowid) from orders o group by o.orderid;
select * from students2;
update orders set customername='Johnn' where orderid<'005;
delete orders where rowid in(select  min(o.rowid) from orders o group by o.orderid);
*/
--b. Modify Quantity Column: Write a SQL statement to increase the size of the
--`Quantity` column in the `ORDERS` table to allow a maximum of 5 digits.
alter table orders modify (quantity number(5));
--14. Employees2 Table: a. Add Department Column: Write a SQL statement to add a new column named
--`Department` to the `EMPLOYEES2` table which can store up to 20 characters.
alter table employees2 add (department varchar2(20));
--select * from employees2;
select * from department;
--Update the existing records with values for this new column.
update employees2 set department='ENGINEERING';
commit;
--b. Modify HireDate Column: Write a SQL statement to modify the `Department` column in the `EMPLOYEES2` table to be of type `VARCHAR2` with a
--maximum length of 30 characters.
alter table employees2 modify (department varchar2(30));
--15. Movies Table: a. Add Director Column: Write a SQL statement to add a new column named
--`Director` to the `MOVIES` table which can store up to 20 characters.
--b. Modify MovieName Column: Write a SQL statement to increase the size of the `MovieName` column in the `MOVIES` table to allow up to 40 characters. The
--current size of the movie name column is 30 characters.
--delete movies where rowid in(select  min(o.rowid) from movies o group by o.movieid);
commit;
select * from movies;
alter table movies add (director varchar2(20));
alter table movies modify (moviename varchar2(40));
--update movies add (director varchar2(20));

--16. Updating Book Price: The bookstore has decided to offer a discount on older books to encourage sales. Your task is to reduce the price of all books published before the year
--2000 by 15%. Write an SQL `UPDATE` statement to reduce the price of all books published before the year 2000 by 15%. Ensure that the updated prices are rounded to
--two decimal places.
select bookid,price,price-round((price*15)/100,2) from books where publicationyear<2000;
update books set price=round(price-((price*15)/100),2) where publicationyear<2000;
--17. Correcting Author Names: After a data review, it was found that an intern misspelled the
--name &quot;J.K. Rowling&quot; as &quot;J.N. Rowling&quot; in the database. You are tasked with correcting
--this error. Write an SQL `UPDATE` statement to correct the author&#39;s name from &quot;J.N.
--Rowling&quot; to &quot;J.K. Rowling&quot; in the `books` table. Confirm the changes by retrieving rows
--where the author&#39;s name is &quot;J.K. Rowling&quot;.
select * from books where author='J.N. Rowling';
update books set author='J.K. Rowling' where author='J.N. Rowling';
commit;
select * from books where author='J.K. Rowling';

--18. Correcting Name Typographical Errors: A recent data audit revealed that a data entry operator mistakenly entered 'Johhn' instead of 'John' in the `FirstName` column. Your
--task is to find and correct this error in the `students` table. Write an SQL `UPDATE` statement to correct the first name &quot;Johhn&quot; to &quot;John&quot; in the `students` table. After
--updating, retrieve the rows where the `FirstName` is &quot;John&quot; to confirm the correction.
select * from students where firstname='Johnn';
update students set firstname='John' where firstname='Johnn';
commit;
select * from students where firstname='John';

--19. Updating Date of Birth Records: Due to an administrative error, student with ID 505 had her `DOB` recorded as &quot;1999-04-30&quot;. After cross-checking with paper records, it&#39;s
--determined that the correct date of birth for this student should be &quot;2000-04-30&quot;. Write an--SQL `UPDATE` statement to change the `DOB` of the student from &quot;1999-04-30&quot; to
--&quot;2000-04-30&quot;. Verify your update by retrieving row for student ID 505.
select * from students where studentid=505;
update students set dob=to_date('2000-04-30','yyyy-mm-dd')  where studentid=505;
--20. Updating Product Names: The supplier has rebranded one of its products. All instances of the product named &quot; Smartphone&quot; in the database have been changed to &quot; Smartphone
--Plus&quot;. As a database administrator, you&#39;re tasked with making this update to reflect the
--new product name. Write an SQL `UPDATE` statement to change the product name &quot;
--Smartphone&quot; to &quot; Smartphone Plus&quot; in the `orders` table. After making the update,
--retrieve rows where the `ProductName` is &quot; Smartphone Plus&quot; to verify the change.
select * from orders where productname='Smartphone';
update orders set productname='Smartphone Plus' where productname='Smartphone';
commit;
select * from orders where productname='Smartphone Plus';
--21. Correcting Order Dates: After reviewing recent orders, you&#39;ve discovered that all orders
--entered on &quot;2023-07-10&quot; actually took place on &quot;2023-07-11&quot;. You must correct this
--discrepancy in the records. Write an SQL `UPDATE` statement to correct the
--`OrderDate` for all orders that have a date of &quot;2023-07-10&quot; to &quot;2023-07-11&quot;. Once the
--update is complete, retrieve rows with an `OrderDate` of &quot;2023-07-11&quot; to verify your corrections.
select * from orders where orderdate=to_date('2023-07-10','yyyy-mm-dd';
update  orders set  orderdate=to_date('2023-07-11','yyyy-mm-dd'; where orderdate=to_date('2023-07-10','yyyy-mm-dd';
commit;
--22. Name Correction: During an audit, you realized that an employee&#39;s last name was entered
--incorrectly. The name &quot;Smithson&quot; should actually be &quot;Smith&quot;. This needs to be corrected
--in the database. Write an SQL `UPDATE` statement to change the last name &quot;Smithson&quot;to &quot;Smith&quot; for the affected employee in the `employees` table. After performing the
--update, retrieve rows where the `LastName` is &quot;Smith&quot; to verify the change.

commit;
select * from employees2 ;
select * from employees2 where lastname='Smithson';
update employees2 set lastname='Smith'where lastname='Smithson';
--23. Adjusting Hire Date: Due to an administrative oversight, all employees who were hired on &quot;2021-01-15&quot; were mistakenly recorded as being hired on &quot;2021-01-10&quot;. This
--discrepancy needs to be corrected. Write an SQL `UPDATE` statement to correct the`HireDate` for all employees who were wrongly entered as being hired on &quot;2021-01-10&quot;,
--changing it to &quot;2021-01-15&quot;. After the update, retrieve rows with a `HireDate` of &quot;2021-01-15&quot; to verify your corrections.
select * from employees2 e where e.hiredate=to_date('2021-01-10','yyyy-mm-dd');
update  employees2 set  hiredate=to_date('2021-01-15','yyyy-mm-dd') where hiredate=to_date('2021-01-10','yyyy-mm-dd');
commit;

--24. Changing Movie Genres: A change in classification standards means that all movies previously labeled under the genre &quot;Drama&quot; should now be classified as &quot;Family Drama&quot;.
--You need to adjust the database entries to reflect this change. Write an SQL `UPDATE` statement to modify the genre &quot;Drama&quot; to &quot;Family Drama&quot; in the `movies` table. After
--performing the update, retrieve rows where the `Genre` is &quot;Family Drama&quot; to verify the change.
select * from movies;
update movies set genre='Family Drama' where genre='Drama';
commit;
--25. Adjusting Movie Release Year: Due to a miscommunication with your data source, all movies recorded with a `ReleaseYear` of 2022 were actually released in 2021. You must
--correct this error in the database. Write an SQL `UPDATE` statement to modify the`ReleaseYear` for movies wrongly entered as 2022, changing it to 2021. After the update,
--retrieve rows with a `ReleaseYear` of 2021 to verify your corrections.
select * from movies;
update movies set releaseyear=2021 where releaseyear=2022;
commit;
--26. Books Table: a. Find Fantasy Novels: Write a SQL query to retrieve all columns for books whosetitles contain the word &quot;Great&quot;.
--b. Books Priced Above $15: Write a SQL query to retrieve the `Title` and `Price` of all books priced above $15.
select * from books;
select b.* from books b where b.title like '%Great%';
select b.* from books b where b.price>15;
select b.title,b.price from books b where b.price>15;

--27. Students2 Table:a. Students Born After 1997: Write a SQL query to retrieve the `FirstName`,`LastName`, and `DOB` of students who were born after January 1, 1997.
--b. Search for a Student: Write a SQL query to find all information about a student named &quot;Jane Smith&quot;.
select * from students s where s.dob>to_date(1997,'yyyy');
select s.firstname,s.lastname from students s where s.dob>to_date(1997,'yyyy');

--28. Orders Table: a. Recent Orders: Write a SQL query to retrieve all columns for orders that were
--placed in August 2023.b. Bulk Orders: Write a SQL query to retrieve the `OrderID` and `Quantity` of
--orders where the quantity is more than 5.
select o.orderid,o.quantity from orders o where o.quantity>5;
--29. Employees2 Table: a. New Hires: Write a SQL query to retrieve the `FirstName` and `HireDate` of
--employees who were hired in the year 2021.
--b. Search by Last Name: Write a SQL query to retrieve all columns for employees
--whose last name starts with &quot;Cru&quot;.
select e.*,(extract (year from e.hiredate))hiredate from employees2 e ;
select e.firstname||' '||e.lastname from employees2 e where (extract (year from e.hiredate))=2021;
select * from employees2 e where e.lastname like'Cru%';

--30. Movies Table:a. Sci-Fi Movies Released After 2000: Write a SQL query to retrieve the`MovieName` and `ReleaseYear` of movies in the &quot;Sci-Fi&quot; genre that were
--released after the year 2000.b. Movies from the &#39;90s: Write a SQL query to retrieve all columns for movies that--were released between 1990 and 1999, inclusive.

--31. Books Table:a. Delete Books by Publication Year: Delete all books from the table that were published in 1925.
--b. Delete Books Below Price: Remove all books from the database that are priced below $10.
--32. Students2 Table:a. Delete Students by Year of Birth: Remove all students whose year of birth is
--1996.
--b. Delete Specific Student: Delete the student records for anyone named &quot;Jane
--Smith&quot;.
--33. Orders Table: Delete Orders by Date: Delete all orders that were placed on &#39;2023-07-15&#39;.
--b. Delete Orders with Low Quantity: Remove all orders from the table where thequantity is less than or equal to 3.
--34. Employees2 Table:a. Delete Employees by Hiredate: Delete all employees who joined in either 2018 or
--2019.b. Delete Recent Hires: Remove all employees hired after &#39;2023-01-01&#39;.
--35. Movies Table:-a. Delete Movies by Release Year: Delete all movies from the table that were
--released before 2000.
--b. Delete Movies by Genre: Remove all movies from the database with the genre
--&-quot;Sci-Fi&quot;.

Part 2
Objectives: The lab exercises are based on the scott.sql schema
? like operator
? is null
? is not null
? between
? multiple comparison operators
? multiple logical operators
? sorting - order by ascending and descending
1. Write a query to retrieve all employee names that start with the letter &#39;S&#39;.
2. Write a query to retrieve all employee numbers and job titles whose job title contains the
word &#39;MANAGER&#39;.
3. Write a query to find all employees whose names end with the letter &#39;E&#39;.
4. Write a query to retrieve all employee numbers and job titles whose job title starts with
the letter &#39;A&#39; and ends with the letter &#39;T&#39;.
5. Write a query to find all employees whose names have an &#39;A&#39; as the second character.
6. Write a query to retrieve all employees whose job titles do not contain the word
&#39;CLERK&#39;.
7. Write a query to find all employees whose names are exactly 5 characters long.
8. Write a query to retrieve all employees whose names start with &#39;J&#39; and end with &#39;S&#39;.
9. Write a query to find all employees whose names have &#39;R&#39; as the third character and &#39;E&#39; as
the fifth character.
10. Write a query to retrieve all employees whose names start with a vowel (A, E, I, O, U).
11. Write a query to retrieve all employee names who have a NULL value in the manager
column.
12. Write a query to retrieve all employee numbers and commission who have a NOT NULL
value in the commission column.
13. Write a query to retrieve all employees who have a hire date that is NOT NULL.
14. Write a query to find all employees whose manager is NOT NULL and whose
commission is NULL.

Database Systems UNYT

Page 9 of
15. Write a query to retrieve all employee names who have both a NOT NULL value in the
job column and a NULL value in the commission column.
16. Write a query to retrieve all employees who have a NOT NULL value in the department
number column and a salary that is greater than 1500
17. Write a query to find all employees whose job title is &#39;MANAGER&#39; and whose
commission is NULL.
18. Write a query to retrieve all employee names and their hire dates where the hire date is
NOT NULL and the employee number is less than 7900.
19. Write a query to find all employees whose job title is &#39;SALESMAN&#39; and whose manager
is NOT NULL.
20. Write a query to retrieve all employee names and salaries who have a salary between
1000 and 3000.
21. Write a query to retrieve all employee names and hiredate who were hired between
January 1st, 1980 and December 31st, 1985.
22. Write a query to find all employees whose manager&#39;s employee number is between 7500
and 7900.
23. Write a query to retrieve all employees who belong to departments 10 through 30.
24. Write a query to find all employees whose commission is between 500 and 1500 or salary
is between 1000 and 2000.
25. Write a query to retrieve all employees whose employee number is between 7400 and
7900, and whose job title is &#39;CLERK&#39;.
26. Write a query to find all employees who were hired in the years 1981, 1982, or 1983.
27. Write a query to retrieve all employees who have a salary between 2000 and 4000 and
belong to department 20.
28. Write a query to find all employees whose commission is between 0 and 1000, inclusive.
29. Write a query to retrieve all employees who were hired between July 1st, 1981 and June
30th, 1984.
30. Write a query to retrieve all employees who have a salary greater than 800 and a
commission less than 1000.
31. Write a query to retrieve all employees who were hired before January 1st, 1982 or
whose job title is &#39;MANAGER&#39;.
32. Write a query to find all employees whose salary is less than 1000 and who belong to
department 10 or 30.
33. Write a query to retrieve all employees who are not managers and who have a salary
greater than 1500 or a commission greater than 500.
34. Write a query to find all employees whose name starts with the letter &#39;S&#39; and whose job
title is either &#39;CLERK&#39; or &#39;SALESMAN&#39;.
35. Write a query to retrieve all employees who were hired after January 1st, 1980 and whose
manager&#39;s employee number is less than 7700.
36. Write a query to find all employees whose commission is either NULL or less than 1000,
and whose department number is not 20.

37. Write a query to retrieve all employees whose salary is between 1000 and 3000,
inclusive, and whose job title is not &#39;ANALYST&#39;.
38. Write a query to find all employees whose name does not end with the letter &#39;S&#39; and who
have either a manager with employee number greater than 7800 or a hire date before
January 1st, 1985.