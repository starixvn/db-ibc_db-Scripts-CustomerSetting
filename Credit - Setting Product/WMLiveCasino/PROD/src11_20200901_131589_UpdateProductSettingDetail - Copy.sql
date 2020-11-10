/*
	Created: Winfred
	Date: 20200828
	Task: Update SettingStatus = 0 (PROD) for WM [Redmine: 131589]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO
UPDATE S
SET S.SettingStatus = 0
FROM ProductSettingDetail S WITH(ROWLOCK) 
WHERE Sporttype = 233
