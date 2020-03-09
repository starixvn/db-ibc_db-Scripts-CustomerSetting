/*
	Created: 20200309@Tiara
	Task: Insert ProductSettingSystemDisplay [Redmine: 124311]
	DB: DBCUST/CustDB
*/

-- BEGIN DEPLOY THIS SCRIPT ON DBCUST/CustDB	 --
-----------------------------------------------------------
USE CustDB
GO

DELETE P 
FROM ProductSettingSystemDisplay P WITH (ROWLOCK)
WHERE P.ProductID = 21

INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (5,41,1,3)
INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (5,41,3,3)
INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (5,41,6,3)
INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (5,41,13,3)