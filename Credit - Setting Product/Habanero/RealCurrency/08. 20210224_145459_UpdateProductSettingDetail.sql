/*
	Created: 20210224@Tina
	Task: Update SettingStatus = 0 (PROD) for Habanero - Credit - Real Currency
	Redmine: https://nexdev.net/issues/145459
	DB: DBCUST/CustDB
*/

DECLARE @BetType INT,@SportType SMALLINT
SELECT @BetType =  7001,@SportType = 238

UPDATE S
SET S.SettingStatus = 0
FROM ProductSettingDetail S WITH(ROWLOCK) 
WHERE Sporttype = @SportType AND ProductID = 22	
	AND SettingType = 8 AND BetType = @BetType

