--/*<info serverAlias="DBCUST-CustDB"></info>*/
--/*
--	Date: 20230117
--	Created: Helios 
--	Task: Jili Games - Incorporate to Licensee Sites [redmine : #182869]
--	DB: DBCUST/CUSTDB
--*/

DELETE Dep_ProductStatusProfile WITH(ROWLOCK) WHERE SportType = 158
DELETE Dep_ProductSetting WITH(ROWLOCK) WHERE ProductSettingID IN (156,157,158)
DELETE Dep_ProductSettingDetail WITH(ROWLOCK) WHERE ProductSettingID IN (156,157,158)
DELETE GameGroup WITH(ROWLOCK) WHERE GameGroupID = 43
GO

INSERT INTO Dep_ProductStatusProfile(SportType,Bettype,BitmapOrder)
SELECT 158,5100,35

INSERT INTO [dbo].[Dep_ProductSetting]
           ([ProductSettingID]
           ,[ProductID]
           ,[SettingType]
           ,[TemplateID]
           ,[DisplayOrder]
           ,[SettingLevel])
SELECT       156, 75, 4, 0, 1, 1
UNION SELECT 157, 75, 8, 0, 2, 1
UNION SELECT 158, 75, 1, 0, 3, 2
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
SELECT       156, 158, 5100, 0, 0, 1, NULL, 0
UNION SELECT 157, 158, 5100, 0, 0, 1, NULL, 0
UNION SELECT 158, 158, 5100, 0, 0, 1, NULL, 0
GO

INSERT INTO [dbo].[GameGroup]
           ([GameGroupID]
           ,[RefSportType]
           ,[RefBetType]
           ,[GroupName]
           ,[IsDeposit])
SELECT 43, 158, 5100, 'Level 1', 1
GO