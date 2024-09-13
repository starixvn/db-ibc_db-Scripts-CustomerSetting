/*<info serverAlias="DBCUST-CustDB,IRS_DBACC-bodb02,IRS_DBTP-bodb02"></info>*/
/*
	Created: 20240912@Johnson
	Task: Drop DF constraint RepUpdateTime for Bet Limit Control [redmine: #209892]
	DB: DBCUST/CUSTDB	
*/ 
ALTER TABLE [dbo].[BetLimitControlCustSetting] DROP CONSTRAINT [DF_BetLimitControlCustSetting_RepUpdateTime]
GO

ALTER TABLE [dbo].[BetLimitControlDefaultSetting] DROP CONSTRAINT [DF_BetLimitControlDefaultSetting_RepUpdateTime]
GO

ALTER TABLE [dbo].[BetLimitControlProduct] DROP CONSTRAINT [DF_BetLimitControlProduct_RepUpdateTime]
GO

ALTER TABLE [dbo].[BetLimitControlType] DROP CONSTRAINT [DF_BetLimitControlType_RepUpdateTime]
GO

--ALTER TABLE [dbo].[BetLimitControlTypeDetail] DROP CONSTRAINT [DF_BetLimitControlTypeDetail_RepUpdateTime]
--GO

ALTER TABLE [dbo].[BetRestriction_Currency] DROP CONSTRAINT [DF_BetRestriction_Currency_RepUpdateTime]
GO

ALTER TABLE [dbo].[BetRestriction_Customer] DROP CONSTRAINT [DF_BetRestriction_Customer_RepUpdateTime]
GO

ALTER TABLE [dbo].[BetRestriction_Setting] DROP CONSTRAINT [DF_BetRestriction_Setting_RepUpdateTime]
GO

ALTER TABLE [dbo].[BetRestriction_Site] DROP CONSTRAINT [DF_BetRestriction_Site_RepUpdateTime]
GO








