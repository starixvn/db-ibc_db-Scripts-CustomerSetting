/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Luke@20230612
    Task: ALTER TABLE BetRestriction_Currency, BetRestriction_Site ADD NEW COLUMN [Redmine: #187771]
    DB: DBCUST/CustDB, DBACC/bodb02(replication)
*/ 

USE CustDB
GO
DECLARE @schemaName		VARCHAR(10),
		@tableCurrName	VARCHAR(50),
		@tableSiteName	VARCHAR(50),
		@newCol			VARCHAR(50)
SELECT	@schemaName		= 'dbo',
		@tableCurrName	= 'BetRestriction_Currency',
		@tableSiteName	= 'BetRestriction_Site',
		@newCol			= 'AccumulateBalance'

--check exists and add new column to BetRestriction_Currency
IF NOT EXISTS(
	SELECT 1
	FROM sys.tables WITH (NOLOCK)
	WHERE SCHEMA_NAME(schema_id) = @schemaName AND name = @tableCurrName
)
BEGIN
	RAISERROR ('Table %s doesn''t exist.', 16, 1, @tableCurrName)
END
ELSE IF EXISTS(
	SELECT 1
	FROM sys.tables t WITH (NOLOCK) 
		INNER JOIN sys.columns c WITH (NOLOCK) ON c.object_id = t.object_id
	WHERE SCHEMA_NAME(t.schema_id) = @schemaName
		AND t.name = @tableCurrName
		AND c.name = @newCol
)
BEGIN
	RAISERROR('Column %s is being used.', 16, 1, @newCol)
END
ELSE
BEGIN
	ALTER TABLE dbo.BetRestriction_Currency ADD AccumulateBalance BIT NULL
END

--check exists and add new column to BetRestriction_Site
IF NOT EXISTS(
	SELECT 1
	FROM sys.tables WITH (NOLOCK)
	WHERE SCHEMA_NAME(schema_id) = @schemaName AND name = @tableSiteName
)
BEGIN
	RAISERROR ('Table %s doesn''t exist.', 16, 1, @tableSiteName)
END
ELSE IF EXISTS(
	SELECT 1
	FROM sys.tables t WITH (NOLOCK) 
		INNER JOIN sys.columns c WITH (NOLOCK) ON c.object_id = t.object_id
	WHERE SCHEMA_NAME(t.schema_id) = @schemaName
		AND t.name = @tableSiteName
		AND c.name = @newCol
)
BEGIN
	RAISERROR('Column %s is being used.', 16, 1, @newCol)
END
ELSE
BEGIN
	ALTER TABLE dbo.BetRestriction_Site ADD AccumulateBalance BIT NULL
END
