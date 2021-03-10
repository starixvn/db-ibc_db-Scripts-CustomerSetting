/*
	Created: 20210304@Tina
	Task: Update SettingStatus = 0 (PROD) for PP Live Casino - Real Currency
	DB: DBCUST/CustDB
	
*/
 
USE CustDB
GO
UPDATE a 
SET a.SettingStatus = 0
FROM ProductSettingDetail a WITH(ROWLOCK) 
WHERE Sporttype = 170

--SELECT * FROM ProductSettingDetail a WITH(NOLOCK) WHERE Sporttype = 170
