/*
	Created: Eden
	Date: 20200324
	Task: UPDATE global setting for Indo 4D DEPOSIT
	DB: DBCust/CustDB
*/

USE CustDB
GO

UPDATE ps
SET ps.SettingStatus = 0
FROM dbo.Dep_ProductSettingDetail ps WITH(ROWLOCK,UPDLOCK)
WHERE SportType = 223