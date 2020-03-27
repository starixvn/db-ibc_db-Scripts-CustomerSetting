/*
	Created: Elodie
	Date: 20200327
	Task: Create setting for Lottery ( New accounts)
	DB: DBCust/CustDB
*/

	DECLARE @max_custid INT = xxx

	DECLARE @SportBettype TABLE (SportType SMALLINT, BetType SMALLINT)
	INSERT INTO @SportBettype(SportType, BetType) VALUES (220, 1021)

	--> API Licensee
	CREATE TABLE #APIsupers (custid int)

	INSERT INTO #APIsupers(custid)
	SELECT c.custid
	FROM customer c WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
		INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
		INNER JOIN dbo.exchange e WITH (NOLOCK) ON ci.currency = e.exchangeid
	WHERE c.roleid = 4  
		AND s.islicensee = 1
		AND ci.Enabled = 1
		AND (e.Code IN ('GBP','EUR','CHF','USD','AUD','BND','CAD','MKK','NZD','SGD','PEN','MYR','PLN','RON','BRL','KHR','TRY','GHS','CNY',
				'DKK','HKD','NOK','SEK','ZAR','IDR','MXN','CZK','INH','THB','TWD','UYU','ARS','PHP','INR','RUB','KES','JPY',
				'CLP','KRW','COP','VES','VND','PYG','UUS') OR e.exchangeid = 20)
		AND s.site IN (	'12B','18Luck','24TECH','365online','368Cash','3star88','568Win','633esports','818Bet','88Macao','9Club','9Wsports',
						'A1game','Abcasino','AEUG','afb99','AG','alog','ALPHA88','AMG','AnvoFH','Aplus','Apollo','asiabet88','Asian88',
						'B24VN','BBIN2','BBIN3','BBIN4','BetDeal','BETSUN','BigGaming','Bobbet','Bobo88','Bodog','BOG22','BoinGroup',
						'Boma365','Bonanza88','BOSSB','Boying','BPLE','BWGaming','Cali','Calibet','Callmeboss','CGame','CGame4','Champion',
						'dabo88','Dachen','Dade','Datang','Datang001','Dawoo','DBP','DEWA','DF88','DingTai','DTGW','e8casino','ECLBET',
						'ENT22','ENTAPLAY','erhaozhan','FB88','Five88','FLC','G2Win','Gameroom','GamingSoft','Gampag','Gaobet','gbkj',
						'GESAB','GGBOOK','GGBOOKES','GMASTER','GPgaming88','GPIGAME','haifa','Happy1668','Happy8','HBO999','HCVIP',
						'Heaven','Hecbet','Heji888','HeleThai','Hengcai88','hjccasino','HJTK','HL8','HONBET','HonorW','HOT88','HuangMa',
						'IBG','IBO','ID88','ig128','IGPTech','INSERTGAME','ISC888','IvoryBet','JGQP8','JIBET','JIDU','Jinyazhou',
						'JZFortune','K8VN','KeenOcean','KhmerG','Kraton','Kudatogel','KUTECH','Leng4D','Liga','LLGAME','Man1878',
						'mansion88','MARS','MAX88','Mayayule','Mayfair','Mbet','MFgame','MICL','Monaco','Mopgaming','MRCATSB','MTech',
						'mtegames','Mybet88','N88','N8B','N8G','Nbbet','Newbet','NewFuture','NextBet','Nova88','OCMS','Okada','OLE777',
						'Onegaming','OneSports','Opadmin','Opal88','OPEBET','PanguGame','Pinbo','PKbet','PKKing','Raisetech','Royal',
						'Salon365','sbt88','shengboyun','Siamgame','skykey','Soon88','Spark','SSSGaming','Starnet','Sun988','Sunbet138',
						'Sunrise','Sunriseb2b','Sunwin','Swin','TangChao','TaoCai','TCbet','TGO','TitanCraft','TitanOne','TLC','TopGame',
						'Tripleone','TXG','txwl002','TYCgame','UN168','UwinY','VCBA','VN88','VWIN66','W88','Wanbo','Wanfang','WB101',
						'WBG88','WBS','webet88','weicai','Weiwei','Win68Club','Win88','WINCLUB88','WKCUR','WKIBPH','WKPHIL','WUYICP',
						'Xinbo','XinYo','XTD3','XTDGT','Xtu168','YAYOU','YBTech','Yibo','YongBao','YTX','Yunji','ZhiFeng032',
						'ZhiFeng035','Zowin','zt828')

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
	SELECT ci.custid, ci.roleid, ci.currency,ci.mrecommend,cs.spositiontaking ,s.siteid
	FROM Custinfo ci WITH (NOLOCK)
		INNER JOIN dbo.CustSettingGame cs WITH (NOLOCK) ON ci.srecommend = cs.custid
		INNER JOIN customer c WITH (NOLOCK) ON c.custid = ci.custid
		INNER JOIN dbo.Site s WITH (NOLOCK) ON c.site = s.site
	WHERE ci.srecommend IN (SELECT custid FROM #APIsupers) AND ci.roleid IN (2,3,4) AND Enabled = 1 AND ci.custid > @max_custid 
		AND ci.mrecommend NOT IN (SELECT custid FROM #APIDummy)
		AND cs.Sporttype = 202 AND cs.Bettype = 1501

	INSERT INTO #MemberTemp(CustID,Currency,mrecommend,PT,SiteId)
	SELECT ci.custid, ci.currency,ci.mrecommend,cs.spositiontaking,s.siteid
	FROM Custinfo ci WITH (NOLOCK)
		INNER JOIN customer c WITH (NOLOCK) ON c.custid = ci.recommend
		INNER JOIN dbo.CustSettingGame cs WITH (NOLOCK) ON ci.srecommend = cs.custid
		INNER JOIN dbo.Site s WITH (NOLOCK) ON c.site = s.site
	WHERE ci.srecommend IN (SELECT custid FROM #APIsupers) AND ci.roleid = 1  AND Enabled = 1 AND ci.custid > @max_custid	
	AND ci.mrecommend NOT IN (SELECT custid FROM #APIDummy)

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

	-------------------------------------------------BetSetting----------------------------------------------------------------
	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustBetSetting_Agent
	FROM Dep_CustBetSetting_Agent a WITH(NOLOCK)
	INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.CustID = ci.custid 

	DELETE a
	FROM Dep_CustBetSetting_Agent a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #Dep_CustBetSetting_Agent t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustBetSetting_Member
	FROM Dep_CustBetSetting_Member a WITH(NOLOCK)
	INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN #MemberTemp ci WITH(NOLOCK) ON a.CustID = ci.custid 

	DELETE a
	FROM Dep_CustBetSetting_Member a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #Dep_CustBetSetting_Member t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	-------------
	SELECT dl.CustID,dl.ProductSettingID
	INTO #Dep_LicenseeProductSetting
	FROM Dep_LicenseeProductSetting dl WITH(NOLOCK)
	INNER JOIN Dep_ProductSetting dp WITH(NOLOCK) ON dl.ProductSettingID = dp.ProductSettingID
	INNER JOIN #SMATemp ci WITH(NOLOCK) ON dl.CustID = ci.custid
	WHERE dp.ProductID = 28

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
						WHERE dp.ProductID = 28
							AND dp.SettingType IN (4,1,2) -- Product Status, PT, Bet Limit
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
	DECLARE @SportBettype_BetSetting TABLE (SportType SMALLINT, BetType SMALLINT,Code VARCHAR(3), MinBet MONEY,MaxBet MONEY)
	INSERT INTO @SportBettype_BetSetting(SportType, BetType, Code, MinBet, MaxBet)
	SELECT 220, 1021, 'UUS', 1, 3000, 15000 UNION ALL
	SELECT 220, 1021, 'GBP', 1, 2000, 10000 UNION ALL
	SELECT 220, 1021, 'EUR', 1, 2500, 12500 UNION ALL
	SELECT 220, 1021, 'CHF', 1, 3000, 15000 UNION ALL
	SELECT 220, 1021, 'USD', 1, 3000, 15000 UNION ALL
	SELECT 220, 1021, 'AUD', 1, 4000, 20000 UNION ALL
	SELECT 220, 1021, 'BND', 1, 4000, 20000 UNION ALL
	SELECT 220, 1021, 'CAD', 1, 4000, 20000 UNION ALL
	SELECT 220, 1021, 'MKK', 1, 4000, 20000 UNION ALL
	SELECT 220, 1021, 'NZD', 2, 4000, 20000 UNION ALL
	SELECT 220, 1021, 'SGD', 2, 4000, 20000 UNION ALL
	SELECT 220, 1021, 'PEN', 5, 9000, 45000 UNION ALL
	SELECT 220, 1021, 'MYR', 5, 10000, 50000 UNION ALL
	SELECT 220, 1021, 'PLN', 5, 10000, 50000 UNION ALL
	SELECT 220, 1021, 'RON', 5, 10000, 50000 UNION ALL
	SELECT 220, 1021, 'BRL', 5, 11000, 55000 UNION ALL
	SELECT 220, 1021, 'KHR', 5, 12000, 60000 UNION ALL
	SELECT 220, 1021, 'TRY', 10, 15000, 75000 UNION ALL
	SELECT 220, 1021, 'GHS', 10, 16000, 80000 UNION ALL
	SELECT 220, 1021, 'CNY', 10, 20000, 100000 UNION ALL
	SELECT 220, 1021, 'DKK', 10, 20000, 100000 UNION ALL
	SELECT 220, 1021, 'HKD', 10, 20000, 100000 UNION ALL
	SELECT 220, 1021, 'NOK', 10, 20000, 100000 UNION ALL
	SELECT 220, 1021, 'SEK', 10, 20000, 100000 UNION ALL
	SELECT 220, 1021, 'ZAR', 20, 35000, 175000 UNION ALL
	SELECT 220, 1021, 'IDR *', 15, 40000, 200000 UNION ALL
	SELECT 220, 1021, 'MXN', 20, 50000, 250000 UNION ALL
	SELECT 220, 1021, 'CZK', 20, 65000, 325000 UNION ALL
	SELECT 220, 1021, 'INH *', 20, 65000, 325000 UNION ALL
	SELECT 220, 1021, 'THB', 50, 100000, 500000 UNION ALL
	SELECT 220, 1021, 'TWD', 50, 100000, 500000 UNION ALL
	SELECT 220, 1021, 'UYU', 50, 100000, 500000 UNION ALL
	SELECT 220, 1021, 'ARS', 50, 125000, 625000 UNION ALL
	SELECT 220, 1021, 'PHP', 50, 150000, 750000 UNION ALL
	SELECT 220, 1021, 'INR', 50, 200000, 1000000 UNION ALL
	SELECT 220, 1021, 'RUB', 50, 200000, 1000000 UNION ALL
	SELECT 220, 1021, 'KES', 100, 300000, 1500000 UNION ALL
	SELECT 220, 1021, 'JPY', 100, 330000, 1650000 UNION ALL
	SELECT 220, 1021, 'CLP', 500, 2000000, 10000000 UNION ALL
	SELECT 220, 1021, 'KRW', 1000, 3000000, 15000000 UNION ALL
	SELECT 220, 1021, 'COP', 1000, 9000000, 45000000 UNION ALL
	SELECT 220, 1021, 'VES', 1000, 10000000, 50000000 UNION ALL
	SELECT 220, 1021, 'VND', 20000, 65000000, 325000000 UNION ALL
	SELECT 220, 1021, 'PYG', 1000, 15000000, 75000000

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
		INNER JOIN dbo.exchange e WITH (NOLOCK) ON b.Code = CASE WHEN e.exchangeid = 20 THEN 'UUS' ELSE e.Code END
	WHERE e.exchangeid = t.currency

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
		INNER JOIN dbo.exchange e WITH (NOLOCK) ON b.Code = CASE WHEN e.exchangeid = 20 THEN 'UUS' ELSE e.Code END
	WHERE e.exchangeid = t.currency

	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp