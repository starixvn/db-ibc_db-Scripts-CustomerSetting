/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 20210531
	Task:	 Delete redundant and add new setting newly created customer for AdvantPlay & AdvantPlay Mini RedmineID:#177465
	DB:		 DBCUST/CustDB
	P/s : Step 5 Delete redundant and add new setting newly created customer AdvantPlay & AdvantPlay Mini
*/
USE [CustDB]
GO
-----------------------------------------------------
	PRINT N'Step 5: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
	CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))

	DECLARE @maxcustid INT

	SELECT @maxcustid = xxx

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'
			AND ci.Enabled=1  
			AND cs.site IN('ZhiFeng255','JIB88','GESAB','Mayayule','CGame4','ZhiFeng201','FLCSW','iBET','vnggame','Million','erhaozhan','vssports','ug396','VCBA','OCMS','YYHbet','442ball','zt828','CloudRock','W88','n88clubSW','BBIN2','9wtest','Ot88','ZhiFeng242','ZFRT129','QASite','PLAYES','NukeGaming','3Star88','bdtt','TSEnter','SGM88','ZhiFeng176','368Cash','wmcasinoS','365online','9wickets','PKbet','IDNSPORT','ZF055PMW','ABEMT','liv66SW','XmenSW','ZhiFeng221','ZhiFeng035','MTech','Lucklotter','INSERTGAME','SL88SW','0sServices','FKsport','WSlots','ZFRT242','633esports','Royal','ISC888','ALog','UG2','Soon88','88Macao','5ATech','Kingfun','Haifa','AEUG','HFYX','Winsplay','JJBGAME','ZhiFeng050','Tesla','GPIgame','DBP','Okada','Yibo','ZFRT080','NextBet','Happistar','ZhiFeng204','TGAA0813','Xiaojin','MICL','ECLBET','OBGM','Gampag','PINT','DTGJZ','Huangma','USSBET','Wcasino','ROYAL88','ZFRT219','TangChao','Tripleone','ZhiFeng262','IBO','WKPHIL','M88ASIA','lionsclub','livv88sw','ABcasino','TSLA','X2Dynamic','BigGaming','CandyA18','TCbet','DEWA','ZFRT165','LSM99','WINHX1','ID88','ZFRT175','DFGame','OYO','383sport','ZhiFeng133','Happy8','HIDZ','ZF215CNY','Mybet88','Omni88','WRSeamless','Uwoniwin','awc2','ZFRT259','NewFuture','WKCUR','VN88','B24VN','EclipseSW','Xtu168','CGame','ZFRT179','G4ALL','ZFRT155new','FHLMSABAS','ZhiFeng107','ZhiFeng032','ZFRT218','GoldenF2','GamingSoft','LIGAWLHKB','US8YAYOU','N8BK','IONclub','UGaming','Diamond','Xinbo','YakaGaming','XLMEDIA','dj888','368CashSW','BOG22','OPEBET','e8casino','DingTai','BPLE','ZhiFeng012','Apollo369','TLC','Dawooxin','SDYSW','12bet','ZhiFeng009','OESports','Sunwin','AsiaBet88','SEAGaming','Riverich','Mayibet','ZhiFeng021','ig128','3ge888','shengboyun','Bonanza88','loc','SampleSite','F88IN1SW','bigbet','CENTRAL168','ZFRT132','VEGA77','bdtt2','Baji','ZhiFeng013','ZhiFeng183','Lode88','M8Credit','N8G','HY6','HBPT','SBObet','Bobo88','GmasterS','MARS','DongYing','beplay','ig128s','Leng4D','TYgaming','24AVIASL','JDJDAPI','9Club','WBS','ZF138VND','d3sports','ZhiFeng051','ZhiFeng222','DCSDemo','ZhiFeng019','ZhiFeng055','OSUSDT','Zhifeng215','Wanfang','568WinSW','ZFRT240','Asiasigma','ZhiFeng142','DDwin','ZhiFeng030','wmcasino','TYM2','ZFRT126','998bet','Dawoo','win365','JDYGaming','Aladdin99','Ole777','ZFRT167','luckybuy','Twowin','GBET','ZF138THB','Heaven','ZhiFeng266','hjccasino','khmerA2','ZFRT156','LLgaming','Mopgaming','GMASTER','N8B','skykey','infini88','Weiwei','Wcasino88','HC6YAYOU','STEBBCBI','7kplatform','Datang001','ZhiFeng040','Webet88','ZhiFeng116','ZFRT090','Kzing2','Sunriseb2b','Sky88','Peakk','OXPLAY','GMDFD','Monaco','aws03','Betway','XTSB','MAX88','SENBKK','A1game','UNOGAMING','ANGbet','ZhiFeng147','Towin','Yintai','ALPHA88','ZFRT159','YongBao','OGWLS','GoldenF','LEIHUO','Callmeboss','ZFRT186','Hejiyongle','ZhiFeng138','txwl002','KUTECH','Vwin88','OneSports','TXJT','ZFRT152','mbxusdt','ZhiFeng208','568Win','SWDemo','JBO','Pay4d','Heji888','SEAL888','Rio66','mtegames','LUCKYBET','Happy1668','JUYOU','allwincity','AE88','WGAMING','Niu8gaming','ZhiFeng228','Xiaoxiang','ZhiFeng132','KZSW','PKKing','VWIN66','ZFRT213','OXbet','HonorW','pmwint','FB88','JUNBOVN','ARYA','Raisetech','AG','AKYL99','Winbox','baowang188','SAGAME88','Gaobet','X33Asia','ZFRT80GPGT','IGSW','Test0112','DF88','KSTECH2','Bigwiner','Zowin','C88bet','Hecbet','18Luck','AOGcasino','JIBET','MultiSL88','ZhiFeng122','XTDGT','KSTECH','Yunji','SM88','ABCGAME','V9betSW','GAMEBee','directapi','MANBETX','TT128','Test1607','ZFRT263','ZFRT195','awc','TGXI','ZFRT166','NLDSports','Boma365','Wanbo','ZF133FIN2','Dade','ZhiFeng094','VKGAME','ACsports','ZhiFeng084','ZhiFeng248','AEUGSW','OkadaSW','Letian','Rakyat4DSW','NFBI','H1royal','AnvoFH','starsoccer','ZhiFeng036','De365','kgsports','oddstest','FLC','BSSB168','ZhiFeng253','ZTech','MYGAME','WINCLUB88','dghash','HL8','Barcelo9','Alphalota','ZFRT115','GoToWin','ZhiFeng168','OCMSS','Mancity2','V03','YSYBO688','GSCSW','Saba789','ZF215aTR','SWSite','ZFRT166SW','BWGaming','TWWIN','ZFRT144','Nexus','SKY1688','N88','4300','SDY','C7YOUXI','CMBSW','ZhiFeng223','ZF026','kbosports','ManCity','GLive','ZFRT155','WBG88','WLSTAR','Jiuyou','bmwbet','TaoCai','LegendWin','ECBet88','9w','HOT99','KingBet','24AVIA','BBIN3','KzingP88','DMsports','khmer','FHLMSABA','IGPTech','ab6688','yuanbao','TopGame','HOroyal','WABET','ZhiFeng200','Titanbet','ZFRT161','TH3','Sin88','WRServices')
	  AND Ci.currency IN (2,3,4,5,6,7,12,13,15,20,32,45,46,49,51,55,56,61,66,70,71,72,79,80,82,83,85,86,92,93,94,96,97,9,41)
		--,RM,US$,TB,HK$,EURO,DON,GBP,RMB,IN,UUS,JPY,Won,BND,MXN,INH,RUB,PLN,INR,YUN,MKK,KHR,YNG,KES,GHS,BRL,CLP,PEN,ARS,HID,LAK,MK,USDT,BDT,AUD,CHF
			ORDER BY ci.custid 
	
	DECLARE @SuperPT SMALLINT = 93
	DECLARE @currency INT, @siteId INT   ,@StakeLevelID INT
	DECLARE @sportType SMALLINT , @BetType SMALLINT , @sportTypeMini SMALLINT , @BetTypeMini SMALLINT, @GameGroupID INT, @GameGroupIDMini INT
	SELECT @sportType = 172 , @BetType = 7701 , @sportTypeMini = 174 , @BetTypeMini = 7801 ,@GameGroupID = 28 ,@GameGroupIDMini = 30
	
	----------------Delete exits data
	DELETE cg
	FROM Dep_CustPTSetting_Agent cg WITH(UPDLOCK,ROWLOCK)	
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid	
	WHERE  ((SportType =@sportType AND BetType = @BetType) OR 
		(SportType =@sportTypeMini AND BetType = @BetTypeMini )) AND cg.custid > @maxcustID
						
	DELETE cg
	FROM Dep_CustPTSetting_Member cg WITH(UPDLOCK,ROWLOCK)		
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid	
	WHERE  ((SportType =@sportType AND BetType = @BetType) OR 
		(SportType =@sportTypeMini AND BetType = @BetTypeMini )) AND cg.custid > @maxcustID
		
	DELETE cg
	FROM Dep_CustPTGroupSetting_Member cg WITH(UPDLOCK,ROWLOCK)	
		INNER JOIN Customer c WITH (NOLOCK) ON cg.AgentID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid		
	WHERE ((SportType =@sportType AND BetType = @BetType) OR 
		(SportType =@sportTypeMini AND BetType = @BetTypeMini)) AND c.custid > @maxcustID
				
	DELETE cg
	FROM Dep_CustStakeLevel_Agent cg WITH(UPDLOCK,ROWLOCK)	
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid		
	WHERE  ((SportType =@sportType AND BetType = @BetType) OR 
		(SportType =@sportTypeMini AND BetType = @BetTypeMini )) AND c.custid > @maxcustID

	DELETE cg
	FROM Dep_CustStakeLevel_Member cg WITH(UPDLOCK,ROWLOCK)
		INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid			
	WHERE  ((SportType =@sportType AND BetType = @BetType) OR 
		(SportType =@sportTypeMini AND BetType = @BetTypeMini)) AND c.custid > @maxcustID
	-------------------------------
	
	DECLARE @BitOrder INT , @BitOrderMini INT
	SELECT @BitOrder= bitmapOrder 
	FROM Dep_ProductStatusProfile WITH(NOLOCK) 
	WHERE SportType=@Sporttype AND Bettype = @BetType

	SELECT @BitOrderMini= bitmapOrder 
	FROM Dep_ProductStatusProfile WITH(NOLOCK) 
	WHERE SportType = @sportTypeMini AND Bettype = @BetTypeMini

	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend IN(SELECT CustID FROM #supers) AND roleid=3 AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%')

	-------------------------------------PT Setting-----------------------------------------------
	--Agent Level
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
			[CustID]
		   ,@sportTypeMini
		   ,@BetTypeMini
		   ,0
		   ,@SuperPT
		   ,@SuperPT
		   ,@SuperPT
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid AND ci.Enabled=1 
		AND RoleID=4
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	UNION ALL
	SELECT 
			[CustID]
		   ,@sportType
		   ,@BetType
		   ,0
		   ,@SuperPT
		   ,@SuperPT
		   ,@SuperPT
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid AND ci.Enabled=1 
		AND RoleID=4
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	
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
			[CustID]
		   ,@sportTypeMini
		   ,@BetTypeMini
		   ,0
		   ,0
		   ,@SuperPT
		   ,0	
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid AND ci.Enabled=1 
		AND RoleID=3
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	UNION ALL
	SELECT 
			[CustID]
		   ,@sportType
		   ,@BetType
		   ,0
		   ,0
		   ,@SuperPT
		   ,0	
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid AND ci.Enabled=1 
		AND RoleID=3
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)

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
			[CustID]
		   ,@sportTypeMini
		   ,@BetTypeMini
		   ,0
		   ,0
		   ,0
		   ,@SuperPT
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid AND ci.Enabled=1 
		AND RoleID=2
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	UNION ALL
	SELECT 
			[CustID]
		   ,@sportType
		   ,@BetType
		   ,0
		   ,0
		   ,0
		   ,@SuperPT
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid AND ci.Enabled=1 
		AND RoleID=2
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)

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
			[CustID]
		   ,@sportTypeMini
		   ,@BetTypeMini
		   ,0
		   ,0
		   ,0
		   ,@SuperPT
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid AND ci.Enabled=1 
		AND RoleID=2
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	UNION ALL
	SELECT 
			[CustID]
		   ,@sportType
		   ,@BetType
		   ,0
		   ,0
		   ,0
		   ,@SuperPT
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid AND ci.Enabled=1 
		AND RoleID=2
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	--Member Level
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
			ci.CustID
		   ,@sportTypeMini
		   ,@BetTypeMini
		   ,0
		   ,0
		   ,0
		   ,@SuperPT
	FROM custInfo ci WITH(NOLOCK)
		INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON ci.CustID=m.CustID
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid AND ci.Enabled=1 
		AND RoleID=1
		AND m.IsGroupedPT=0
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	UNION ALL
	SELECT 
			ci.CustID
		   ,@sportType
		   ,@BetType
		   ,0
		   ,0
		   ,0
		   ,@SuperPT
	FROM custInfo ci WITH(NOLOCK)
		INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON ci.CustID=m.CustID
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid AND ci.Enabled=1 
		AND RoleID=1
		AND m.IsGroupedPT=0
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
	SELECT ci.CustID,1
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid AND ci.Enabled=1 
		AND RoleID=1
		AND NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode WITH(NOLOCK) WHERE CustID=ci.CustID)
		AND NOT EXISTS (SELECT 1 FROM Dep_CustBAActive BA WITH (NOLOCK) WHERE BA.CustId=ci.CustID)
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)
		
	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT t.custid,99
	FROM #supers t
	WHERE t.custid>@maxcustid	
		AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting a WITH(NOLOCK) WHERE a.CustID=t.custid AND a.ProductSettingID=99)
	UNION ALL
	SELECT t.custid,105
	FROM #supers t
	WHERE t.custid>@maxcustid	
		AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting a WITH(NOLOCK) WHERE a.CustID=t.custid AND a.ProductSettingID=105)

	-------------------------------------Betlimit Setting-----------------------------------------------
	CREATE TABLE #MemberTemp (CustID INT ,Sporttype INT, Bettype INT, StakeLevelID VARCHAR(100),isfinished BIT DEFAULT(0), PRIMARY KEY(CustID ,Sporttype, Bettype ))	
	CREATE TABLE #SMATemp  (CustID INT, Sporttype INT, Bettype INT, StakeLevelID VARCHAR(100), PRIMARY KEY(CustID ,Sporttype, Bettype ))	
	--Agent Level
	INSERT INTO  #SMATemp (CustID, Sporttype, Bettype, StakeLevelID)
	SELECT CI.custid, @Sporttype, @BetType, CAST(sl.StakeLevelID	AS VARCHAR(100))
	FROM Custinfo CI WITH (NOLOCK)
		INNER JOIN Customer C WITH (NOLOCK) ON C.custid = CI.custid
		INNER JOIN dbo.DEP_StakeLevel sl WITH (NOLOCK) ON sl.GameTypeID = @BetType
								AND sl.GameGroupID = @GameGroupID
								AND sl.ExchangeId = c.currency
	WHERE ci.srecommend IN(SELECT CustID FROM #supers) 
	AND ci.roleid IN (2,3,4) AND Enabled = 1 AND ci.custid > @maxcustid 
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)
	UNION ALL 
	SELECT CI.custid, @sportTypeMini, @BetTypeMini, CAST(sl.StakeLevelID AS VARCHAR(100))
	FROM Custinfo CI WITH (NOLOCK)
		INNER JOIN Customer C WITH (NOLOCK) ON C.custid = CI.custid
		INNER JOIN dbo.DEP_StakeLevel sl WITH (NOLOCK) ON sl.GameTypeID = @BetTypeMini
								AND sl.GameGroupID = @GameGroupIDMini
								AND sl.ExchangeId = c.currency
	WHERE ci.srecommend IN (SELECT CustID FROM #supers)
	AND ci.roleid IN (2,3,4) AND Enabled = 1 AND ci.custid > @maxcustid 
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO dbo.Dep_CustStakeLevel_Agent  ([CustID],[SportType],[BetType],[StakeLevelList]) 
	SELECT   custid,Sporttype, Bettype, StakeLevelID
	FROM #SMATemp
	--Member Level
	INSERT INTO #MemberTemp  (CustID,Sporttype, Bettype, StakeLevelID) 
	SELECT CI.custid, @Sporttype, @BetType, CAST(sl.StakeLevelID	AS VARCHAR(100))
	FROM Custinfo CI WITH (NOLOCK)
		INNER JOIN Customer C WITH (NOLOCK) ON C.custid = CI.custid
		INNER JOIN dbo.DEP_StakeLevel sl WITH (NOLOCK) ON sl.GameTypeID = @BetType
								AND sl.GameGroupID = @GameGroupID
								AND sl.ExchangeId = c.currency
	WHERE ci.srecommend IN(SELECT CustID FROM #supers) AND ci.roleid IN (1) 
	AND Enabled = 1 AND ci.custid > @maxcustid AND CI.mrecommend NOT IN (SELECT custid FROM #Dummy)
	UNION ALL 
	SELECT CI.custid, @sportTypeMini, @BetTypeMini, CAST(sl.StakeLevelID	AS VARCHAR(100))
	FROM Custinfo CI WITH (NOLOCK)
		INNER JOIN Customer C WITH (NOLOCK) ON C.custid = CI.custid
		INNER JOIN dbo.DEP_StakeLevel sl WITH (NOLOCK) ON sl.GameTypeID = @BetTypeMini
								AND sl.GameGroupID = @GameGroupIDMini
								AND sl.ExchangeId = c.currency
	WHERE ci.srecommend IN(SELECT CustID FROM #supers) AND ci.roleid IN (1) 
	AND Enabled = 1 AND ci.custid > @maxcustid AND CI.mrecommend NOT IN (SELECT custid FROM #Dummy)
	
	DECLARE @Cust_Temp TABLE(CustID INT, Sporttype INT, Bettype INT, StakeLevelID VARCHAR(100))
	DECLARE @BatchSize SMALLINT = 5000
	
	WHILE(1 =1)
	BEGIN
		UPDATE TOP (@BatchSize) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype,DELETED.StakeLevelID INTO @Cust_Temp(CustID,Sporttype,Bettype,StakeLevelID)
		FROM #MemberTemp c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0
		BEGIN 
			BREAK
		END 	
			
		INSERT INTO dbo.Dep_CustStakeLevel_Member([CustID]
										   ,[SportType]
										   ,[BetType]
										   ,[StakeLevelList]
										   ,LastUpdated) 
		SELECT CustID , SportType,BetType,StakeLevelID as [StakeLevelList],GETDATE() as LastUpdated
		FROM @Cust_Temp	
		
		DELETE FROM @Cust_Temp
	END
	
	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT t.custid,100
	FROM #supers t
	WHERE t.custid>@maxcustid	
		AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting a WITH(NOLOCK) WHERE a.CustID=t.custid AND a.ProductSettingID=100)
	UNION ALL
	SELECT t.custid,106
	FROM #supers t
	WHERE t.custid>@maxcustid	
		AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting a WITH(NOLOCK) WHERE a.CustID=t.custid AND a.ProductSettingID=106)
	--------------------------------------------Enable Status--------------------------------------------------
	CREATE TABLE #AllUsers (CustID int PRIMARY KEY)
	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32),isfinished BIT DEFAULT(0))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	CREATE TABLE #Dep_NotExistsStatus(CustID INT PRIMARY KEY,bitmapIsHidden BINARY(32), bitmapIsDisabled BINARY(32))

	INSERT INTO #AllUsers (CustID)
	SELECT DISTINCT SMA.CustID FROM #SMATemp SMA WITH (NOLOCK)
	UNION 
	SELECT DISTINCT M.CustID FROM #MemberTemp M WITH (NOLOCK)

	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	SELECT DISTINCT c.CustID
		,bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsHidden,@BitOrderMini,0))
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsDisabled,@BitOrderMini,0))
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  #SMATemp temp ON temp.CustID = c.custid
	UNION ALL
	SELECT DISTINCT c.CustID
		,bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsHidden,@BitOrderMini,0))
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsDisabled,@BitOrderMini,0))
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  #MemberTemp temp ON temp.CustID = c.custid
	
	UPDATE c 
	SET bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsHidden,@BitOrder,0))
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsDisabled,@BitOrder,0))
	FROM #Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
		INNER JOIN Customer Ci WITH (NOLOCK) ON C.custid = Ci.custid
	WHERE ci.srecommend IN(SELECT custid FROM #supers)

	SET @BatchSize = 5000
	WHILE 1 = 1 
	BEGIN
		TRUNCATE TABLE #TempProductStatus

		UPDATE TOP (@BatchSize) a WITH (ROWLOCK)
		SET a.isfinished = 1
		OUTPUT DELETED.CustID,DELETED.bitmapIsHidden,DELETED.bitmapIsDisabled INTO #TempProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
		FROM #Dep_CustProductStatus a 
		WHERE a.isfinished = 0
		 
		IF @@ROWCOUNT = 0 
			BREAK;

		UPDATE c 
		SET  c.bitmapIsHidden = tmp.bitmapIsHidden
			,c.bitmapIsDisabled = tmp.bitmapIsDisabled
		FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
			INNER JOIN #TempProductStatus tmp ON c.CustID = tmp.CustID

		WAITFOR DELAY '00:00:00.100'
	END

	INSERT INTO #Dep_NotExistsStatus (CustID,bitmapIsDisabled,bitmapIsHidden)
	SELECT	A.custid
			, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrderMini,0) AS bitmapIsDisabled
			, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrderMini,0)  AS bitmapIsHidden
	FROM #AllUsers A
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = A.CustID)

	UPDATE c 
	SET bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsHidden,@BitOrder,0))
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsDisabled,@BitOrder,0))
	FROM #Dep_NotExistsStatus c WITH(ROWLOCK, UPDLOCK)
		INNER JOIN Customer Ci WITH (NOLOCK) ON C.custid = Ci.custid
	WHERE ci.srecommend IN(SELECT custid FROM #supers)

	INSERT INTO Dep_CustProductStatus (CustID,bitmapIsDisabled,bitmapIsHidden)
	SELECT	A.custid
			, A.bitmapIsDisabled
			, A.bitmapIsHidden
	FROM #Dep_NotExistsStatus A WITH (NOLOCK)

	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT t.custid,98
	FROM #supers t
	WHERE t.custid>@maxcustid	
		AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting a WITH(NOLOCK) WHERE a.CustID=t.custid AND a.ProductSettingID=98)
	UNION ALL
	SELECT t.custid,104
	FROM #supers t
	WHERE t.custid>@maxcustid	
		AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting a WITH(NOLOCK) WHERE a.CustID=t.custid AND a.ProductSettingID=104)

	DROP TABLE #supers
	DROP TABLE #Dummy
	DROP TABLE #MemberTemp
	DROP TABLE #SMATemp
	DROP TABLE #Dep_CustProductStatus
	DROP TABLE #TempProductStatus
	DROP TABLE #Dep_NotExistsStatus
	DROP TABLE #AllUsers
	PRINT N'Step 5: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

