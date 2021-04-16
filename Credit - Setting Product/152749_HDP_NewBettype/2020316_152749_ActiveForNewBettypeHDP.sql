/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: Winfred
	Date: 2020416
	Task: Active Sport_Bettype_Reference_Setting for New HDP Bet Type  RedmineID:#152749
	DB: DBTXN/bodb02
*/

USE bodb02
GO

UPDATE a 
SET a.isActive = 1
FROM Sport_Bettype_Reference_Setting a WITH(UPDLOCK,ROWLOCK) 
WHERE a.SportType = 1 AND BetType = 229
 