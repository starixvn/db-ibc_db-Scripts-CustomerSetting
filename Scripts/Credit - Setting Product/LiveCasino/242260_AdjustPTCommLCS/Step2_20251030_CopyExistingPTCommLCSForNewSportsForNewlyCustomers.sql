/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created By: Johnson@20251030
	Description: copy existing settings from old sports to new sports for newly customers [redmine: #242260]
	DB: DBCust/CustDB	
*/
DECLARE @maxCustid INT = xxx
DECLARE @__delaytime VARCHAR(10)

CREATE TABLE #tblSMA(CustID INT, roleid TINYINT, srecommend INT, mrecommend INT, recommend INT, isfinished BIT DEFAULT(0))
CREATE TABLE #tblDirectMember (CustID INT PRIMARY KEY,srecommend INT, mrecommend INT, recommend INT)
CREATE TABLE #tblCust(CustID INT PRIMARY  KEY, roleid TINYINT)
DECLARE @tmpCust TABLE(CustID INT PRIMARY KEY)

--PhoneBetting
CREATE TABLE #PhoneBetting(mrecommend INT, recommend INT)
CREATE TABLE #DummySuper(custid INT)

--115 rows affected
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

--Direct members 
INSERT INTO #tblDirectMember(CustID,srecommend,mrecommend,recommend)
SELECT DISTINCT ci.custid, ci.srecommend, ci.mrecommend, ci.recommend
FROM customer ci WITH(NOLOCK)
	INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid				
WHERE  EXISTS (SELECT custid FROM dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
	AND ci.roleid = 1 
	AND ci.site IN ('BEST-ODDS','611111','733333','755555','222223','7aa666','KORIBC','722222','XYZBet')		
	AND c.Enabled=1				
	AND ci.custid > @maxCustid

--downlines of normal supers
INSERT INTO #tblCust(CustID, roleid)
SELECT CustID, roleid
FROM Custinfo WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM #tblSMA WHERE roleid = 4)	
	AND CustID > @maxCustid

--downlines of direct masters
INSERT INTO #tblCust(CustID, roleid)
SELECT CustID, roleid
FROM Custinfo WITH(NOLOCK)
WHERE mrecommend IN (SELECT custid FROM #tblSMA WHERE roleid = 3)
	AND Enabled = 1
	AND CustID > @maxCustid

--downlines of direct agents
INSERT INTO #tblCust(CustID, roleid)
SELECT CustID, roleid
FROM Custinfo WITH(NOLOCK)
WHERE recommend IN (SELECT custid FROM #tblSMA WHERE roleid = 2)
	AND Enabled = 1
	AND CustID > @maxCustid


WHILE (1=1)
BEGIN
	DELETE TOP (1000) t
	OUTPUT DELETED.CustID INTO @tmpCust(custid)
	FROM #tblCust t
	WHERE roleid IN (2,3,4)

	IF @@ROWCOUNT =0 BREAK;

	INSERT INTO [dbo].[CustPTSetting3rd_Agent]
		([CustID]
		,[SportType]
		,[BetType]
		,[IsLive]
		,[IsAutoMasterPT]
		,[IsAutoSuperPT]
		,[SuperPT]
		,[MasterPT]
		,[AgentPT]
		,[AutoSuperPT]
		,[AutoMasterPT]
		,[MinPT]
		,[MaxPT]
		,[RepUpdateTime])
	SELECT CustID, t.SportType, t.BetType, IsLive, IsAutoMasterPT, IsAutoSuperPT, SuperPT, MasterPT, AgentPT, AutoSuperPT, AutoMasterPT, MinPT, MaxPT, dbo.f_GetDateTime2()
	FROM  CustPTSetting3rd_Agent cs WITH(NOLOCK)
		CROSS APPLY (SELECT 9916 as SportType, 2400 as BetType			
						UNION ALL SELECT 9917, 2400) AS t
	WHERE custid IN (SELECT custid FROM @tmpCust)
		AND cs.SportType = 9911
		AND cs.BetType = 2400
		AND NOT EXISTS (SELECT 1 FROM dbo.CustPTSetting3rd_Agent cs2 WITH(NOLOCK) WHERE cs2.CustID = cs.CustID AND cs2.SportType = t.SportType AND cs2.BetType = t.BetType)

	DELETE @tmpCust	

	SELECT @__delaytime = dbo.f_DelayTime('CS_Adhoc')
	WAITFOR DELAY @__delaytime 
END

WHILE (1=1)
BEGIN
	DELETE TOP (1000) t
	OUTPUT DELETED.CustID INTO @tmpCust(custid)
	FROM #tblCust t
	WHERE roleid = 1

	IF @@ROWCOUNT =0 BREAK;

	INSERT INTO [dbo].[CustPTSetting3rd_Member]
		([CustID]
		,[SportType]
		,[BetType]
		,[IsLive]
		,[IsAutoMasterPT]
		,[IsAutoSuperPT]
		,[SuperPT]
		,[MasterPT]
		,[AgentPT]
		,[AutoSuperPT]
		,[AutoMasterPT]
		,[RepUpdateTime])
	SELECT CustID, t.SportType, t.BetType, IsLive, IsAutoMasterPT, IsAutoSuperPT, SuperPT, MasterPT, AgentPT, AutoSuperPT, AutoMasterPT, dbo.f_GetDateTime2()
	FROM  CustPTSetting3rd_Member cs WITH(NOLOCK)
		CROSS APPLY (SELECT 9916 as SportType, 2400 as BetType			
						UNION ALL SELECT 9917, 2400) AS t
	WHERE custid IN (SELECT custid FROM @tmpCust)
		AND cs.SportType = 9911
		AND cs.BetType = 2400
		AND NOT EXISTS (SELECT 1 FROM dbo.CustPTSetting3rd_Member cs2 WITH(NOLOCK) WHERE cs2.CustID = cs.CustID AND cs2.SportType = t.SportType AND cs2.BetType = t.BetType)

	DELETE @tmpCust	

	SELECT @__delaytime = dbo.f_DelayTime('CS_Adhoc')
	WAITFOR DELAY @__delaytime 	
END

--Insert for dummy accounts
;WITH t AS (
	SELECT DISTINCT srecommend AS CustID
	FROM #tblSMA
	WHERE roleid IN (2,3)
	UNION 
	SELECT DISTINCT mrecommend AS CustID
	FROM #tblSMA
	WHERE roleid IN (2)
	UNION 
	SELECT DISTINCT srecommend AS CustID
	FROM #tblDirectMember
	UNION 
	SELECT DISTINCT mrecommend AS CustID
	FROM #tblDirectMember
	UNION 
	SELECT DISTINCT recommend AS CustID
	FROM #tblDirectMember
)
INSERT INTO [dbo].[CustPTSetting3rd_Agent]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[IsAutoMasterPT]
           ,[IsAutoSuperPT]
           ,[SuperPT]
           ,[MasterPT]
           ,[AgentPT]
           ,[AutoSuperPT]
           ,[AutoMasterPT]
           ,[MinPT]
           ,[MaxPT]
           ,[RepUpdateTime])
SELECT CustID, t.SportType, t.BetType, IsLive, IsAutoMasterPT, IsAutoSuperPT, SuperPT, MasterPT, AgentPT, AutoSuperPT, AutoMasterPT, MinPT, MaxPT, dbo.f_GetDateTime2()
FROM  CustPTSetting3rd_Agent cs WITH(NOLOCK)
	CROSS APPLY (SELECT 9916 as SportType, 2400 as BetType			
				UNION ALL SELECT 9917, 2400) AS t	
WHERE cs.CustID IN (SELECT DISTINCT custid FROM T WHERE custid > @maxCustid)
	AND cs.SportType = 9911
	AND cs.BetType = 2400
	AND NOT EXISTS (SELECT 1 FROM dbo.CustPTSetting3rd_Agent cs2 WITH(NOLOCK) WHERE cs2.CustID = cs.CustID AND cs2.SportType = t.SportType AND cs2.BetType = t.BetType)
		
--insert for direct members
WHILE (1=1)
BEGIN
	DELETE TOP (1000) t
	OUTPUT DELETED.CustID INTO @tmpCust(custid)
	FROM #tblDirectMember t
	
	IF @@ROWCOUNT =0 BREAK;

	INSERT INTO [dbo].[CustPTSetting3rd_Member]
			([CustID]
			,[SportType]
			,[BetType]
			,[IsLive]
			,[IsAutoMasterPT]
			,[IsAutoSuperPT]
			,[SuperPT]
			,[MasterPT]
			,[AgentPT]
			,[AutoSuperPT]
			,[AutoMasterPT]
			,[RepUpdateTime])
	SELECT CustID, t.SportType, t.BetType, IsLive, IsAutoMasterPT, IsAutoSuperPT, SuperPT, MasterPT, AgentPT, AutoSuperPT, AutoMasterPT, dbo.f_GetDateTime2()
	FROM  CustPTSetting3rd_Member cs WITH(NOLOCK)
		CROSS APPLY (SELECT 9916 as SportType, 2400 as BetType			
						UNION ALL SELECT 9917, 2400) AS t
	WHERE custid IN (SELECT custid FROM @tmpCust)
		AND cs.SportType = 9911
		AND cs.BetType = 2400
		AND NOT EXISTS (SELECT 1 FROM dbo.CustPTSetting3rd_Member cs2 WITH(NOLOCK) WHERE cs2.CustID = cs.CustID AND cs2.SportType = t.SportType AND cs2.BetType = t.BetType)
		
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
