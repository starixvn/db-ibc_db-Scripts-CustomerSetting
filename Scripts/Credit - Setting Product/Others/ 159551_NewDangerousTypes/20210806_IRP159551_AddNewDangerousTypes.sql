/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210806@Johnson
	Task: add new dangerous types 
	DB: DBCust/CustDB
*/
--Step 1: add 2 columns Danger4, Danger5 into custinfo
--run at @DBCUST/CustDB
ALTER TABLE custinfo ADD Danger4 TINYINT NULL
GO

ALTER TABLE custinfo ADD Danger5 TINYINT NULL
GO

ALTER TABLE [dbo].[custInfo] ADD  CONSTRAINT [DF_custInfo_danger4]  DEFAULT ((0)) FOR [danger4]
GO

ALTER TABLE [dbo].[custInfo] ADD  CONSTRAINT [DF_custInfo_danger5]  DEFAULT ((0)) FOR [danger5]
GO


--Step 2: Add new fields to DB05.bodb_Customer.dbo.custinfo_old table--
----------------------------------------------------------------
USE bodb_customer
GO
ALTER TABLE [dbo].[custInfo_old] ADD Danger4 TINYINT CONSTRAINT DF_custinfo_old_Danger4 DEFAULT(0) NULL
GO
ALTER TABLE [dbo].[custInfo_old] ADD Danger5 TINYINT CONSTRAINT DF_custinfo_old_Danger5 DEFAULT(0) NULL
GO

--Step 3: Add new fields into DBTP.bodb_CustHistory.dbo.custinfo_history table----
--------------------------------------------------------------------------
USE bodb_CustHistory
GO
ALTER TABLE [dbo].[CustInfo_history] ADD Danger4 TINYINT CONSTRAINT DF_custinfo_history_Danger4 DEFAULT(0) NULL
GO
ALTER TABLE [CustInfo_history] ADD Danger5 TINYINT CONSTRAINT DF_custinfo_history_Danger5 DEFAULT(0) NULL
GO