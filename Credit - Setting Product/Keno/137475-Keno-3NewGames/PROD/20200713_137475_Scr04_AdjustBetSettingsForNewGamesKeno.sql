/*
	Created: 20200713@Eden
	Task: adjust settings for new games of Keno after copy settings from MaxKeno [Redmine:#137475]
	DB: DBCUST/CUSTDB
*/
USE CUSTDB
GO
						
CREATE TABLE #tblCust (CustID INT ,GameTypeID INT, PRIMARY KEY CLUSTERED(custid,GameTypeID))	
CREATE TABLE #Supers(CustID INT)
	
INSERT INTO #Supers(custid)
SELECT ci.custid 
FROM dbo.customer c WITH (Nolock) 
	INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
WHERE ci.roleid = 4
	AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))	
	AND ci.custid NOT IN (SELECT custid FROM dbo.CustSuper WITH(NOLOCK) WHERE isInternal = 1)
	AND ci.Enabled = 1
	AND s.islicensee = 0
	AND ci.currency <> 20--exclude UUS
	AND c.username NOT LIKE '3rdSuper%'
		
--check change settings
INSERT INTO #tblCust(custid,GameTypeID)
SELECT cg2.custid, cg2.GameTypeID
FROM DBNOTI.CustDB_AdjustCS.dbo.CustGameType cg1 WITH(NOLOCK)
	INNER JOIN dbo.CustInfo ci WITH(NOLOCK) ON cg1.custid = ci.custid
	INNER JOIN dbo.CustGameType cg2 WITH(NOLOCK) ON cg2.custid = ci.custid
WHERE ci.srecommend IN (SELECT custid FROM #Supers)
	AND cg1.GameTypeID = 15
	AND cg2.GameTypeID IN (27,28,29)
	AND (cg1.MinBet <> cg2.MinBet
		OR cg1.MaxBet <> cg2.MaxBet
		OR cg1.MaxPerGameType <> cg2.MaxPerGameType
		OR cg1.IsDisabled <> cg2.IsDisabled
		)
		
UPDATE cg2
SET	cg2.MinBet = cg1.MinBet,
	cg2.MaxBet = cg1.MaxBet,
	cg2.MaxPerGameType = cg1.MaxPerGameType,
	cg2.IsDisabled = cg1.IsDisabled
FROM DBNOTI.CustDB_AdjustCS.dbo.CustGameType cg1 WITH(NOLOCK)
	INNER JOIN #tblCust ci WITH(NOLOCK) ON cg1.custid = ci.custid
											AND cg1.GameTypeID = 15
	INNER JOIN dbo.CustGameType cg2 WITH(UPDLOCK,ROWLOCK) ON cg2.custid = ci.custid
											AND cg2.GameTypeID = ci.GameTypeID
	
DROP TABLE #Supers
DROP TABLE #tblCust
