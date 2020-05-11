/*
	Created: 20200309@Eden
	Task: - Insert ProductSettingSystemDisplay , Use for updating Bet Setting on External NAP 
		  - Hide Status for 789y (all system)  
	[Redmine:#122743]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DELETE P 
FROM ProductSettingSystemDisplay P WITH (ROWLOCK)
WHERE P.ProductID = 38

--MBC Use for updating Bet Setting on External NAP
INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (5,38,1,3)
INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (5,38,6,3)
INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (5,38,13,3)

--789y Use for updating Bet Setting on External NAP
INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (9,38,1,3)
INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (9,38,6,3)
INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (9,38,13,3)

--789y Hide Status
INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (6,38,13,3)
INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (7,38,13,3)
INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (8,38,13,3)
