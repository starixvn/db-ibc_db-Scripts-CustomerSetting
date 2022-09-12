/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 20220907
	Task:	 Delete redundant and add new setting newly created customer for Bitcoin RedmineID:#159039
	DB:		 DBCUST/CustDB
	P/s : Step 6 Delete redundant and add new setting newly created customer Bitcoin
*/
USE [CustDB]
GO
-----------------------------------------------------
	PRINT N'Step 6: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
	DECLARE @maxcustid INT
	SELECT @maxcustid = xxx
	DECLARE @SportType SMALLINT = 175,@betType SMALLINT = 7901
	DECLARE @BitOrder INT 

	SELECT @BitOrder= bitmapOrder 
	FROM Dep_ProductStatusProfile WITH(NOLOCK) 
	WHERE SportType=@Sporttype	
	
	CREATE TABLE #supers (custid int)

	CREATE TABLE #Member
	(
		CustID INT PRIMARY KEY CLUSTERED
	   ,Currency INT
	   ,InsBetSetting BIT DEFAULT 0
	   ,mrecommend INT
	)
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

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'
		AND ci.Enabled=1
		AND cs.site IN('ZhiFeng255','JIB88','GESAB','Mayayule','CGame4','ZhiFeng201','GoldenFCV','DawooCV','FLCSW','iBET','vnggame','Million','erhaozhan','vssports','ug396','VCBA','OCMS','YYHbet','442ball','zt828','CloudRock','W88','n88clubSW','BBIN2','9wtest','yuanbaoCV','Ot88','ZhiFeng242','ZFRT129','QASite','PLAYES','NukeGaming','TGXICV','3Star88','bdtt','TSEnter','SGM88','ZhiFeng176','368Cash','wmcasinoS','365online','9wickets','PKbet','allwinCV','IDNSPORT','ZF055PMW','ABEMT','liv66SW','XmenSW','ZhiFeng221','ZhiFeng035','MTech','Lucklotter','INSERTGAME','SL88SW','0sServices','FKsport','WSlots','ZFRT242','633esports','Royal','ISC888','ALog','UG2','Soon88','88Macao','5ATech','Kingfun','Haifa','AEUG','HFYX','Winsplay','JJBGAME','ZhiFeng050','Tesla','GPIgame','DBP','Okada','Yibo','ZFRT080','NextBet','Happistar','ZhiFeng204','TGAA0813','Xiaojin','MICL','ECLBET','MYGAMECV','OBGM','Gampag','PINT','DTGJZ','Huangma','USSBET','Wcasino','GoldenF2CV','ROYAL88','ZFRT144CV','ZFRT219','TangChao','Tripleone','ZhiFeng262','IBO','WKPHIL','M88ASIA','lionsclub','livv88sw','ABcasino','TSLA','X2Dynamic','BigGaming','CandyA18','TCbet','DEWA','ZFRT165','LSM99','WINHX1','ID88','ZFRT175','DFGame','OYO','Xinli3CV','383sport','YSYBO688CV','ZhiFeng133','Happy8','HIDZ','ZF215CNY','VCBACV','BSSB168CV','Mybet88','Omni88','kbosportCV','WRSeamless','Uwoniwin','awc2','ZFRT259','e8casinoCV','NewFuture','WKCUR','VN88','B24VN','EclipseSW','Xtu168','CGame','ZFRT179','G4ALL','ZFRT155new','FHLMSABAS','ZhiFeng107','ZhiFeng032','Xinli2CV','ZFRT218','GoldenF2','VKGAMECV','GamingSoft','LIGAWLHKB','US8YAYOU','N8BK','IONclub','UGaming','Diamond','Xinbo','YakaGaming','XLMEDIA','dj888','FB88CV','368CashSW','BOG22','OPEBET','e8casino','DingTai','W88CV','BPLE','ZhiFeng012','Apollo369','TLC','Dawooxin','SDYSW','12bet','ZhiFeng009','OESports','Sunwin','AsiaBet88','SEAGaming','Riverich','Mayibet','ZhiFeng021','ig128','3ge888','Soon88CV','shengboyun','Bonanza88','loc','SampleSite','F88IN1SW','ZFRT126CV','bigbet','CENTRAL168','ZFRT132','VEGA77','bdtt2','Baji','ZhiFeng013','ZhiFeng183','Lode88','M8Credit','N8G','HY6','HBPT','SBObet','Bobo88','GmasterS','MARS','DongYing','beplay','ig128s','Leng4D','TYgaming','24AVIASL','JDJDAPI','9Club','WBS','ZF138VND','d3sports','ZhiFeng051','ZhiFeng222','OLE777CV','DCSDemo','ZhiFeng019','ZhiFeng055','OSUSDT','golden8','Zhifeng215','Wanfang','568WinSW','ZFRT240','Asiasigma','ZhiFeng142','DDwin','ZhiFeng030','wmcasino','TYM2','ZFRT126','998bet','Dawoo','win365','JDYGaming','Aladdin99','Ole777','ZFRT167','luckybuy','Twowin','GBET','ZF138THB','Heaven','ZhiFeng266','hjccasino','khmerA2','ZFRT156','LLgaming','Mopgaming','GMASTER','N8B','skykey','infini88','Weiwei','Wcasino88','HC6YAYOU','STEBBCBI','7kplatform','Datang001','ZhiFeng040','Webet88','ZhiFeng116','ZFRT090','Kzing2','Sunriseb2b','Sky88','Peakk','MayibetCV','OXPLAY','GMDFD','Monaco','aws03','AJJCV','Betway','XTSB','MAX88','SENBKK','A1game','UNOGAMING','ANGbet','ZhiFeng147','Towin','Yintai','SunriseCV','ALPHA88','ZFRT159','YongBao','OGWLS','GoldenF','LEIHUO','Callmeboss','ZFRT186','Hejiyongle','ZhiFeng138','ZFRT158CV','txwl002','KUTECH','Vwin88','OneSports','XinliCV','TXJT','ZFRT152','mbxusdt','ZhiFeng208','568Win','SWDemo','JBO','Pay4d','Heji888','SEAL888','Rio66','mtegames','LUCKYBET','Happy1668','JUYOU','allwincity','AE88','WGAMING','Niu8gaming','ZhiFeng228','Xiaoxiang','ZhiFeng132','KZSW','PKKing','VWIN66','beplayCV','ZFRT213','OXbet','HonorW','pmwint','YiboCV','FB88','JUNBOVN','ARYA','Raisetech','AG','AKYL99','golden88','Winbox','baowang188','SAGAME88','Gaobet','X33Asia','ZFRT80GPGT','IGSW','Test0112','DF88','KSTECH2','Bigwiner','Zowin','C88bet','Hecbet','18Luck','AOGcasino','JIBET','MultiSL88','ZhiFeng122','XTDGT','KSTECH','Yunji','SM88','ABCGAME','dfbetCV','V9betSW','GAMEBee','directapi','MANBETX','TT128','Test1607','ZFRT263','ZFRT195','awc','TGXI','ZFRT166','MTechCV','NLDSports','Boma365','Wanbo','ZF133FIN2','Dade','ZhiFeng094','VKGAME','ACsports','ZhiFeng084','ZhiFeng248','AEUGSW','OkadaSW','Letian','Rakyat4DSW','NFBI','H1royal','AnvoFH','starsoccer','ZhiFeng036','De365','kgsports','oddstest','FLC','BSSB168','ZhiFeng253','ZTech','MYGAME','WINCLUB88','dghash','dghashCV','HL8','Barcelo9','Alphalota','GSCFTWCV','ZFRT115','GoToWin','ZhiFeng168','OCMSS','Mancity2','V03','24aviaCV','YSYBO688','GSCSW','Saba789','ZF215aTR','SWSite','ZFRT166SW','BWGaming','TWWIN','ZFRT144','Nexus','GB888CV','TSXJCV','SKY1688','N88','4300','SDY','JJBGAMECV','C7YOUXI','CMBSW','ZhiFeng223','ZF026','kbosports','ManCity','GLive','ZFRT155','WBG88','WLSTAR','Jiuyou','bmwbet','TaoCai','LegendWin','ECBet88','9w','HOT99','KingBet','24AVIA','BBIN3','KzingP88','DMsports','khmer','FHLMSABA','IGPTech','C7YOUXICV','ab6688','BGCV','yuanbao','TopGame','HOroyal','WABET','ZhiFeng200','Bet88CV','Titanbet','ZFRT161','RBCV','TH3','Sin88','WRServices')

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

	INSERT INTO #Member(CustID,mrecommend,Currency)
	SELECT custid, mrecommend,Currency
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 1  AND Enabled = 1 AND custid > @maxcustID	
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	--DELETE existing data

	CREATE TABLE #ProductBetSetting (Currency INT,MinBet	MONEY,MaxBet	MONEY,MaxPerMatch	MONEY,
									SMAMinBet	MONEY,SMAMaxBet	MONEY,SMAMaxPerMatch	MONEY, Sporttype INT DEFAULT(175), Bettype INT DEFAULT(7901))
					
	INSERT INTO #ProductBetSetting(Currency,MinBet,MaxBet,MaxPerMatch,SMAMinBet,SMAMaxBet,SMAMaxPerMatch)
	SELECT 2 AS Currency ,5 AS MinBet,1000 AS MaxBet,3000 AS MaxPerMatch,5 AS DefaultMinBet,1000 AS DefaultMaxBet,3000 AS DefaultMaxPerMatch  Union ALL --RM
	SELECT 3 AS Currency ,3 AS MinBet,300 AS MaxBet,900 AS MaxPerMatch,3 AS DefaultMinBet,300 AS DefaultMaxBet,900 AS DefaultMaxPerMatch  Union ALL --US$
	SELECT 4 AS Currency ,100 AS MinBet,8000 AS MaxBet,24000 AS MaxPerMatch,100 AS DefaultMinBet,8000 AS DefaultMaxBet,24000 AS DefaultMaxPerMatch  Union ALL --TB
	SELECT 5 AS Currency ,10 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,10 AS DefaultMinBet,2000 AS DefaultMaxBet,6000 AS DefaultMaxPerMatch  Union ALL --HK$
	SELECT 6 AS Currency ,2 AS MinBet,200 AS MaxBet,600 AS MaxPerMatch,2 AS DefaultMinBet,200 AS DefaultMaxBet,600 AS DefaultMaxPerMatch  Union ALL --EURO
	SELECT 7 AS Currency ,25000 AS MinBet,5000000 AS MaxBet,15000000 AS MaxPerMatch,25000 AS DefaultMinBet,5000000 AS DefaultMaxBet,15000000 AS DefaultMaxPerMatch  Union ALL --DON
	SELECT 9 AS Currency ,3 AS MinBet,300 AS MaxBet,900 AS MaxPerMatch,3 AS DefaultMinBet,300 AS DefaultMaxBet,900 AS DefaultMaxPerMatch  Union ALL --AUD
	SELECT 12 AS Currency ,2 AS MinBet,200 AS MaxBet,600 AS MaxPerMatch,2 AS DefaultMinBet,200 AS DefaultMaxBet,600 AS DefaultMaxPerMatch  Union ALL --GBP
	SELECT 13 AS Currency ,10 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,10 AS DefaultMinBet,2000 AS DefaultMaxBet,6000 AS DefaultMaxPerMatch  Union ALL --RMB
	SELECT 15 AS Currency ,25 AS MinBet,4000 AS MaxBet,12000 AS MaxPerMatch,25 AS DefaultMinBet,4000 AS DefaultMaxBet,12000 AS DefaultMaxPerMatch  Union ALL --IN
	SELECT 32 AS Currency ,250 AS MinBet,25000 AS MaxBet,75000 AS MaxPerMatch,250 AS DefaultMinBet,25000 AS DefaultMaxBet,75000 AS DefaultMaxPerMatch  Union ALL --JPY
	SELECT 41 AS Currency ,2 AS MinBet,200 AS MaxBet,600 AS MaxPerMatch,2 AS DefaultMinBet,200 AS DefaultMaxBet,600 AS DefaultMaxPerMatch  Union ALL --CHF
	SELECT 42 AS Currency ,120 AS MinBet,12000 AS MaxBet,36000 AS MaxPerMatch,120 AS DefaultMinBet,12000 AS DefaultMaxBet,36000 AS DefaultMaxPerMatch  Union ALL --PE
	SELECT 45 AS Currency ,2500 AS MinBet,300000 AS MaxBet,900000 AS MaxPerMatch,2500 AS DefaultMinBet,300000 AS DefaultMaxBet,900000 AS DefaultMaxPerMatch  Union ALL --Won
	SELECT 46 AS Currency ,3 AS MinBet,300 AS MaxBet,900 AS MaxPerMatch,3 AS DefaultMinBet,300 AS DefaultMaxBet,900 AS DefaultMaxPerMatch  Union ALL --BND
	SELECT 47 AS Currency ,25 AS MinBet,4000 AS MaxBet,12000 AS MaxPerMatch,25 AS SuperMinBet,4000 AS SuperMaxBet,12000 AS SuperMaxPerMatch  Union ALL --DDD
	SELECT 49 AS Currency ,45 AS MinBet,4000 AS MaxBet,12000 AS MaxPerMatch,45 AS DefaultMinBet,4000 AS DefaultMaxBet,12000 AS DefaultMaxPerMatch  Union ALL --MXN
	SELECT 50 AS Currency ,3 AS MinBet,300 AS MaxBet,900 AS MaxPerMatch,3 AS DefaultMinBet,300 AS DefaultMaxBet,900 AS DefaultMaxPerMatch  Union ALL --CAN
	SELECT 51 AS Currency ,25 AS MinBet,5000 AS MaxBet,15000 AS MaxPerMatch,25 AS DefaultMinBet,5000 AS DefaultMaxBet,15000 AS DefaultMaxPerMatch  Union ALL --INH
	SELECT 52 AS Currency ,15 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,15 AS DefaultMinBet,2000 AS DefaultMaxBet,6000 AS DefaultMaxPerMatch  Union ALL --DKK
	SELECT 53 AS Currency ,15 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,15 AS DefaultMinBet,2000 AS DefaultMaxBet,6000 AS DefaultMaxPerMatch  Union ALL --SEK
	SELECT 54 AS Currency ,15 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,15 AS DefaultMinBet,2000 AS DefaultMaxBet,6000 AS DefaultMaxPerMatch  Union ALL --NOK
	SELECT 55 AS Currency ,175 AS MinBet,18000 AS MaxBet,54000 AS MaxPerMatch,175 AS DefaultMinBet,18000 AS DefaultMaxBet,54000 AS DefaultMaxPerMatch  Union ALL --RUB
	SELECT 56 AS Currency ,10 AS MinBet,1000 AS MaxBet,3000 AS MaxPerMatch,10 AS DefaultMinBet,1000 AS DefaultMaxBet,3000 AS DefaultMaxPerMatch  Union ALL --PLN
	SELECT 57 AS Currency ,50 AS MinBet,5000 AS MaxBet,15000 AS MaxPerMatch,50 AS DefaultMinBet,5000 AS DefaultMaxBet,15000 AS DefaultMaxPerMatch  Union ALL --CZK
	SELECT 58 AS Currency ,10 AS MinBet,1000 AS MaxBet,3000 AS MaxPerMatch,10 AS DefaultMinBet,1000 AS DefaultMaxBet,3000 AS DefaultMaxPerMatch  Union ALL --RON
	SELECT 61 AS Currency ,100 AS MinBet,18000 AS MaxBet,54000 AS MaxPerMatch,100 AS DefaultMinBet,18000 AS DefaultMaxBet,54000 AS DefaultMaxPerMatch  Union ALL --INR
	SELECT 66 AS Currency ,10 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,10 AS DefaultMinBet,2000 AS DefaultMaxBet,6000 AS DefaultMaxPerMatch  Union ALL --YUN
	SELECT 70 AS Currency ,4 AS MinBet,360 AS MaxBet,1080 AS MaxPerMatch,4 AS DefaultMinBet,360 AS DefaultMaxBet,1080 AS DefaultMaxPerMatch  Union ALL --MKK
	SELECT 71 AS Currency ,10 AS MinBet,1000 AS MaxBet,3000 AS MaxPerMatch,10 AS DefaultMinBet,1000 AS DefaultMaxBet,3000 AS DefaultMaxPerMatch  Union ALL --KHR
	SELECT 73 AS Currency ,15 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,15 AS DefaultMinBet,2000 AS DefaultMaxBet,6000 AS DefaultMaxPerMatch  Union ALL --LIR
	SELECT 79 AS Currency ,250 AS MinBet,25000 AS MaxBet,75000 AS MaxPerMatch,250 AS DefaultMinBet,25000 AS DefaultMaxBet,75000 AS DefaultMaxPerMatch  Union ALL --KES
	SELECT 80 AS Currency ,10 AS MinBet,1000 AS MaxBet,3000 AS MaxPerMatch,10 AS DefaultMinBet,1000 AS DefaultMaxBet,3000 AS DefaultMaxPerMatch  Union ALL --GHS
	SELECT 82 AS Currency ,10 AS MinBet,1000 AS MaxBet,3000 AS MaxPerMatch,10 AS DefaultMinBet,1000 AS DefaultMaxBet,3000 AS DefaultMaxPerMatch  Union ALL --BRL
	SELECT 83 AS Currency ,1700 AS MinBet,170000 AS MaxBet,510000 AS MaxPerMatch,1700 AS DefaultMinBet,170000 AS DefaultMaxBet,510000 AS DefaultMaxPerMatch  Union ALL --CLP
	SELECT 85 AS Currency ,10 AS MinBet,1000 AS MaxBet,3000 AS MaxPerMatch,10 AS DefaultMinBet,1000 AS DefaultMaxBet,3000 AS DefaultMaxPerMatch  Union ALL --PEN
	SELECT 86 AS Currency ,200 AS MinBet,20000 AS MaxBet,60000 AS MaxPerMatch,200 AS DefaultMinBet,20000 AS DefaultMaxBet,60000 AS DefaultMaxPerMatch  Union ALL --ARS
	SELECT 92 AS Currency ,10 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,10 AS DefaultMinBet,2000 AS DefaultMaxBet,6000 AS DefaultMaxPerMatch  Union ALL --HID
	SELECT 93 AS Currency ,15 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,15 AS DefaultMinBet,2000 AS DefaultMaxBet,6000 AS DefaultMaxPerMatch  Union ALL --LAK
	SELECT 94 AS Currency ,4 AS MinBet,360 AS MaxBet,1080 AS MaxPerMatch,4 AS DefaultMinBet,360 AS DefaultMaxBet,1080 AS DefaultMaxPerMatch  Union ALL --MK
	SELECT 96 AS Currency ,3 AS MinBet,300 AS MaxBet,900 AS MaxPerMatch,3 AS DefaultMinBet,300 AS DefaultMaxBet,900 AS DefaultMaxPerMatch  Union ALL --USDT
	SELECT 97 AS Currency ,200 AS MinBet,20000 AS MaxBet,60000 AS MaxPerMatch,200 AS DefaultMinBet,20000 AS DefaultMaxBet,60000 AS DefaultMaxPerMatch  Union ALL --BDT
	SELECT 121 AS Currency ,350 AS MinBet,38000 AS MaxBet,114000 AS MaxPerMatch,350 AS DefaultMinBet,38000 AS DefaultMaxBet,114000 AS DefaultMaxPerMatch  Union ALL --PKR
	SELECT 122 AS Currency ,1000 AS MinBet,100000 AS MaxBet,300000 AS MaxPerMatch,1000 AS DefaultMinBet,100000 AS DefaultMaxBet,300000 AS DefaultMaxPerMatch  Union ALL --KZT
	SELECT 123 AS Currency ,250 AS MinBet,25000 AS MaxBet,75000 AS MaxPerMatch,250 AS DefaultMinBet,25000 AS DefaultMaxBet,75000 AS DefaultMaxPerMatch  Union ALL --NPR
	SELECT 20 AS Currency ,3 AS MinBet,600 AS MaxBet,1800 AS MaxPerMatch,3 AS DefaultMinBet,600 AS DefaultMaxBet,1800 AS DefaultMaxPerMatch  Union ALL --UUS
	SELECT 72 AS Currency ,50 AS MinBet,10000 AS MaxBet,30000 AS MaxPerMatch,50 AS DefaultMinBet,10000 AS DefaultMaxBet,30000 AS DefaultMaxPerMatch	  --YNG
		
	-------------------------------------------------BetSetting----------------------------------------------------------------

	SELECT a.CustID,a.SportType,a.BetType 
	INTO #Dep_CustBetSetting_Agent
	FROM Dep_CustBetSetting_Agent a WITH(NOLOCK) 
		INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.CustID = ci.custid
	WHERE SportType = @SportType AND BetType = @betType

	DELETE cg
	FROM Dep_CustBetSetting_Agent cg WITH(ROWLOCK,UPDLOCK)
		INNER  JOIN #Dep_CustBetSetting_Agent t
			ON cg.CustID=t.CustID	AND cg.SportType=t.SportType AND cg.BetType=t.Bettype 

	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustBetSetting_Member 
	FROM Dep_CustBetSetting_Member a WITH(NOLOCK) 
		INNER JOIN #Member ci WITH(NOLOCK) ON a.CustID = ci.custid
	WHERE SportType = @SportType AND BetType = @betType	
	
	DELETE cg
	FROM Dep_CustBetSetting_Member cg WITH(ROWLOCK,UPDLOCK)
		INNER  JOIN #Dep_CustBetSetting_Member t
			ON cg.CustID=t.CustID AND cg.SportType=t.SportType AND cg.BetType=t.Bettype 
	
	SELECT dl.CustID,dl.ProductSettingID
	INTO #Dep_LicenseeProductSetting
	FROM Dep_LicenseeProductSetting dl WITH(NOLOCK)
			INNER JOIN Dep_ProductSetting dp WITH(NOLOCK) ON dl.ProductSettingID = dp.ProductSettingID
			INNER JOIN #SMATemp s ON dl.CustID = s.custid
	WHERE dp.ProductID = 69

	DELETE cg
	FROM Dep_LicenseeProductSetting cg WITH(ROWLOCK,UPDLOCK) 	
		INNER JOIN #Dep_LicenseeProductSetting t 
			ON cg.CustID=t.CustID	AND cg.ProductSettingID=t.ProductSettingID 
-------------------------------------------------Add new Betlimit Setting----------------------------------------------------------------
	INSERT INTO Dep_CustBetSetting_Agent(
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
	)
	SELECT t.CustID,b.SportType,b.BetType,b.SMAMinBet,b.SMAMaxBet,b.SMAMaxPerMatch
	FROM #SMATemp t WITH(NOLOCK)
		CROSS APPLY #ProductBetSetting b
	WHERE t.Currency = b.Currency	

	--Member Level
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #MemberTemp
		UPDATE TOP (3000)  t SET t.InsBetSetting = 1 OUTPUT DELETED.CustID,deleted.Currency INTO #MemberTemp(CustID,Currency) FROM #Member t WHERE t.InsBetSetting = 0

		IF @@ROWCOUNT=0
			BREAK

		INSERT INTO Dep_CustBetSetting_Member(
			 CustID
			,SportType
			,BetType
			,MinBet
			,MaxBet
			,MaxPerMatch
		)
		SELECT t.CustID,b.SportType,b.BetType,b.MinBet,b.MaxBet,b.MaxPerMatch
		FROM #MemberTemp t WITH(NOLOCK)
			CROSS APPLY #ProductBetSetting b
		WHERE b.Currency = t.Currency	
	END

	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT s.CustID,114
	FROM #SMATemp s WITH(NOLOCK)
	WHERE s.RoleID = 4 AND NOT EXISTS (SELECT 1 
	FROM Dep_LicenseeProductSetting D WITH(NOLOCK) 
	WHERE D.CustID=s.CustID AND d.ProductSettingID = 114)

	--------------------------------------------Enable Status--------------------------------------------------
	CREATE TABLE #AllUsers (CustID int PRIMARY KEY)
	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	INSERT INTO #AllUsers (CustID)
	SELECT DISTINCT SMA.CustID FROM #SMATemp SMA WITH (NOLOCK)
	UNION 
	SELECT DISTINCT M.CustID FROM #Member M WITH (NOLOCK)

	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,@BitOrder,0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,@BitOrder,0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  #SMATemp temp ON temp.CustID = c.custid
	UNION ALL
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,@BitOrder,0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,@BitOrder,0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  #Member temp ON temp.CustID = c.custid

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

		WAITFOR DELAY '00:00:00.100'
	END

	INSERT INTO Dep_CustProductStatus (CustID,bitmapIsDisabled,bitmapIsHidden)
	SELECT	A.custid
			, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0) AS bitmapIsDisabled
			, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0)  AS bitmapIsHidden
	FROM #AllUsers A WITH (NOLOCK)
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = A.CustID)

	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT s.CustID,113
	FROM #SMATemp s WITH(NOLOCK)
	WHERE s.RoleID = 4 AND NOT EXISTS (SELECT 1 
						FROM Dep_LicenseeProductSetting D WITH(NOLOCK) 
						WHERE D.CustID=s.CustID AND d.ProductSettingID = 113)

	DROP TABLE #supers
	DROP TABLE #Dummy
	DROP TABLE #MemberTemp
	DROP TABLE #SMATemp
	DROP TABLE #Dep_CustProductStatus
	DROP TABLE #TempProductStatus
	DROP TABLE #AllUsers