/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230904@Helios
	Task: Inital Data Setting SportBettypeSettingMatrix [#189389]
	DB: DBCUST-CustDB
*/

UPDATE mt 
SET SporttypeRefWinlossLimit = NULL 
, BettypeRefWinlossLimit = NULL
, RepUpdateTime	= SYSDATETIME()
from SportBettypeSettingMatrix mt WITH (ROWLOCK,UPDLOCK)
WHERE ProductID = 41
AND isLicensee = 0
AND Site = 'All'
AND SportType IN (211,225,233,239,241,242,244,159,170,236,243)
AND BetType NOT IN (2401,5601,3401,3501,3300,3201,3001,3151,3701,5701,3101)