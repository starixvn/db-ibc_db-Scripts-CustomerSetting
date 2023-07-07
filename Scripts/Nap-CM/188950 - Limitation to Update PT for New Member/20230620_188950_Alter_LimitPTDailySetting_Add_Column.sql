/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Luke@20230620
    Task: ALTER TABLE LimitPTDailySetting ADD NEW COLUMN LimitNewAccUpdPT [Redmine: #188950]
    DB: DBCUST/CustDB
*/ 

USE CustDB
GO

DECLARE @schemaName VARCHAR(10),
		@tableName	VARCHAR(50),
		@newCol		VARCHAR(50)
SELECT	@schemaName = 'dbo',
		@tableName	= 'LimitPTDailySetting',
		@newCol		= 'LimitNewAccUpdPT'

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
	ALTER TABLE dbo.LimitPTDailySetting ADD LimitNewAccUpdPT BIT NULL
END
GO