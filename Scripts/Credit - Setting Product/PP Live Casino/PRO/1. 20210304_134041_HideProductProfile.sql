/*
	Created: 20210304@Tina
	Task: Hide product profile for PP Live Casino - Real Currency
	DB: DBCUST/CustDB
	
*/ 

USE CustDB
GO

UPDATE S
SET S.SettingStatus = 2
FROM ProductSettingDetail S WITH(ROWLOCK) 
WHERE Sporttype = 170

--SELECT * FROM ProductSettingDetail S WITH (NOLOCK) where SportType = 170




