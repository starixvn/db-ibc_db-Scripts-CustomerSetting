/*
	Created: 20200327@Elodie
	Task: Update product profile for Table Games
	DB: DBCUST/CustDB
*/

USE CustDB
GO

UPDATE ps
SET ps.SettingStatus = 0
FROM dbo.ProductSettingDetail ps WITH(ROWLOCK)
WHERE ProductID = 28