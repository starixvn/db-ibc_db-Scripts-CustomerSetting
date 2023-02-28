/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230228@Johnson
	Task: Add new column autosuspend3 into custinfo for Auto suspend VR Basketball [redmine: #184339]
	DB: DBCUST/CustDB
*/

--Step 1: add column autosuspend3 into custinfo
--run at @DBCUST/CustDB

ALTER TABLE custinfo ADD autosuspend3 BIT

--Step 2: Add new fields to DB05.bodb_Customer.dbo.custinfo_old table--
----------------------------------------------------------------
USE bodb_customer
GO

ALTER TABLE [dbo].[custInfo_old] ADD autosuspend3 BIT
GO

--Step 3: Add new fields into DBTP.bodb_CustHistory.dbo.custinfo_history table----
--------------------------------------------------------------------------
USE bodb_CustHistory
GO
ALTER TABLE [dbo].[CustInfo_history] ADD autosuspend3 BIT
GO