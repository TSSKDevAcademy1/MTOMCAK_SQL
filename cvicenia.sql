
-- Cvicenie 24.7

CREATE VIEW totalRevenue AS
    SELECT 
        il.InvoiceId AS 'Id invoice line',
        (il.Quantity * il.UnitPrice) AS 'Revenue'
    FROM
        invoiceline il
            JOIN
        invoice i USING (invoiceId)
    GROUP BY invoiceId;
SELECT 
    *
FROM
    totalRevenue;

-- 2. Vypíšte zoznam všetkých umelcov v databáze, ktorý vznikne spojením záznamov z tabuľky Artist a Track. 
-- Výsledný zoznam usporiadajte podľa abecedy. Pre overenie správnosti vášho dopytu bude výsledný zoznam obsahovať 1080 záznamov.

SELECT 
    name
FROM
    artist 
UNION SELECT 
    Composer
FROM
    track
WHERE
    Composer IS NOT NULL
ORDER BY name ASC;

-- 3. Zistite najdlhšiu skladbu a najkratšiu skladbu v albume War od U2.

SELECT 
    *
FROM
    track
WHERE
    Milliseconds IN (SELECT 
            MAX(track.Milliseconds)
        FROM
            album
                JOIN
            track USING (AlbumId)
        WHERE
            track.Composer = 'U2'
                AND album.Title = 'WAR') 
UNION SELECT 
    *
FROM
    track
WHERE
    Milliseconds IN (SELECT 
            MIN(track.Milliseconds)
        FROM
            album
                JOIN
            track USING (AlbumId)
        WHERE
            track.Composer = 'U2'
                AND album.Title = 'WAR')
;

   
-- 4. vypíšte názvy všetkých skladieb, ktoré nepatria do playlistu Music Videos. Pre overenie správnosti je celkový počet týchto skladieb 3502.
SELECT 
    Name
FROM
    track
WHERE
    NOT TrackId IN (SELECT 
            TrackId
        FROM
            playlisttrack
        WHERE
            PlaylistId = (SELECT 
                    playlistId
                FROM
                    playlist
                WHERE
                    name = 'Music Videos'));


-- 5. Vypíšte zoznam skladieb, ktoré neboli kúpené ani raz. Pre overenie správnosti dopytu vedzte, že počet týchto skladieb je 1519.   
SELECT 
    *
FROM
    track
WHERE
    NOT TrackId IN (SELECT 
            TrackId
        FROM
            invoiceline);


-- 6. Vypíšte zoznam skladieb, ktoré boli kúpené aspoň 100x. Pre overenie správnosti dopytu vedzte, že počet týchto skladieb je 0 a počet skladieb predaných práve 2x je 256
SELECT 
    *
FROM
    track
        JOIN
    invoiceline USING (trackId)
GROUP BY TrackId
HAVING COUNT(*) = 2;


-- 7. Vypíšte prvých 10 jedinečných (neopakujúcich sa) názvov skladieb z playlistu 'TV Shows' usporiadaných 
-- podľa abecedy vzostupne (pre overenie je prvá “?” a posledná Adrift).
SELECT DISTINCT
    t.name
FROM
    track t
        JOIN
    playlistTrack pt USING (trackId)
        JOIN
    playlist p ON pt.playlistId = p.playlistId
        AND p.name = 'TV Shows'
ORDER BY t.name ASC
LIMIT 10;


-- Nájdite menovcov s rovnakým krstným menom (priezvisko nemusí byť rovnaké) v tabuľke zákazníkov. 
-- Vypíšte ich spoločné krstné meno ako name, potom priezvisko prvého menovca, a priezvisko druhého menovca. 
-- Na overenie je jeden pár menovcov Mark Philips a Mark Taylor a všetkých takýchto párov je počet 3. Každú dvojicu vypíšte iba raz.
SELECT 
    FirstName, LastName
FROM
    customer
WHERE
    FirstName IN ((SELECT 
            FirstName
        FROM
            customer
        GROUP BY FirstName
        HAVING COUNT(*) > 1));
-- select FirstName as 'Name', LastName as 'First LastNamesake', LastName as 'Second LastNamesake' from customer where FirstName in (select FirstName from customer group by FirstName having count(*) > 1);

SELECT 
    *
FROM
    artist ar
        JOIN
    album al ON ar.ArtistId = al.ArtistId
        AND ar.Name = 'U2';

-- Vypíšte zoznam všetkých videosúborov.
SELECT 
    *
FROM
    track t
        JOIN
    mediatype m ON t.MediaTypeId = m.MediaTypeId
        AND m.Name LIKE '%video%';

-- Zobrazte všetky skladby (ich názvy, interpreta, dĺžka trvania v sekundách), 
-- ktoré sa nachádzajú v playliste 90’s Music. Skladby vypíšte usporiadané podľa ich názvu. 
-- Nevypisujte však tie skladby, ktoré nemajú uvedené interpreta (stĺpec COMPOSER má hodnotu NULL). 
-- Pre overenie správnosti je počet týchto skladieb 1210.
SELECT 
    t.Name, t.Composer, ROUND((t.Milliseconds / 1000), 2) AS 's'
FROM
    playlisttrack
        JOIN
    playlist pl USING (PlaylistId)
        JOIN
    track t USING (TrackId)
WHERE
    t.Composer IS NOT NULL
        AND pl.Name = '90’s Music'
ORDER BY Name ASC;
