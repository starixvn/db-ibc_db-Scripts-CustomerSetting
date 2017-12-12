/*
	Created: 20171212@Elodie
	Task: Update product profile for Lucky3
	DB: DBCUST/CustDB
*/

USE CustDB
GO

UPDATE ps
SET ps.SettingStatus = 0
FROM dbo.ProductSettingDetail ps WITH(ROWLOCK,UPDLOCK)
WHERE ProductID = 26