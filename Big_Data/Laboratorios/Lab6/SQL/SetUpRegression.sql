 ALTER DATABASE CURRENT SET QUERY_STORE CLEAR;
 GO
 ALTER DATABASE CURRENT SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL);
 GO
 DROP INDEX IF EXISTS IX_OrderHistory_CustomerDate ON dbo.OrderHistory;
 CREATE NONCLUSTERED INDEX IX_OrderHistory_CustomerDate
 ON dbo.OrderHistory (CustomerID, OrderDate DESC);
 GO
 INSERT INTO dbo.OrderHistory (CustomerID, ProductID, OrderDate, Quantity, UnitPrice, Status)
 SELECT TOP 50000
     1,
     p.ProductID,
     DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 365, GETDATE()),
     ABS(CHECKSUM(NEWID())) % 10 + 1,
     p.ListPrice,
     N'Pending'
 FROM SalesLT.Product AS p
 CROSS JOIN SalesLT.Product AS p2
 ORDER BY NEWID();
 GO
 UPDATE STATISTICS dbo.OrderHistory;
 GO
  CREATE OR ALTER PROCEDURE dbo.GetCustomerOrders
     @CustomerID INT
 AS
 BEGIN
     SELECT
         oh.OrderID,
         oh.OrderDate,
         p.Name AS ProductName,
         oh.Quantity,
         oh.UnitPrice,
         oh.TotalAmount,
         oh.Status
     FROM dbo.OrderHistory AS oh
     INNER JOIN SalesLT.Product AS p
         ON oh.ProductID = p.ProductID
     WHERE oh.CustomerID = @CustomerID
     ORDER BY oh.OrderDate DESC;
 END;