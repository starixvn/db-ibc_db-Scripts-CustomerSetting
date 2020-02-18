/*
	Created: 20200218@Tiara
	Date: 20200218
	Task: Update product profile for SA Gaming [Redmine: #128128]
	DB: DBCUST/CustDB
*/

USE CustDB
GO
UPDATE ps
SET ps.SettingStatus = 0
FROM dbo.ProductSettingDetail ps WITH(ROWLOCK,UPDLOCK)
WHERE ProductID = 39 AND SportType=244
