 -- Find blocked sessions
 SELECT
     r.session_id AS blocked_session,
     r.blocking_session_id AS head_blocker,
     r.wait_type,
     r.wait_time AS wait_time_ms,
     r.wait_resource,
     t.text AS blocked_query
 FROM sys.dm_exec_requests AS r
 CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) AS t
 WHERE r.blocking_session_id <> 0;  

  -- Investigate the head blocker
 SELECT
     s.session_id,
     s.status,
     s.login_time,
     s.program_name,
     s.host_name,
     t.text AS last_query,
     c.connect_time,
     s.last_request_start_time,
     s.last_request_end_time
 FROM sys.dm_exec_sessions AS s
 LEFT JOIN sys.dm_exec_connections AS c
     ON s.session_id = c.session_id
 CROSS APPLY sys.dm_exec_sql_text(c.most_recent_sql_handle) AS t
 WHERE s.session_id = 116;