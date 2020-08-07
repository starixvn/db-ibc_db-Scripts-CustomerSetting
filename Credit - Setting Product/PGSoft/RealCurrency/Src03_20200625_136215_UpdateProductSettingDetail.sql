/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200805
	Task: Update SettingStatus = 0 (PROD) for Saba VS [Redmine: 137763]
	DB: DBCUST/CustDB
*/ 

DECLARE @BetType INT,@SportType SMALLINT
SELECT @BetType = 6001,@SportType = 232

UPDATE S
SET S.SettingStatus = 0
FROM ProductSettingDetail S WITH(ROWLOCK) 
WHERE Sporttype = @SportType AND ProductID = 22	
	AND SettingType = 8 AND BetType = @BetType
