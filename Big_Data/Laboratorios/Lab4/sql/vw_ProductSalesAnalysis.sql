USE [AdventureWorksLT];
GO

/*
    View:      vw_ProductSalesAnalysis
    Purpose:   Summarize sales performance for each product.
    Author:    Copilot
*/
CREATE OR ALTER VIEW [SalesLT].[vw_ProductSalesAnalysis]
AS
    SELECT
        p.[Name] AS [ProductName],
        pc.[Name] AS [CategoryName],
        COALESCE(SUM(sod.[OrderQty]), 0) AS [TotalQuantitySold],
        COALESCE(SUM(sod.[LineTotal]), CONVERT(MONEY, 0)) AS [TotalRevenue],
        AVG(sod.[UnitPrice]) AS [AverageSalePrice],
        COUNT(DISTINCT soh.[SalesOrderID]) AS [NumberOfOrders]
    FROM [SalesLT].[Product] AS p
    LEFT JOIN [SalesLT].[ProductCategory] AS pc
        ON pc.[ProductCategoryID] = p.[ProductCategoryID]
    LEFT JOIN [SalesLT].[SalesOrderDetail] AS sod
        ON sod.[ProductID] = p.[ProductID]
    LEFT JOIN [SalesLT].[SalesOrderHeader] AS soh
        ON soh.[SalesOrderID] = sod.[SalesOrderID]
    GROUP BY
        p.[ProductID],
        p.[Name],
        pc.[Name];
GO