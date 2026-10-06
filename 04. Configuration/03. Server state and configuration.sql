SELECT A.sqlserver_start_time AS Server_started -- Server start time and CPU/memory configuration
	, A.cpu_count AS Logical_CPU_cores
	, A.hyperthread_ratio AS Physical_CPU_cores
	, A.physical_memory_kb / 1024 / 1024 AS Physical_memory_Gb
	, A.physical_memory_kb / 1024 AS Physical_memory_Mb
	, A.physical_memory_kb AS Physical_memory_Kb
	, A.virtual_memory_kb AS Virtual_memory_Kb
	--, '-------' AS [-------]
	--, A.*
FROM sys.dm_os_sys_info A;

SELECT * FROM sys.dm_os_sys_info; -- Server state and configuration



