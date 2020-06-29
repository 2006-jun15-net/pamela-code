SELECT CustomerId, FirstName, LastName, Country FROM Customer WHERE Country<>'USA';

SELECT CustomerId, FirstName, LastName, Country FROM Customer WHERE Country='Brazil';

SELECT Title FROM Employee WHERE Title='Sales Support Agent';

SELECT DISTINCT BillingCountry FROM Invoice;



SELECT COUNT(*) as 'Invoices',
	SUM(Total) as 'Totals'
	FROM Invoice
	WHERE InvoiceDate LIKE '%2009%'; 
	--WHERE InvoiceDate >= '2009' AND InvoiceDate < '2010';
	--WHERE YEAR(InvoiceDate) >= 2009; built-in function to extract parts of a date

SELECT YEAR(InvoiceDate) AS InvoiceYear, COUNT(*) AS InvoiceCount, SUM(Total) AS SalesTotal
FROM Invoice
GROUP BY YEAR(InvoiceDate)
ORDER BY InvoiceYear DESC;

SELECT * FROM InvoiceLine;
SELECT COUNT(InvoiceLineId) 
	FROM InvoiceLine
	WHERE InvoiceId='37';

SELECT BillingCountry, COUNT(*)
	FROM Invoice
	GROUP BY BillingCountry;

SELECT BillingCountry,
	SUM(Total) 
	FROM Invoice
	GROUP BY BillingCountry;


SELECT * FROM Invoice;
SELECT * FROM Customer;
SELECT * FROM Employee;
--1
SELECT * FROM Invoice LEFT JOIN Customer ON Invoice.CustomerId=Customer.CustomerId WHERE Customer.Country='Brazil';

--2
SELECT i.*, e.FirstName, e.LastName
FROM Invoice AS i
	LEFT JOIN Customer AS c ON i.CustomerId=c.CustomerId
	LEFT JOIN Employee as e ON c.SupportRepId=e.EmployeeId


--3
SELECT p.PlaylistId, p.Name, COUNT(*) AS "Number of Tracks"
FROM Playlist AS p
	LEFT JOIN PlaylistTrack AS pt ON p.PlaylistId= pt.PlaylistId
GROUP BY p.PlaylistId, p.Name;


--which artists didn't make any albums at all
-- join version
SELECT ar.Name
FROM Artist AS ar
	LEFT JOIN Album AS al ON ar.ArtistId=al.ArtistId 
WHERE al.AlbumId IS NULL;
-- CTE version
WITH the_albums AS (
	SELECT ArtistId FROM Album
) 
SELECT Artist.Name FROM Artist WHERE ArtistId NOT IN (
	SELECT * FROM the_albums
);

--which artists did not record any tracks of the Latin genre?
--subquery version
SELECT *
FROM Artist 
WHERE ArtistId NOT IN(		--all the artists who wrote such an album
	SELECT ArtistId FROM Album WHERE AlbumId IN(	--all the albums with a latin song 
		SELECT AlbumId					
		FROM Track				--all the genres named latin
		WHERE GenreId IN (SELECT GenreId FROM Genre WHERE Name = 'Latin')
	)
);
-- join and set-op version
SELECT * FROM Artist
EXCEPT
SELECT ar.*
FROM Artist AS ar
	INNER JOIN Album AS al ON ar.ArtistId=al.ArtistId
	INNER JOIN Track AS t ON al.AlbumId=t.AlbumId
	INNER JOIN Genre AS g ON t.GenreId=g.GenreId
WHERE g.Name = 'Latin';

--Insert new record into the Employee table
SELECT * FROM Employee;
INSERT INTO Employee (EmployeeId, LastName, FirstName) VALUES (9, 'Pamela', 'Soulis');

--Insert new record into the Tracks table
SELECT * FROM Track;
INSERT INTO Track VALUES (3504, 'Dreams', 347, 5, 1, 'Fleetwood Mac', 343729, 11170434, 0.99);

--change customer Aaron Mitchell to Robert Walter
SELECT * FROM Customer;
SELECT CustomerId FROM Customer WHERE FirstName='Aaron' AND LastName='Mitchell';
UPDATE Customer
SET FirstName='Robert' --AND LastName='Walter'
WHERE (SELECT CustomerId FROM Customer WHERE FirstName='Aaron' AND LastName='Mitchell');



--create a database
CREATE TABLE Department(
	ID int NOT NULL PRIMARY KEY,
	Name varchar(100),
	Location varchar(100)
);
CREATE TABLE Worker(
	ID int NOT NULL PRIMARY KEY,
	FirstName varchar(100),
	LastName varchar(100),
	SSN int,
	DeptID int FOREIGN KEY REFERENCES Department(ID)
);
CREATE TABLE EmpDetails(
	ID int NOT NULL PRIMARY KEY,
	EmployeeID int FOREIGN KEY REFERENCES Worker(ID),
	Salary money,
	FirstAddress varchar(100),
	SecondAddress varchar(100),
	City varchar(100),
	State varchar(100),
	Country varchar(100)
);

--Insert records in the tables
SELECT * FROM Department;
SELECT * FROM Worker;
SELECT * FROM EmpDetails;


INSERT INTO Department VALUES(1,'Marketing','Downtown');
INSERT INTO Department VALUES(2,'Tech','Downtown');

INSERT INTO Worker VALUES(1,'Pamela','Soulis',123456789,1)
INSERT INTO Worker VALUES(2,'Tina','Smith',234567891,1);
INSERT INTO Worker VALUES(3,'Alejandro','Lopez',345678912,2);

INSERT INTO EmpDetails VALUES(1,1,$50000, '4942', 'Willow St.', 'Denver', 'CO', 'USA');
INSERT INTO EmpDetails VALUES(2,2,$50000, '70', 'Morningside Dr.', 'New York', 'NY', 'USA');
INSERT INTO EmpDetails VALUES(3,3,$90000, '4942', 'Willow St.', 'Denver', 'CO', 'USA');



