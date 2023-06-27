/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Luke@20230612
    Task: ALTER TABLE BetRestriction_Customer ADD NEW COLUMN [Redmine: #187771]
    DB: DBCUST/CustDB, DBACC/bodb02(replication)
*/ 

USE CustDB
GO
DECLARE @schemaName		VARCHAR(10),
		@tableCustName	VARCHAR(50),
		@newCol			VARCHAR(50)
SELECT	@schemaName		= 'dbo',
		@tableCustName	= 'BetRestriction_Customer',
		@newCol			= 'AccumulateBalance'

--check exists and add new column to BetRestriction_Customer
IF NOT EXISTS(
	SELECT 1
	FROM sys.tables WITH (NOLOCK)
	WHERE SCHEMA_NAME(schema_id) = @schemaName AND name = @tableCustName
)
BEGIN
	RAISERROR ('Table %s doesn''t exist.', 16, 1, @tableCustName)
END
ELSE IF EXISTS(
	SELECT 1
	FROM sys.tables t WITH (NOLOCK) 
		INNER JOIN sys.columns c WITH (NOLOCK) ON c.object_id = t.object_id
	WHERE SCHEMA_NAME(t.schema_id) = @schemaName
		AND t.name = @tableCustName
		AND c.name = @newCol
)
BEGIN
	RAISERROR('Column %s is being used.', 16, 1, @newCol)
END
ELSE
BEGIN
	ALTER TABLE dbo.BetRestriction_Customer ADD AccumulateBalance BIT NULL
END
