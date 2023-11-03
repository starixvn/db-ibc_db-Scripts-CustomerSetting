/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230810@Tacy
	Task: Add product profile setting for VS3 (new)
	DB: DBCust/CustDB
*/

USE CustDB
GO

INSERT INTO dbo.Dep_ProductSetting(ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
SELECT 176, 77, 9, 0, 4, 1	
GO

INSERT INTO [Dep_ProductSettingDetail]([ProductSettingID],[SportType],[BetType],[IsLive],[MaxDefaultValue],[SettingStatus],[IsApplyBA]) 
SELECT 176, 178, 5302, 0, 0, 0, 0
GO