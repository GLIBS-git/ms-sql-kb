SELECT -- Index list for a table
	OBJECT_NAME(A.object_id) AS [Table]
	, A.index_id AS [Id]
	, A.name AS [Index]
	, A.type_desc AS [Type]
	, A.is_unique AS [Unique]
	, [Index_key_fields] = STUFF((SELECT  '   |   ' + CAST(Y.name AS NVARCHAR)
		FROM sys.index_columns X
		INNER JOIN sys.columns Y ON Y.object_id = A.object_id AND Y.column_id = X.column_id
		WHERE X.object_id = A.object_id AND X.index_id = A.index_id AND X.is_included_column = 0
		ORDER BY X.key_ordinal
		FOR XML PATH(''), type
	  ).value('.', 'nvarchar(max)'), 1, 7, '')
	, [Index_include_fields] = STUFF((SELECT '   |   ' + CAST(Y.name AS NVARCHAR)
		FROM sys.index_columns X
		INNER JOIN sys.columns Y ON Y.object_id = A.object_id AND Y.column_id = X.column_id
		WHERE X.object_id = A.object_id AND X.index_id = A.index_id AND X.is_included_column = 1
		ORDER BY X.key_ordinal
		FOR XML PATH(''), type
	  ).value('.', 'nvarchar(max)'), 1, 7, '')
	, A.is_primary_key AS [PK]
	, A.fill_factor AS [Fill_factor]
	, (SELECT [name] FROM sys.data_spaces WHERE data_space_id = A.data_space_id) AS Data_space_id
	--, '-----' AS '-----'
	--, A.*
FROM sys.indexes A
WHERE A.object_id = OBJECT_ID('Some_table_name') -- Table name here or comment line
--WHERE A.object_id = 1894124613 -- Object id here or comment line
ORDER BY A.object_id, A.index_id
;

EXEC sp_help 'Some_table_name'; -- Also shows indexes, but not only indexes
