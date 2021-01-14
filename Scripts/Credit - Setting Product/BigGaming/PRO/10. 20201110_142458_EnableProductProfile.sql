/*
	Created: 20201111@Tina
	Task: Update SettingStatus = 0 (PROD) for Big Gaming [Redmine: #142458]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO
UPDATE a 
SET a.SettingStatus = 0
FROM ProductSettingDetail a WITH(ROWLOCK) 
WHERE Sporttype = 239

--SELECT * FROM ProductSettingDetail a WITH(NOLOCK) WHERE Sporttype = 239
