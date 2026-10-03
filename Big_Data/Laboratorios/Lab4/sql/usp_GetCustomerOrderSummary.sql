USE [AdventureWorksLT];
GO

/*
    Procedure: usp_GetCustomerOrderSummary
    Purpose:   Return order totals and the last order date for customers.
    Author:    Copilot
*/
CREATE OR ALTER PROCEDURE [dbo].[usp_GetCustomerOrderSummary]
    @CustomerID INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        SELECT
            c.[FirstName] + N' ' + c.[LastName] AS [CustomerName],
            COUNT(DISTINCT soh.[SalesOrderID]) AS [TotalOrders],
            COALESCE(SUM(sod.[LineTotal]), CONVERT(MONEY, 0)) AS [TotalOrderAmount],
            MAX(soh.[OrderDate]) AS [LastOrderDate]
        FROM [SalesLT].[Customer] AS c
        LEFT JOIN [SalesLT].[SalesOrderHeader] AS soh
            ON soh.[CustomerID] = c.[CustomerID]
        LEFT JOIN [SalesLT].[SalesOrderDetail] AS sod
            ON sod.[SalesOrderID] = soh.[SalesOrderID]
        WHERE @CustomerID IS NULL
            OR c.[CustomerID] = @CustomerID
        GROUP BY
            c.[CustomerID],
            c.[FirstName],
            c.[LastName];
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH;
END;
GO