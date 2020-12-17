/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20201202
	Task:  Config deploy 1sp dep OddsAdj  [RedmineID:#142532]
	DB: DBCust/CustDB
*/
USE CustDB
GO


 
 
UPDATE Customer WITH (ROWLOCK, UPDLOCK) 
SET username = 'FLCRMB0110000'
WHERE custid = 47203894 AND username = 'FLCRMB01017'

UPDATE custInfo WITH (ROWLOCK, UPDLOCK) 
SET username = 'FLCRMB0110000'
WHERE custid = 47203894 AND username = 'FLCRMB01017'