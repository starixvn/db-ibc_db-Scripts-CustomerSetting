/*
	Created: Winfred
	Date: 20210223
	Task: Update SettingStatus = 2 (PROD) for Sports Lottery [Redmine: 147361]
	DB: DBCUST/CustDB
	
	P/s : Step 1 hide Sports Lottery
*/ 
USE CustDB
GO
UPDATE S
SET S.SettingStatus = 2
FROM ProductSettingDetail S WITH(ROWLOCK) 
WHERE Sporttype = 169


--SELECT * FROM ProductSettingDetail S WITH (NOLOCK) where SportType = 169