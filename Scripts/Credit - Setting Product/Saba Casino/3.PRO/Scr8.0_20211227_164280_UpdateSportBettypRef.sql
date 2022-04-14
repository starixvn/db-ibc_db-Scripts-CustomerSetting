/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: 20211227@Eden
	Task: Enable Saba Casino [#164280]
	DB: DBTXN-bodb02
*/
USE bodb02
GO
UPDATE t 
SET t.isActive = 1
FROM dbo.Sport_Bettype_Reference_Setting t WITH(ROWLOCK,UPDLOCK) 
WHERE sporttype IN( 208,209,210)
	AND isActive = 0