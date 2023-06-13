/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Luke@20230612
    Task: ALTER TABLE CustomerClassRule ADD NEW COLUMN [Redmine: #187771]
    DB: DBCUST/CustDB
*/ 

USE CustDB
GO

IF EXISTS (
	SELECT 1
	FROM sys.tables
	WHERE name = 'CustomerClassRule' AND SCHEMA_NAME(schema_id) = 'dbo'
)
BEGIN
	ALTER TABLE CustomerClassRule ADD SeizeBetAccumulateBal BIT NULL
END
ELSE
BEGIN
	RAISERROR('This table doesn''t exists', 16, 1)
END
GO
