/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221129@Eden
	Task: Update HideKeno = 0 for line superid = 5395806 [#181009]
	DB: DBCust/CustDB
*/
USE CustDB
GO
UPDATE ci 
SET ci.HideKeno = 0
FROM custinfo ci WITH(ROWLOCK,UPDLOCK) 
WHERE HideKeno = 1
	AND srecommend = 5395806
	AND enabled = 1