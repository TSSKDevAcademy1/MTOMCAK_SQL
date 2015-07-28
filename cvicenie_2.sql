-- 1. Aká bola tržba z objednávok v máji 2013? Pre overenie správnosti bola táto tržba 37.62.

SELECT 
    SUM(UnitPrice * Quantity)
FROM
    invoiceline il
        JOIN
    invoice i USING (invoiceId)
WHERE
    InvoiceDate BETWEEN '2013-05-1' AND '2013-05-31';

-- OTHER METHOD
SELECT 
    SUM(UnitPrice * Quantity)
FROM
    invoiceline il
        JOIN
    invoice i ON i.invoiceId = il.invoiceId
        AND invoiceDate LIKE '%2013-05%';
    
    
    
-- 2. Vypíšte sumárne zisky z predaja po jednotlivých rokoch. 
-- Pre overenie správnosti dopytu viete, že celkový zisk z predaja v roku 2009 bol $449.46.
SELECT 
    SUM(UnitPrice * Quantity), YEAR(i.InvoiceDate) 'year'
FROM
    invoiceline il
        JOIN
    invoice i USING (InvoiceId)
GROUP BY YEAR(i.InvoiceDate);

-- 3. Koľko skladieb sa nachádza v albume War? Pre overenie správnosti ich je 10.
SELECT 
    COUNT(*)
FROM
    album a
        JOIN
    track t USING (AlbumId)
WHERE
    a.Title = 'War';

-- 4. Zistite celkový čas prehrávania albumu “War” od “U2” v minútach a sekundách 
-- (milisekundy treba previest na minuty a sekundy). (42 min a 10 sek)
SELECT 
    ROUND(SUM((Milliseconds / 1000) / 60)) AS 'min',
    ROUND((SUM(Milliseconds) / 1000) % 60)
FROM
    album a
        JOIN
    track t USING (AlbumId)
WHERE
    a.Title = 'War';

-- 5. Vypíšte zisky z predaja podľa jednotlivých krajín za rok 2012. 
-- Zoznam zoraďte podľa zisku od najvyšších po najnižšie. 
-- Pre overenie správnosti najvyššie zisky v roku 2012 boli dosiahnuté 
-- predajom v USA a najnižšie v Holandsku (20 záznamov, prvý je dvojica ‘USA’, 127.98).

SELECT 
    BillingCountry,
    SUM(UnitPrice * Quantity) AS 'Zisk za rok 2012'
FROM
    invoice i
        JOIN
    invoiceline il USING (InvoiceId)
WHERE
    YEAR(InvoiceDate) = 2012
GROUP BY BillingCountry
ORDER BY SUM(UnitPrice * Quantity) DESC;


-- 6. Zistite čas v sekundách najdlhšej skladby, najkratšej skladby a priemerný čas skladieb albumu War od U2.
SELECT 
    MAX(Milliseconds / 1000) AS 'Longest track',
    MIN(Milliseconds / 1000) AS 'Shortest track',
    AVG(Milliseconds / 1000) AS 'Average track time'
FROM
    album a
        JOIN
    track t USING (AlbumId)
WHERE
    a.Title = 'War';

-- 7. Vypíšte sumárne zisky z predaja za jednotlivé mesiace a roky. Pre overenie správnosti dopytu viete, že v 
-- apríli 2011 bol celkový zisk z predaja $51.62.
SELECT 
    EXTRACT(YEAR FROM (i.InvoiceDate)) AS 'ROK',
    EXTRACT(MONTH FROM (i.InvoiceDate)) AS 'Mesiac',
    SUM(UnitPrice * Quantity) AS 'Money'
FROM
    invoiceline il
        JOIN
    invoice i USING (InvoiceId)
GROUP BY MONTH(i.InvoiceDate) , YEAR(i.InvoiceDate)
ORDER BY i.InvoiceDate , InvoiceDate;
	

-- 8. Aký skladateľ je najobľúbenejší u zákazníka Wyatta Girarda? (najobľúbenejší - kupoval ho najčastejšie, hodí sa vám LIMIT).
SELECT 
    T.Composer
FROM
    customer c
        JOIN
    invoice I ON c.CustomerId = I.CustomerId
        AND c.FirstName = 'Wyatt'
        AND c.LastName = 'Girard'
        JOIN
    invoiceline IL USING (invoiceId)
        JOIN
    track T USING (trackId)
WHERE
    composer IS NOT NULL
GROUP BY T.composer
ORDER BY COUNT(*) DESC
LIMIT 1;
