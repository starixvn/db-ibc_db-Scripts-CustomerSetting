/*
	Created: Eden
	Date: 20191029
	Task: Adjust setting for Virtual game follow by Macau games (UM)
	DB: DBCust/CustDB
*/

	DECLARE @max_custid INT = xxx

	CREATE TABLE #CustTemp
	(
		CustID INT PRIMARY KEY CLUSTERED
	   ,currency INT
	)

	INSERT INTO #CustTemp (CustID,currency)
	SELECT c.custid,c.currency
	FROM customer c WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
		INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
	WHERE s.islicensee = 1
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
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsHidden, PSP.bitmapOrder)) as isHidden,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsDisabled, PSP.bitmapOrder)) as isDisabled,
		c.CustID
	INTO #CustStatus
	FROM Dep_CustProductStatus c WITH (NOLOCK)
		INNER JOIN #CustTemp d ON c.CustID = d.CustID
		CROSS APPLY @SportBettype t
		INNER JOIN dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = t.fBetType AND PSP.Sporttype = t.fSportType

	UPDATE c 
	SET  c.bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,isHidden)
		,c.bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,isDisabled)
	FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
		CROSS APPLY @SportBettype t
		INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = t.tBetType AND PSP.Sporttype = t.tSportType
		INNER JOIN  #CustStatus temp ON temp.CustID = c.custid

	-----------------------------------------Dep_LicenseeProductSetting-------------------------------------------------------

	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT dl.CustID
		  ,dpt.ProductSettingID
	FROM Dep_LicenseeProductSetting dl WITH(NOLOCK)
		 INNER JOIN  #CustTemp temp ON temp.CustID = dl.custid
		 INNER JOIN Dep_ProductSetting dp WITH(NOLOCK) ON dl.ProductSettingID = dp.ProductSettingID
		 INNER JOIN Dep_ProductSetting dpt WITH(NOLOCK) ON dp.SettingType = dpt.SettingType AND dpt.ProductID = 38
	WHERE dp.ProductID = 22
		AND dp.SettingType IN (4,1,8) -- Product Status, PT, Bet Limit

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
			 c.[CustID]
			,t.[tSportType]
			,t.[tBetType]
			,c.[IsLive]
			,c.[SuperPT]
			,c.[MasterPT]
			,c.[AgentPT]
	FROM Dep_CustPTSetting_Agent c WITH(NOLOCK)
		INNER JOIN #CustTemp d ON c.CustID = d.CustID
		CROSS APPLY @SportBettype t
	WHERE c.SportType  = t.fSportType and c.BetType = t.fBetType

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
	SELECT   c.[custid]
			,t.[tsporttype]
			,t.[tbettype]
			,c.[islive]
			,c.[superPT]
			,c.[masterPT]
			,c.[agentPT]
	FROM Dep_CustPTSetting_Member c WITH(NOLOCK)
		 INNER JOIN #CustTemp d ON c.CustID = d.CustID
		 CROSS APPLY @SportBettype t
	WHERE c.SportType  = t.fSportType and c.BetType = t.fBetType
	
	INSERT INTO Dep_CustPTGroupSetting_Member (
		 AgentID
		,SportType
		,BetType
		,IsLive
		,SuperPT
		,MasterPT
		,AgentPT
	)
	SELECT AgentID
		,t.tSportType
		,t.tBetType
		,IsLive
		,SuperPT
		,MasterPT
		,AgentPT
	FROM Dep_CustPTGroupSetting_Member c WITH(NOLOCK) 
		JOIN #CustTemp tmp ON c.AgentID = tmp.CustID
		CROSS APPLY @SportBettype t
	WHERE c.SportType  = t.fSportType and c.BetType = t.fBetType	

	-------------------------------------------------STAKE LEVEL----------------------------------------------------------------
	INSERT INTO Dep_CustStakeLevel_Agent(CustID, SportType, BetType, StakeLevelList)
	SELECT ca.CustID
		,SportType = t.tSportType
		,BetType = t.tBetType
		,StakeLevelList = CONVERT(VARCHAR(200),st.StakeLevelID)
	FROM Dep_CustStakeLevel_Agent ca WITH (NOLOCK)
		INNER JOIN #CustTemp tmp ON tmp.CustID = ca.CustID
		CROSS APPLY @SportBettype t
		CROSS APPLY ( SELECT s.StakeLevelID FROM Dep_StakeLevel s WITH(NOLOCK) WHERE s.ExchangeId = tmp.currency AND s.GameTypeID = t.tBetType) st
	WHERE ca.SportType  = t.fSportType and ca.BetType = t.fBetType

	INSERT INTO Dep_CustStakeLevel_Member(CustID, SportType, BetType, StakeLevelList)
	SELECT ca.CustID
		,SportType = t.tSportType
		,BetType = t.tBetType
		,StakeLevelList = CONVERT(VARCHAR(200),st.StakeLevelID)
	FROM Dep_CustStakeLevel_Member ca WITH (NOLOCK)
		INNER JOIN #CustTemp tmp ON tmp.CustID = ca.CustID
		CROSS APPLY @SportBettype t
		CROSS APPLY ( SELECT s.StakeLevelID FROM Dep_StakeLevel s WITH(NOLOCK) WHERE s.ExchangeId = tmp.currency AND s.GameTypeID = t.tBetType) st
	WHERE ca.SportType  = t.fSportType and ca.BetType = t.fBetType

	DROP TABLE #CustStatus
	DROP TABLE #CustTemp

