/*
	Created: 20200218@Tiara
	Date: 20200218
	Task: Update product profile to hide old Allbet [Redmine: #128128]
	DB: DBCUST/CustDB
*/

USE CustDB
GO
UPDATE ps
SET ps.SettingStatus = 2
FROM dbo.ProductSettingDetail ps WITH(ROWLOCK,UPDLOCK)
WHERE ProductID = 21 AND SportType = 211

