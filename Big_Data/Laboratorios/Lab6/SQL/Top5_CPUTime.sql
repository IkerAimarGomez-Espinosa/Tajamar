 SELECT TOP 5
     qs.total_worker_time / qs.execution_count AS avg_cpu_time_us,
     qs.execution_count,
     qs.total_logical_reads / qs.execution_count AS avg_logical_reads,
     SUBSTRING(st.text, (qs.statement_start_offset / 2) + 1,
         ((CASE qs.statement_end_offset
             WHEN -1 THEN DATALENGTH(st.text)
             ELSE qs.statement_end_offset
         END - qs.statement_start_offset) / 2) + 1) AS query_text
 FROM sys.dm_exec_query_stats AS qs
 CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS st
 ORDER BY avg_cpu_time_us DESC;