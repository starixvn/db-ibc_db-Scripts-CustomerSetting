/*
	Created: Eden
	Date: 20191029
	Task: UPDATE global setting for Virtual games
	DB: DBCust/CustDB
*/

USE CustDB
GO

UPDATE ps
SET ps.SettingStatus = 0
FROM dbo.ProductSettingDetail ps WITH(ROWLOCK,UPDLOCK)
WHERE ProductID = 38