/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Luke@20230612
    Task: ALTER TABLE CustomerClassRule_UAT ADD NEW COLUMN [Redmine: #187771]
    DB: DBCUST/CustDB
*/ 

USE CustDB
GO

IF EXISTS (
	SELECT 1
	FROM sys.tables
	WHERE name = 'CustomerClassRule_UAT' AND SCHEMA_NAME(schema_id) = 'dbo'
)
BEGIN
	ALTER TABLE CustomerClassRule_UAT ADD SeizeBetAccumulateBal BIT NULL
END
ELSE
BEGIN
	RAISERROR('This table doesn''t exists', 16, 1)
END
GO
