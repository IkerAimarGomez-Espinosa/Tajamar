  SELECT
     oh.CustomerID,
     p.Name AS ProductName,
     pc.Name AS CategoryName,
     oh.Status,
     COUNT(*) AS OrderCount,
     SUM(oh.TotalAmount) AS TotalRevenue,
     AVG(oh.TotalAmount) AS AvgOrderValue,
     STDEV(oh.TotalAmount) AS StdDevOrderValue,
     RANK() OVER (PARTITION BY oh.Status
         ORDER BY SUM(oh.TotalAmount) DESC) AS StatusRevenueRank,
     PERCENT_RANK() OVER (PARTITION BY pc.Name
         ORDER BY AVG(oh.TotalAmount)) AS CategoryPctRank,
     SUM(COUNT(*)) OVER (PARTITION BY oh.Status) AS StatusTotalOrders
 FROM dbo.OrderHistory AS oh
 INNER JOIN SalesLT.Product AS p
     ON oh.ProductID = p.ProductID
 INNER JOIN SalesLT.ProductCategory AS pc
     ON p.ProductCategoryID = pc.ProductCategoryID
 GROUP BY oh.CustomerID, p.Name, pc.Name, oh.Status
 ORDER BY TotalRevenue DESC;

 SELECT q.query_id, qt.query_sql_text
 FROM sys.query_store_query_text AS qt
 INNER JOIN sys.query_store_query AS q
     ON qt.query_text_id = q.query_text_id
 WHERE qt.query_sql_text LIKE '%RevenueRank%PARTITION%'
     AND qt.query_sql_text NOT LIKE '%query_store%';

 EXEC sp_query_store_set_hints
     @query_id = 27,
     @query_hints = N'OPTION (MAXDOP 1)';

 EXEC sp_query_store_clear_hints @query_id = 27;