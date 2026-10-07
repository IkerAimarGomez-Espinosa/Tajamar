SELECT
    q.query_id,
    p.plan_id,
    p.is_forced_plan,
    p.force_failure_count,
    qt.query_sql_text
FROM sys.query_store_plan AS p
INNER JOIN sys.query_store_query AS q
    ON p.query_id = q.query_id
INNER JOIN sys.query_store_query_text AS qt
    ON q.query_text_id = qt.query_text_id
WHERE p.is_forced_plan = 1;
GO
EXEC dbo.GetCustomerOrders @CustomerID = 29485;
GO
EXEC dbo.GetCustomerOrders @CustomerID = 1;
GO
DROP PROCEDURE IF EXISTS dbo.GetCustomerOrders;
GO
DROP INDEX IX_OrderHistory_CustomerDate ON dbo.OrderHistory;
GO
CREATE NONCLUSTERED INDEX IX_OrderHistory_CustomerDate
ON dbo.OrderHistory (CustomerID, OrderDate DESC)
INCLUDE (ProductID, Quantity, UnitPrice, Status);