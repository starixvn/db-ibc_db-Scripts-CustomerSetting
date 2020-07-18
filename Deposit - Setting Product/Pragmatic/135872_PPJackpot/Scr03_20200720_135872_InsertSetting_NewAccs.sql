/*
	Date: 20200720
	Created: Elodie
	Task: Insert setting for PP Jackpot - Deposit [#135872] - New accounts
	DB: DBCUST/CUSTDB
*/

	DECLARE @SportBettype TABLE (SportType SMALLINT, BetType SMALLINT)
	INSERT INTO @SportBettype(SportType, BetType) VALUES (248, 4297)

	DECLARE @ProductSettingID INT

	SELECT @ProductSettingID = p.ProductSettingID
	FROM Dep_ProductSettingDetail ps WITH (NOLOCK)
		INNER JOIN Dep_ProductSetting p WITH (NOLOCK) ON p.ProductSettingID = ps.ProductSettingID
	WHERE sporttype = 248 AND SettingType = 1 AND bettype = 4101

	--> API Licensee
	CREATE TABLE #APIsupers (custid int)

	INSERT INTO #APIsupers(custid)
	SELECT c.custid
	FROM customer c WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
		INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
		INNER JOIN Dep_LicenseeProductSetting ls WITH (NOLOCK) ON c.custid = ls.custid
	WHERE c.roleid = 4  
	 AND s.islicensee = 1
	 AND ci.Enabled = 1
	 AND s.site NOT IN ('Athena000', 'Spondemo')
	 AND ls.ProductSettingID = @ProductSettingID

	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED
	   ,Currency INT
	   ,mrecommend INT
	   ,PT SMALLMONEY
	   ,SiteId INT
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED
	   ,Currency INT
	   ,RoleID TINYINT
	   ,mrecommend INT
	   ,PT SMALLMONEY
	   ,SiteId INT
	)

	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend IN (SELECT custid FROM #APIsupers) AND roleid=3 
		AND(username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%' )
	
	INSERT INTO #SMATemp(CustID,RoleID,Currency,mrecommend,PT,SiteId)
	SELECT ci.custid, ci.roleid, ci.currency,ci.mrecommend,100,s.siteid
	FROM Custinfo ci WITH (NOLOCK)
		INNER JOIN customer c WITH (NOLOCK) ON c.custid = ci.custid
		INNER JOIN dbo.Site s WITH (NOLOCK) ON c.site = s.site
	WHERE ci.srecommend IN (SELECT custid FROM #APIsupers) AND ci.roleid IN (2,3,4) AND Enabled = 1 AND ci.custid > @max_custid 
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO #MemberTemp(CustID,Currency,mrecommend,PT,SiteId)
	SELECT ci.custid, ci.currency,ci.mrecommend,100,s.siteid
	FROM Custinfo ci WITH (NOLOCK)
		INNER JOIN customer c WITH (NOLOCK) ON c.custid = ci.recommend
		INNER JOIN dbo.Site s WITH (NOLOCK) ON c.site = s.site
	WHERE ci.srecommend IN (SELECT custid FROM #APIsupers) AND ci.roleid = 1  AND Enabled = 1 AND ci.custid > @max_custid	
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)

	--DELETE existing data
	------------------------------------PT Setting-------------------------------------------------	
	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustPTSetting_Agent
	FROM Dep_CustPTSetting_Agent a WITH(NOLOCK)
	INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.CustID = ci.custid

	DELETE a
	FROM Dep_CustPTSetting_Agent a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #Dep_CustPTSetting_Agent t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustPTSetting_Member
	FROM Dep_CustPTSetting_Member a WITH(NOLOCK)
	INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN #MemberTemp ci WITH(NOLOCK) ON a.CustID = ci.custid

	DELETE a
	FROM Dep_CustPTSetting_Member a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #Dep_CustPTSetting_Member t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	SELECT a.AgentID,a.SportType,a.BetType
	INTO #Dep_CustPTGroupSetting_Member
	FROM Dep_CustPTGroupSetting_Member a WITH(NOLOCK)
	INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.AgentID = ci.custid

	DELETE a
	FROM Dep_CustPTGroupSetting_Member a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #Dep_CustPTGroupSetting_Member t ON a.AgentID = t.AgentID AND a.SportType = t.SportType and a.BetType = t.BetType 

	-------------
	--SELECT dl.CustID,dl.ProductSettingID
	--INTO #Dep_LicenseeProductSetting
	--FROM Dep_LicenseeProductSetting dl WITH(NOLOCK)
	--	INNER JOIN Dep_ProductSettingDetail dp WITH(NOLOCK) ON dl.ProductSettingID = dp.ProductSettingID
	--	INNER JOIN @SportBettype t ON dp.SportType = t.SportType and dp.BetType = t.BetType
	--	INNER JOIN CustInfo ci WITH(NOLOCK) ON dl.CustID = ci.custid
	--	INNER JOIN #SMATemp s ON ci.custid = s.custid

	--DELETE a
	--FROM Dep_LicenseeProductSetting a WITH(ROWLOCK,UPDLOCK)
	--INNER JOIN #Dep_LicenseeProductSetting t ON a.CustID = t.CustID AND a.ProductSettingID = t.ProductSettingID

	DROP TABLE #Dep_CustPTGroupSetting_Member
	DROP TABLE #Dep_CustPTSetting_Agent
	DROP TABLE #Dep_CustPTSetting_Member
	--DROP TABLE #Dep_LicenseeProductSetting

	---------------------CREATE setting for NEW ACCs-----------------------------------
	-----------------------------------------Dep_LicenseeProductSetting-------------------------------------------------------

	--INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	--SELECT temp.CustID
	--	  ,st.ProductSettingID
	--FROM #SMATemp temp 
	--	 CROSS APPLY (	SELECT ProductSettingID 
	--					FROM Dep_ProductSettingDetail dp WITH(NOLOCK) 
	--						INNER JOIN @SportBettype t ON dp.SportType = t.SportType and dp.BetType = t.BetType
	--					) st
	--WHERE temp.RoleID = 4

	------------------------------------PT Setting-------------------------------------------------		
	--SMA LEVEL
	INSERT INTO dbo.Dep_CustPTSetting_Agent
		(	[CustID]
			,[SportType]
			,[BetType]
			,[IsLive]
			,[SuperPT]
			,[MasterPT]
			,[AgentPT]
			)
	SELECT 
			 d.[CustID]
			,t.[SportType]
			,t.[BetType]
			,[IsLive] = 0
			,[SuperPT] = CASE WHEN d.roleid = 4 THEN d.PT ELSE 0 END
			,[MasterPT] = CASE WHEN d.roleid IN (4,3) THEN d.PT ELSE 0 END
			,[AgentPT] = CASE WHEN d.roleid IN (4,2) THEN d.PT ELSE 0 END
	FROM #SMATemp d
		CROSS APPLY @SportBetType t

	----MEMBER LEVEL
	INSERT INTO dbo.Dep_CustPTSetting_Member
		(	    [custid]
			,	[sporttype]
			,	[bettype]
			,	[islive]
			,	[superPT]
			,	[masterPT]
			,	[agentPT]
		)
	SELECT 
			 d.[CustID]
			,t.[SportType]
			,t.[BetType]
			,[IsLive] = 0
			,[SuperPT] = 0
			,[MasterPT] = 0
			,[AgentPT] = d.PT
	FROM #MemberTemp d
		CROSS APPLY @SportBetType t
		INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON d.CustID = m.CustID
	WHERE m.IsGroupedPT = 0

	INSERT INTO Dep_CustPTGroupSetting_Member (
		 AgentID
		,SportType
		,BetType
		,IsLive
		,SuperPT
		,MasterPT
		,AgentPT
	)
	SELECT d.[CustID]
		,t.[SportType]
		,t.[BetType]
		,[IsLive] = 0
		,[SuperPT] = 0
		,[MasterPT] = 0
		,[AgentPT] = d.PT
	FROM #SMATemp d
		CROSS APPLY @SportBetType t	
	WHERE roleid = 2

	INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
	SELECT t.CustID,1
	FROM #MemberTemp t WITH(NOLOCK)
		LEFT JOIN Dep_CustSettingMode d WITH(NOLOCK) ON  d.CustID = t.CustID
	WHERE d.CustID IS NULL

	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp