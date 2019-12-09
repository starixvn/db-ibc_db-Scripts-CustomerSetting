/*
	Created: Eden
	Date: 20191029
	Task: Create setting for Virtual game ( New accounts)
	DB: DBCust/CustDB
*/

	DECLARE @max_custid INT = xxx

	DECLARE @VGSportBettype TABLE (SportType SMALLINT, BetType SMALLINT)
	INSERT INTO @VGSportBettype(SportType, BetType) VALUES (245, 4601)

	--DELETE existing data
	------------------------------------PT Setting-------------------------------------------------	
	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustPTSetting_Agent
	FROM Dep_CustPTSetting_Agent a WITH(NOLOCK)
	INNER JOIN @VGSportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid AND ci.currency <> 20
	WHERE a.CustID >@max_custid

	DELETE a
	FROM Dep_CustPTSetting_Agent a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #Dep_CustPTSetting_Agent t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustPTSetting_Member
	FROM Dep_CustPTSetting_Member a WITH(NOLOCK)
	INNER JOIN @VGSportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid AND ci.currency <> 20
	WHERE a.CustID >@max_custid

	DELETE a
	FROM Dep_CustPTSetting_Member a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #Dep_CustPTSetting_Member t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	SELECT a.AgentID,a.SportType,a.BetType
	INTO #Dep_CustPTGroupSetting_Member
	FROM Dep_CustPTGroupSetting_Member a WITH(NOLOCK)
	INNER JOIN @VGSportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN CustInfo ci WITH(NOLOCK) ON a.AgentID = ci.custid AND ci.currency <> 20
	WHERE a.AgentID >@max_custid

	DELETE a
	FROM Dep_CustPTGroupSetting_Member a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #Dep_CustPTGroupSetting_Member t ON a.AgentID = t.AgentID AND a.SportType = t.SportType and a.BetType = t.BetType 

	-------------------------------------------------STAKE LEVEL----------------------------------------------------------------
	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustStakeLevel_Agent
	FROM Dep_CustStakeLevel_Agent a WITH(NOLOCK)
	INNER JOIN @VGSportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid AND ci.currency <> 20
	WHERE a.CustID >@max_custid

	DELETE a
	FROM Dep_CustStakeLevel_Agent a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #Dep_CustStakeLevel_Agent t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustStakeLevel_Member
	FROM Dep_CustStakeLevel_Member a WITH(NOLOCK)
	INNER JOIN @VGSportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid AND ci.currency <> 20
	WHERE a.CustID >@max_custid

	DELETE a
	FROM Dep_CustStakeLevel_Member a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #Dep_CustStakeLevel_Member t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	-------------
	SELECT dl.CustID,dl.ProductSettingID
	INTO #Dep_LicenseeProductSetting
	FROM Dep_LicenseeProductSetting dl WITH(NOLOCK)
	INNER JOIN Dep_ProductSetting dp WITH(NOLOCK) ON dl.ProductSettingID = dp.ProductSettingID
	INNER JOIN CustInfo ci WITH(NOLOCK) ON dl.CustID = ci.custid AND ci.currency <> 20
	WHERE dp.ProductID = 38
		AND dl.CustID >@max_custid

	DELETE a
	FROM Dep_LicenseeProductSetting a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #Dep_LicenseeProductSetting t ON a.CustID = t.CustID AND a.ProductSettingID = t.ProductSettingID

	DROP TABLE #Dep_CustPTGroupSetting_Member
	DROP TABLE #Dep_CustPTSetting_Agent
	DROP TABLE #Dep_CustPTSetting_Member
	DROP TABLE #Dep_CustStakeLevel_Agent
	DROP TABLE #Dep_CustStakeLevel_Member
	DROP TABLE #Dep_LicenseeProductSetting

	---------------------CREATE setting for NEW ACCs-----------------------------------

	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED
	   ,Currency INT
	   ,mrecommend INT
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED
	   ,Currency INT
	   ,RoleID TINYINT
	   ,mrecommend INT
	)

	CREATE TABLE #supers (custid int)

	INSERT INTO #supers(custid)
	SELECT c.custid
	FROM customer c WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
		INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
	WHERE c.roleid = 4  
	 AND s.islicensee = 1
	 AND ci.Enabled = 1
	 AND c.currency <> 20
	 AND s.site IN ('Athena000')

	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid=3 AND username LIKE '%Acc%'
	
	INSERT INTO #SMATemp(CustID,RoleID,Currency,mrecommend)
	SELECT custid, roleid, currency,mrecommend
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @max_custid 
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND currency NOT IN (72,27,28,17,21,31,36,37,40,44,46,50,62,63,65,68,73)

	INSERT INTO #MemberTemp(CustID,Currency,mrecommend)
	SELECT custid, currency,mrecommend
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 1  AND Enabled = 1 AND custid > @max_custid	
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND currency NOT IN (72,27,28,17,21,31,36,37,40,44,46,50,62,63,65,68,73)

	DECLARE @SportBettype TABLE
	(
		SportType SMALLINT, 
		BetType   SMALLINT
	)
	INSERT INTO @SportBettype(SportType, BetType) VALUES (245, 4601)

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

	-----------------------------------------Dep_LicenseeProductSetting-------------------------------------------------------

	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT temp.CustID
		  ,st.ProductSettingID
	FROM #SMATemp temp 
		 CROSS APPLY (	SELECT ProductSettingID 
						FROM Dep_ProductSetting dp WITH(NOLOCK) 
						WHERE dp.ProductID = 38
							AND dp.SettingType IN (4,1,7) -- Product Status, PT, Bet Limit
						) st
	WHERE temp.RoleID = 4

	------------------------------------PT Setting-------------------------------------------------		
	DECLARE @PT smallmoney = 93.00 --Licensee fee :  7% (Licensees take 93%, House takes 7%)

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
			,[SuperPT] = CASE WHEN d.roleid = 4 THEN @PT ELSE 0 END
			,[MasterPT] = CASE WHEN d.roleid IN (4,3) THEN @PT ELSE 0 END
			,[AgentPT] = CASE WHEN d.roleid IN (4,2) THEN @PT ELSE 0 END
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
			,[AgentPT] = @PT
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
		,[AgentPT] = @PT
	FROM #SMATemp d
		CROSS APPLY @SportBetType t	
	WHERE roleid = 2

	INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
	SELECT t.CustID,1
	FROM #MemberTemp t WITH(NOLOCK)
		LEFT JOIN Dep_CustSettingMode d WITH(NOLOCK) ON  d.CustID = t.CustID
	WHERE d.CustID IS NULL

	-------------------------------------------------STAKE LEVEL----------------------------------------------------------------
	--> Bet Limit: Apply bet limit group level for all S/M/A/Member levels
	INSERT INTO DEP_CustStakeLevel_Agent(CustID, SportType, BetType, StakeLevelList)
	SELECT tmp.CustID
		,SportType = t.SportType
		,BetType = t.BetType
		,StakeLevelList = SUBSTRING(( SELECT ',' + CONVERT(VARCHAR(5),s.StakeLevelID) 
										FROM DEP_StakeLevel s WITH(NOLOCK) 
										WHERE s.ExchangeId = tmp.Currency AND s.GameTypeID = t.BetType
										FOR XML PATH(''))
							,2,200)
	FROM #SMATemp tmp
		CROSS APPLY @SportBetType t

	INSERT INTO DEP_CustStakeLevel_Member(CustID, SportType, BetType, StakeLevelList,LastUpdated)
	SELECT tmp.CustID
		,SportType = t.SportType
		,BetType = t.BetType
		,StakeLevelList = (	SELECT TOP 1 CONVERT(VARCHAR(5),s.StakeLevelID) 
							FROM DEP_StakeLevel s WITH(NOLOCK) 
							WHERE s.ExchangeId = tmp.Currency AND s.GameTypeID = t.BetType 
							ORDER BY s.MaxStake)
		,GETDATE()
	FROM #MemberTemp tmp
		CROSS APPLY @SportBetType t

	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp