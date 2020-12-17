/*<info serverAlias="DBTRANS-BODB02"></info>*/
/*
	Created: Winfred
	Date: 20201202
	Task:  Update UserName Max custid  [RedmineID:#142532]
	DB: DBTRANS/BODB02
*/
USE BODB02
GO

UPDATE bettrans WITH (ROWLOCK, UPDLOCK) 
SET Username = 'FLCRMB0110000'
WHERE custid = 47203894 AND username = 'FLCRMB01017'
