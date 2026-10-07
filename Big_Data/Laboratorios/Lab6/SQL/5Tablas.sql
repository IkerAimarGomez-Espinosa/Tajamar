 SELECT
     p.Name AS ProductName,
     p.ProductNumber,
     oh.OrderDate,
     oh.Quantity,
     oh.TotalAmount
 FROM dbo.OrderHistory AS oh
 INNER JOIN SalesLT.Product AS p
     ON oh.ProductID = p.ProductID
 WHERE oh.Status = N'Pending'
     AND oh.OrderDate >= DATEADD(MONTH, -1, GETDATE())
 ORDER BY oh.TotalAmount DESC;
 GO 5