-- T-systems --> Homework 22.7.2015
SELECT 
    *
FROM
    track
WHERE
    Composer = 'U2';
SELECT 
    CONCAT(ROUND(Milliseconds / 1000, 2), ' s')
FROM
    track
WHERE
    Composer = 'U2' AND Name = 'One';
SELECT 
    FirstName, LastName
FROM
    customer
WHERE
    Country = 'Czech Republic';
SELECT 
    Name,
    Composer,
    CONCAT(ROUND(UnitPrice, 2), ' $') AS 'USD',
    CONCAT(ROUND(UnitPrice * 0.76, 2), ' €') AS 'EUR',
    CONCAT(ROUND(UnitPrice * 19.20, 2), ' CK') AS 'CZK'
FROM
    track;
SELECT 
    InvoiceId, InvoiceDate
FROM
    invoice
WHERE
    BillingCountry = 'United Kingdom'
        AND InvoiceDate BETWEEN '2013-05-01' AND '2013-05-31';
SELECT 
    *
FROM
    employee
WHERE
    Country <> 'USA';
SELECT 
    *
FROM
    employee
WHERE
    BirthDate BETWEEN '1970-1-1' AND '1979-12-31'
ORDER BY BirthDate ASC;
SELECT 
    *
FROM
    employee
WHERE
    MONTH(BirthDate) = 2;
SELECT 
    *
FROM
    customer
WHERE
    Email LIKE '%@yahoo.com'
        OR Email LIKE '%@gmail.com';
SELECT 
    FirstName,
    LastName,
    BirthDate,
    ROUND(DATEDIFF(CURDATE(), BirthDate) / 365) AS 'Years'
FROM
    employee;