/*
	Created: Elodie
	Date: 20200330
	Task: Create setting for Table Games Deposit (N88, N8B, N8G)( New accounts)
	DB: DBCust/CustDB
*/

	DECLARE @max_custid INT = xxx

	DECLARE @SportBetType TABLE
	(
		SportType	SMALLINT, 
		BetType		SMALLINT,
		fSportType	SMALLINT,
		fBettype	SMALLINT
	)
	INSERT INTO @SportBetType(SportType, BetType, fSportType, fBettype) VALUES (222, 4901, 220, 1021)
	
	--DELETE existing data
	------------------------------------PT Setting-------------------------------------------------	
	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustPTSetting_Agent
	FROM Dep_CustPTSetting_Agent a WITH(NOLOCK)
	INNER JOIN @SportBetType t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid
	WHERE a.CustID >@max_custid

	DELETE a
	FROM Dep_CustPTSetting_Agent a WITH(ROWLOCK)
	INNER JOIN #Dep_CustPTSetting_Agent t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustPTSetting_Member
	FROM Dep_CustPTSetting_Member a WITH(NOLOCK)
	INNER JOIN @SportBetType t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid
	WHERE a.CustID >@max_custid

	DELETE a
	FROM Dep_CustPTSetting_Member a WITH(ROWLOCK)
	INNER JOIN #Dep_CustPTSetting_Member t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	SELECT a.AgentID,a.SportType,a.BetType
	INTO #Dep_CustPTGroupSetting_Member
	FROM Dep_CustPTGroupSetting_Member a WITH(NOLOCK)
	INNER JOIN @SportBetType t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN CustInfo ci WITH(NOLOCK) ON a.AgentID = ci.custid
	WHERE a.AgentID >@max_custid

	DELETE a
	FROM Dep_CustPTGroupSetting_Member a WITH(ROWLOCK)
	INNER JOIN #Dep_CustPTGroupSetting_Member t ON a.AgentID = t.AgentID AND a.SportType = t.SportType and a.BetType = t.BetType 

	-------------------------------------------------BetSetting----------------------------------------------------------------
	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustBetSetting_Agent
	FROM Dep_CustBetSetting_Agent a WITH(NOLOCK)
	INNER JOIN @SportBetType t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid
	WHERE a.CustID >@max_custid

	DELETE a
	FROM Dep_CustBetSetting_Agent a WITH(ROWLOCK)
	INNER JOIN #Dep_CustBetSetting_Agent t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustBetSetting_Member
	FROM Dep_CustBetSetting_Member a WITH(NOLOCK)
	INNER JOIN @SportBetType t ON a.SportType = t.SportType and a.BetType = t.BetType
	INNER JOIN CustInfo ci WITH(NOLOCK) ON a.CustID = ci.custid
	WHERE a.CustID >@max_custid

	DELETE a
	FROM Dep_CustBetSetting_Member a WITH(ROWLOCK)
	INNER JOIN #Dep_CustBetSetting_Member t ON a.CustID = t.CustID AND a.SportType = t.SportType and a.BetType = t.BetType 

	-------------
	SELECT dl.CustID,dl.ProductSettingID
	INTO #Dep_LicenseeProductSetting
	FROM Dep_LicenseeProductSetting dl WITH(NOLOCK)
	INNER JOIN Dep_ProductSetting dp WITH(NOLOCK) ON dl.ProductSettingID = dp.ProductSettingID
	INNER JOIN CustInfo ci WITH(NOLOCK) ON dl.CustID = ci.custid
	WHERE dp.ProductID = 40
		AND dl.CustID >@max_custid

	DELETE a
	FROM Dep_LicenseeProductSetting a WITH(ROWLOCK)
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
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED
	   ,Currency INT
	   ,RoleID TINYINT
	   ,mrecommend INT
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
	AND s.site IN ('11bet','12Bet','24TECH','365online','368Cash','396Club','3star88','568Win','633esports','7Konline','818Bet',
					'88Goals','88Macao','9bet','9Club','9wickets','A1game','Abcasino','Ae88','AEUG','afb99','AG','allwincity',
					'alog','ALPHA88','AMG','ANGbet','AnvoFH','Aoncash','Aplus','Apollo','asiabet88','Asian88','Athena000',
					'Axiawin','B24VN','BE7','BetDeal','BETSUN','BigGaming','Bobbet','Bobo88','Bodog','BoinGroup','Bolanation',
					'Boma365','Bonanza88','BOSSB','Boying','BPLE','Brown888','BWGaming','Cali','Calibet','Callmeboss','CGame',
					'CGame4','Champion','Dachen','Dade','Datang','Datang001','Dawoo','Debet','DEWA','DF88','DingTai','DTGW',
					'e8casino','ECLBET','ENT22','ENTAPLAY','erhaozhan','Fabet','FB88','Five88','FLC','G2Win','Gameroom',
					'GamingSoft','Gampag','Gaobet','gbkj','GESAB','GGBOOK','GMASTER','GPgaming88','GPIGAME','Happy1668',
					'Happy8','HCVIP','Heaven','Hecbet','HeleThai','Hengcai88','hjccasino','HJTK','HL8','HONBET','Hong88',
					'HonorW','HOT88','HuangMa','iBET','IBG','IBO','ID88','IGPTech','INSERTGAME','IONclub','ITCbet','Jarvis',
					'JIBET','JIDU','Jinyazhou','Jumbo88','JZFortune','KeenOcean','KhmerG','KingBet','Kraton','Kudatogel',
					'KUTECH','Lagadewa','Leng4D','Liga','Lode88','Lucky88','Luckywin88','M8bola','Macaubet','Man1878',
					'mansion88','MARS','MAX88','Mayayule','Mayfair','Mbet','MFgame','MICL','Monstergol','Mopgaming',
					'MRCATSB','MTech','Mybet88','N88','N8B','N8G','Nbbet','NBCbet','Newbet','NewFuture','Newhonbet',
					'OCMS','Okada','OLE777','One88','Onegaming','Opadmin','OPEBET','PanguGame','Pinbo','PKbet','Q8bola',
					'QASite','Raisetech','Ratugg','Red88','Royal','Salon365','sbt88','Senibet','shengboyun','Siamgame',
					'Sin88','skykey','Soon88','Spark','spondemo','SSSGaming','Starnet','starsoccer','Sun988','Sunbet138',
					'SunGame','Sunwin','Swin','Taipanbet','TangChao','TaoCai','TCbet','TGO','Tianbo','TitanCraft','TitanOne',
					'TLC','TopGame','Tripleone','TXG','txwl002','TYCgame','UN168','Unobet','UwinY','Uwoniwin','VCBA','VN88',
					'VWIN66','W88','Wanbo','Wanfang','WB101','WBG88','WBS','webet88','weicai','Weiwei','Win68Club','Win88',
					'WINCLUB88','Winn69','WKCUR','WKIBPH','WKPHIL','WUYICP','Xinbo','XinYo','XTDGT','Yabo3','YAYOU','Yibo',
					'YongBao','YTX','Yunji','Zbet','Zowin','zt828'
					)

	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid=3 
		AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
	
	INSERT INTO #SMATemp(CustID,RoleID,Currency,mrecommend)
	SELECT custid, roleid, currency,mrecommend
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @max_custid 
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO #MemberTemp(CustID,Currency,mrecommend)
	SELECT custid, currency,mrecommend
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 1  AND Enabled = 1 AND custid > @max_custid	
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

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
						WHERE dp.ProductID = 40
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
			,cs.IsLive
			,cs.SuperPT
			,cs.MasterPT
			,cs.AgentPT
	FROM #SMATemp d
		INNER JOIN Dep_CustPTSetting_Agent cs WITH (NOLOCK) ON cs.CustID = d.CustID
		INNER JOIN @SportBetType t ON t.fBetType = cs.BetType AND t.fSportType = cs.SportType

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
			,cs.IsLive
			,cs.SuperPT
			,cs.MasterPT
			,cs.AgentPT
	FROM #MemberTemp d
		INNER JOIN Dep_CustPTSetting_Member cs WITH (NOLOCK) ON cs.CustID = d.CustID
		INNER JOIN @SportBetType t ON t.fBetType = cs.BetType AND t.fSportType = cs.SportType
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
		,cs.IsLive
		,cs.SuperPT
		,cs.MasterPT
		,cs.AgentPT
	FROM #SMATemp d
		INNER JOIN Dep_CustPTGroupSetting_Member cs WITH (NOLOCK) ON cs.AgentID = d.CustID
		INNER JOIN @SportBetType t ON t.fBetType = cs.BetType AND t.fSportType = cs.SportType
	WHERE roleid = 2

	INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
	SELECT t.CustID,1
	FROM #MemberTemp t WITH(NOLOCK)
		LEFT JOIN Dep_CustSettingMode d WITH(NOLOCK) ON  d.CustID = t.CustID
	WHERE d.CustID IS NULL

	-------------------------------------------------BetSetting----------------------------------------------------------------
	INSERT INTO Dep_CustBetSetting_Agent(
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
	)
	SELECT t.CustID,b.SportType,b.BetType,cs.MinBet,cs.MaxBet,cs.MaxPerMatch
	FROM #SMATemp t
		INNER JOIN Dep_CustBetSetting_Agent cs WITH (NOLOCK) ON cs.CustID = t.CustID
		INNER JOIN @SportBetType b ON b.fBetType = cs.BetType AND b.fSportType = cs.SportType

	INSERT INTO Dep_CustBetSetting_Member(
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
	)
	SELECT t.CustID,b.SportType,b.BetType,cs.MinBet,cs.MaxBet,cs.MaxPerMatch
	FROM #MemberTemp t
		INNER JOIN Dep_CustBetSetting_Member cs WITH (NOLOCK) ON cs.CustID = t.CustID
		INNER JOIN @SportBetType b ON b.fBetType = cs.BetType AND b.fSportType = cs.SportType

	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp