/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Luke@20230612
    Task: ALTER TABLE BetRestriction_Currency, BetRestriction_Site, BetRestriction_Customer ADD NEW COLUMN [Redmine: #187771]
    DB: DBCUST/CustDB, DBACC/bodb02(replication)
*/ 

USE CustDB
GO
IF EXISTS (
	SELECT 1
	FROM sys.tables 
	WHERE name = 'BetRestriction_Currency' AND SCHEMA_NAME(SCHEMA_ID) = 'dbo'
)
BEGIN
	ALTER TABLE BetRestriction_Currency ADD AccumulateBalance BIT NULL
END
ELSE
BEGIN
	RAISERROR('This table doesn''t exist', 16, 1)
END
GO

IF EXISTS (
	SELECT 1
	FROM sys.tables 
	WHERE name = 'BetRestriction_Site' AND SCHEMA_NAME(SCHEMA_ID) = 'dbo'
)
BEGIN
	ALTER TABLE BetRestriction_Site ADD AccumulateBalance BIT NULL
END
ELSE
BEGIN
	RAISERROR('This table doesn''t exist', 16, 1)
END
GO

IF EXISTS (
	SELECT 1
	FROM sys.tables 
	WHERE name = 'BetRestriction_Customer' AND SCHEMA_NAME(SCHEMA_ID) = 'dbo'
)
BEGIN
	ALTER TABLE BetRestriction_Customer ADD AccumulateBalance BIT NULL
END
ELSE
BEGIN
	RAISERROR('This table doesn''t exist', 16, 1)
END
GO
