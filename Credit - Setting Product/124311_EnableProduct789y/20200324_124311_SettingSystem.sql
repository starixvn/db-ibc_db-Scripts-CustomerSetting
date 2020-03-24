/*
	Created: 20200324@Tiara
	Task: Insert SettingSystem [Redmine: 124311]
	DB: DBCUST/CustDB
*/

-- BEGIN DEPLOY THIS SCRIPT ON DBCUST/CustDB	 --
-----------------------------------------------------------
USE CustDB
GO

INSERT INTO [dbo].[SettingSystem] ([SystemID],[SystemName],[Description],[SystemPrefix]) VALUES (6,'789y Alpha','789y Alpla For Agents','EALP')
INSERT INTO [dbo].[SettingSystem] ([SystemID],[SystemName],[Description],[SystemPrefix]) VALUES (7,'789y Internal Alpha','789y Alpha For Interal Login','IALP')
INSERT INTO [dbo].[SettingSystem] ([SystemID],[SystemName],[Description],[SystemPrefix]) VALUES (8,'789y External NAP','789y External NAP','ENAP')
INSERT INTO [dbo].[SettingSystem] ([SystemID],[SystemName],[Description],[SystemPrefix]) VALUES (9,'789y External NAP (Bet Setting only','Use for updating Bet Setting on External NAP','ENAP')