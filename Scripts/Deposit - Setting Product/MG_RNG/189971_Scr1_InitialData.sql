/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20/06/2023
	Created: Helios 
	Task: MG-RNG - Integrate the product for deposit sites 
	DB: DBCUST/CUSTDB 
*/

INSERT INTO [dbo].[Dep_ProductStatusProfile] ([SportType],[Bettype],[BitmapOrder])
SELECT 155,8400,39

INSERT INTO [dbo].[Dep_ProductSetting]
           ([ProductSettingID]
           ,[ProductID]
           ,[SettingType]
           ,[TemplateID]
           ,[DisplayOrder]
           ,[SettingLevel])
SELECT       171, 73, 4, 0, 1, 1
UNION SELECT 172, 73, 1, 0, 2, 1
UNION SELECT 173, 73, 8, 0, 3, 2
GO

INSERT INTO [dbo].[Dep_ProductSettingDetail]
           ([ProductSettingID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[MaxDefaultValue]
           ,[SettingStatus]
           ,[MinDefaultValue]
           ,[IsApplyBA])
SELECT       171, 155, 8400, 0, 0, 1, NULL, 0
UNION SELECT 172, 155, 8400, 0, 0, 1, NULL, 0
UNION SELECT 173, 155, 8699, 0, 0, 1, NULL, 0
GO

INSERT INTO [dbo].[GameGroup]
           ([GameGroupID]
           ,[RefSportType]
           ,[RefBetType]
           ,[GroupName]
           ,[IsDeposit])
SELECT 45, 155, 8699, 'Level 1', 1
GO