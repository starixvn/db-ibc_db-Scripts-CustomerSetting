/*
	Created: Elodie
	Date: 20200326
	Task: Insert setting for Virtual game - Real Currency -  API Site (N88, N8B, N8G)
	DB: DBCust/CustDB
*/

ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	 @srecommend INT		
	,@target VARCHAR(20)
	,@max_custid INT
	,@PT smallmoney
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductStatusProfile') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 RETURN

	DECLARE @currency INT, @siteId INT

	SELECT @currency = ci.currency, @siteId = s.siteid 
	FROM dbo.customer ci WITH (NOLOCK) 
		INNER JOIN site s ON s.site = ci.site
	WHERE ci.custid = @srecommend

	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED
		,roleid	TINYINT
	)
	
	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend=@srecommend AND roleid=3 AND username LIKE '%Acc%'
		AND custid<=@max_custid 

	INSERT INTO #MemberTemp (CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1  AND Enabled = 1 AND custid <= @max_custid
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	
	INSERT INTO #SMATemp (CustID,roleid)
	SELECT custid,roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND Enabled = 1 AND custid <= @max_custid
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	DECLARE @SportBetType TABLE
	(
		SportType SMALLINT, 
		BetType   SMALLINT
	)
	INSERT INTO @SportBetType(SportType, BetType) VALUES (245, 4601)

	--------------------------------------------Product Status------------------------------------------------
	DECLARE @bitmapOrder INT
	 
	SELECT @bitmapOrder = bitmapOrder 
	FROM dbo.Dep_ProductStatusProfile m WITH (NOLOCK) 
		INNER JOIN @SportBetType t ON t.Sporttype = m.SportType AND t.Bettype = m.BetType

	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))

	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		CROSS APPLY @SportBetType t
		INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = t.BetType AND PSP.Sporttype = t.SportType
		INNER JOIN  #SMATemp temp ON temp.CustID = c.custid
	UNION ALL
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		CROSS APPLY @SportBetType t
		INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = t.BetType AND PSP.Sporttype = t.SportType
		INNER JOIN  #MemberTemp temp ON temp.CustID = c.custid
	
	DECLARE @batch int = 3000
	WHILE 1 = 1 
	BEGIN
		TRUNCATE TABLE #TempProductStatus

		DELETE TOP (@batch) a
		OUTPUT deleted.CustID,deleted.bitmapIsHidden,deleted.bitmapIsDisabled INTO #TempProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
		FROM #Dep_CustProductStatus a 

		IF @@ROWCOUNT = 0 
			BREAK;

		UPDATE c 
		SET  c.bitmapIsHidden = tmp.bitmapIsHidden
			,c.bitmapIsDisabled = tmp.bitmapIsDisabled
		FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
			INNER JOIN #TempProductStatus tmp ON c.CustID = tmp.CustID

		INSERT INTO Dep_CustProductStatus (CustID,bitmapIsDisabled,bitmapIsHidden)
		SELECT	t.custid
				, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @bitmapOrder,0) AS bitmapIsDisabled
				, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @bitmapOrder,0)  AS bitmapIsHidden
		FROM #TempProductStatus t
		WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = t.CustID)

		WAITFOR DELAY '00:00:00.100'
	END

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
	WHERE temp.roleid = 4

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
	DECLARE @DEP_Stake TABLE (
		[GameTypeID] [int] NOT NULL,
		[Currency] [nvarchar](max) NULL,
		[MinStake] [money] NULL,
		[MaxStake] [money] NULL,
		[MinLabel] [varchar](20) NULL,
		[MaxLabel] [varchar](20) NULL
	) 
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'UUS', 5.00, 500.00, '5', '500') -- 
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'UUS', 5.00, 1000.00, '5', '1,000') -- 
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'UUS', 5.00, 2000.00, '5', '2,000') -- 
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'RM', 20.00, 2090.00, '20', '2,090') -- MYR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'RM', 20.00, 4150.00, '20', '4,150') -- MYR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'RM', 20.00, 8300.00, '20', '8,300') -- MYR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'HKK', 20.00, 2090.00, '20', '2,090') -- HKD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'HKK', 20.00, 4150.00, '20', '4,150') -- HKD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'HKK', 20.00, 8300.00, '20', '8,300') -- HKD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'KHR', 20.00, 2090.00, '20', '2,090') -- KHR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'KHR', 20.00, 4150.00, '20', '4,150') -- KHR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'KHR', 20.00, 8300.00, '20', '8,300') -- KHR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PLN', 20.00, 2090.00, '20', '2,090') -- PLN
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PLN', 20.00, 4150.00, '20', '4,150') -- PLN
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PLN', 20.00, 8300.00, '20', '8,300') -- PLN
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'$US', 5.00, 500.00, '5', '500') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'$US', 5.00, 1000.00, '5', '1,000') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'$US', 5.00, 2000.00, '5', '2,000') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'US$', 5.00, 500.00, '5', '500') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'US$', 5.00, 1000.00, '5', '1,000') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'US$', 5.00, 2000.00, '5', '2,000') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'UT', 5.00, 500.00, '5', '500') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'UT', 5.00, 1000.00, '5', '1,000') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'UT', 5.00, 2000.00, '5', '2,000') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'Yen', 5.00, 500.00, '5', '500') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'Yen', 5.00, 1000.00, '5', '1,000') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'Yen', 5.00, 2000.00, '5', '2,000') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PTU', 5.00, 500.00, '5', '500') -- INR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PTU', 5.00, 1000.00, '5', '1,000') -- INR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PTU', 5.00, 2000.00, '5', '2,000') -- INR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'CHF', 5.00, 500.00, '5', '500') -- CHF
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'CHF', 5.00, 1000.00, '5', '1,000') -- CHF
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'CHF', 5.00, 2000.00, '5', '2,000') -- CHF
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'MKK', 5.00, 500.00, '5', '500') -- MMK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'MKK', 5.00, 1000.00, '5', '1,000') -- MMK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'MKK', 5.00, 2000.00, '5', '2,000') -- MMK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'MMK', 5.00, 500.00, '5', '500') -- MMK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'MMK', 5.00, 1000.00, '5', '1,000') -- MMK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'MMK', 5.00, 2000.00, '5', '2,000') -- MMK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'TH', 5.00, 500.00, '5', '500') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'TH', 5.00, 1000.00, '5', '1,000') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'TH', 5.00, 2000.00, '5', '2,000') -- USD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PS', 5.00, 500.00, '5', '500') -- INR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PS', 5.00, 1000.00, '5', '1,000') -- INR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PS', 5.00, 2000.00, '5', '2,000') -- INR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'SD$', 5.00, 500.00, '5', '500') -- SGD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'SD$', 5.00, 1000.00, '5', '1,000') -- SGD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'SD$', 5.00, 2000.00, '5', '2,000') -- SGD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'YNG', 5.00, 500.00, '5', '500') -- YNG
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'YNG', 5.00, 1000.00, '5', '1,000') -- YNG
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'YNG', 5.00, 2000.00, '5', '2,000') -- YNG
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'AUD', 5.00, 500.00, '5', '500') -- AUD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'AUD', 5.00, 1000.00, '5', '1,000') -- AUD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'AUD', 5.00, 2000.00, '5', '2,000') -- AUD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'RMB', 30.00, 3500.00, '30', '3,500') -- CNY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'RMB', 30.00, 7000.00, '30', '7,000') -- CNY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'RMB', 30.00, 14000.00, '30', '14,000') -- CNY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'CY', 30.00, 3500.00, '30', '3,500') -- CNY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'CY', 30.00, 7000.00, '30', '7,000') -- CNY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'CY', 30.00, 14000.00, '30', '14,000') -- CNY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'YUN', 30.00, 3500.00, '30', '3,500') -- CNY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'YUN', 30.00, 7000.00, '30', '7,000') -- CNY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'YUN', 30.00, 14000.00, '30', '14,000') -- CNY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PTH', 30.00, 3500.00, '30', '3,500') -- INR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PTH', 30.00, 7000.00, '30', '7,000') -- INR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PTH', 30.00, 14000.00, '30', '14,000') -- INR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'HK$', 30.00, 3500.00, '30', '3,500') -- HKD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'HK$', 30.00, 7000.00, '30', '7,000') -- HKD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'HK$', 30.00, 14000.00, '30', '14,000') -- HKD
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'DKK', 30.00, 3500.00, '30', '3,500') -- DKK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'DKK', 30.00, 7000.00, '30', '7,000') -- DKK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'DKK', 30.00, 14000.00, '30', '14,000') -- DKK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'SEK', 30.00, 3500.00, '30', '3,500') -- SEK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'SEK', 30.00, 7000.00, '30', '7,000') -- SEK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'SEK', 30.00, 14000.00, '30', '14,000') -- SEK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'NOK', 30.00, 3500.00, '30', '3,500') -- NOK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'NOK', 30.00, 7000.00, '30', '7,000') -- NOK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'NOK', 30.00, 14000.00, '30', '14,000') -- NOK
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IND', 50.00, 7000.00, '50', '7,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IND', 50.00, 14000.00, '50', '14,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IND', 50.00, 28000.00, '50', '28,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IDR', 50.00, 7000.00, '50', '7,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IDR', 50.00, 14000.00, '50', '14,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IDR', 50.00, 28000.00, '50', '28,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IN', 50.00, 7000.00, '50', '7,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IN', 50.00, 14000.00, '50', '14,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IN', 50.00, 28000.00, '50', '28,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IDD', 50.00, 7000.00, '50', '7,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IDD', 50.00, 14000.00, '50', '14,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IDD', 50.00, 28000.00, '50', '28,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'DDD', 50.00, 7000.00, '50', '7,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'DDD', 50.00, 14000.00, '50', '14,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'DDD', 50.00, 28000.00, '50', '28,000') -- IDR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'THB', 150.00, 15000.00, '150', '15,000') -- THB
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'THB', 150.00, 30200.00, '150', '30,200') -- THB
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'THB', 150.00, 60000.00, '150', '60,000') -- THB
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'TB', 150.00, 15000.00, '150', '15,000') -- THB
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'TB', 150.00, 30200.00, '150', '30,200') -- THB
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'TB', 150.00, 60000.00, '150', '60,000') -- THB
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'Won', 5000.00, 587000.00, '5,000', '587,000') -- KRW
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'Won', 5000.00, 1150000.00, '5,000', '1,150,000') -- KRW
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'Won', 5000.00, 2350000.00, '5,000', '2,350,000') -- KRW
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'KW', 5000.00, 587000.00, '5,000', '587,000') -- KRW
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'KW', 5000.00, 1150000.00, '5,000', '1,150,000') -- KRW
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'KW', 5000.00, 2350000.00, '5,000', '2,350,000') -- KRW
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'INH', 100.00, 11500.00, '100', '11,500') -- VND
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'INH', 100.00, 23000.00, '100', '23,000') -- VND
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'INH', 100.00, 46500.00, '100', '46,500') -- VND
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'INR', 300.00, 35000.00, '300', '35,000') -- INR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'INR', 300.00, 70000.00, '300', '70,000') -- INR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'INR', 300.00, 140000.00, '300', '140,000') -- INR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'RUB', 300.00, 35000.00, '300', '35,000') -- RUB
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'RUB', 300.00, 70000.00, '300', '70,000') -- RUB
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'RUB', 300.00, 140000.00, '300', '140,000') -- RUB
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'GBP', 3.00, 385.00, '3', '385') -- GBP
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'GBP', 3.00, 750.00, '3', '750') -- GBP
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'GBP', 3.00, 1500.00, '3', '1,500') -- GBP
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'EURO', 3.00, 385.00, '3', '385') -- EUR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'EURO', 3.00, 750.00, '3', '750') -- EUR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'EURO', 3.00, 1500.00, '3', '1,500') -- EUR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'EUR', 3.00, 385.00, '3', '385') -- EUR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'EUR', 3.00, 750.00, '3', '750') -- EUR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'EUR', 3.00, 1500.00, '3', '1,500') -- EUR
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'JPY', 500.00, 54000.00, '500', '54,000') -- JPY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'JPY', 500.00, 105000.00, '500', '105,000') -- JPY
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'JPY', 500.00, 215000.00, '500', '215,000') -- JPY

	DECLARE @MaxStakeLevelID INT
	SELECT @MaxStakeLevelID = MAX(StakeLevelID) FROM DEP_StakeLevel WITH(NOLOCK)

	IF NOT EXISTS (	SELECT 1 
					FROM DEP_StakeLevel WITH (NOLOCK)
					WHERE SiteID = @SiteId AND ExchangeID = @currency AND GameTypeID = 4601)
	BEGIN
		INSERT INTO DEP_StakeLevel(
				GameTypeID
			,MinLabel
			,MaxLabel
			,MinStake
			,MaxStake
			,ExchangeId
			,GameGroupID
			,SiteID
			,StakeLevelID
		)
		SELECT	t.GameTypeID,
				t.MinLabel,
				t.MaxLabel,
				CONVERT(DECIMAL(19,2),t.MinStake) AS MinStake,
				CONVERT(DECIMAL(19,2),t.MaxStake) AS MaxStake,
				ExchangeId = e.exchangeid,
				GameGroupID = 0,
				@SiteId,
				StakeLevelID = @MaxStakeLevelID + ROW_NUMBER() OVER(ORDER BY e.exchangeid)
		FROM @DEP_Stake t
			INNER JOIN exchange e WITH(NOLOCK) ON t.Currency = e.Currency
		WHERE e.exchangeid = @currency
	END

	-------------------------------------------------STAKE LEVEL----------------------------------------------------------------
	DECLARE @StakeLevAgent VARCHAR(200)
	DECLARE @StakeLevMember VARCHAR(200)
	SELECT @StakeLevAgent = SUBSTRING(( SELECT ',' + CONVERT(VARCHAR(5),s.StakeLevelID) 
										FROM DEP_StakeLevel s WITH(NOLOCK) 
											CROSS APPLY @SportBetType t	
										WHERE s.ExchangeId = @currency AND s.GameTypeID = t.BetType AND s.SiteID = @SiteId 
										FOR XML PATH(''))
							,2,200)

	SELECT @StakeLevMember = (	SELECT TOP 1 CONVERT(VARCHAR(5),s.StakeLevelID) 
								FROM DEP_StakeLevel s WITH(NOLOCK) 
									CROSS APPLY @SportBetType t	
								WHERE s.ExchangeId = @currency AND s.GameTypeID = t.BetType AND s.SiteID = @SiteId 
								ORDER BY s.MaxStake)

	--> Bet Limit: Apply bet limit group level for all S/M/A/Member levels
	INSERT INTO DEP_CustStakeLevel_Agent(CustID, SportType, BetType, StakeLevelList)
	SELECT tmp.CustID
		,SportType = t.SportType
		,BetType = t.BetType
		,StakeLevelList = @StakeLevAgent
	FROM #SMATemp tmp
		CROSS APPLY @SportBetType t

	INSERT INTO DEP_CustStakeLevel_Member(CustID, SportType, BetType, StakeLevelList,LastUpdated)
	SELECT tmp.CustID
		,SportType = t.SportType
		,BetType = t.BetType
		,StakeLevelList = @StakeLevMember
		,GETDATE()
	FROM #MemberTemp tmp
		CROSS APPLY @SportBetType t

	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
END
GO

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT , @max_custid INT
DECLARE @PT smallmoney = 94.00 --6% of API Licensee fee (Licensees take 94%, House takes 6%)

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
WHERE c.roleid = 4  
 AND s.islicensee = 1
 AND ci.Enabled = 1
 AND c.custid <= @max_custid
 AND c.currency NOT IN (72,27,28,17,21,31,36,37,40,44,46,50,62,63,65,68,73)
  AND s.site IN ('Happy8','GamingSoft','DBP','HL8','TLC','368Cash','Senibet','HonorW','W88','12Bet','alog','asiabet88','mansion88',
				'OLE777','SunGame','HAIFA','Bodog','Boma365','Happy1668','KeenOcean','ISC888','3star88','Newhonbet','Abcasino',
				'Hecbet ','iBET','Royal','XTD3','IBO','Liga','88Macao','9Club','Ae88','AG','HONBET','TGO','KhmerG','365online',
				'IONclub','Mayayule','Sun988','DEWA','Gampag','HuangMa','Boying','webet88','PKbet','BigGaming','VCBA','Taipanbet',
				'Dawoo','FLC','Sunrise','Uwoniwin','ECLBET','PanguGame','818Bet','Heaven','IGPTech','K8VN','GPIGAME','Swin','396Club',
				'e8casino','Lucky88','MAX88','OPEBET','BBIN2','Bobo88','GMASTER','Opal88','Sunriseb2b','YongBao','ALPHA88','11bet',
				'Aplus','zt828','ENTAPLAY','MICL','Tripleone','Yibo','TangChao','WBS','CGame','Xinbo','FB88','YBTech','Monaco','BETSUN',
				'Mybet88','JIBET','Gameroom','Fabet','WINCLUB88','Callmeboss','SSSGaming','ANGbet','One88','Nbbet','Bobbet','TitanOne',
				'18Luck','AEUG','XinYo','VWIN66','AMG','Starnet','gbkj','VN88','ig128','MARS','YAYOU','UwinY','Hong88','Gaobet',
				'Five88','Zbet','A1game','IBG','Raisetech','txwl002','sbt88','WKCUR','WKPHIL','GESAB','Win88','AnvoFH','Xtu168',
				'weicai','HCVIP','Kraton','BBIN3','Mopgaming','pinbo','ID88','DingTai','ENT22','BOSSB','allwincity','TopGame',
				'Onegaming','24AVIA','B24VN','Sunwin','Apollo','YTX','BOG22','Wanfang','MTech','JIDU','Leng4D','G2Win','erhaozhan',
				'Okada','KUTECH','Siamgame','Datang001','hjccasino','BWGaming','Champion','shengboyun','Spark','afb99','Debet',
				'633esports','Wanbo','Jarvis','Tianbo','WUYICP','CGame4','TitanCraft','TaoCai','ZhiFeng032','TYCgame','HBO999',
				'Yunji','JZFortune','OneSports','TCbet','Soon88','GGBOOK','INSERTGAME')

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_Dep_DynamicCustSetting_09 @srecommend = @srecommend
			,@target = 'REPLICATED'
			,@max_custid = @max_custid
			,@PT = @PT
						
	waitfor delay '00:00:0.100'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DROP TABLE #supers
GO
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT , @max_custid INT
DECLARE @PT smallmoney = 94.00 --6% of API Licensee fee (Licensees take 94%, House takes 6%)

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
WHERE c.roleid = 4  
 AND s.islicensee = 1
 AND ci.Enabled = 1
 AND c.custid <= @max_custid
 AND c.currency NOT IN (72,27,28,17,21,31,36,37,40,44,46,50,62,63,65,68,73)
 AND s.site IN ('Happy8','GamingSoft','DBP','HL8','TLC','368Cash','Senibet','HonorW','W88','12Bet','alog','asiabet88','mansion88',
				'OLE777','SunGame','HAIFA','Bodog','Boma365','Happy1668','KeenOcean','ISC888','3star88','Newhonbet','Abcasino',
				'Hecbet ','iBET','Royal','XTD3','IBO','Liga','88Macao','9Club','Ae88','AG','HONBET','TGO','KhmerG','365online',
				'IONclub','Mayayule','Sun988','DEWA','Gampag','HuangMa','Boying','webet88','PKbet','BigGaming','VCBA','Taipanbet',
				'Dawoo','FLC','Sunrise','Uwoniwin','ECLBET','PanguGame','818Bet','Heaven','IGPTech','K8VN','GPIGAME','Swin','396Club',
				'e8casino','Lucky88','MAX88','OPEBET','BBIN2','Bobo88','GMASTER','Opal88','Sunriseb2b','YongBao','ALPHA88','11bet',
				'Aplus','zt828','ENTAPLAY','MICL','Tripleone','Yibo','TangChao','WBS','CGame','Xinbo','FB88','YBTech','Monaco','BETSUN',
				'Mybet88','JIBET','Gameroom','Fabet','WINCLUB88','Callmeboss','SSSGaming','ANGbet','One88','Nbbet','Bobbet','TitanOne',
				'18Luck','AEUG','XinYo','VWIN66','AMG','Starnet','gbkj','VN88','ig128','MARS','YAYOU','UwinY','Hong88','Gaobet',
				'Five88','Zbet','A1game','IBG','Raisetech','txwl002','sbt88','WKCUR','WKPHIL','GESAB','Win88','AnvoFH','Xtu168',
				'weicai','HCVIP','Kraton','BBIN3','Mopgaming','pinbo','ID88','DingTai','ENT22','BOSSB','allwincity','TopGame',
				'Onegaming','24AVIA','B24VN','Sunwin','Apollo','YTX','BOG22','Wanfang','MTech','JIDU','Leng4D','G2Win','erhaozhan',
				'Okada','KUTECH','Siamgame','Datang001','hjccasino','BWGaming','Champion','shengboyun','Spark','afb99','Debet',
				'633esports','Wanbo','Jarvis','Tianbo','WUYICP','CGame4','N88','TitanCraft','TaoCai','ZhiFeng032','TYCgame','HBO999',
				'Yunji','JZFortune','OneSports','TCbet','Soon88','GGBOOK','INSERTGAME')

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_Dep_DynamicCustSetting_09 @srecommend = @srecommend
			,@target = 'DBCUST'
			,@max_custid = @max_custid
			,@PT = @PT
						
	waitfor delay '00:00:0.100'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DROP TABLE #supers
GO