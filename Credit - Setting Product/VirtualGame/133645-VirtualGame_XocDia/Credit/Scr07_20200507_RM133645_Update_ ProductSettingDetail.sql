/*
	Created: Eden
	Date: 20200507
	Task: UPDATE global setting for Virtual games - XocDia
	DB: DBCust/CustDB
*/

USE CustDB
GO

UPDATE ps
SET ps.SettingStatus = 0
FROM dbo.ProductSettingDetail ps WITH(ROWLOCK,UPDLOCK)
WHERE ProductID = 38
	AND SportType = 245
	AND bettype = 4602