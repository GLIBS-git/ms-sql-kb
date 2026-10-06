SELECT -- Executing requests
	CAST(GETDATE() - A.start_time AS TIME) AS Duration
	, A.cpu_time AS [CPU_time]
	, A.total_elapsed_time AS [Elapsed_time]
	, DB_NAME(A.database_id) AS [DataBase]
	, A.session_id AS [Session]
	, A.status AS [Status]
	, A.command AS [Command]
	, SUBSTRING(Z.text, (A.statement_start_offset / 2) + 1, ((CASE statement_end_offset WHEN -1 THEN DATALENGTH(Z.text) ELSE A.statement_end_offset END - A.statement_start_offset) / 2) + 1) AS [SQL]
	, (SELECT query_plan FROM sys.dm_exec_query_plan(A.plan_handle)) AS [Plan]
	, A.blocking_session_id AS [Blocking_session]
	, A.wait_type AS [Wait_type]
	, A.wait_time AS [Wait_time]
	, A.last_wait_type AS [Last_wait_type]
	, A.reads AS [Reads]
	, A.writes AS [Writes]
	, A.logical_reads AS [Logical_reads]
	, A.transaction_id AS [Transaction]
	, W.login_name AS [Login]
	, W.HOST_NAME AS [Host_name]
	, W.program_name AS [Application]
	, A.wait_resource AS [Wait_resource]
	, A.start_time AS [Start_time]
	, A.sql_handle AS [SQL_handle]
	, A.plan_handle AS [Plan_handle]
	, Z.text [Full_SQL]
	, CASE	WHEN SUBSTRING(Z.text , 1, 16) = 'FETCH API_CURSOR' THEN (
					SELECT (SELECT TOP 1 text FROM sys.dm_exec_sql_text(A.sql_handle)) + CHAR(9) + CHAR(9)
					FROM sys.dm_exec_cursors(A.session_id) A
					FOR XML PATH('')
				)
			ELSE '' 
		END AS [Cursor_Sql]
	--, A.connection_id AS Connection_id
	--, A.task_address AS Task_address
	--, '-----' AS [-----]
	--, A.* 
FROM sys.dm_exec_requests A WITH (NOLOCK)
outer apply (
	SELECT top 1 text FROM sys.dm_exec_sql_text(A.sql_handle)
) Z
OUTER APPLY (
	SELECT X.HOST_NAME, X.program_name, X.login_name FROM sys.dm_exec_sessions X WITH (NOLOCK)
	INNER JOIN sys.dm_exec_connections Y WITH (NOLOCK) ON Y.session_id = X.session_id
	WHERE Y.connection_id = A.connection_id
) W
where A.database_id in (db_id('Production_DB_name'), db_id('Buffer_DB_name'))
AND A.session_id <> @@SPID
AND A.command NOT IN ('GHOST CLEANUP','CHECKPOINT','TM REQUEST','WAITFOR') -- Exemptions list
--AND A.session_id IN (451)
ORDER BY A.start_time
--ORDER BY A.session_id desc
;























