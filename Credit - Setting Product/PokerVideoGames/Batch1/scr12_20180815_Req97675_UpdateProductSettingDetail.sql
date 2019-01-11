/*
	Created: 20190110@Winnie
	Task: Update product profile for Poker Games
	DB: DBCUST/CustDB
*/

USE CustDB
GO

UPDATE ps
SET ps.SettingStatus = 0
FROM dbo.ProductSettingDetail ps WITH(ROWLOCK,UPDLOCK)
WHERE ProductID = 33 AND SportType=165