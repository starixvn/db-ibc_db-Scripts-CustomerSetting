/*<info serverAlias="DBSPARE-CustDB,DBCUST-CustDB"></info>*/
/*
	Created: 20230807@Tacy
	Task: Add product profile setting for YeeBet, MG-RnG
	DB: DBSPARE/CustDB,DBCUST-CustDB
*/

USE CustDB
GO

INSERT INTO dbo.Dep_ProductSetting(ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
SELECT 174, 73, 9, 0, 4, 1	
UNION 
SELECT 175, 76, 9, 0, 4, 1
GO

INSERT INTO [Dep_ProductSettingDetail]([ProductSettingID],[SportType],[BetType],[IsLive],[MaxDefaultValue],[SettingStatus],[IsApplyBA]) 
SELECT 174, 155, 8400, 0, 0, 0, 0
UNION 
SELECT 175, 159, 3151, 0, 0, 0, 0
GO