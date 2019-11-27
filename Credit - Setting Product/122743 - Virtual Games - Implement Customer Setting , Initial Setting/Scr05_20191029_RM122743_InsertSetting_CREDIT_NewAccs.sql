/*
	Created: Eden
	Date: 20191031
	Task: Create setting for Virtual game follow by Macau games ( New accounts)
	DB: DBCust/CustDB
*/

	DECLARE @max_custid INT = xxx

	DECLARE @VGSportBettype TABLE (SportType SMALLINT, BetType SMALLINT)

	INSERT INTO @VGSportBettype(SportType, BetType) VALUES (245, 4601)

	--DELETE existing data
	------------------------------------PT Setting-------------------------------------------------	
	SELECT a.CustID,a.SportType,a.BetType
	INTO #CustPTSetting3rd_Agent
	FROM CustPTSetting3rd_Agent a WITH(NOLOCK)
	INNER JOIN @VGSportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid AND ci.currency <> 20
	WHERE a.CustID >@max_custid

	DELETE a
	FROM CustPTSetting3rd_Agent a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #CustPTSetting3rd_Agent t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	SELECT a.CustID,a.SportType,a.BetType
	INTO #CustPTSetting3rd_Member
	FROM CustPTSetting3rd_Member a WITH(NOLOCK)
	INNER JOIN @VGSportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid AND ci.currency <> 20
	WHERE a.CustID >@max_custid

	DELETE a
	FROM CustPTSetting3rd_Member a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #CustPTSetting3rd_Member t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	SELECT a.AgentID,a.SportType,a.BetType
	INTO #CustPTGroupSetting3rd_Member
	FROM CustPTGroupSetting3rd_Member a WITH(NOLOCK)
	INNER JOIN @VGSportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN CustInfo ci WITH(NOLOCK) ON a.AgentID = ci.custid AND ci.currency <> 20
	WHERE a.AgentID >@max_custid

	DELETE a
	FROM CustPTGroupSetting3rd_Member a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #CustPTGroupSetting3rd_Member t ON a.AgentID = t.AgentID AND a.SportType = t.SportType and a.BetType = t.BetType 

	----------------------------------------WinLoss Limit Setting-------------------------------------------------		
	SELECT a.CustID,a.SportType,a.BetType
	INTO #CustWinLossLimit_Agent
	FROM CustWinLossLimit_Agent a WITH(NOLOCK)
	INNER JOIN @VGSportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid AND ci.currency <> 20
	WHERE a.CustID >@max_custid

	DELETE a
	FROM CustWinLossLimit_Agent a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #CustWinLossLimit_Agent t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	SELECT a.CustID,a.SportType,a.BetType
	INTO #CustWinLossLimit_Member
	FROM CustWinLossLimit_Member a WITH(NOLOCK)
	INNER JOIN @VGSportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid AND ci.currency <> 20
	WHERE a.CustID >@max_custid

	DELETE a
	FROM CustWinLossLimit_Member a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #CustWinLossLimit_Member t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	-------------------------------------------------STAKE LEVEL----------------------------------------------------------------
	SELECT a.CustID,a.SportType,a.BetType
	INTO #CustStakeLevel_Agent
	FROM CustStakeLevel_Agent a WITH(NOLOCK)
	INNER JOIN @VGSportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid AND ci.currency <> 20
	WHERE a.CustID >@max_custid

	DELETE a
	FROM CustStakeLevel_Agent a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #CustStakeLevel_Agent t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	SELECT a.CustID,a.SportType,a.BetType
	INTO #CustStakeLevel_Member
	FROM CustStakeLevel_Member a WITH(NOLOCK)
	INNER JOIN @VGSportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid AND ci.currency <> 20
	WHERE a.CustID >@max_custid

	DELETE a
	FROM CustStakeLevel_Member a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #CustStakeLevel_Member t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	DROP TABLE #CustPTGroupSetting3rd_Member
	DROP TABLE #CustPTSetting3rd_Agent
	DROP TABLE #CustPTSetting3rd_Member
	DROP TABLE #CustStakeLevel_Agent
	DROP TABLE #CustStakeLevel_Member
	DROP TABLE #CustWinLossLimit_Agent
	DROP TABLE #CustWinLossLimit_Member

	---------------------CREATE setting for NEW ACCs-----------------------------------
	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED
	   ,Currency INT
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED
	   ,Currency INT
	)

	CREATE TABLE #supers (custid int)

	INSERT INTO #supers(custid)
	SELECT c.custid
	FROM customer c WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
		INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
		INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid 
	WHERE c.roleid = 4  
	 AND s.islicensee = 0
	 AND cs.isinternal = 0
	 AND ci.username NOT LIKE '3rdSuper%'
	 AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	 AND ci.Enabled = 1
	 AND ci.currency <> 20
	 AND c.site <> 'CN88'
	
	INSERT INTO #SMATemp(CustID,Currency)
	SELECT custid, currency
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @max_custid 

	INSERT INTO #MemberTemp(CustID,Currency)
	SELECT custid, currency
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 1  AND Enabled = 1 AND custid > @max_custid	
	
	DECLARE @SportBettype TABLE
	(
		fSportType SMALLINT, 
		fBetType   SMALLINT, 
		tSportType SMALLINT, 
		tBetType   SMALLINT
	)
	INSERT INTO @SportBettype(fSportType, fBetType, tSportType, tBetType) VALUES (212, 4001, 245, 4601)

	--------------------------------------------Product Status------------------------------------------------
	SELECT
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsDisabled, PSP.bitmapOrder)) as isDisabled,
		c.CustID
	INTO #SMAStatus
	FROM CustProductStatus c WITH (NOLOCK)
		INNER JOIN #SMATemp d ON c.CustID = d.CustID
		CROSS APPLY @SportBettype t
		INNER JOIN dbo.ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = t.fBetType AND PSP.Sporttype = t.fSportType
	
	SELECT
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsDisabled, PSP.bitmapOrder)) as isDisabled,
		c.CustID
	INTO #MemberStatus
	FROM CustProductStatus c WITH (NOLOCK)
		INNER JOIN #MemberTemp d ON c.CustID = d.CustID
		CROSS APPLY @SportBettype t
		INNER JOIN dbo.ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = t.fBetType AND PSP.Sporttype = t.fSportType

	UPDATE c 
	SET  c.bitmapHasSynced = dbo.f_GenerateProductStatus (c.bitmapHasSynced,psp.bitmapOrder,1)
		,c.bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,0)
		,c.bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,isDisabled)
	FROM CustProductStatus c WITH(ROWLOCK, UPDLOCK)
		CROSS APPLY @SportBettype t
		INNER JOIN  dbo.ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = t.tBetType AND PSP.Sporttype = t.tSportType
		INNER JOIN  #SMAStatus temp ON temp.CustID = c.custid

	UPDATE c 
	SET  c.bitmapHasSynced = dbo.f_GenerateProductStatus (c.bitmapHasSynced,psp.bitmapOrder,1)
		,c.bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,0)
		,c.bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,isDisabled)
	FROM CustProductStatus c WITH(ROWLOCK, UPDLOCK)
		CROSS APPLY @SportBettype t
		INNER JOIN  dbo.ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = t.tBetType AND PSP.Sporttype = t.tSportType
		INNER JOIN  #MemberStatus temp ON temp.CustID = c.custid

	------------------------------------PT Setting-------------------------------------------------	
	--SMA LEVEL
	INSERT INTO dbo.CustPTSetting3rd_Agent
		(	[CustID]
			,[SportType]
			,[BetType]
			,[IsLive]
			,[SuperPT]
			,[MasterPT]
			,[AgentPT]
			,[IsAutoMasterPT]
			,[AutoMasterPT]
			,[IsAutoSuperPT]
			,[AutoSuperPT]
			,[MinPT]
			,[MaxPT])
	SELECT 
			 c.[CustID]
			,t.[tSportType]
			,t.[tBetType]
			,c.[IsLive]
			,c.[SuperPT]
			,c.[MasterPT]
			,c.[AgentPT]
			,c.[IsAutoMasterPT]
			,c.[AutoMasterPT]
			,c.[IsAutoSuperPT]
			,c.[AutoSuperPT]
			,c.[MinPT]
			,c.[MaxPT]
	FROM CustPTSetting3rd_Agent c WITH(NOLOCK)
		INNER JOIN #SMATemp d ON c.CustID = d.CustID
		CROSS APPLY @SportBettype t
	WHERE c.SportType  = t.fSportType and c.BetType = t.fBetType

	----MEMBER LEVEL
	INSERT INTO dbo.CustPTSetting3rd_Member
		(	    [custid]
			,	[sporttype]
			,	[bettype]
			,	[islive]
			,	[superPT]
			,	[masterPT]
			,	[agentPT]
			,	[IsAutoMasterPT]
			,	[AutoMasterPT]
			,	[IsAutoSuperPT]
			,	[AutoSuperPT])
	SELECT   c.[custid]
			,t.[tsporttype]
			,t.[tbettype]
			,c.[islive]
			,c.[superPT]
			,c.[masterPT]
			,c.[agentPT]
			,c.[IsAutoMasterPT]
			,c.[AutoMasterPT]
			,c.[IsAutoSuperPT]
			,c.[AutoSuperPT]
	FROM CustPTSetting3rd_Member c WITH(NOLOCK)
		 INNER JOIN #MemberTemp d ON c.CustID = d.CustID
		 CROSS APPLY @SportBettype t
	WHERE c.SportType  = t.fSportType and c.BetType = t.fBetType
	
	INSERT INTO CustPTGroupSetting3rd_Member(
		 AgentID
		,SportType
		,BetType
		,IsLive
		,SuperPT
		,MasterPT
		,AgentPT
		,IsAutoMasterPT
		,AutoMasterPT
		,IsAutoSuperPT
		,AutoSuperPT
	)
	SELECT AgentID
		,t.tSportType
		,t.tBetType
		,IsLive
		,SuperPT
		,MasterPT
		,AgentPT
		,IsAutoMasterPT
		,AutoMasterPT
		,IsAutoSuperPT
		,AutoSuperPT 
	FROM CustPTGroupSetting3rd_Member c WITH(NOLOCK) 
		JOIN #SMATemp tmp ON c.AgentID = tmp.CustID
		CROSS APPLY @SportBettype t
	WHERE c.SportType  = t.fSportType and c.BetType = t.fBetType	

	----------------------------------------WinLoss Limit Setting-------------------------------------------------		
	--Agent Level
	
	INSERT INTO dbo.CustWinLossLimit_Agent
       (
		CustID, 
		SportType, 
		BetType, 
		MaxWinLimit, 
		MaxLossLimit, 
		IsAutoReset
       )
       SELECT c.CustID, 
              t.tSportType, 
              t.tBetType, 
              c.MaxWinLimit, 
              c.MaxLossLimit, 
              c.IsAutoReset
		FROM CustWinLossLimit_Agent c WITH(NOLOCK)
			INNER JOIN #SMATemp d ON c.CustID = d.CustID
			CROSS APPLY @SportBettype t
		WHERE c.SportType  = t.fSportType and c.BetType = t.fBetType	
		 
	--Member Level
	INSERT INTO dbo.CustWinLossLimit_Member
	(
		CustID, 
		SportType, 
		BetType, 
		MaxWinLimit, 
		MaxLossLimit, 
		IsAutoReset
	)
	SELECT  c.CustID, 
			t.tSportType, 
			t.tBetType, 
			c.MaxWinLimit, 
			c.MaxLossLimit, 
			c.IsAutoReset
	FROM CustWinLossLimit_Member c WITH(NOLOCK)
		 INNER JOIN #MemberTemp d ON c.CustID = d.CustID
		 CROSS APPLY @SportBettype t
	WHERE c.SportType  = t.fSportType and c.BetType = t.fBetType

	-------------------------------------------------STAKE LEVEL----------------------------------------------------------------
	--> Bet Limit: Apply bet limit group level for all S/M/A/Member levels
	INSERT INTO CustStakeLevel_Agent(CustID, SportType, BetType, StakeLevelList)
	SELECT tmp.CustID
		,SportType = t.tSportType
		,BetType = t.tBetType
		,StakeLevelList = SUBSTRING(( SELECT ',' + CONVERT(VARCHAR(5),s.StakeLevelID) 
										FROM StakeLevel s WITH(NOLOCK) 
										WHERE s.ExchangeId = tmp.Currency AND s.GameTypeID = t.tBetType
										FOR XML PATH(''))
							,2,200)
	FROM #SMATemp tmp
		CROSS APPLY @SportBettype t

	INSERT INTO CustStakeLevel_Member(CustID, SportType, BetType, StakeLevelList)
	SELECT tmp.CustID
		,SportType = t.tSportType
		,BetType = t.tBetType
		,StakeLevelList = ( SELECT TOP 1 CONVERT(VARCHAR(5),s.StakeLevelID) 
							FROM StakeLevel s WITH(NOLOCK) 
							WHERE s.ExchangeId = tmp.Currency AND s.GameTypeID = t.tBetType
							ORDER BY s.MaxStake
							)
	FROM #MemberTemp tmp
		CROSS APPLY @SportBettype t

	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
	DROP TABLE #SMAStatus
	DROP TABLE #MemberStatus