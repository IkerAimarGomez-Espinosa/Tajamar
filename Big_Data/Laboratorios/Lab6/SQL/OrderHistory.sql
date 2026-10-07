 DROP TABLE IF EXISTS dbo.OrderHistory;

 CREATE TABLE dbo.OrderHistory (
     OrderID INT IDENTITY(1,1) PRIMARY KEY,
     CustomerID INT NOT NULL,
     ProductID INT NOT NULL,
     OrderDate DATETIME NOT NULL,
     Quantity INT NOT NULL,
     UnitPrice DECIMAL(10,2) NOT NULL,
     TotalAmount AS (Quantity * UnitPrice) PERSISTED,
     Status NVARCHAR(20) NOT NULL
 );

 -- Insert 80,000 rows referencing real AdventureWorksLT customers and products
 INSERT INTO dbo.OrderHistory (CustomerID, ProductID, OrderDate, Quantity, UnitPrice, Status)
 SELECT TOP 80000
     c.CustomerID,
     p.ProductID,
     DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 365, GETDATE()),
     ABS(CHECKSUM(NEWID())) % 10 + 1,
     p.ListPrice,
     CASE ABS(CHECKSUM(NEWID())) % 4
         WHEN 0 THEN N'Pending'
         WHEN 1 THEN N'Processing'
         WHEN 2 THEN N'Shipped'
         ELSE N'Delivered'
     END
 FROM SalesLT.Customer AS c
 CROSS JOIN SalesLT.Product AS p
 ORDER BY NEWID();

  SELECT COUNT(*) AS TotalOrders FROM dbo.OrderHistory;
 GO

 CREATE NONCLUSTERED INDEX IX_OrderHistory_CustomerDate
 ON dbo.OrderHistory (CustomerID, OrderDate DESC)
 INCLUDE (ProductID, Quantity, UnitPrice, Status);