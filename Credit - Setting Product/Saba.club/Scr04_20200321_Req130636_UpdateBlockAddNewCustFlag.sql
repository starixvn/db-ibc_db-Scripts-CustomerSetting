/*
	Created: 20200321@Elodie
	Task: Update BlockNewCusti7 flag [#RM:130636]
	DB: DBCUST/CustDB
*/

USE CustDB
GO

UPDATE dbo.SettingSystem 
SET BlockNewCusti7 = 0,
	UnblockTime = '01:30 PM (GMT+8)'
WHERE SystemID = 1
