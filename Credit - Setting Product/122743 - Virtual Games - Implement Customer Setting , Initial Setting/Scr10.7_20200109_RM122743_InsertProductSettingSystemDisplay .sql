/*
	Created: 20200309@Eden
	Task: Insert ProductSettingSystemDisplay [Redmine:#122743]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DELETE P 
FROM ProductSettingSystemDisplay P WITH (ROWLOCK)
WHERE P.ProductID = 38

INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (5,38,1,3)
INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (5,38,6,3)
INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (5,38,13,3)
