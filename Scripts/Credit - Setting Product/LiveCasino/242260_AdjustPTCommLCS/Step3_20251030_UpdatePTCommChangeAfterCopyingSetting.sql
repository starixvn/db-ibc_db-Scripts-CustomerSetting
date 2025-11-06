/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created By: Johnson@20251030
	Description: Update PT/Comm change after copying settings [redmine: #242260]
	DB: DBCust/CustDB	
*/
DECLARE @maxCustid INT =xxx
DECLARE @LastUpdateTime DATETIME = 'yyy'
DECLARE @__delaytime VARCHAR(10)

CREATE TABLE #tblSMA(CustID INT, roleid TINYINT, srecommend INT, mrecommend INT, recommend INT, isfinished BIT DEFAULT(0))
CREATE TABLE #tblDirectMember (CustID INT PRIMARY KEY,srecommend INT, mrecommend INT, recommend INT)
CREATE TABLE #tblCust(CustID INT PRIMARY  KEY)
DECLARE @tmpCust TABLE(CustID INT PRIMARY KEY)

--PhoneBetting
CREATE TABLE #PhoneBetting(mrecommend INT, recommend INT)
CREATE TABLE #DummySuper(custid INT)

INSERT INTO #PhoneBetting(mrecommend,recommend)	
SELECT DISTINCT mrecommend,recommend
FROM dbo.PhoneBettingCustomerList p WITH(NOLOCK)
	INNER JOIN customer c WITH(NOLOCK) ON p.username = c.username
	
-- get dummy super list
INSERT INTO #DummySuper(custid)
SELECT DISTINCT srecommend 
FROM CustDirectAccount da WITH (NOLOCK)
     INNER JOIN customer ci WITH(NOLOCK) ON da.CustID = ci.custid	 
WHERE  ci.roleid IN (1, 2, 3) 	
	AND ci.site IN ('BEST-ODDS','611111','733333','755555','222223','7aa666','KORIBC','722222','XYZBet')				
	AND srecommend NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	
--Get supers normal
INSERT INTO #tblSMA(CustID,roleid)
SELECT DISTINCT ci.custid, ci.roleid 
FROM customer ci WITH (NOLOCK) 
	INNER JOIN custinfo cu with (nolock) on cu.custid=ci.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site	
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid		
WHERE ci.roleid = 4 
	AND ci.site IN ('BEST-ODDS','611111','733333','755555','222223','7aa666','KORIBC','722222','XYZBet')	
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND ci.custid NOT IN (SELECT custid FROM #dummySuper)
	AND cu.Enabled = 1
	AND s.islicensee = 0	
	AND cs.IsInternal=0
	AND ci.custid>=100
	AND ci.username not like '3rdSuper%' 
	AND ci.custid <= @maxCustid
	AND ci.custid = 270267360

--Direct masters exclude who has  phone betting	members
INSERT INTO #tblSMA(CustID,roleid,srecommend)
SELECT DISTINCT ci.custid, ci.roleid, ci.srecommend 
	FROM customer ci with(nolock)
		INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid				
	WHERE EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		AND ci.roleid=3 
		AND ci.site IN ('BEST-ODDS','611111','733333','755555','222223','7aa666','KORIBC','722222','XYZBet')		
		AND c.Enabled=1				
		AND c.custid NOT IN (SELECT mrecommend FROM #PhoneBetting)		
		AND ci.custid <= @maxCustid

--Direct agents exclude who has  phone betting	members
INSERT INTO #tblSMA(CustID,roleid,srecommend,mrecommend)
SELECT DISTINCT ci.custid, ci.roleid, ci.srecommend, ci.mrecommend
FROM customer ci WITH(NOLOCK)
	INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid				
WHERE  EXISTS (SELECT custid FROM dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
	AND ci.roleid = 2 
	AND ci.site IN ('BEST-ODDS','611111','733333','755555','222223','7aa666','KORIBC','722222','XYZBet')		
	AND c.Enabled=1		
	AND c.custid NOT IN (SELECT recommend FROM #PhoneBetting)		
	AND ci.custid <= @maxCustid

--Direct members 
INSERT INTO #tblDirectMember(CustID,srecommend,mrecommend,recommend)
SELECT DISTINCT ci.custid, ci.srecommend, ci.mrecommend, ci.recommend
FROM customer ci WITH(NOLOCK)
	INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid				
WHERE  EXISTS (SELECT custid FROM dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
	AND ci.roleid = 1 
	AND ci.site IN ('BEST-ODDS','611111','733333','755555','222223','7aa666','KORIBC','722222','XYZBet')		
	AND c.Enabled=1				
	AND ci.custid <= @maxCustid

--get list customer have changed PT during copying settings
INSERT INTO #tblCust(CustID)
SELECT ci.custid
FROM CustPTSetting3rd_Agent cs1 WITH(NOLOCK)
	INNER JOIN custinfo ci WITH (NOLOCK) ON cs1.custid = ci.custid
	INNER JOIN CustPTSetting3rd_Agent cs2 WITH(NOLOCK) ON ci.custid = cs2.custid
WHERE cs1.SportType = 9911
	AND cs1.BetType = 2400
	AND cs2.SportType = 9916
	AND cs2.BetType = 2400
	AND ci.custid <= @maxCustid
	AND (ci.srecommend IN (SELECT custid FROM #tblSMA WHERE roleid = 4)
		OR ci.mrecommend IN (SELECT custid FROM #tblSMA WHERE roleid = 3)
		OR ci.recommend IN (SELECT custid FROM #tblSMA WHERE roleid = 2))
	AND ci.roleid IN (2,3,4)	
	AND cs1.RepUpdateTime >= @LastUpdateTime
	AND (cs1.IsAutoMasterPT <> cs2.IsAutoMasterPT 
		OR cs1.IsAutoSuperPT <> cs2.IsAutoSuperPT 
		OR cs1.SuperPT <> cs2.SuperPT 
		OR cs1.MasterPT <> cs2.MasterPT 
		OR cs1.AgentPT <> cs2.AgentPT 
		OR cs1.AutoSuperPT <> cs2.AutoSuperPT 
		OR cs1.AutoMasterPT <> cs2.AutoMasterPT 
		OR cs1.MinPT <> cs2.MinPT 
		OR cs1.MaxPT <> cs2.MaxPT)

WHILE (1=1)
BEGIN
	DELETE TOP (1000) t
	OUTPUT DELETED.CustID INTO @tmpCust(custid)
	FROM #tblCust t
	
	IF @@ROWCOUNT =0 BREAK;

	UPDATE cs
	SET cs.IsAutoMasterPT = cs2.IsAutoMasterPT,
			cs.IsAutoSuperPT = cs2.IsAutoSuperPT,
			cs.SuperPT = cs2.SuperPT,
			cs.MasterPT = cs2.MasterPT,
			cs.AgentPT = cs2.AgentPT,
			cs.AutoSuperPT = cs2.AutoSuperPT,
			cs.AutoMasterPT = cs2.AutoMasterPT,
			cs.MinPT = cs2.MinPT,
			cs.MaxPT = cs2.MaxPT,
			cs.RepUpdateTime = dbo.f_GetDateTime2()	
	FROM CustPTSetting3rd_Agent cs WITH(ROWLOCK)
		INNER JOIN CustPTSetting3rd_Agent cs2 WITH(ROWLOCK) ON cs.CustID = cs2.CustID
	WHERE cs.custid IN (SELECT custid FROM @tmpCust)
		AND cs.SportType IN (9916,9917)
		AND cs.BetType = 2400
		AND cs2.SportType = 9911
		AND cs2.BetType = 2400	

	DELETE @tmpCust	

	SELECT @__delaytime = dbo.f_DelayTime('CS_Adhoc')
	WAITFOR DELAY @__delaytime 
END


--get list members change settings
INSERT INTO #tblCust(CustID)
SELECT ci.custid
FROM CustPTSetting3rd_Member cs1 WITH(NOLOCK)
	INNER JOIN custinfo ci WITH (NOLOCK) ON cs1.custid = ci.custid
	INNER JOIN CustPTSetting3rd_Member cs2 WITH(NOLOCK) ON ci.custid = cs2.custid
WHERE cs1.SportType = 9911
	AND cs1.BetType = 2400
	AND cs2.SportType = 9916
	AND cs2.BetType = 2400
	AND ci.custid <= @maxCustid
	AND (ci.srecommend IN (SELECT custid FROM #tblSMA WHERE roleid = 4)
		OR ci.mrecommend IN (SELECT custid FROM #tblSMA WHERE roleid = 3)
		OR ci.recommend IN (SELECT custid FROM #tblSMA WHERE roleid = 2)
		OR ci.custid IN (SELECT custid FROM #tblDirectMember))
	AND ci.roleid = 1	
	AND cs1.RepUpdateTime >= @LastUpdateTime
	AND (cs1.IsAutoMasterPT <> cs2.IsAutoMasterPT 
		OR cs1.IsAutoSuperPT <> cs2.IsAutoSuperPT 
		OR cs1.SuperPT <> cs2.SuperPT 
		OR cs1.MasterPT <> cs2.MasterPT 
		OR cs1.AgentPT <> cs2.AgentPT 
		OR cs1.AutoSuperPT <> cs2.AutoSuperPT 
		OR cs1.AutoMasterPT <> cs2.AutoMasterPT)


WHILE (1=1)
BEGIN
	DELETE TOP (1000) t
	OUTPUT DELETED.CustID INTO @tmpCust(custid)
	FROM #tblCust t
	
	IF @@ROWCOUNT =0 BREAK;

	UPDATE cs
	SET cs.IsAutoMasterPT = cs2.IsAutoMasterPT,
			cs.IsAutoSuperPT = cs2.IsAutoSuperPT,
			cs.SuperPT = cs2.SuperPT,
			cs.MasterPT = cs2.MasterPT,
			cs.AgentPT = cs2.AgentPT,
			cs.AutoSuperPT = cs2.AutoSuperPT,
			cs.AutoMasterPT = cs2.AutoMasterPT,
			cs.RepUpdateTime = dbo.f_GetDateTime2()
	FROM CustPTSetting3rd_Member cs WITH(ROWLOCK)
		INNER JOIN CustPTSetting3rd_Member cs2 WITH(ROWLOCK) ON cs.CustID = cs2.CustID
	WHERE cs.custid IN (SELECT custid FROM @tmpCust)
		AND cs.SportType IN (9916,9917)
		AND cs.BetType = 2400
		AND cs2.SportType = 9911
		AND cs2.BetType = 2400

	DELETE @tmpCust	

	SELECT @__delaytime = dbo.f_DelayTime('CS_Adhoc')
	WAITFOR DELAY @__delaytime 
END
		
DROP TABLE #tblSMA	
DROP TABLE #tblCust
DROP TABLE #tblDirectMember
DROP TABLE #dummySuper	
DROP TABLE #PhoneBetting
GO	
