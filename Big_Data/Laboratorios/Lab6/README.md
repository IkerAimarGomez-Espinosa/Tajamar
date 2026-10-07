# Laboratorio 6

## Contenido

- [Provision an Azure SQL Database](#provision-an-azure-sql-database)
  - [Create Server](#create-server)
  - [Create Database Basic](#create-database-basic)
  - [Compute + Storage](#compute--storage)
  - [Create Database Networking](#create-database-networking)
  - [Create Database Additional Settings](#create-database-additional-settings)
- [Create the test workload](#create-the-test-workload)
  - [Conectar BD en SSMS](#conectar-bd-en-ssms)
  - [Script Order History](#script-order-history)
- [Enable and configure Query Store](#enable-and-configure-query-store)
- [Analyze execution plans and add a missing index](#analyze-execution-plans-and-add-a-missing-index)
  - [Actual Execution Plan](#actual-execution-plan)
  - [Statistics Query](#statistics-query)
  - [Execution Plan](#execution-plan)
  - [Clustered Index Scan OrderHistory](#clustered-index-scan-orderhistory)
  - [IndexScan RowNumbers](#indexscan-rownumbers)
  - [Missing Index](#missing-index)
  - [Index](#index)
  - [Logical Reads](#logical-reads)
  - [Create Cover Index](#create-cover-index)
  - [Index Seek](#index-seek)
- [Use DMVs to find the most expensive queries](#use-dmvs-to-find-the-most-expensive-queries)
  - [CPU Time](#cpu-time)
  - [5 Tablas](#5-tablas)
  - [Optimizer Recommendation](#optimizer-recommendation)
- [Simulate and detect a plan regression with Query](#simulate-and-detect-a-plan-regression-with-query)
  - [Set up regression](#set-up-regression)
  - [Cause Regression](#cause-regression)
  - [Query Store GUI](#query-store-gui)
  - [Forzar Plan](#forzar-plan)
  - [Verify plan forcing](#verify-plan-forcing)
- [Apply a Query Store hint](#apply-a-query-store-hint)
  - [Partitions Query](#partitions-query)
  - [Query Store Hint Plan](#query-store-hint-plan)
  - [Find Query_id](#find-query_id)
  - [Aply MAXDROP](#aply-maxdrop)
  - [Clear Hint](#clear-hint)
- [Identify and resolve blocking](#identify-and-resolve-blocking)
  - [3 Windows](#3-windows)
  - [Investigate Head Blocker](#investigate-head-blocker)
  - [Window 1 Rollback](#window-1-rollback)
  - [Window 2 Executed](#window-2-executed)

---

## Provision an Azure SQL Database

### Create Server

![Creación del servidor SQL de Azure (Create SQL Database Server)](img/CreateServer.png)

### Create Database Basic

![Create SQL Database - pestaña Basics (parte 1)](img/CreateDatabase_Basic_01.png)

![Create SQL Database - pestaña Basics (parte 2)](img/CreateDatabase_Basic_02.png)

### Compute + Storage

![Configuración de Compute + Storage](img/ComputeStorage.png)

### Create Database Networking

![Create SQL Database - pestaña Networking](img/CreateDatabase_Networking.png)

### Create Database Additional Settings

![Create SQL Database - pestaña Additional settings](img/CreateDatabase_AdditionalSettings.png)

## Create the test workload

### Conectar BD en SSMS

![Conexión a la base de datos desde SSMS](img/ConectarBD.png)

### Script Order History

![Script de creación de la tabla OrderHistory](img/OrderHistoryScript.png)

## Enable and configure Query Store

![Script para habilitar y configurar Query Store](img/QueryStoreScript.png)

## Analyze execution plans and add a missing index

### Actual Execution Plan

![Activar Include Actual Execution Plan](img/Actual_Execution_Plan.png)

### Statistics Query

![Consulta con estadísticas (SET STATISTICS) y su resultado](img/QueryStatistics.png)

### Execution Plan

![Plan de ejecución de la consulta](img/ExecutionPlan.png)

### Clustered Index Scan OrderHistory

![Clustered Index Scan sobre OrderHistory](img/Clustered_Index_Scan_OrderHistory.png)

### IndexScan RowNumbers

![Número de filas del Index Scan](img/IndexScan_RowNumbers.png)

### Missing Index

![Sugerencia de Missing Index en el plan de ejecución](img/Missing_Index.png)

### Index

![Definición del índice sugerido](img/Index.png)

### Logical Reads

![Lecturas lógicas sobre OrderHistory](img/LogicalReads_OrderHistory.png)

### Create Cover Index

![Creación del índice de cobertura](img/CreateCoverIndex.png)

### Index Seek

![Index Seek sobre el índice IX_OrderHistory](img/IX_OrderHistory.png)

## Use DMVs to find the most expensive queries

### CPU Time

![Top 5 consultas por tiempo de CPU](img/Top5_CPUTime.png)

### 5 Tablas

![Consulta sobre 5 tablas](img/5_Tablas.png)

### Optimizer Recommendation

![Recomendaciones del optimizador](img/Optimizer_Recommendations.png)

## Simulate and detect a plan regression with Query

### Set up regression

![Preparación del escenario de regresión](img/Setup_regression_scenario.png)

### Cause Regression

![Script que provoca la regresión del plan](img/Cause_Regression.png)

### Query Store GUI

![Interfaz gráfica de Query Store](img/Query_Store_GUI.png)

### Forzar Plan

![Forzar plan desde Query Store](img/Forzar_Plan.png)

### Verify plan forcing

![Script de verificación del plan forzado](img/Forzar_Plan_Script.png)

## Apply a Query Store hint

### Partitions Query

![Consulta con particiones (PARTITION BY)](img/Partitions%20Query.png)

### Query Store Hint Plan

![Plan de ejecución de la consulta - plan 1](img/QueryStoreHint_Plan1.png)

![Plan de ejecución de la consulta - plan 2](img/QueryStoreHint_Plan2.png)

![Plan de ejecución de la consulta - plan 3](img/QueryStoreHint_Plan3.png)

![Plan de ejecución de la consulta - plan 4](img/QueryStoreHint_Plan4.png)

### Find Query_id

![Consulta para localizar el query_id](img/Find_Query_id.png)

### Aply MAXDROP

![Aplicación del hint MAXDOP con Query Store](img/Aply%20Maxdrop1.png)

### Clear Hint

![Eliminación del hint de Query Store](img/Clear_Hint.png)

## Identify and resolve blocking

### 3 Windows

![Tres ventanas de consulta para simular el bloqueo](img/3_Windows.png)

### Investigate Head Blocker

![Resultados de la investigación del head blocker](img/Window3_Results.png)

### Window 1 Rollback

![Ventana 1: ROLLBACK de la transacción](img/Window1_Rollback.png)

### Window 2 Executed

![Ventana 2: consulta ejecutada tras liberar el bloqueo](img/Window2_Executed.png)
