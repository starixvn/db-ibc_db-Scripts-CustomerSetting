/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20201127@Tina
	Task: Update SettingStatus = 0 (PROD) for Gold Diamond Gaming [Redmine: #144105]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO
UPDATE a 
SET a.SettingStatus = 0
FROM ProductSettingDetail a WITH(ROWLOCK) 
WHERE Sporttype = 236

--SELECT * FROM ProductSettingDetail a WITH(NOLOCK) WHERE Sporttype = 236
