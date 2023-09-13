/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230913@Helios
	Task: Inital Migrate Data Setting SportsBook Currency UUS [#193083]
	DB: DBCust/CustDB
*/
	SET NOCOUNT ON  

	DECLARE @max_custid			INT
		,	@target				VARCHAR(20) 

	--IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST')
	--	SET @target = 'DBCUST' 
	--ELSE 
	--	SET @target = 'REPLICATED'
	--Print 'Server Name : ' + @target

	SELECT @max_custid = (SELECT MAX(CustID) FROM Customer)

	---------------------------------------CREARE TEMP TABLE--------------------------------------

	-- Create Temp Table stored SuperInfo
	CREATE TABLE #TmpSuperInfo		 (CustID	INT
											PRIMARY KEY CLUSTERED (CustID))

	-- Create Temp Table stored SportType - BetType...
	CREATE TABLE #Tmp_ProductSetting (SettingType SMALLINT , SportType SMALLINT, BetType SMALLINT, Islive BIT DEFAULT 0,
											PRIMARY KEY CLUSTERED (SettingType , SportType , BetType , Islive))

	-- Create Temp Table stored PT Setting
	CREATE TABLE #PT_Setting (
		CustID				int,
		SportType			smallint,
		BetType				smallint,
		IsLive				bit,
		IsAutoMasterPT		bit,
		IsAutoSuperPT		bit,
		SuperPT				smallmoney,
		MasterPT			smallmoney,
		AgentPT				smallmoney,
		AutoSuperPT			smallmoney,
		AutoMasterPT		smallmoney,
		MinPT				smallmoney,
		MaxPT				smallmoney,
		IsAffeted			BIT DEFAULT 0
		PRIMARY KEY CLUSTERED (CustID , SportType , BetType , IsLive)
	)

	-- Create Temp Table stored Discount Setting
	CREATE TABLE #DiscountSMA_Setting (
		CustID				int,
		SportType			smallint,
		BetType				smallint,
		Discount			decimal(9,8),
		IsAffeted			BIT DEFAULT 0
		PRIMARY KEY CLUSTERED (CustID , SportType , BetType)
	)

	CREATE TABLE #DiscountMember_Setting (
		CustID				int,
		SportType			smallint,
		BetType				smallint,
		PlayerDiscount		decimal(9,8),
		AgentDiscount		decimal(9,8),
		MasterDiscount		decimal(9,8),
		SuperDiscount		decimal(9,8),
		IsAffeted			BIT DEFAULT 0
		PRIMARY KEY CLUSTERED (CustID , SportType , BetType)
	)

	
	-- Create Temp Table stored Bet Setting
	CREATE TABLE #Bet_Setting (
		CustID				int,
		SportType			smallint,
		BetType				smallint,
		MinBet				money,
		MaxBet				money,
		MaxPerMatch			money,
		IsAffeted			BIT DEFAULT 0
		PRIMARY KEY CLUSTERED (CustID , SportType , BetType)
	)


	---------------------------------------Declare Deployed Info---------------------------------------
	DECLARE @Batch									INT = 5000 
	,		@Count_User								INT
	,		@msg_total								NVARCHAR(200) = 'Total of Super Headline: %d.'

	,		@msg_total_SMABetSetting				NVARCHAR(200) = 'Total of SMA WinLostLimit Affected: %d.'
	,		@msg_total_MemberBetSetting				NVARCHAR(200) = 'Total of Member WinLostLimit Affected: %d.'

	,		@msg_total_SMAPT						NVARCHAR(200) = 'Total of SMA StakeLevel Affected: %d.'
	,		@msg_total_MemberPT						NVARCHAR(200) = 'Total of Member StakeLevel Affected: %d.'

	,		@msg_total_SMADiscount					NVARCHAR(200) = 'Total of SMA Discount Affected: %d.'
	,		@msg_total_MemberDiscount				NVARCHAR(200) = 'Total of Member Discount Affected: %d.'
		
	CREATE TABLE #CustAffected (
		Custid				INT , 
		SportType			INT ,
		BetType				INT ,
		IsLive				BIT
	)


	---------------------------------------Initial SportType-BetType---------------------------------------
	
	INSERT INTO #Tmp_ProductSetting (SettingType ,SportType , BetType , Islive)
	 -- Comm		: SettingType = 25
		   SELECT  25 ,  1 ,  1 , 0
	 UNION SELECT  25 ,  1 ,  3 , 0 
	 UNION SELECT  25 ,  1 ,  7 , 0 
	 UNION SELECT  25 ,  1 ,  8 , 0 
	 UNION SELECT  25 ,  1 ,  5 , 0 
	 UNION SELECT  25 ,  1 ,  4 , 0 
	 -- BetSetting  : SettingType = 26
	 UNION SELECT  26 ,  43 ,  1 , 0 
	 UNION SELECT  26 ,  44 ,  3 , 0 
	 -- PT			: SettingType = 28
	 UNION SELECT  28 ,  1 ,  1 , 0 
	 UNION SELECT  28 ,  1 ,  1 , 1 
	 UNION SELECT  28 ,  1 ,  5 , 0
	 UNION SELECT  28 ,  1 ,  5 , 1
	 UNION SELECT  28 ,  1 ,  9999 , 0 
	 UNION SELECT  28 ,  1 ,  9999 , 1 
	 UNION SELECT  28 ,  99 ,  9 , 0 


	---------------------------------------Collect Super Infor:---------------------------------------

	PRINT N'Step 2.0: Start on Count Total Super Headline: ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

	INSERT INTO #TmpSuperInfo (CustID)
	SELECT cu.CustId
	FROM Customer cu WITH (NOLOCK)
	INNER JOIN Site s WITH (NOLOCK)
				ON cu.site = s.site
	INNER JOIN exchange e WITH (NOLOCK)
				ON cu.currency = e.ExchangeId AND e.IsActive = 1 AND e.OfferSite IN (0,1)
	LEFT JOIN custsuper cs WITH (NOLOCK) 
				ON cu.custid = cs.custid
	WHERE cu.roleid = 4  
		AND s.islicensee = 0
		AND s.isActive = 1
		AND cu.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND cu.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND e.ExchangeId = 20
		AND cu.srecommend IN (95940925,95935217) --<= @max_custid

	SET @Count_User = (SELECT COUNT(1) FROM #TmpSuperInfo )
	RAISERROR (@msg_total, 0, 1, @Count_User) WITH NOWAIT



	/* Release Notes
	BetSetting - SettingType = 26
	- Migrate data with SportType IN (43,44)
	FROM CustBetSetting3rd_Agent to CustBetSetting_Agent
	FROM CustBetSetting3rd_Member to CustBetSetting_Member
	*/

	---------------------------------------Collect SMA CustSetting Infor: BetSetting - SettingType = 26---------------------------------------

	PRINT N'Step 2.1: Start on Migrate SMA Bet Setting ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
	INSERT INTO #Bet_Setting (CustID , SportType , BetType , MinBet , MaxBet , MaxPerMatch)
	SELECT ca.CustID , ca.SportType , ca.BetType , ca.MinBet , ca.MaxBet , ca.MaxPerMatch
	FROM #TmpSuperInfo								si
	INNER JOIN	custInfo							ci		WITH (NOLOCK)		ON si.CustID = ci.srecommend
	INNER JOIN	CustBetSetting3rd_Agent				ca		WITH (NOLOCK)		ON ci.custid = ca.CustID
	INNER JOIN #Tmp_ProductSetting					ps							ON ca.SportType = ps.SportType AND ca.BetType = ps.BetType
	WHERE  ps.SettingType = 26
	AND ci.roleid IN (2,3,4)
	AND ci.Enabled = 1

	SET @Count_User = (SELECT COUNT(1) FROM #Bet_Setting )
	RAISERROR (@msg_total_SMABetSetting, 0, 1, @Count_User) WITH NOWAIT


	TRUNCATE TABLE #Bet_Setting
	---------------------------------------Collect Member CustSetting Infor: BetSetting - SettingType = 26---------------------------------------

	PRINT N'Step 2.2: Start on Migrate Member Bet Setting ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
	INSERT INTO #Bet_Setting (CustID , SportType , BetType , MinBet , MaxBet , MaxPerMatch)
	SELECT ca.CustID , ca.SportType , ca.BetType , ca.MinBet , ca.MaxBet , ca.MaxPerMatch
	FROM #TmpSuperInfo				si
	INNER JOIN	custInfo							ci		WITH (NOLOCK)		ON si.CustID = ci.srecommend
	INNER JOIN	CustBetSetting3rd_Member			ca		WITH (NOLOCK)		ON ci.custid = ca.CustID
	INNER JOIN #Tmp_ProductSetting					ps							ON ca.SportType = ps.SportType AND ca.BetType = ps.BetType
	WHERE  ps.SettingType = 26
	AND ci.roleid = 1
	AND ci.Enabled = 1



	SET @Count_User = (SELECT COUNT(1) FROM #Bet_Setting )
	RAISERROR (@msg_total_MemberBetSetting, 0, 1, @Count_User) WITH NOWAIT





	DROP TABLE #Bet_Setting
	---------------------------------------Collect SMA CustSetting Infor: PT - SettingType = 28---------------------------------------



	PRINT N'Step 2.3: Start on Migrate SMA PT Setting ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

	-- Collect Super, Master, Agent Setting PT Need Insert

	INSERT INTO #PT_Setting (CustID , SportType , BetType , IsLive , SuperPT , MasterPT , AgentPT , AutoSuperPT , IsAutoSuperPT , AutoMasterPT , IsAutoMasterPT , MinPT , MaxPT)

	-- Just affected Non Live PT Values
	SELECT
	cs.custId,
	CASE WHEN cs.sporttype = 1 THEN 9914 ELSE 9915 END AS SportType ,
	CASE WHEN cs.bettype = 1 THEN 915 WHEN cs.bettype = 5 THEN 916 WHEN cs.bettype = 9999 THEN 917 ELSE 918 END AS BetType ,
	ps.Islive AS Islive ,
	spositiontaking AS SuperPT,
	mpositiontaking AS MasterPT,
	apositiontaking AS AgentPT,
	autopositiontaking AS AutoSuperPT,
	isautopositiontaking AS IsAutoSuperPT,
	autompositiontaking AS AutoMasterPT,
	isautompositiontaking AS IsAutoMasterPT,
	ISNULL(co.minpositiontaking , 0) AS MinPT,
	ISNULL(co.maxpositiontaking , 0) AS MaxPT
	FROM #TmpSuperInfo								si
	INNER JOIN CustInfo								ci		WITH (NOLOCK)		ON si.CustID = ci.srecommend
	INNER JOIN custOverride							co		WITH (NOLOCK)		ON ci.CustID = co.custid
	INNER JOIN #Tmp_ProductSetting					ps							ON co.SportType = ps.SportType AND co.BetType = ps.BetType
	INNER JOIN CustSetting							cs		WITH (NOLOCK)		ON cs.custid = co.custid AND cs.SportType = co.SportType AND cs.BetType = co.BetType
	WHERE ci.Enabled = 1
	AND ps.SettingType = 28
	AND ps.Islive = 0
	AND ci.roleid IN (2,3,4)
	

	UNION


	-- BetType = 1  is Handicap : Collect Live Values
	-- BetType <> 1 is (1X2, Others) : Copy Values From NonLive
	SELECT
	cs.custId,
	9913 AS SportType ,
	CASE WHEN cs.bettype = 1 THEN 915 WHEN cs.bettype = 5 THEN 916 WHEN cs.bettype = 9999 THEN 917 ELSE 918 END AS BetType ,
	ps.Islive AS Islive ,
	CASE WHEN cs.betType = 1  THEN slivepositiontaking ELSE spositiontaking END  AS SuperPT,
	CASE WHEN cs.betType = 1  THEN mlivepositiontaking ELSE mpositiontaking END  AS MasterPT,
	CASE WHEN cs.betType = 1  THEN alivepositiontaking ELSE apositiontaking END  AS AgentPT,
	CASE WHEN cs.betType = 1  THEN autolivepositiontaking ELSE autopositiontaking END   AS AutoSuperPT,
	CASE WHEN cs.betType = 1  THEN isautolivepositiontaking ELSE isautopositiontaking END  AS IsAutoSuperPT,
	CASE WHEN cs.betType = 1  THEN autolivempositiontaking ELSE autompositiontaking END  AS AutoMasterPT,
	CASE WHEN cs.betType = 1  THEN isautolivempositiontaking ELSE isautompositiontaking END  AS IsAutoMasterPT,
	CASE WHEN cs.betType = 1  THEN ISNULL(co.minlivepositiontaking , 0) ELSE ISNULL(co.minpositiontaking , 0) END AS MinPT,
	CASE WHEN cs.betType = 1  THEN ISNULL(co.maxlivepositiontaking , 0) ELSE ISNULL(co.maxpositiontaking , 0) END AS MaxPT
	FROM #TmpSuperInfo							si
	INNER JOIN CustInfo							ci		WITH (NOLOCK)		ON si.CustID = ci.srecommend
	INNER JOIN custOverride						co		WITH (NOLOCK)		ON ci.CustID = co.custid
	INNER JOIN #Tmp_ProductSetting				ps							ON co.SportType = ps.SportType AND co.BetType = ps.BetType
	INNER JOIN CustSetting						cs		WITH (NOLOCK)		ON cs.custid = co.custid AND cs.SportType = co.SportType AND cs.BetType = co.BetType
	WHERE ci.Enabled = 1
	AND ps.SettingType = 28
	AND ps.Islive = 1
	AND ci.roleid IN (2,3,4)
	

	SET @Count_User = (SELECT COUNT(1) FROM #PT_Setting)
	RAISERROR (@msg_total_SMAPT, 0, 1, @Count_User) WITH NOWAIT




	
	
	
	TRUNCATE TABLE #PT_Setting
	ALTER TABLE #PT_Setting DROP COLUMN MinPT , MaxPT

	-----------------------------------------Collect Member CustSetting Infor: PT - SettingType = 28---------------------------------------

	PRINT N'Step 2.4: Start on Migrate Member PT Setting ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

	-- Collect Member Setting PT Need Insert
	INSERT INTO #PT_Setting (CustID , SportType , BetType , IsLive , SuperPT , MasterPT , AgentPT , AutoSuperPT , IsAutoSuperPT , AutoMasterPT , IsAutoMasterPT )

	-- Just affected Non Live PT Values
	SELECT
	cs.custId,
	CASE WHEN cs.sporttype = 1 THEN 9914 ELSE 9915 END AS SportType ,
	CASE WHEN cs.bettype = 1 THEN 915 WHEN cs.bettype = 5 THEN 916 WHEN cs.bettype = 9999 THEN 917 ELSE 918 END AS BetType ,
	ps.Islive AS Islive ,
	spositiontaking AS SuperPT,
	mpositiontaking AS MasterPT,
	apositiontaking AS AgentPT,
	autopositiontaking AS AutoSuperPT,
	isautopositiontaking AS IsAutoSuperPT,
	autompositiontaking AS AutoMasterPT,
	isautompositiontaking AS IsAutoMasterPT
	FROM #TmpSuperInfo						si
	INNER JOIN CustInfo						ci WITH (NOLOCK)	ON si.CustID = ci.srecommend
	INNER JOIN CustSetting					cs WITH (NOLOCK)	ON cs.custid = ci.custid
	INNER JOIN #Tmp_ProductSetting			ps					ON cs.SportType = ps.SportType AND cs.BetType = ps.BetType
	WHERE ci.Enabled = 1
	AND ps.SettingType = 28
	AND ps.Islive = 0
	AND ci.roleid = 1
	

	UNION


	-- BetType = 1  is Handicap : Collect Live Values
	-- BetType <> 1 is (1X2, Others) : Copy Values From NonLive
	SELECT
	cs.custId,
	9913 AS SportType ,
	CASE WHEN cs.bettype = 1 THEN 915 WHEN cs.bettype = 5 THEN 916 WHEN cs.bettype = 9999 THEN 917 ELSE 918 END AS BetType ,
	ps.Islive AS Islive ,
	CASE WHEN cs.betType = 1  THEN slivepositiontaking ELSE spositiontaking END  AS SuperPT,
	CASE WHEN cs.betType = 1  THEN mlivepositiontaking ELSE mpositiontaking END  AS MasterPT,
	CASE WHEN cs.betType = 1  THEN alivepositiontaking ELSE apositiontaking END  AS AgentPT,
	CASE WHEN cs.betType = 1  THEN autolivepositiontaking ELSE autopositiontaking END   AS AutoSuperPT,
	CASE WHEN cs.betType = 1  THEN isautolivepositiontaking ELSE isautopositiontaking END  AS IsAutoSuperPT,
	CASE WHEN cs.betType = 1  THEN autolivempositiontaking ELSE autompositiontaking END  AS AutoMasterPT,
	CASE WHEN cs.betType = 1  THEN isautolivempositiontaking ELSE isautompositiontaking END  AS IsAutoMasterPT
	FROM #TmpSuperInfo						si
	INNER JOIN CustInfo						ci WITH (NOLOCK)	ON si.CustID = ci.srecommend
	INNER JOIN CustSetting					cs WITH (NOLOCK)	ON cs.custid = ci.custid
	INNER JOIN #Tmp_ProductSetting			ps					ON cs.SportType = ps.SportType AND cs.BetType = ps.BetType
	WHERE ci.Enabled = 1
	AND ps.SettingType = 28
	AND ps.Islive = 1
	AND ci.roleid = 1
	
	SET @Count_User = (SELECT COUNT(1) FROM #PT_Setting)
	RAISERROR (@msg_total_MemberPT, 0, 1, @Count_User) WITH NOWAIT

	
	DROP TABLE #PT_Setting

	---------------------------------------Collect SMA CustSetting Infor: Discount - SettingType = 25---------------------------------------

	PRINT N'Step 2.5: Start on Migrate SMA Discount Setting ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

	INSERT INTO #DiscountSMA_Setting (CustID , SportType , BetType , Discount)

	SELECT 
	cs.custid , 
	cs.SportType , 
	cs.BetType , 
	CASE 
		WHEN ps.BetType = 1									THEN cs.groupa					-- GroupA
		WHEN ps.BetType = 3									THEN cs.groupb					-- GroupB
		WHEN ps.BetType = 7									THEN cs.groupc					-- GroupC
		WHEN ps.BetType = 8									THEN cs.groupd					-- GroupD
		WHEN ps.BetType IN (4,5) AND ci.roleid = 4			THEN cs.sdiscount				-- 1x2 Comm ,  Others Comm
		WHEN ps.BetType IN (4,5) AND ci.roleid = 3			THEN cs.adiscount				-- 1x2 Comm ,  Others Comm
		WHEN ps.BetType IN (4,5) AND ci.roleid = 2			THEN cs.discount				-- 1x2 Comm ,  Others Comm	
	END 
		AS Discount

	FROM #TmpSuperInfo							si
	INNER JOIN custInfo							ci WITH (NOLOCK)	ON si.CustID = ci.srecommend
	INNER JOIN CustSetting						cs WITH (NOLOCK)	ON cs.custid = ci.custid
	INNER JOIN #Tmp_ProductSetting				ps					ON cs.SportType = ps.SportType AND cs.BetType = ps.BetType
	WHERE ci.Enabled = 1
	AND ci.roleid IN (2,3,4)
	AND ps.SettingType = 25

	UNION

	SELECT 
	cr.custid , 
	2				AS SportType , 
	1				AS BetType , 
	cr.CommRate		AS Discount
	FROM #TmpSuperInfo							si
	INNER JOIN custInfo							ci WITH (NOLOCK)	ON si.CustID = ci.srecommend
	INNER JOIN AgentCommRate					cr WITH (NOLOCK)	ON cr.custid = ci.custid
	WHERE ci.Enabled = 1
	AND ci.roleid IN (2,3,4)


	SET @Count_User = (SELECT COUNT(1) FROM #DiscountSMA_Setting)
	RAISERROR (@msg_total_SMADiscount, 0, 1, @Count_User) WITH NOWAIT



	DROP TABLE #DiscountSMA_Setting


	---------------------------------------Collect Member CustSetting Infor: Discount - SettingType = 25---------------------------------------

	PRINT N'Step 2.6: Start on Migrate Member Discount Setting ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
	INSERT INTO #DiscountMember_Setting (CustID , SportType , BetType , PlayerDiscount , AgentDiscount , MasterDiscount , SuperDiscount)

	SELECT 
	cs.custid , 
	cs.SportType , 
	cs.Bettype ,
	cs.playerdiscount ,
	cs.adiscount ,
	cs.discount ,
	cs.sdiscount 

	FROM #TmpSuperInfo							si
	INNER JOIN custInfo							ci WITH (NOLOCK)	ON si.CustID = ci.srecommend
	INNER JOIN CustSetting						cs WITH (NOLOCK)	ON cs.custid = ci.custid
	INNER JOIN Customer							c  WITH (NOLOCK)	ON cs.custid = c.custid
	INNER JOIN #Tmp_ProductSetting				ps					ON cs.SportType = ps.SportType AND cs.BetType = ps.BetType
	WHERE ci.Enabled = 1
	AND ci.roleid = 1
	AND ps.SettingType = 25
	AND (
			cs.BetType = CASE 
					WHEN c.ugroup IN ('a', 'hka', 'dea') THEN 1 
					WHEN c.ugroup IN ('b', 'hkb', 'deb') THEN 3
					WHEN c.ugroup IN ('c', 'hkc', 'dec') THEN 7 
					WHEN c.ugroup IN ('d', 'hkd', 'ded') THEN 8 
					END
			OR
			cs.Bettype IN (4,5)	
		)
	
	UNION

	SELECT 
	cr.custid , 
	2				AS SportType , 
	1				AS BetType , 
	cr.playerdiscount ,
	cr.adiscount ,
	cr.discount ,
	cr.sdiscount 
	FROM #TmpSuperInfo							si
	INNER JOIN custInfo							ci WITH (NOLOCK)	ON si.CustID = ci.srecommend
	INNER JOIN CustCommRate						cr WITH (NOLOCK)	ON cr.custid = ci.custid
	WHERE ci.Enabled = 1
	AND ci.roleid = 1



	SET @Count_User = (SELECT COUNT(1) FROM #DiscountMember_Setting)
	RAISERROR (@msg_total_MemberDiscount, 0, 1, @Count_User) WITH NOWAIT


	DROP TABLE #DiscountMember_Setting
	-------------------------------------------------------------------------------------------------------------------------
	DROP TABLE #TmpSuperInfo
	DROP TABLE #Tmp_ProductSetting
	DROP TABLE #CustAffected
	