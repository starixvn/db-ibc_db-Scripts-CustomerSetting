/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240422@Eden
	Task: Correct Member dep_custsettingmode.IsGroupPT [Redmine: #204235]
		113891227		SM88INH14S206351
		117839753		568WinSWINR01S1651245
	DB: DBCUST/CustDB 
*/ 

CREATE TABLE #Member_WrongGroupPT(CustID INT)

INSERT INTO #Member_WrongGroupPT(CustID)
SELECT CustID
FROM dep_custsettingmode WITH(NOLOCK) 
WHERE IsGroupedPT = 0
	AND custid IN (113891227,117839753)

UPDATE c
SET c.IsGroupedPT = 1
FROM dep_custsettingmode c WITH(ROWLOCK,UPDLOCK) 
	INNER JOIN #Member_WrongGroupPT t
		ON c.CustID = t.CustID
WHERE c.IsGroupedPT = 0

DELETE c
FROM Dep_CustPTSetting_Member c WITH(ROWLOCK,UPDLOCK) 
	INNER JOIN #Member_WrongGroupPT t
		ON c.CustID = t.CustID

DROP TABLE #Member_WrongGroupPT