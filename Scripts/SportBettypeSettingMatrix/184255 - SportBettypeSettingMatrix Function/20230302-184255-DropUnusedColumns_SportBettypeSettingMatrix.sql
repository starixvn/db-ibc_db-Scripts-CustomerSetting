/*<info serverAlias="DBCUST-CustDB"></info>*/
/*	
	Created: 20230302@Tacy
	Task: Drop unused columns on SportBettypeSettingMatrix
	Redmine: https://nexdev.net/issues/184255
	DB: DBCUST-CustDB
*/
USE CustDB
GO 

--DROP COLUMN
ALTER TABLE dbo.SportBettypeSettingMatrix DROP COLUMN StructureVerPT
GO
ALTER TABLE dbo.SportBettypeSettingMatrix DROP COLUMN StructureVerComm
GO
ALTER TABLE dbo.SportBettypeSettingMatrix DROP COLUMN StructureVerBetSetting
GO