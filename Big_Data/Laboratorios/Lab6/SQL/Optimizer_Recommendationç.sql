 SELECT TOP 10
     mid.statement AS table_name,
     mid.equality_columns,
     mid.inequality_columns,
     mid.included_columns,
     ROUND(migs.avg_total_user_cost * migs.avg_user_impact *
         (migs.user_seeks + migs.user_scans), 2) AS improvement_measure
 FROM sys.dm_db_missing_index_groups AS mig
 INNER JOIN sys.dm_db_missing_index_group_stats AS migs
     ON migs.group_handle = mig.index_group_handle
 INNER JOIN sys.dm_db_missing_index_details AS mid
     ON mig.index_handle = mid.index_handle
 ORDER BY improvement_measure DESC;