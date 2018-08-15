/*
	Created: 20180815@Elodie
	Task: Update product profile for Poker Games
	DB: DBCUST/CustDB
*/

USE CustDB
GO

UPDATE ps
SET ps.SettingStatus = 0
FROM dbo.ProductSettingDetail ps WITH(ROWLOCK,UPDLOCK)
WHERE ProductID = 33