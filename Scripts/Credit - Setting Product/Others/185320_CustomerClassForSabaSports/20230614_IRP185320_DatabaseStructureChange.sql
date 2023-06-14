/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created: 20230614@Johnson
	Task: Add column CCSabaSoccer,CCSabaBasketball for CTS [#RedmineID:#185320]
	DB: DBCust/CustDB
*/

--Step 1: add column CCSabaSoccer,CCSabaBasketball into custinfo
--run at @DBCUST/CustDB

ALTER TABLE custinfo ADD CCSabaSoccer SMALLINT,CCSabaBasketball SMALLINT

--Step 2: Add new fields to DB05.bodb_Customer.dbo.custinfo_old table--
----------------------------------------------------------------
USE bodb_customer
GO

ALTER TABLE [dbo].[custInfo_old] ADD CCSabaSoccer SMALLINT,CCSabaBasketball SMALLINT
GO

--Step 3: Add new fields into DBTP.bodb_CustHistory.dbo.custinfo_history table----
--------------------------------------------------------------------------
USE bodb_CustHistory
GO
ALTER TABLE [dbo].[CustInfo_history] ADD CCSabaSoccer SMALLINT,CCSabaBasketball SMALLINT
GO