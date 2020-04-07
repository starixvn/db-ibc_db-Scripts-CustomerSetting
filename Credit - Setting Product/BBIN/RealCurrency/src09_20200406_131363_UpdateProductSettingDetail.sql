/*
	Created: 20200406@Eden
	Task: Update SettingStatus = 0 (PROD) for BBIN [Redmine: #131363]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO
UPDATE a 
SET a.SettingStatus = 0
FROM ProductSettingDetail a WITH(ROWLOCK) 
WHERE Sporttype = 241

--SELECT * FROM ProductSettingDetail a WITH(NOLOCK) WHERE Sporttype = 241