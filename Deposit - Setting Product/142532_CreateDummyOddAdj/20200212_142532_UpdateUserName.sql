/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20201202
	Task:  Update UserName Max custid  [RedmineID:#142532]
	DB: DBCust/CustDB
*/
USE CustDB
GO


 
 
UPDATE Customer WITH (ROWLOCK, UPDLOCK) 
SET username = 'FLCRMB0119512'
WHERE custid = 47203894 AND username = 'FLCRMB01017'

UPDATE custInfo WITH (ROWLOCK, UPDLOCK) 
SET username = 'FLCRMB0119512'
WHERE custid = 47203894 AND username = 'FLCRMB01017'