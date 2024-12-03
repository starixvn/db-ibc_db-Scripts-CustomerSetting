/*<info serverAlias="DBTP-bodb02"></info>*/
/*
	Created: 20240725@Johnson
	Task:Add IsDeleted for custsetting tables on DBTP.bodb02 [redmine:#207025]
	DB: DBTP/bodb02
*/

------------------------------------------------
--Dep_CustBAActive
ALTER TABLE [dbo].[Dep_CustBAActive] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_CustBetSetting_Agent
ALTER TABLE [dbo].[Dep_CustBetSetting_Agent] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_CustBetSetting_Member
ALTER TABLE [dbo].[Dep_CustBetSetting_Member] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_CustBetSettingGame_Agent
ALTER TABLE [dbo].[Dep_CustBetSettingGame_Agent] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_CustBetSettingGame_Member
ALTER TABLE [dbo].[Dep_CustBetSettingGame_Member] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_CustBetSettingGameGroup_Member
ALTER TABLE [dbo].[Dep_CustBetSettingGameGroup_Member] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_CustDiscountGroupSetting_Member
ALTER TABLE [dbo].[Dep_CustDiscountGroupSetting_Member] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_Customer_Archived
ALTER TABLE [dbo].[Dep_Customer_Archived] ADD IsDeleted BIT NULL
GO
 
------------------------------------------------
--Dep_CustProductSetting
ALTER TABLE [dbo].[Dep_CustProductSetting] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_CustProductStatus
ALTER TABLE [dbo].[Dep_CustProductStatus] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_CustPTGroupSetting_Member
ALTER TABLE [dbo].[Dep_CustPTGroupSetting_Member] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_CustSettingMode
ALTER TABLE [dbo].[Dep_CustSettingMode] ADD IsDeleted BIT NULL
GO
 
------------------------------------------------
--Dep_CustVIP
ALTER TABLE [dbo].[Dep_CustVIP] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_ProductSetting
ALTER TABLE [dbo].[Dep_ProductSetting] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_ProductSettingDetail
ALTER TABLE [dbo].[Dep_ProductSettingDetail] ADD IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_ProductStatusProfile
ALTER TABLE [dbo].[Dep_ProductStatusProfile] ADD  IsDeleted BIT NULL
GO

------------------------------------------------
--Dep_SupperProductSetting
ALTER TABLE [dbo].[Dep_SupperProductSetting] ADD IsDeleted BIT NULL
GO

