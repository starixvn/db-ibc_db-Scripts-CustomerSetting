/*
	Created: Eden
	Date: 20191029
	Task: UPDATE global setting for Virtual games DEPOSIT
	DB: DBCust/CustDB
*/

USE CustDB
GO

UPDATE ps
SET ps.SettingStatus = 0
FROM dbo.Dep_ProductSettingDetail ps WITH(ROWLOCK,UPDLOCK)
WHERE SportType = 245