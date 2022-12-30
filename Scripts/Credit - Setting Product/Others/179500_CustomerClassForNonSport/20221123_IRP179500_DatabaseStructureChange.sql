/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created: 20221123@Johnson
	Task: Add column CCNonSports for CTS [#RedmineID:#179500]
	DB: DBCust/CustDB
*/

--Step 1: add column CCNonSports into custinfo
--run at @DBCUST/CustDB

ALTER TABLE custinfo ADD CCNonSports SMALLINT

--Step 2: Add new fields to DB05.bodb_Customer.dbo.custinfo_old table--
----------------------------------------------------------------
USE bodb_customer
GO

ALTER TABLE [dbo].[custInfo_old] ADD CCNonSports SMALLINT
GO

--Step 3: Add new fields into DBTP.bodb_CustHistory.dbo.custinfo_history table----
--------------------------------------------------------------------------
USE bodb_CustHistory
GO
ALTER TABLE [dbo].[CustInfo_history] ADD CCNonSports SMALLINT
GO