/*<info serverAlias="DBGLOB-GlobCustDB,IRS_DBTP-bodb02,DBCustRepl-ReplCustDB,DBACC-bodb02"></info>*/
/*
	Created: 20250415@Tacy	
	Task: tbl [Dep_ProductBetSetting] - Alter [Currency] datatype TINYINT --> SMALLINT 
	DB: DBGLOB-GlobCustDB,IRS_DBTP-bodb02,DBCustRepl-ReplCustDB,DBACC-bodb02
	
	Revisions:
		- 20250415@Tacy: Created [RedmineID: #222339]
*/
-- Run on DBGLOB only: [Dep_ProductBetSetting_Del_InHouse]
IF @@SERVERNAME IN ('DBCUST','DBSPARE','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	AND DB_NAME()='GlobCustDB'
BEGIN
	ALTER TABLE Dep_ProductBetSetting_Del_InHouse ALTER COLUMN Currency SMALLINT NOT NULL
END

----------------------------------------------------------------------------------------------
-- Dep_ProductBetSetting
--1. Drop PK
ALTER TABLE Dep_ProductBetSetting DROP CONSTRAINT PK_Dep_ProductBetSetting
GO

--2. Change datatype
ALTER TABLE Dep_ProductBetSetting ALTER COLUMN Currency SMALLINT NOT NULL
GO

--3. Add PK
ALTER TABLE Dep_ProductBetSetting ADD CONSTRAINT PK_Dep_ProductBetSetting PRIMARY KEY (Sporttype, Bettype, Currency)
GO