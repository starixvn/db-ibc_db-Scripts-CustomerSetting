/*
	Created: 20191030@Winnie
	Task: Update product profile for SG
	DB: DBCUST/CustDB
*/

USE CustDB
GO
UPDATE ps
SET ps.SettingStatus = 0
FROM dbo.ProductSettingDetail ps WITH(ROWLOCK,UPDLOCK)
WHERE ProductID = 22 AND SportType=247
