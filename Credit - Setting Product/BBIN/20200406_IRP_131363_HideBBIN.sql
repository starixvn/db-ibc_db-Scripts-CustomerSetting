/*
	Created: 20200406@Elodie
	Task: Hide BBIN
	DB: DBCUST/CustDB
*/

USE CustDB
GO

UPDATE ProductSettingDetail WITH (ROWLOCK) 
SET SettingStatus = 2
WHERE SportType = 241






