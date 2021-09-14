/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Winfred
	Date: 20210806
	Task: Update SettingStatus = 2 (PROD) for Bitcoin [Redmine: 159039]
	DB: DBCUST/CustDB
	
	P/s : Step 1 hide Bitcoin
*/ 
USE CustDB
GO
UPDATE S
SET S.SettingStatus = 2
FROM ProductSettingDetail S WITH(ROWLOCK) 
WHERE Sporttype = 175


--SELECT * FROM ProductSettingDetail S WITH (NOLOCK) where SportType = 175