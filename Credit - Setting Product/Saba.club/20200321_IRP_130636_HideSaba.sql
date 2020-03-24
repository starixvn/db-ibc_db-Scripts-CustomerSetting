/*
	Created: 20200321@Elodie
	Task: Update product profile for Saba.club
	DB: DBCUST/CustDB
*/

USE CustDB
GO

UPDATE ps
SET ps.SettingStatus = 1
FROM dbo.ProductSettingDetail ps WITH(ROWLOCK)
WHERE ProductID = 42