/*
	Created: Eden
	Date: 20191031
	Task: Adjust setting for Virtual game follow by Macau games (UM)
	DB: DBCust/CustDB
*/

	DECLARE @max_custid INT = xxx

	CREATE TABLE #TempCust
	(
		CustID INT PRIMARY KEY CLUSTERED 
	   ,Currency INT
	)
	
	INSERT INTO #TempCust (CustID,Currency)
	SELECT c.custid,c.currency
	FROM customer c WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
		INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
	WHERE s.islicensee = 0
	 AND ci.Enabled = 1
	 AND c.custid > @max_custid
	
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
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapHasSynced, PSP.bitmapOrder)) as IsSync,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsHidden, PSP.bitmapOrder)) as isHidden,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsDisabled, PSP.bitmapOrder)) as isDisabled,
		c.CustID
	INTO #CustStatus
	FROM CustProductStatus c WITH (NOLOCK)
		INNER JOIN #TempCust tmp ON c.CustID = tmp.CustID
		CROSS APPLY @SportBettype t
		INNER JOIN dbo.ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = t.fBetType AND PSP.Sporttype = t.fSportType

	UPDATE c 
	SET  c.bitmapHasSynced = dbo.f_GenerateProductStatus (c.bitmapHasSynced,psp.bitmapOrder,1)
		,c.bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,0)
		,c.bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,isDisabled)
	FROM CustProductStatus c WITH(ROWLOCK, UPDLOCK)
		CROSS APPLY @SportBettype t
		INNER JOIN  dbo.ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = t.tBetType AND PSP.Sporttype = t.tSportType
		INNER JOIN  #CustStatus temp ON temp.CustID = c.custid

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
		INNER JOIN #TempCust d ON c.CustID = d.CustID
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
		 INNER JOIN #TempCust d ON c.CustID = d.CustID
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
		JOIN #TempCust tmp ON c.AgentID = tmp.CustID
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
			INNER JOIN #TempCust d ON c.CustID = d.CustID
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
		 INNER JOIN #TempCust d ON c.CustID = d.CustID
		 CROSS APPLY @SportBettype t
	WHERE c.SportType  = t.fSportType and c.BetType = t.fBetType

	-------------------------------------------------STAKE LEVEL----------------------------------------------------------------
	INSERT INTO CustStakeLevel_Agent(CustID, SportType, BetType, StakeLevelList)
	SELECT ca.CustID
		,SportType = t.tSportType
		,BetType = t.tBetType
		,StakeLevelList = CONVERT(VARCHAR(200),st.StakeLevelID)
	FROM CustStakeLevel_Agent ca WITH (NOLOCK)
		INNER JOIN #TempCust tmp ON tmp.CustID = ca.CustID
		CROSS APPLY @SportBettype t
		CROSS APPLY ( SELECT s.StakeLevelID FROM StakeLevel s WITH(NOLOCK) WHERE s.ExchangeId = tmp.Currency AND s.GameTypeID = t.tBetType) st
	WHERE ca.SportType  = t.fSportType and ca.BetType = t.fBetType

	INSERT INTO CustStakeLevel_Member(CustID, SportType, BetType, StakeLevelList)
	SELECT ca.CustID
		,SportType = t.tSportType
		,BetType = t.tBetType
		,StakeLevelList = CONVERT(VARCHAR(200),st.StakeLevelID)
	FROM CustStakeLevel_Member ca WITH (NOLOCK)
		INNER JOIN #TempCust tmp ON tmp.CustID = ca.CustID
		CROSS APPLY @SportBettype t
		CROSS APPLY ( SELECT s.StakeLevelID FROM StakeLevel s WITH(NOLOCK) WHERE s.ExchangeId = tmp.Currency AND s.GameTypeID = t.tBetType) st
	WHERE ca.SportType  = t.fSportType and ca.BetType = t.fBetType

	DROP TABLE #CustStatus
	DROP TABLE #TempCust
