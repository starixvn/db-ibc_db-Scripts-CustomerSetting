/*
	Created: Tiara
	Date: 20200505
	Task: Update Product Profile [Redmine: 132018]
	DB: DBCUST/CustDB
*/
USE CustDB
GO
UPDATE S
SET S.SettingStatus = 0
FROM ProductSettingDetail S WITH(ROWLOCK) 
WHERE Sporttype = 224
