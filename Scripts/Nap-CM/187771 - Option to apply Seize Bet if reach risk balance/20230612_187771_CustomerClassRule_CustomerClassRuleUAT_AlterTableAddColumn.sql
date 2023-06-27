/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Luke@20230612
    Task: ALTER TABLE CustomerClassRule, CustomerClassRule_UAT ADD NEW COLUMN [Redmine: #187771]
    DB: DBCUST/CustDB
*/ 

USE CustDB
GO

DECLARE @schemaName		VARCHAR(10),
		@tableName		VARCHAR(50),
		@tableUATName	VARCHAR(50),
		@newCol			VARCHAR(50)
SELECT	@schemaName		= 'dbo',
		@tableName		= 'CustomerClassRule',
		@tableUATName	= 'CustomerClassRule_UAT',
		@newCol			= 'SeizeBetAccumulateBal'

--check exist and add column to CustomerClassRule
IF NOT EXISTS(
	SELECT 1
	FROM sys.tables WITH (NOLOCK)
	WHERE SCHEMA_NAME(schema_id) = @schemaName AND name = @tableName
)
BEGIN
	RAISERROR ('Table %s doesn''t exist.', 16, 1, @tableName)
END
ELSE IF EXISTS(
	SELECT 1
	FROM sys.tables t WITH (NOLOCK) 
		INNER JOIN sys.columns c WITH (NOLOCK) ON c.object_id = t.object_id
	WHERE SCHEMA_NAME(t.schema_id) = @schemaName
		AND t.name = @tableName
		AND c.name = @newCol
)
BEGIN
	RAISERROR('Column %s is being used.', 16, 1, @newCol)
END
ELSE
BEGIN
	ALTER TABLE dbo.CustomerClassRule ADD SeizeBetAccumulateBal BIT NULL
END

--check exist and add column to CustomerClassRule_UAT
IF NOT EXISTS(
	SELECT 1
	FROM sys.tables WITH (NOLOCK)
	WHERE SCHEMA_NAME(schema_id) = @schemaName AND name = @tableUATName
)
BEGIN
	RAISERROR ('Table %s doesn''t exist.', 16, 1, @tableUATName)
END
ELSE IF EXISTS(
	SELECT 1
	FROM sys.tables t WITH (NOLOCK) 
		INNER JOIN sys.columns c WITH (NOLOCK) ON c.object_id = t.object_id
	WHERE SCHEMA_NAME(t.schema_id) = @schemaName
		AND t.name = @tableUATName
		AND c.name = @newCol
)
BEGIN
	RAISERROR('Column %s is being used.', 16, 1, @newCol)
END
ELSE
BEGIN
	ALTER TABLE dbo.CustomerClassRule_UAT ADD SeizeBetAccumulateBal BIT NULL
END
GO
