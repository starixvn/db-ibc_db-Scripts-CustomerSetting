/*
	Created: Eden
	Date: 20200507
	Task: UPDATE global setting for Virtual games DEPOSIT -XocDia
	DB: DBCust/CustDB
*/

USE CustDB
GO

UPDATE ps
SET ps.SettingStatus = 0
FROM dbo.Dep_ProductSettingDetail ps WITH(ROWLOCK,UPDLOCK)
WHERE SportType = 245 AND bettype = 4602