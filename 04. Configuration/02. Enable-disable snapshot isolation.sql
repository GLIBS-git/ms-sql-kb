USE "Master";
GO

ALTER DATABASE "Database_name" -- Enable read committed snapshot isolation for DB
SET READ_COMMITTED_SNAPSHOT ON;
GO

ALTER DATABASE "Database_name" -- Enable snapshot isolation for DB
SET ALLOW_SNAPSHOT_ISOLATION ON;
GO
