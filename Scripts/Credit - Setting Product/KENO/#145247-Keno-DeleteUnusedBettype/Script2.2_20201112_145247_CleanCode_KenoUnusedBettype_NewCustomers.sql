/*<info serverAlias="DBCUST-CustDB,DBACC-bodb02"></info>*/
/*
	Created: 20201112@Eden
	Task: Clean code for un-used bettype of Keno - New Customers [#145247]
	DB: DBCUST/CUSTDB 
*/	

DECLARE @maxCustID INT = xxx

CREATE TABLE #TempCustSetting (CustID INT)
CREATE TABLE #SMAMembers(CustID INT)

DECLARE @Batch INT  = 500


INSERT INTO #SMAMembers
SELECT a.CustID
FROM CustGameType a WITH(ROWLOCK) 
WHERE a.GameTypeID = 14 
	AND a.CustID > @maxCustID

WHILE(1=1)
BEGIN
	TRUNCATE TABLE #TempCustSetting

	DELETE TOP (@Batch) a
	OUTPUT deleted.CustID INTO #TempCustSetting(CustID)
	FROM #SMAMembers a
		
	IF @@ROWCOUNT = 0
		BREAK;
		
	DELETE a
	FROM CustOverrideGame a WITH(ROWLOCK) 
		INNER JOIN #TempCustSetting temp ON a.CustId = temp.CustID 
	WHERE  a.sporttype = 202 AND a.BetType BETWEEN 1502 AND 1514
		
	DELETE a
	FROM CustSettingGame a WITH(ROWLOCK) 
		INNER JOIN #TempCustSetting temp ON a.CustId = temp.CustID 
	WHERE  a.sporttype = 202 AND a.BetType BETWEEN 1502 AND 1514

	DELETE a
	FROM CustGameType a WITH(ROWLOCK) 
		INNER JOIN #TempCustSetting temp ON a.CustId = temp.CustID 
	WHERE a.GameTypeID BETWEEN 2 AND 14
END

DROP TABLE #TempCustSetting
DROP TABLE #SMAMembers