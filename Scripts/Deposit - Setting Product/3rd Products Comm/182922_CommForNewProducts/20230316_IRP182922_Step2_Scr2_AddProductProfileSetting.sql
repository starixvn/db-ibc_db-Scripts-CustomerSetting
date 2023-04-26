/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230316@Johnson
	Task: Add product profile setting for MaxGame,FGG,Jili
	DB: DBCust/CustDB
*/


USE CustDB
GO
INSERT INTO dbo.Dep_ProductSetting(ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
SELECT 162,60, 9, 0, 4, 1 	
UNION SELECT 163,70, 9, 0, 4, 1
UNION SELECT 164,75, 9, 0, 4, 1

INSERT INTO [Dep_ProductSettingDetail]([ProductSettingID],[SportType],[BetType],[IsLive],[MaxDefaultValue],[SettingStatus],[IsApplyBA]) 
SELECT 162,237,5401,0,0,0,0
UNION SELECT 163,176,8201,0,0,0,0
UNION SELECT 164,158,5100,0,0,0,0
