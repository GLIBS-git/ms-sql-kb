--USE Production_DB_name; -- Database dependent!

CREATE INDEX Index_name ON Table_name (Field_1,Field_1,...) WITH (ONLINE = OFF, SORT_IN_TEMPDB = ON, MAXDOP = 6);
CREATE UNIQUE INDEX Index_name ON Table_name (Field_1,Field_2,...) with (ONLINE = OFF, sort_in_tempdb = on, maxdop = 6);
CREATE CLUSTERED INDEX Index_name ON Table_name (Field_1,Field_2,...) WITH (ONLINE = OFF, SORT_IN_TEMPDB = ON, MAXDOP = 6);
ALTER TABLE Table_name ADD CONSTRAINT Index_name PRIMARY KEY NONCLUSTERED (Field_1,Field_2,...) WITH (ONLINE = OFF, SORT_IN_TEMPDB = ON, MAXDOP = 6);

ALTER INDEX [Index_name] on [Table_name] REBUILD WITH (SORT_IN_TEMPDB = ON, MAXDOP = 6, ONLINE = OFF);
ALTER INDEX ALL ON [Table_name] REBUILD WITH (SORT_IN_TEMPDB = ON, MAXDOP = 6, ONLINE = OFF);

DROP INDEX [Index_name] ON [dbo].[Table_name] WITH (ONLINE = OFF);
ALTER TABLE [dbo].[Table_name] DROP CONSTRAINT [Index_name] WITH (ONLINE = OFF);

CREATE INDEX Index_name ON Table_name (Field_1,Field_2,...) INCLUDE (Field_3,Field_4,...) WITH (ONLINE = OFF, SORT_IN_TEMPDB = ON, MAXDOP = 6);







