/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 20221020
	Task: Enable Product Status for all disabled customers under 789y Headline - RedmineID: #124311
	DB: DBCUST/CustDB
*/ 

CREATE TABLE #supers (custid int)
CREATE TABLE #supers_missDis (custid INT PRIMARY KEY) --update hideKeno=1, miss update disabled=1
CREATE TABLE #DownlineTemp ( CustID INT)	
	
CREATE CLUSTERED INDEX CIX_DownlineTemp ON #DownlineTemp (CustID)

INSERT INTO #supers_missDis(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.islicensee = 0
		AND (  ( ci.Site IN ('611111') AND ci.currency IN (2,42))
			OR ( ci.Site IN ('722222','733333') AND ci.currency IN (13))
			OR ( ci.Site IN ('y789','y889','yOther','yUT') AND ci.currency IN (2,6))
			OR ( ci.Site IN ('7aa666') AND ci.currency IN (2))
			OR ( ci.Site IN ('BEST-ODDS') AND ci.currency IN (42)))

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN custInfo C WITH (NOLOCK) ON C.custid = ci.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND ci.site IN ('y789','y889','yOther','yUT')
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.currency <> 20
	AND Enabled = 1 
		AND ci.custid NOT IN (SELECT custid FROM #supers_missDis )

INSERT INTO #DownlineTemp (CustID)
SELECT DISTINCT ci.custid
FROM Custinfo ci WITH (NOLOCK)
	INNER JOIN dbo.CustGameType cs WITH (NOLOCK) ON cs.CustID = ci.custid
WHERE srecommend IN (SELECT custid FROM #supers)
	AND ci.HideKeno = 1
	AND Enabled = 1 
	AND cs.IsDisabled = 0
	AND cs.GameTypeID BETWEEN 1 AND 99

--update disabled=0 miss update hideKeno=0 
UPDATE g 
SET HideKeno = 0
FROM dbo.CustInfo g WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #DownlineTemp b ON g.CustID = b.CustID 

DROP TABLE #supers_missDis
DROP TABLE #supers
DROP TABLE #DownlineTemp
GO

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------