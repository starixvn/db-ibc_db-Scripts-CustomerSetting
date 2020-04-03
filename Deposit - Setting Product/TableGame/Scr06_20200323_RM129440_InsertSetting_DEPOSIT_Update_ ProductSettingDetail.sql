/*
	Created: Elodie
	Date: 20200330
	Task: UPDATE global setting for Table Games DEPOSIT
	DB: DBCust/CustDB
*/

USE CustDB
GO

UPDATE ps
SET ps.SettingStatus = 0
FROM dbo.Dep_ProductSettingDetail ps WITH(ROWLOCK)
WHERE SportType = 222