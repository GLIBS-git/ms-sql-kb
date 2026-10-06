SELECT A.[name] AS Name_ -- DB configuration
	, A.database_id AS Id
	, A.recovery_model_desc AS Recovery_model
	, CASE
		WHEN A.is_read_committed_snapshot_on = 1 THEN 'ON'
		WHEN A.is_read_committed_snapshot_on = 0 THEN 'OFF'
		ELSE '#Unknown#'
	  END AS Read_committed_snapshot_on
	, A.snapshot_isolation_state_desc AS Snapshot_isolation_state
	, A.state_desc AS Db_state
	, A.is_auto_create_stats_on AS Auto_create_stats
	, A.is_auto_update_stats_on AS Auto_update_stats
	, A.collation_name AS Collation
	--, '-----' AS [-----]
	--, A.* 
FROM sys.databases A
--WHERE A.[name] IN ('Production_DB_name') -- Optional filter
--WHERE A.database_id IN (5,6) -- Optional filter
;
