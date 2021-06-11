/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: Winfred
	Date: 20210611
	Task: Active Sport_Bettype_Reference_Setting for Soccer 5 H5 linked games RedmineID:#154704
	DB: DBTXN/bodb02
*/

USE bodb02
GO

UPDATE a 
SET a.isActive = 1
FROM Sport_Bettype_Reference_Setting a WITH(UPDLOCK,ROWLOCK) 
WHERE a.SportType = 168 AND BetType in (3604)
 