/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220425
	Task: Delete redundant and copy new setting newly created customer [Leap Gaming Virtual Sports 3] - deposit  API Licensees RedmineID:#171868
	DB: DBCUST/CustDB
	
	P/s : Step 3 Delete redundant and copy new setting newly created customer Leap Gaming Virtual Sports 3 Deposit  API Licensees 
*/
-- BEGIN STEP 3.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
	USE CustDB
	GO

	DECLARE @MaxCustID INT = xxx	
	
	DECLARE @batch int = 3000
	DECLARE @BitOrder INT 
	
	DECLARE @SportType SMALLINT = 231
	DECLARE @betType SMALLINT = 5301
	
	CREATE TABLE #supers (custid int)
	DECLARE @SportBetType TABLE
	(
		SportType	SMALLINT, 
		BetType		SMALLINT,
		fSportType	SMALLINT,
		fBettype	SMALLINT
	)
	INSERT INTO @SportBetType(SportType, BetType, fSportType, fBettype) VALUES (231, 5301,180,1201)
	
	SELECT @BitOrder= st.bitmapOrder 
	FROM Dep_ProductStatusProfile st WITH(NOLOCK) 
	INNER JOIN @SportBetType sb ON st.Sporttype = sb.SportType AND st.Bettype = sb.BetType

	
	CREATE TABLE #MemberTemp (CustID INT PRIMARY KEY CLUSTERED,mrecommend INT,Currency INT,isfinished BIT DEFAULT(0))
	CREATE TABLE #SMATemp    (CustID INT PRIMARY KEY CLUSTERED,RoleID TINYINT,mrecommend INT ,Currency INT,isfinished BIT DEFAULT(0))
	CREATE TABLE #MemberBatch (CustID INT PRIMARY KEY CLUSTERED,mrecommend INT,Currency INT)
	CREATE TABLE #SMABatch    (CustID INT PRIMARY KEY CLUSTERED,RoleID TINYINT,mrecommend INT ,Currency INT)
	
	CREATE TABLE #Dep_CustPTSetting_AgentTemp(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype))
	CREATE TABLE #Dep_CustPTSetting_MemberTemp(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype))
	CREATE TABLE #Dep_CustPTGroupSetting_MemberTemp(AgentID INT,Sporttype INT,Bettype INT, PRIMARY KEY(AgentID ,Sporttype ,Bettype))
	CREATE TABLE #Dep_CustBetSetting_AgentTemp(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #Dep_CustBetSetting_MemberTemp(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #Dep_LicenseeProductSettingTemp(CustID INT,ProductSettingID INT, PRIMARY KEY(CustID ,ProductSettingID ))	

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'
		AND ci.Enabled=1
		AND cs.site IN('12bet','ALog','Haifa','W88','3Star88','Ole777','Boma365','88Macao','AE88','368Cash','Royal','Senibet','Happy1668','AG','9Club','iBET','Liga','HonorW','DEWA','IBO','GamingSoft','DBP','Hecbet','HL8','ABcasino','365online','IONclub','Gampag','Mayayule','Huangma','Webet88','BigGaming','PKbet','CGame','VCBA','FLC','IGPTech','Dawoo','Uwoniwin','ECLBET','GPIgame','Bobo88','OPEBET','Sunriseb2b','Okada','Heaven','e8casino','TangChao','MAX88','YongBao','BBIN2','GMASTER','ALPHA88','Tripleone','11bet','MICL','9wickets','zt828','WBS','Yibo','FB88','Xinbo','Monaco','Opadmin','Bonanza88','JIBET','WINCLUB88','MARS','Dade','ANGbet','Callmeboss','One88','VWIN66','A1game','skykey','AEUG','18Luck','ig128','VN88','Zbet','Sin88','Sunwin','Gaobet','Five88','Raisetech','txwl002','DF88','GESAB','AnvoFH','WKPHIL','WKCUR','weicai','Leng4D','Xtu168','Mopgaming','TopGame','DingTai','BBIN3','INSERTGAME','ID88','B24VN','allwincity','BWGaming','KingBet','BOG22','Wanfang','24AVIA','KUTECH','WBG88','NewFuture','erhaozhan','MTech','Wanbo','568Win','shengboyun','Datang001','633esports','starsoccer','N88','hjccasino','OCMS','Lode88','Soon88','XTDGT','mtegames','Yunji','OneSports','TCbet','TaoCai','ZhiFeng032','Zowin','N8G','N8B','BPLE','ZhiFeng035','ZhiFeng036','ZhiFeng009','M8Credit','ZhiFeng012','MANBETX','wmcasino','Winbox','pmwint','ZhiFeng021','HC6YAYOU','TIC88','Sky88','Kbet','Dabet','AOGcasino','Hejiyongle','XO88','US8YAYOU','RICbet','OXbet','WABET','Kzing2','TSEnter','ZhiFeng046','Vwin88','TT128','N8BK','ManCity','ZhiFeng051','Mayibet','Alphalota','GAMEBee','SBObet','ZFRT125','Diamond','bdtt','HOT99','BSSB168','OSUSDT','7kplatform','ZFRT128','ZhiFeng040','Bigwiner','win365','ZFRT132','MSbet','Baji','HY6','ZhiFeng030','SDY','ECBet88','Comebet','9w','3ge888','ZFRT127','ZFRT80GPGT','ZFRT125MGT','ZFRT144','MYGAME','FHLMSABA','LegendWin','UG2','ab6688','Mancity2','VEGA77','dj888','ZFRT155','Barcelo9','directapi','OYO','ZFRT156','LLgaming','Tesla','ZhiFeng083','Aladdin99','ZFRT166','ZFRT165','G4ALL','loc','ZFRT090','OBGM','Jiuyou','ZF055PMW','V03','TH3','LIGAWLHKB','ZFRT161','Towin','ZhiFeng132','TGXI','XTSB','ZhiFeng098','ZhiFeng138','HFYX','ZFRT179','KZO41','ZhiFeng147','HBPT','infini88','TGAA0813','Yintai','Rio66','ZFRT186','JJBGAME','VKGAME','Xiaojin','YakaGaming','Wcasino','Wcasino88','Letian','ZFRT195','ZFRT126','beplay','DTGJZ','WRServices','Million','NFBI','STEBBCBI','383sport','ZF138THB','ZhiFeng178','Titanbet','ZhiFeng183','Xiaoxiang','ZhiFeng013','ZhiFeng019','H1royal','YSYBO688','SEAGaming','kgsports','GLive','YYHbet','NLDSports','ZFRT213','ZF138VND','mbxusdt','ZTech','OESports','5ATech','LEGaming','ZFRT218','ROYAL88','TYM2','kbosports','DDwin','USSBET','ZhiFeng201','DFGame','ZF133FIN2','TSLA','Dawooxin','ZFRT198','SKY1688')  
		AND ci.currency IN (2,3,4,5,6,12,13,15,20,45,46,50,51,61,70,92,94,96,97,121)  -- RM,US$,TB,HK$,EURO,GBP,RMB,IN,UUS,Won,BND,CAN,INH,INR,MKK,HID,MK,USDT,BDT,PKR
		
	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid=3 
		AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
	
	INSERT INTO #SMATemp(CustID,RoleID,mrecommend,Currency)
	SELECT custid, roleid,mrecommend,Currency
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @maxcustID 
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO #MemberTemp(CustID,mrecommend,Currency)
	SELECT custid, mrecommend,Currency
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 1  AND Enabled = 1 AND custid > @maxcustID	
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)
		
--DELETE existing data
	------------------------------------PT Setting-------------------------------------------------	
	
	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustPTSetting_Agent
	FROM Dep_CustPTSetting_Agent a WITH(NOLOCK)
		INNER JOIN @SportBetType t ON a.SportType = t.SportType and a.BetType = t.BetType
		INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.CustID = ci.custid

	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustPTSetting_Member
	FROM Dep_CustPTSetting_Member a WITH(NOLOCK)
		INNER JOIN @SportBetType t ON a.SportType = t.SportType and a.BetType = t.BetType
		INNER JOIN #MemberTemp ci WITH(NOLOCK) ON a.CustID = ci.custid

	SELECT a.AgentID,a.SportType,a.BetType
	INTO #Dep_CustPTGroupSetting_Member
	FROM Dep_CustPTGroupSetting_Member a WITH(NOLOCK)
		INNER JOIN @SportBetType t ON a.SportType = t.SportType and a.BetType = t.BetType
		INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.AgentID = ci.custid
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustPTSetting_Agent)
	BEGIN
		DELETE TOP (@batch) #Dep_CustPTSetting_Agent OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype INTO #Dep_CustPTSetting_AgentTemp(CustID,Sporttype,Bettype)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustPTSetting_Agent cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustPTSetting_AgentTemp  t 
				ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype

		TRUNCATE TABLE #Dep_CustPTSetting_AgentTemp
	END
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustPTSetting_Member)
	BEGIN	
	
		DELETE TOP (@batch) #Dep_CustPTSetting_Member OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype INTO #Dep_CustPTSetting_MemberTemp(CustID,Sporttype,Bettype)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustPTSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustPTSetting_MemberTemp  t 
				ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype
		OPTION(MAXDOP 1)
		
		TRUNCATE TABLE #Dep_CustPTSetting_MemberTemp
				
	END  
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustPTGroupSetting_Member)
	BEGIN	
		DELETE TOP (@batch) #Dep_CustPTGroupSetting_Member OUTPUT DELETED.AgentID,DELETED.Sporttype,DELETED.Bettype INTO #Dep_CustPTGroupSetting_MemberTemp(AgentID,Sporttype,Bettype)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustPTGroupSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustPTGroupSetting_MemberTemp  t 
				ON cg.AgentID=t.AgentID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype
			
		TRUNCATE TABLE #Dep_CustPTGroupSetting_MemberTemp			
	END 	
	-------------------------------------------------BetSetting----------------------------------------------------------------
	
	SELECT S.CustID,s.SportType,s.BetType 
	INTO #Dep_CustBetSetting_Agent
	FROM Dep_CustBetSetting_Agent S WITH(NOLOCK) 
		INNER JOIN #SMATemp ci WITH(NOLOCK) ON s.CustID = ci.custid
	WHERE s.SportType =@sportType AND s.BetType = @betType

	SELECT S.CustID,SportType,BetType 
	INTO #Dep_CustBetSetting_Member
	FROM Dep_CustBetSetting_Member S WITH(NOLOCK) 
		INNER JOIN #MemberTemp ci WITH(NOLOCK) ON s.CustID = ci.custid
	WHERE SportType =@sportType  AND s.BetType = @betType
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustBetSetting_Agent)
	BEGIN		
			
		DELETE TOP (@batch) #Dep_CustBetSetting_Agent OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype INTO #Dep_CustBetSetting_AgentTemp(CustID,Sporttype,Bettype)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustBetSetting_Agent cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustBetSetting_AgentTemp  t 
				ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype

		TRUNCATE TABLE #Dep_CustBetSetting_AgentTemp				
	END 

	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustBetSetting_Member)
	BEGIN
		DELETE TOP (@batch) #Dep_CustBetSetting_Member OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype INTO #Dep_CustBetSetting_MemberTemp(CustID,Sporttype,Bettype)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustBetSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustBetSetting_MemberTemp  t 
				ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype
		OPTION(MAXDOP 1)	
		
		TRUNCATE TABLE #Dep_CustBetSetting_MemberTemp
			
	END	

	-------------------------------------------------Licensee----------------------------------------------------------------
	SELECT dl.CustID,dl.ProductSettingID
	INTO #Dep_LicenseeProductSetting
	FROM Dep_LicenseeProductSetting dl WITH(NOLOCK)
			INNER JOIN Dep_ProductSetting dp WITH(NOLOCK) ON dl.ProductSettingID = dp.ProductSettingID
			INNER JOIN CustInfo ci WITH(NOLOCK) ON dl.CustID = ci.custid
			INNER JOIN #SMATemp s ON ci.srecommend = s.custid
	WHERE dp.ProductID = 49 AND s.RoleID = 4
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_LicenseeProductSetting)
	BEGIN	
		DELETE TOP (@batch) #Dep_LicenseeProductSetting OUTPUT DELETED.CustID,DELETED.ProductSettingID INTO #Dep_LicenseeProductSettingTemp(CustID,ProductSettingID)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_LicenseeProductSetting cg WITH(ROWLOCK)		
		INNER JOIN #Dep_LicenseeProductSettingTemp  t 
			ON cg.CustID=t.CustID AND cg.ProductSettingID=t.ProductSettingID	
	
		TRUNCATE TABLE #Dep_LicenseeProductSettingTemp			
	END
	
	-- SMA LEVEL
	WHILE(1 =1)
	BEGIN
		
		UPDATE TOP (@batch) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID,DELETED.RoleID,DELETED.Currency INTO #SMABatch(CustID,RoleID,Currency)
		FROM #SMATemp c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK
		-------------------------------------------------Add new PT Setting-------------------------------------------------------
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
					a.CustID
				   ,t.SportType
				   ,t.BetType
				   ,0 AS IsLive
				   ,CASE WHEN a.RoleID = 4 THEN 88.00 ELSE 0 END AS SuperPT
				   ,CASE WHEN a.RoleID IN (4,3) THEN 88.00 ELSE 0 END AS MasterPT
				   ,CASE WHEN a.RoleID IN (4,2) THEN 88.00 ELSE 0 END AS AgentPT
			FROM #SMABatch a WITH(NOLOCK)
				CROSS APPLY @SportBetType t

		INSERT INTO dbo.Dep_CustPTGroupSetting_Member
				(	AgentID
				   ,[SportType]
				   ,[BetType]
				   ,[IsLive]
				   ,[SuperPT]
				   ,[MasterPT]
				   ,[AgentPT]
				 )
			SELECT 
					a.CustID
				   ,t.SportType
				   ,t.BetType
				   ,0 AS IsLive
				   ,0 AS SuperPT
				   ,0 AS MasterPT
				   ,88.00 AS AgentPT
			FROM #SMABatch a WITH(NOLOCK)
					CROSS APPLY @SportBetType t	
			WHERE a.RoleID=2
		-------------------------------------Betlimit Setting----------------------------------------------
		INSERT INTO Dep_CustBetSetting_Agent(
			 CustID
			,SportType
			,BetType
			,MinBet
			,MaxBet
			,MaxPerMatch
		)
		SELECT CustID,SportType,BetType,MinBet, CASE WHEN MinBet > MaxBet THEN MinBet ELSE MaxBet END AS MaxBet, MaxPerMatch
		FROM (
			SELECT t.CustID,b.SportType,b.BetType,
			CASE 
				WHEN (cs.MinBet = 0 AND (cs.MaxBet = 0 OR cs.MaxBet = 0.1)) THEN cs.MinBet 
				WHEN cs.MinBet <  c.MinBet THEN c.MinBet ELSE cs.MinBet END AS MinBet,
			CASE 
				WHEN (cs.MinBet = 0 AND (cs.MaxBet = 0 OR cs.MaxBet = 0.1)) THEN cs.MaxBet 
				WHEN cs.MaxBet >  c.MaxBet THEN c.MaxBet ELSE cs.MaxBet END AS MaxBet,	
			0 AS MaxPerMatch
			FROM #SMABatch t WITH(NOLOCK)
				CROSS APPLY @SportBetType b 
				INNER JOIN Dep_ProductBetSetting c WITH(NOLOCK) ON t.Currency = c.Currency AND c.Sporttype = b.SportType AND c.Bettype = b.BetType
				INNER JOIN Dep_CustBetSetting_Agent cs WITH (NOLOCK) ON cs.CustID = t.CustID AND b.fBetType = cs.BetType AND b.fSportType = cs.SportType	
			UNION 
			SELECT t.CustID,b.SportType,b.BetType,c.MinBet,c.MaxBet, 0 AS MaxPerMatch
			FROM #SMABatch t WITH(NOLOCK)
				CROSS APPLY @SportBetType b 
				INNER JOIN Dep_ProductBetSetting c WITH(NOLOCK) ON t.Currency = c.Currency AND c.Sporttype = b.SportType AND c.Bettype = b.BetType
			WHERE NOT EXISTS(SELECT TOP 1 1 FROM Dep_CustBetSetting_Agent WITH(NOLOCK) WHERE Custid=t.CustID AND SportType = b.fSportType And BetType = b.fBetType)	
			) KQ	
				
		TRUNCATE TABLE #SMABatch
	END			
	
	--MEMBER LEVEL
	WHILE(1 =1)
	BEGIN
		
		UPDATE TOP (@batch) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID,DELETED.Currency INTO #MemberBatch(CustID,Currency)
		FROM #MemberTemp c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK
		-------------------------------------------------Add new PT Setting----------------------------------------------------------------
		INSERT INTO dbo.Dep_CustPTSetting_Member
		(	CustID
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		 )
		SELECT 
				a.CustID
			   ,t.SportType
			   ,t.BetType
			   ,0 AS IsLive
			   ,0 AS SuperPT
			   ,0 AS MasterPT
			   ,88.00 AS AgentPT
		FROM #MemberBatch a WITH(NOLOCK)
				INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON m.CustID=a.CustID
				CROSS APPLY @SportBetType t
			WHERE m.IsGroupedPT=0

		INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
		SELECT t.CustID,1
		FROM #MemberBatch t WITH(NOLOCK) 
		WHERE NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode D WITH(NOLOCK) WHERE D.CustID=t.CustID)
			AND NOT EXISTS (SELECT 1 FROM Dep_CustBAActive BA WITH (NOLOCK) WHERE BA.CustId=t.CustID)
		-------------------------------------Betlimit Setting----------------------------------------------
		-----
		INSERT INTO Dep_CustBetSetting_Member(
			 CustID
			,SportType
			,BetType
			,MinBet
			,MaxBet
			,MaxPerMatch
		)
		SELECT CustID,SportType,BetType,MinBet, CASE WHEN MinBet > MaxBet THEN MinBet ELSE MaxBet END AS MaxBet, MaxPerMatch
		FROM (
			SELECT t.CustID,b.SportType,b.BetType,
			CASE 
				WHEN (cs.MinBet = 0 AND (cs.MaxBet = 0 OR cs.MaxBet = 0.1)) THEN cs.MinBet 
				WHEN cs.MinBet <  c.MinBet THEN c.MinBet ELSE cs.MinBet END AS MinBet,
			CASE 
				WHEN (cs.MinBet = 0 AND (cs.MaxBet = 0 OR cs.MaxBet = 0.1)) THEN cs.MaxBet 
				WHEN cs.MaxBet >  c.MaxBet THEN c.MaxBet ELSE cs.MaxBet END AS MaxBet,	
			0 AS MaxPerMatch
			FROM #MemberBatch t WITH(NOLOCK)
				CROSS APPLY @SportBetType b 
				INNER JOIN Dep_ProductBetSetting c WITH(NOLOCK) ON t.Currency = c.Currency AND c.Sporttype = b.SportType AND c.Bettype = b.BetType
				INNER JOIN Dep_CustBetSetting_Member cs WITH (NOLOCK) ON cs.CustID = t.CustID AND b.fBetType = cs.BetType AND b.fSportType = cs.SportType
			UNION 
			SELECT t.CustID,b.SportType,b.BetType,c.MinBet,c.MaxBet, 0 AS MaxPerMatch
			FROM #MemberBatch t WITH(NOLOCK)
				CROSS APPLY @SportBetType b 
				INNER JOIN Dep_ProductBetSetting c WITH(NOLOCK) ON t.Currency = c.Currency AND c.Sporttype = b.SportType AND c.Bettype = b.BetType
			WHERE NOT EXISTS(SELECT TOP 1 1 FROM Dep_CustBetSetting_Member WITH(NOLOCK) WHERE Custid=t.CustID AND SportType = b.fSportType And BetType = b.fBetType)	
			) KQ
					
		TRUNCATE TABLE #MemberBatch
	END 
	
	-------------------------------------Licensee Setting----------------------------------------------
	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT temp.CustID
		  ,st.ProductSettingID
	FROM #SMATemp temp 
		 CROSS APPLY (	SELECT ProductSettingID 
						FROM Dep_ProductSetting dp WITH(NOLOCK) 
						WHERE dp.ProductID = 49
							AND dp.SettingType IN (4,1,11) -- Product Status, PT, BetLimit
						) st
	WHERE temp.RoleID = 4

	--------------------------------------------Enable Status--------------------------------------------------
	CREATE TABLE #AllUsers (CustID int PRIMARY KEY)
	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	INSERT INTO #AllUsers (CustID)
	SELECT DISTINCT SMA.CustID FROM #SMATemp SMA WITH (NOLOCK)
	UNION 
	SELECT DISTINCT M.CustID FROM #MemberTemp M WITH (NOLOCK)

	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(c.bitmapIsHidden,@BitOrder,0))
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(c.bitmapIsDisabled,@BitOrder,0))
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		CROSS APPLY @SportBetType t
		INNER JOIN  #SMATemp temp ON temp.CustID = c.custid
	UNION ALL
	SELECT c.CustID
		,bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus  (c.bitmapIsHidden,@BitOrder,0))
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus  (c.bitmapIsDisabled,@BitOrder,0))
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		CROSS APPLY @SportBetType t
		INNER JOIN  #MemberTemp temp ON temp.CustID = c.custid

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

		WAITFOR DELAY '00:00:00.100'
	END

	INSERT INTO Dep_CustProductStatus (CustID,bitmapIsDisabled,bitmapIsHidden)
	SELECT	A.custid
			, (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0) AS bitmapIsDisabled)
			, (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0)  AS bitmapIsHidden)
	FROM #AllUsers A WITH (NOLOCK)
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = A.CustID)
	
	
	DROP TABLE #MemberTemp 
	DROP TABLE #SMATemp    
	DROP TABLE #MemberBatch
	DROP TABLE #SMABatch   
	
	DROP TABLE #Dep_CustPTSetting_AgentTemp
	DROP TABLE #Dep_CustPTSetting_MemberTemp
	DROP TABLE #Dep_CustPTGroupSetting_MemberTemp
	DROP TABLE #Dep_CustBetSetting_AgentTemp
	DROP TABLE #Dep_CustBetSetting_MemberTemp
	DROP TABLE #Dep_LicenseeProductSettingTemp

