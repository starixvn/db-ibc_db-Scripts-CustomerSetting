/*<info serverAlias="DBTP-bodb02"></info>*/
/*
	Created: 20240725@Johnson
	Task:Add IsDeleted for custsetting tables on DBTP.bodb02 [redmine:#207025]
	DB: DBTP/bodb02
*/

------------------------------------------------
--Dep_CustBetLimit_Special
ALTER TABLE [dbo].[Dep_CustBetLimit_Special] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_CustCategoryHistory
ALTER TABLE [dbo].[Dep_CustCategoryHistory] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_CustDiscountSetting_Agent
ALTER TABLE [dbo].[Dep_CustDiscountSetting_Agent] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_CustDiscountSetting_Member
ALTER TABLE [dbo].[Dep_CustDiscountSetting_Member] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_CustomerClass
ALTER TABLE [dbo].[Dep_CustomerClass] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_CustPTSetting_Agent
ALTER TABLE [dbo].[Dep_CustPTSetting_Agent] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_CustPTSetting_Member
ALTER TABLE [dbo].[Dep_CustPTSetting_Member] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_CustSetting_AGCasino
ALTER TABLE [dbo].[Dep_CustSetting_AGCasino] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_CustSettingGame
ALTER TABLE [dbo].[Dep_CustSettingGame] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_CustSpecialLevel
ALTER TABLE [dbo].[Dep_CustSpecialLevel] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_CustStakeLevel_Agent
ALTER TABLE [dbo].[Dep_CustStakeLevel_Agent] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_CustStakeLevel_Member
ALTER TABLE [dbo].[Dep_CustStakeLevel_Member] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_CustSuper
ALTER TABLE [dbo].[Dep_CustSuper] ADD IsDeleted BIT NULL
GO


------------------------------------------------
--Dep_DefaultOddGroup
ALTER TABLE [dbo].[Dep_DefaultOddGroup] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_LicenseeProductSetting
ALTER TABLE [dbo].[Dep_LicenseeProductSetting] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_ProductBetSetting
ALTER TABLE [dbo].[Dep_ProductBetSetting] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_StakeLevel
ALTER TABLE [dbo].[Dep_StakeLevel] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_StakeLevelGroupDetail
ALTER TABLE [dbo].[Dep_StakeLevelGroupDetail] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_SuperSetting_AGCasino
ALTER TABLE [dbo].[Dep_SuperSetting_AGCasino] ADD IsDeleted BIT NULL
GO
