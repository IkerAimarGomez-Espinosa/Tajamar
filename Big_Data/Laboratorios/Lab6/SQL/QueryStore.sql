 ALTER DATABASE CURRENT SET QUERY_STORE = ON (
     OPERATION_MODE = READ_WRITE,
     QUERY_CAPTURE_MODE = AUTO,
     WAIT_STATS_CAPTURE_MODE = ON
 );
 GO

 -- Clear any prior data so only this exercise's queries appear
 ALTER DATABASE CURRENT SET QUERY_STORE CLEAR;
 GO

  SELECT actual_state_desc, desired_state_desc,
     current_storage_size_mb, max_storage_size_mb
 FROM sys.database_query_store_options;