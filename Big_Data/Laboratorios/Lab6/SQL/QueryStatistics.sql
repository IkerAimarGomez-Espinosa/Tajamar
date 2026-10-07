 SET STATISTICS IO ON;
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
 WHERE oh.CustomerID = 29485
     AND oh.OrderDate >= DATEADD(MONTH, -3, GETDATE())
 ORDER BY oh.OrderDate DESC;
 SET STATISTICS IO OFF;