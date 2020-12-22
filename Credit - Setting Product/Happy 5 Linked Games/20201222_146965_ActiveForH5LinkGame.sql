/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: Winfred
	Date: 20201221
	Task: Active Sport_Bettype_Reference_Setting for H5 linked games RedmineID:#131370
	DB: DBTXN/bodb02
*/

USE bodb02
GO

UPDATE a 
SET a.isActive = 1
FROM Sport_Bettype_Reference_Setting a WITH(UPDLOCK,ROWLOCK) 
WHERE a.SportType = 168 AND BetType in (3601,3602,3603)
 