/*
	Created: Elodie
	Date: 20200326
	Task: Create setting for Virtual games Athena Site and API Site (N88, N8B, N8G)( New accounts)
	DB: DBCust/CustDB
*/

	DECLARE @max_custid INT = xxx

	DECLARE @VGSportBettype TABLE (SportType SMALLINT, BetType SMALLINT)
	INSERT INTO @VGSportBettype(SportType, BetType) VALUES (245, 4601)

	--> API Licensee
	CREATE TABLE #APIsupers (custid int)

	INSERT INTO #APIsupers(custid)
	SELECT c.custid
	FROM customer c WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
		INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
	WHERE c.roleid = 4  
	 AND s.islicensee = 1
	 AND ci.Enabled = 1
	 AND c.currency NOT IN (72,27,28,17,21,31,36,37,40,44,46,50,62,63,65,68,73)
	 AND s.site IN ('KeenOcean','Champion','Sunrise','GESAB','Mayayule','CGame4','ID88','ANGbet','ALPHA88','SSSGaming','YBTech','JIBET','JGQP8','MICL','afb99','DTGW',
				'WUYICP','Siamgame','gbkj','BPLE','TLC','BWGaming','ENTAPLAY','Lucky88','HCVIP','PKbet','MRCATSB','G2Win','ZhiFeng035','Webet88','Sunriseb2b','Aoncash',
				'Huangma','Taipanbet','TaoCai','818Bet','erhaozhan','Brown888','mtegames','Happy1668','allwincity','BetDeal','12bet','Bobbet','Lagadewa','Datang','Haifa',
				'AEUG','Fabet','Zowin','GGBOOKES','Hecbet','18Luck','Uwoniwin','NewFuture','WKCUR','NewHonbet','Lode88','396Club','Callmeboss','DEWA','368Cash','TYCgame',
				'365online','9wickets','GamingSoft','hjccasino','TitanOne','Win88','Mopgaming','GMASTER','ALog','Soon88','Boma365','Wanbo','Onegaming','Dade','BOSSB',
				'Mbet','IBO','Debet','WKPHIL','IvoryBet','sbt88','Liga','Happy8','Hong88','Opadmin','MAX88','A1game','VCBA','9Bet','9Wsports','FLC','HonorW','FB88',
				'Raisetech','VN88','TitanCraft','PanguGame','B24VN','Xtu168','Winn69','Heaven','Sin88','Bodog','MTech','INSERTGAME','Mybet88','Nbbet','BETSUN','PKKing',
				'VWIN66','KhmerG','ig128','shengboyun','Bonanza88','UN168','TopGame','Boying','ECLBET','Gampag','JIDU','Q8Bola','GGBOOK','m8bola','NBCbet','Monaco',
				'Apollo','Bolanation','OCMS','Gameroom','Yabo3','Mansion88','txwl002','KUTECH','BOG22','XTD3','OPEBET','e8casino','DingTai','HBO999','Okada','Yibo',
				'Luckywin88','Five88','Senibet','Monstergol','N8G','Bobo88','MARS','88Macao','Ratugg','AE88','Sunwin','UwinY','AsiaBet88','88Goals','XTDGT','dabo88',
				'Yunji','Kudatogel','ZhiFeng032','zt828','W88','Pinbo','BBIN2','Sun988','JZFortune','Kraton','Heji888','ABcasino','Newbet','WBG88','Aplus','YongBao',
				'One88','Red88','MFgame','Athena000','Unobet','YTX','633esports','Royal','ISC888','CGame','BE7','OneSports','12B','Macaubet','SampleSite','K8VN',
				'WKIBPH','AnvoFH','starsoccer','Sunbet138','XinYo','iBET','Starnet','IONclub','Salon365','Xinbo','weicai','Leng4D','9Club','WBS','NextBet','HJTK',
				'Sungame','ITCBET','Spondemo','Dawoo','3Star88','Gaobet','Storm88','Tianbo','IGPTech','BigGaming','Nova88','Axiawin','TCbet','WINCLUB88','AMG','HL8',
				'TGame','Swin','Wanfang','Jarvis','KingBet','24AVIA','BBIN3','Honbet','GPIgame','11bet','DBP','LLGAME','N88','Ole777','Zbet','IBG','TangChao',
				'Tripleone','YAYOU','N8B','skykey','Weiwei','Datang001','Opal88','QASite','AG','Spark','Jumbo88','ENT22','TGO','DF88')

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

	CREATE TABLE #APIDummy	(CustID INT PRIMARY KEY)
	INSERT INTO #APIDummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend IN (SELECT custid FROM #APIsupers) AND roleid=3 AND username LIKE '%Acc%'
	
	INSERT INTO #SMATemp(CustID,RoleID,Currency,mrecommend,PT,SiteId)
	SELECT ci.custid, ci.roleid, ci.currency,ci.mrecommend,94.00,s.siteid
	FROM Custinfo ci WITH (NOLOCK)
		INNER JOIN customer c WITH (NOLOCK) ON c.custid = ci.custid
		INNER JOIN dbo.Site s WITH (NOLOCK) ON c.site = s.site
	WHERE ci.srecommend IN (SELECT custid FROM #APIsupers) AND ci.roleid IN (2,3,4) AND Enabled = 1 AND ci.custid > @max_custid 
	AND ci.mrecommend NOT IN (SELECT custid FROM #APIDummy)

	INSERT INTO #MemberTemp(CustID,Currency,mrecommend,PT,SiteId)
	SELECT ci.custid, ci.currency,ci.mrecommend,94.00,s.siteid
	FROM Custinfo ci WITH (NOLOCK)
		INNER JOIN customer c WITH (NOLOCK) ON c.custid = ci.recommend
		INNER JOIN dbo.Site s WITH (NOLOCK) ON c.site = s.site
	WHERE ci.srecommend IN (SELECT custid FROM #APIsupers) AND ci.roleid = 1  AND Enabled = 1 AND ci.custid > @max_custid	
	AND ci.mrecommend NOT IN (SELECT custid FROM #APIDummy)

	--DELETE existing data
	------------------------------------PT Setting-------------------------------------------------	
	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustPTSetting_Agent
	FROM Dep_CustPTSetting_Agent a WITH(NOLOCK)
	INNER JOIN @VGSportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.CustID = ci.custid

	DELETE a
	FROM Dep_CustPTSetting_Agent a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #Dep_CustPTSetting_Agent t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustPTSetting_Member
	FROM Dep_CustPTSetting_Member a WITH(NOLOCK)
	INNER JOIN @VGSportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN #MemberTemp ci WITH(NOLOCK) ON a.CustID = ci.custid

	DELETE a
	FROM Dep_CustPTSetting_Member a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #Dep_CustPTSetting_Member t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	SELECT a.AgentID,a.SportType,a.BetType
	INTO #Dep_CustPTGroupSetting_Member
	FROM Dep_CustPTGroupSetting_Member a WITH(NOLOCK)
	INNER JOIN @VGSportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.AgentID = ci.custid

	DELETE a
	FROM Dep_CustPTGroupSetting_Member a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #Dep_CustPTGroupSetting_Member t ON a.AgentID = t.AgentID AND a.SportType = t.SportType and a.BetType = t.BetType 

	-------------------------------------------------STAKE LEVEL----------------------------------------------------------------
	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustStakeLevel_Agent
	FROM Dep_CustStakeLevel_Agent a WITH(NOLOCK)
	INNER JOIN @VGSportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.CustID = ci.custid AND ci.currency <> 20

	DELETE a
	FROM Dep_CustStakeLevel_Agent a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #Dep_CustStakeLevel_Agent t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustStakeLevel_Member
	FROM Dep_CustStakeLevel_Member a WITH(NOLOCK)
	INNER JOIN @VGSportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN #MemberTemp ci WITH(NOLOCK) ON a.CustID = ci.custid AND ci.currency <> 20

	DELETE a
	FROM Dep_CustStakeLevel_Member a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #Dep_CustStakeLevel_Member t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	-------------
	SELECT dl.CustID,dl.ProductSettingID
	INTO #Dep_LicenseeProductSetting
	FROM Dep_LicenseeProductSetting dl WITH(NOLOCK)
	INNER JOIN Dep_ProductSetting dp WITH(NOLOCK) ON dl.ProductSettingID = dp.ProductSettingID
	INNER JOIN #SMATemp ci WITH(NOLOCK) ON dl.CustID = ci.custid AND ci.currency <> 20
	WHERE dp.ProductID = 38

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

	INSERT INTO Dep_CustProductStatus (CustID,bitmapIsDisabled,bitmapIsHidden)
	SELECT	t.custid
			, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @bitmapOrder,0) AS bitmapIsDisabled
			, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @bitmapOrder,0)  AS bitmapIsHidden
	FROM #SMATemp t
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = t.CustID)

	INSERT INTO Dep_CustProductStatus (CustID,bitmapIsDisabled,bitmapIsHidden)
	SELECT	t.custid
			, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @bitmapOrder,0) AS bitmapIsDisabled
			, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @bitmapOrder,0)  AS bitmapIsHidden
	FROM #MemberTemp t
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = t.CustID)
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

	-------------------------------------------------STAKE LEVEL----------------------------------------------------------------
	--> Bet Limit: Apply bet limit group level for all S/M/A/Member levels
	INSERT INTO DEP_CustStakeLevel_Agent(CustID, SportType, BetType, StakeLevelList)
	SELECT tmp.CustID
		,SportType = t.SportType
		,BetType = t.BetType
		,StakeLevelList = SUBSTRING(( SELECT ',' + CONVERT(VARCHAR(5),s.StakeLevelID) 
										FROM DEP_StakeLevel s WITH(NOLOCK) 
										WHERE s.ExchangeId = tmp.Currency AND s.GameTypeID = t.BetType AND s.SiteID = tmp.SiteId 
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
							WHERE s.ExchangeId = tmp.Currency AND s.GameTypeID = t.BetType AND s.SiteID = tmp.SiteId 
							ORDER BY s.MaxStake)
		,GETDATE()
	FROM #MemberTemp tmp
		CROSS APPLY @SportBetType t

	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp