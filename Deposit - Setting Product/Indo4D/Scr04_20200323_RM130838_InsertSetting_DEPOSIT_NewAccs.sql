/*
	Created: Eden
	Date: 20191029
	Task: Create setting for Indo 4D Deposit (N88, N8B, N8G)( New accounts)
	DB: DBCust/CustDB
*/

	DECLARE @max_custid INT = xxx

	DECLARE @Indo4DSportBettype TABLE (SportType SMALLINT, BetType SMALLINT)
	INSERT INTO @Indo4DSportBettype(SportType, BetType) VALUES (223, 5001)
	INSERT INTO @Indo4DSportBettype(SportType, BetType) VALUES (223, 5002)
	INSERT INTO @Indo4DSportBettype(SportType, BetType) VALUES (223, 5003)
	INSERT INTO @Indo4DSportBettype(SportType, BetType) VALUES (223, 5004)
	INSERT INTO @Indo4DSportBettype(SportType, BetType) VALUES (223, 5005)
	INSERT INTO @Indo4DSportBettype(SportType, BetType) VALUES (223, 5006)
	INSERT INTO @Indo4DSportBettype(SportType, BetType) VALUES (223, 5007)

	--DELETE existing data
	------------------------------------PT Setting-------------------------------------------------	
	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustPTSetting_Agent
	FROM Dep_CustPTSetting_Agent a WITH(NOLOCK)
	INNER JOIN @Indo4DSportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid AND ci.currency <> 20
	WHERE a.CustID >@max_custid

	DELETE a
	FROM Dep_CustPTSetting_Agent a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #Dep_CustPTSetting_Agent t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustPTSetting_Member
	FROM Dep_CustPTSetting_Member a WITH(NOLOCK)
	INNER JOIN @Indo4DSportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid AND ci.currency <> 20
	WHERE a.CustID >@max_custid

	DELETE a
	FROM Dep_CustPTSetting_Member a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #Dep_CustPTSetting_Member t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	SELECT a.AgentID,a.SportType,a.BetType
	INTO #Dep_CustPTGroupSetting_Member
	FROM Dep_CustPTGroupSetting_Member a WITH(NOLOCK)
	INNER JOIN @Indo4DSportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN CustInfo ci WITH(NOLOCK) ON a.AgentID = ci.custid AND ci.currency <> 20
	WHERE a.AgentID >@max_custid

	DELETE a
	FROM Dep_CustPTGroupSetting_Member a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #Dep_CustPTGroupSetting_Member t ON a.AgentID = t.AgentID AND a.SportType = t.SportType and a.BetType = t.BetType 

	-------------------------------------------------BetSetting----------------------------------------------------------------
	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustBetSetting_Agent
	FROM Dep_CustBetSetting_Agent a WITH(NOLOCK)
	INNER JOIN @Indo4DSportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid AND ci.currency <> 20
	WHERE a.CustID >@max_custid

	DELETE a
	FROM Dep_CustBetSetting_Agent a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #Dep_CustBetSetting_Agent t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustBetSetting_Member
	FROM Dep_CustBetSetting_Member a WITH(NOLOCK)
	INNER JOIN @Indo4DSportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid AND ci.currency <> 20
	WHERE a.CustID >@max_custid

	DELETE a
	FROM Dep_CustBetSetting_Member a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #Dep_CustBetSetting_Member t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	-------------
	SELECT dl.CustID,dl.ProductSettingID
	INTO #Dep_LicenseeProductSetting
	FROM Dep_LicenseeProductSetting dl WITH(NOLOCK)
	INNER JOIN Dep_ProductSetting dp WITH(NOLOCK) ON dl.ProductSettingID = dp.ProductSettingID
	INNER JOIN CustInfo ci WITH(NOLOCK) ON dl.CustID = ci.custid AND ci.currency <> 20
	WHERE dp.ProductID = 43
		AND dl.CustID >@max_custid

	DELETE a
	FROM Dep_LicenseeProductSetting a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #Dep_LicenseeProductSetting t ON a.CustID = t.CustID AND a.ProductSettingID = t.ProductSettingID

	DROP TABLE #Dep_CustPTGroupSetting_Member
	DROP TABLE #Dep_CustPTSetting_Agent
	DROP TABLE #Dep_CustPTSetting_Member
	DROP TABLE #Dep_CustBetSetting_Agent
	DROP TABLE #Dep_CustBetSetting_Member
	DROP TABLE #Dep_LicenseeProductSetting

	---------------------CREATE setting for NEW ACCs-----------------------------------

	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED
	   ,Currency INT
	   ,mrecommend INT
	   ,PT SMALLMONEY
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED
	   ,Currency INT
	   ,RoleID TINYINT
	   ,mrecommend INT
	   ,PT SMALLMONEY
	)

	--> Athena Licensee
	CREATE TABLE #supers (custid int)

	INSERT INTO #supers(custid)
	SELECT c.custid
	FROM customer c WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
		INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
	WHERE c.roleid = 4  
	 AND s.islicensee = 1
	 AND ci.Enabled = 1
	 AND c.currency IN ( 4--THB
						,15--IDR
					)
	 AND s.site IN (
					 'N88'
					,'N8G'
					,'N8B'
					)

	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid=3 AND username LIKE '%Acc%'
	
	INSERT INTO #SMATemp(CustID,RoleID,Currency,mrecommend,PT)
	SELECT custid, roleid, currency,mrecommend,88.00
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @max_custid 
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO #MemberTemp(CustID,Currency,mrecommend,PT)
	SELECT custid, currency,mrecommend,88.00
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 1  AND Enabled = 1 AND custid > @max_custid	
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	DECLARE @SportBettype TABLE
	(
		SportType SMALLINT, 
		BetType   SMALLINT
	)
	INSERT INTO @SportBettype(SportType, BetType) VALUES (223, 5001)

	DECLARE @bitmapOrder INT
	 
	SELECT @bitmapOrder = bitmapOrder 
	FROM dbo.Dep_ProductStatusProfile m WITH (NOLOCK) 
		INNER JOIN @SportBetType t ON t.Sporttype = m.SportType AND t.Bettype = m.BetType

	--------------------------------------------Product Status------------------------------------------------
	UPDATE c 
	SET  c.bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,0)
		,c.bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,0)
	FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
		CROSS APPLY @SportBetType t
		INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = t.BetType AND PSP.Sporttype = t.SportType
		INNER JOIN  #SMATemp temp ON temp.CustID = c.custid

	UPDATE c 
	SET  c.bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,0)
		,c.bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,0)
	FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
		CROSS APPLY @SportBetType t
		INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = t.BetType AND PSP.Sporttype = t.SportType
		INNER JOIN  #MemberTemp temp ON temp.CustID = c.custid

	INSERT INTO Dep_CustProductStatus (CustID,bitmapIsHidden,bitmapIsDisabled)
	SELECT CustID,bitmapIsHidden,bitmapIsDisabled
	FROM #TempProductStatus t
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = t.CustID)
	-----------------------------------------Dep_LicenseeProductSetting-------------------------------------------------------

	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT temp.CustID
		  ,st.ProductSettingID
	FROM #SMATemp temp 
		 CROSS APPLY (	SELECT ProductSettingID 
						FROM Dep_ProductSetting dp WITH(NOLOCK) 
						WHERE dp.ProductID = 43
							AND dp.SettingType IN (4,1,2) -- Product Status, PT, Bet Setting
						) st
	WHERE temp.RoleID = 4

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

	-------------------------------------------------Bet Setting----------------------------------------------------------------
	DECLARE @SportBettype_BetSetting TABLE (SportType SMALLINT, BetType SMALLINT,CurrencyID INT, MinBet MONEY,MaxBet MONEY)
	INSERT INTO @SportBettype_BetSetting(SportType, BetType, CurrencyID, MinBet, MaxBet)
	SELECT 223, 5001, 4, 10.00, 700.00 UNION ALL --THB, TB
	SELECT 223, 5002, 4, 10.00, 1750.00 UNION ALL --THB, TB
	SELECT 223, 5003, 4, 10.00, 5831.00 UNION ALL --THB, TB
	SELECT 223, 5004, 4, 10.00, 5831.00 UNION ALL --THB, TB
	SELECT 223, 5005, 4, 10.00, 4998.00 UNION ALL --THB, TB
	SELECT 223, 5006, 4, 10.00, 45157.00 UNION ALL --THB, TB
	SELECT 223, 5007, 4, 10.00, 8750.00 UNION ALL --THB, TB
	SELECT 223, 5001, 15, 1.00, 366.00 UNION ALL --IDR, IN
	SELECT 223, 5002, 15, 1.00, 915.00 UNION ALL --IDR, IN
	SELECT 223, 5003, 15, 1.00, 3048.00 UNION ALL --IDR, IN
	SELECT 223, 5004, 15, 1.00, 3048.00 UNION ALL --IDR, IN
	SELECT 223, 5005, 15, 1.00, 2612.00 UNION ALL --IDR, IN
	SELECT 223, 5006, 15, 1.00, 23603.00 UNION ALL --IDR, IN
	SELECT 223, 5007, 15, 1.00, 4574.00  --IDR, IN
	
	

	INSERT INTO Dep_CustBetSetting_Agent(
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
	)
	SELECT t.CustID,b.SportType,b.BetType,b.MinBet,b.MaxBet,b.MaxBet
	FROM #SMATemp t
		CROSS APPLY @SportBettype_BetSetting b 
	WHERE b.CurrencyID = t.Currency

	INSERT INTO Dep_CustBetSetting_Member(
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
	)
	SELECT t.CustID,b.SportType,b.BetType,b.MinBet,b.MaxBet,b.MaxBet
	FROM #MemberTemp t
		CROSS APPLY @SportBettype_BetSetting b
	WHERE b.CurrencyID = t.Currency

	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp