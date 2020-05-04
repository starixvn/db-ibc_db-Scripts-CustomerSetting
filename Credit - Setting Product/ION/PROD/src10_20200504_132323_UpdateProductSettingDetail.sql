/*
	Created: 20200504@Eden
	Task: Update SettingStatus = 0 (PROD) for ION [Redmine: 132323]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO
UPDATE S
SET S.SettingStatus = 0
FROM ProductSettingDetail S WITH(ROWLOCK) 
WHERE Sporttype = 225
