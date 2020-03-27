/*
	Created: 20200309@Tiara
	Task: Insert ProductSettingSystemDisplay Revert [Redmine: 124311]
	DB: DBCUST/CustDB
*/

-- BEGIN DEPLOY THIS SCRIPT ON DBCUST/CustDB	 --
-----------------------------------------------------------
USE CustDB
GO

DELETE P 
FROM ProductSettingSystemDisplay P WITH (ROWLOCK)
WHERE P.ProductID = 21 OR P.ProductID = 41

INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (5,21,1,3)
INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (5,21,3,3)
INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (5,21,6,3)
INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (5,21,13,3)
INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (6,21,13,3)
INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (7,21,13,3)
INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (8,21,13,3)
INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (9,21,1,3)
INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (9,21,3,3)
INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (9,21,6,3)
INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (9,21,13,3)
