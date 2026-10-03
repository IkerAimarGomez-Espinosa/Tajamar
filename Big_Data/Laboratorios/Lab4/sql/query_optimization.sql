 SELECT *
 FROM SalesLT.SalesOrderHeader h, SalesLT.SalesOrderDetail d, SalesLT.Product p
 WHERE h.SalesOrderID = d.SalesOrderID
 AND d.ProductID = p.ProductID
 AND h.OrderDate > '2008-01-01'