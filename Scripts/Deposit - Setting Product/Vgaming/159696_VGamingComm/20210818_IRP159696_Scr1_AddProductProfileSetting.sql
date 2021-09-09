/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210818@Johnson
	Task: Add product profile setting for VGaming
	DB: DBCust/CustDB
*/


USE CustDB
GO
INSERT INTO dbo.Dep_ProductSetting(ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
SELECT 115,66, 9, 0, 4, 1 	

INSERT INTO [Dep_ProductSettingDetail]([ProductSettingID],[SportType],[BetType],[IsLive],[MaxDefaultValue],[SettingStatus],[IsApplyBA]) 
SELECT 115,171,3801,0,0,0,0
