

CREATE TABLE Customers1 (
	CustomerID INT IDENTITY (1, 1) NOT NULL,
	FirstName NVARCHAR(250) NOT NULL,
	LastName NVARCHAR(250) NOT NULL,
	Cardnumber INT
);

--add constraints to Customers table
ALTER TABLE Customers1
	ADD CONSTRAINT PK_Customers PRIMARY KEY (CustomerID);


CREATE TABLE Products (
	ProductID INT IDENTITY (1, 1) NOT NULL,
	Name NVARCHAR(250) NOT NULL,
	Price DECIMAL(5,2) NOT NULL
);

--add constraints to Product table
ALTER TABLE Products
	ADD CONSTRAINT PK_Products PRIMARY KEY (ProductID);


CREATE TABLE Orders (
	OrdersID INT NOT NULL,
	ProductID INT NOT NULL,
	CustomerID INT NOT NULL
);

-- add constraints to Orders table
ALTER TABLE Orders
	ADD CONSTRAINT PK_Orders PRIMARY KEY (CustomerID, ProductID);					
ALTER TABLE Orders
	ADD CONSTRAINT FK_Orders_Customers1_CustomerID FOREIGN KEY (CustomerID)
		REFERENCES Customers1 (CustomerID) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Orders
	ADD CONSTRAINT FK_Orders_Products_ProductID FOREIGN KEY (ProductID)
		REFERENCES Products (ProductID) ON DELETE CASCADE ON UPDATE CASCADE;


Select * FROM Customers1;
Select * FROM Products;
Select * FROM Orders;

INSERT INTO Customers1 (FirstName, LastName) VALUES ('Pamela', 'Soulis');
INSERT INTO Customers1 (FirstName, LastName) VALUES ('Alejandro', 'Lopez');
INSERT INTO Customers1 (FirstName, LastName) VALUES ('Jane', 'Doe');
INSERT INTO Customers1 (FirstName, LastName) VALUES ('Tina', 'Smith');

INSERT INTO Products (Name, Price) VALUES ('iPhone', '200');
INSERT INTO Products (Name, Price) VALUES ('iPad', '300');
INSERT INTO Products (Name, Price) VALUES ('MacBook', '900');

INSERT INTO Orders (OrdersID, CustomerID, ProductID) VALUES (1, 4, 1);
INSERT INTO Orders (OrdersID, CustomerID, ProductID) VALUES (2, 1, 1);
INSERT INTO Orders (OrdersID, CustomerID, ProductID) VALUES (3, 2, 1);

SELECT * 
	FROM Orders
	WHERE CustomerID = 4;