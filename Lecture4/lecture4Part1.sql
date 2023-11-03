SELECT
    *
FROM
    emp;

SELECT
    ename,
    &&column
FROM
    emp
WHERE
    job = '&JOB';

SELECT
    ename,
    &&column
FROM
    emp
WHERE
    deptno = &deptno
ORDER BY
    &column;

SELECT
    ename,
    &column
FROM
    emp
WHERE
    deptno = 20;

define;

UNDEFINE column;

SELECT
    firstname,
    lastname,
FROM
    customers
WHERE
    lower(lastname) = 'nelson';
SELECT
    firstname,
    lastname,
    lower(lastname) "lastname in lower"
FROM
    customers
WHERE
    lower(lastname) = 'nelson';

SELECT DISTINCT
    zip,
    substr(zip, 1, 3),
    substr(zip, - 3, 2)
FROM
    customers
WHERE
    substr(zip, - 3, 2) < 30;

SELECT
    substr(contact, instr(contact, ' '))
    || ','
       || substr(contact, 1, instr(contact, ' ') - 1)
          || ','
             || phone
FROM
    publisher;

SELECT
    name,
    instr(name, ',')              "First Comma",
    instr(name, ',', 10)          "Start read position 10",
    instr(name, ',', 1, 2)        "Second Comma"
FROM
    contacts;

SELECT
    contact,
    ltrim(substr(contact,(instr(contact, ' '))), ' '),
    substr(contact,(instr(contact, ' ') + 1)),
    substr(contact, 1, instr(contact, ' ')),
    phone AS name
FROM
    publisher;

SELECT
    substr(name, instr(name, ',') + 1, instr(name, ',', 1, 2) - instr(name, ',') - 1) first,
    instr(name, ',', 1, 2),
    instr(name, ','),
    instr(name, ',', 1, 2) - instr(name, ',') - 1,
    name
FROM
    contacts;

SELECT DISTINCT
    length(address)
FROM
    customers
ORDER BY
    length(address) DESC;

SELECT
    firstname,
    lpad(firstname, 12, ' '),
    lpad(firstname, 12, '*')
FROM
    customers
WHERE
    firstname LIKE 'J%';
SELECT
    lastname,address,
    ltrim(address,'P.O. BOX')
    FROM
    customers
WHERE
    state='FL';name,
SELECT
    address,
    replace(address, 'P.O.', 'post office')
FROM
    customers
WHERE
    state = 'FL';

SELECT
    name,
    translate(name, ',', '-'),
    translate(name, ',A', '-a')
FROM
    contacts;

SELECT
    firstname,
    lastname,
    concat('Customer number: ', customer#) "Number"
FROM
    customers
WHERE
    state = 'FL';

SELECT
    title,
    retail,
    round(retail, 1),
    round(retail, 0),
    round(retail, - 1)
FROM
    books;

SELECT
    title,
    retail,
    trunc(retail, 1),
    trunc(retail, 0),
    trunc(retail, - 1)
FROM
    books;

SELECT
    235 / 16
FROM
    dual;

SELECT
    trunc(235 / 16, 0)      lbs,
    mod(235, 16)            oz
FROM
    dual;

SELECT
    pubdate,
    sysdate,
    round(pubdate - sysdate)             "Days",
    abs(round(pubdate - sysdate))        "ABS Days"
FROM
    books
WHERE
    category = 'CHILDREN';

SELECT
    power(3, 3) "Raised"
FROM
    dual;

SELECT
    order#,
    shipdate,
    orderdate,
    ( shipdate - orderdate ) delay
FROM
    orders;

SELECT
    title,
    months_between(orderdate, pubdate) mths
FROM
         books
    JOIN orderitems USING ( isbn )
    JOIN orders USING ( order# )
WHERE
    order# = 1004;
select title,pubdate,add_months('01-DEC-08',18)"Renegotiate Date",
ADD_MONTHS(pubdate,84) "Drop Date"
FROM books WHERE category='COMPUTER'
ORDER BY "Renegotiate Date";
SELECT ORDER#,ORDERDATE,NEXT_DAY(ORDERDATE,'MONDAY')
FROM orders
WHERE order#=1018;
select order#,orderdate,shipdate,last_day(shipdate)
FROM orders
--WHERE orderdate=TO_DATE('March 31, 2009','Month DD, YYYY');
WHERE orderdate=TO_DATE('March 31, 2009','Month,dd, YY');
select pubdate,ROUND(pubdate,'MONTH'), ROUND(pubdate,'YEAR')
from books;
SELECT
    title,
    TRUNC(months_between(orderdate, pubdate),0)MTHS
FROM
         books
    JOIN orderitems USING ( isbn )
    JOIN orders USING ( order# )
WHERE
    order# = 1004;
select sysdate, current_date FROM
dual;
--select * from suppliers;
SELECT
    order#,
    orderdate,
    shipdate,
    nvl(shipdate, '06-APR-09') - orderdate "Ship Days"
FROM
    orders
WHERE
    orderdate >= '03-APR-09';

SELECT
    order#,
    orderdate,
    shipdate,
    nvl2(shipdate, 'Shiped', 'Not shipped') "Ship Days"
FROM
    orders
WHERE
    orderdate >= '03-APR-09';

SELECT
    o.customer#,
    order#,
    isbn,
    oi.paideach,
    b.retail,
    NULLIF(oi.paideach, b.retail),
    coalesce(to_char(NULLIF(oi.paideach, b.retail)),'Same')
FROM
         orders o
    JOIN orderitems  oi USING ( order# )
    JOIN books       b USING ( isbn )
--WHERE    order# IN ( 1001, 1007 )
ORDER BY    order#;