/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200909
	Task: Update SettingStatus = 2 (DISABLED) for - Credit RedmineID:#131603
	DB: DBCUST/CustDB
*/ 

DECLARE @BetType INT,@SportType SMALLINT
SELECT @BetType = 6401,@SportType = 234

UPDATE S
SET S.SettingStatus = 2
FROM ProductSettingDetail S WITH(ROWLOCK) 
WHERE Sporttype = @SportType AND ProductID = 22	
	AND SettingType = 8 AND BetType = @BetType
