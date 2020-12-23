/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20201216
	Task:  Update SettingStatus = 2 for Max Game - Hide product [RM:#147232]
	DB: DBCUST/CUSTDB
*/ 

DECLARE  @BetType INT = 5401
		,@SportType SMALLINT = 237

UPDATE S
SET S.SettingStatus = 2
FROM ProductSettingDetail S WITH(ROWLOCK) 
WHERE Sporttype = @SportType AND ProductID = 22	
	AND SettingType = 8 AND BetType = @BetType
