/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220907
	Task:  Insert Betlimit for Bitcoin - deposit RedmineID:#159039
	DB: DBCUST/CustDB
	
	P/s : Step 4 Insert Betlimit for Bitcoin
*/
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@CustIDs VARCHAR(MAX) 	= ''
	,@srecommend INT
 	,@RoleID INT = 0
 	,@currency INT
 	,@BitOrder INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbtrans only
	
	IF (dbo.f_CheckRepTable('Dep_CustSettingMode') = 0
		
		OR dbo.f_CheckRepTable('Dep_ProductSetting') = 0
		OR dbo.f_CheckRepTable('Dep_ProductSettingDetail') = 0
		OR dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 
		OR dbo.f_CheckRepTable('CustInfo') = 0 
		OR dbo.f_CheckRepTable('Customer') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 
		OR dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 
	    OR dbo.f_CheckRepTable('Dep_ProductStatusProfile') = 0 
	   )
		RETURN

	CREATE TABLE #CustList (CustID INT PRIMARY KEY,isfinished BIT DEFAULT(0))
	CREATE TABLE #CustListTemp (CustID INT PRIMARY KEY)
			    
	INSERT INTO #CustList(custid)	
	SELECT value
	FROM STRING_SPLIT(@CustIDs,',')
	WHERE value <> ''
	
	DECLARE @batch SMALLINT = 2500
	DECLARE @SportBetType TABLE
	(
		SportType SMALLINT, 
		BetType   SMALLINT,
		StakeLevelID INT
	)
	INSERT INTO @SportBetType(SportType, BetType) 
	VALUES (175, 7901)	

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
	SELECT 72 AS Currency ,50 AS MinBet,10000 AS MaxBet,30000 AS MaxPerMatch,50 AS DefaultMinBet,10000 AS DefaultMaxBet,30000 AS DefaultMaxPerMatch    --YNG
		
	-------------------------------------Betlimit Setting----------------------------------------------
	-- SMA LEVEL
	IF @RoleID <>1
	BEGIN
		WHILE(1 =1)
		BEGIN
			
			UPDATE TOP (@batch) c WITH (ROWLOCK)
			SET c.isfinished = 1
			OUTPUT DELETED.CustID INTO #CustListTemp(CustID)
			FROM #CustList c 
			WHERE isfinished = 0
			
			IF @@ROWCOUNT = 0 BREAK
			-------------------------------------Betlimit Setting----------------------------------------------
			INSERT INTO Dep_CustBetSetting_Agent(
				CustID
				,SportType
				,BetType
				,MinBet
				,MaxBet
				,MaxPerMatch)
			SELECT t.CustID,b.SportType,b.BetType,b.SMAMinBet,b.SMAMaxBet,b.SMAMaxPerMatch
			FROM #CustListTemp t WITH(NOLOCK)
				CROSS APPLY #ProductBetSetting b
			WHERE b.Currency = @Currency

			TRUNCATE TABLE #CustListTemp
		END
	END	
	
	IF @RoleID  = 1
	BEGIN
		WHILE(1 = 1)
		BEGIN
			
			UPDATE TOP (@batch) c WITH (ROWLOCK)
			SET c.isfinished = 1
			OUTPUT DELETED.CustID INTO #CustListTemp(CustID)
			FROM #CustList c 
			WHERE isfinished = 0
			
			IF @@ROWCOUNT = 0 BREAK
			
			-------------------------------------Betlimit Setting----------------------------------------------
			INSERT INTO Dep_CustBetSetting_Member(
				 CustID
				,SportType
				,BetType
				,MinBet
				,MaxBet
				,MaxPerMatch
			)
			SELECT t.CustID,b.SportType,b.BetType,b.MinBet,b.MaxBet,b.MaxPerMatch
			FROM #CustListTemp t WITH(NOLOCK)
				CROSS APPLY #ProductBetSetting b
			WHERE b.Currency = @Currency		
			TRUNCATE TABLE #CustListTemp
		END 	
	END

	--------------------------------------------Enable Status--------------------------------------------------
CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))

	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,@BitOrder,0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,@BitOrder,0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  #CustList temp ON temp.CustID = c.custid

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
	FROM #CustList A WITH (NOLOCK)
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = A.CustID)

	DROP TABLE #Dep_CustProductStatus
	DROP TABLE #TempProductStatus
	DROP TABLE #CustList
	DROP TABLE #CustListTemp
	DROP TABLE #ProductBetSetting
END
GO
-- END STEP 4: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 4: Run this SP at replicated DB: DB06, DBTP -----
--------------------------------------------------------------------------------------
PRINT N'Step 4: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
		DROP TABLE	#supers;

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

CREATE TABLE #supers			(CustID INT PRIMARY KEY, Currency INT, isfinished BIT DEFAULT(0))
CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)	
CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY CLUSTERED,srecommend INT,isfinished BIT DEFAULT(0))
CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY CLUSTERED,srecommend INT,RoleID INT,isfinished BIT DEFAULT(0))

CREATE TABLE #tmpCustTemp		(CustID INT PRIMARY KEY)
CREATE TABLE #tmpSMATemp		(CustID INT PRIMARY KEY)

DECLARE @batch SMALLINT = 5000
DECLARE @CustIDs VARCHAR(MAX)
DECLARE @max_custid INT, @srecommend INT, @currency INT , @Role SMALLINT = 0
SELECT @max_custid = xxx

INSERT INTO #supers(custid,Currency)
SELECT ci.custid,ci.currency
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND cs.site IN('ZhiFeng255','JIB88','GESAB','Mayayule','CGame4','ZhiFeng201','GoldenFCV','DawooCV','FLCSW','iBET','vnggame','Million','erhaozhan','vssports','ug396','VCBA','OCMS','YYHbet','442ball','zt828','CloudRock','W88','n88clubSW','BBIN2','9wtest','yuanbaoCV','Ot88','ZhiFeng242','ZFRT129','QASite','PLAYES','NukeGaming','TGXICV','3Star88','bdtt','TSEnter','SGM88','ZhiFeng176','368Cash','wmcasinoS','365online','9wickets','PKbet','allwinCV','IDNSPORT','ZF055PMW','ABEMT','liv66SW','XmenSW','ZhiFeng221','ZhiFeng035','MTech','Lucklotter','INSERTGAME','SL88SW','0sServices','FKsport','WSlots','ZFRT242','633esports','Royal','ISC888','ALog','UG2','Soon88','88Macao','5ATech','Kingfun','Haifa','AEUG','HFYX','Winsplay','JJBGAME','ZhiFeng050','Tesla','GPIgame','DBP','Okada','Yibo','ZFRT080','NextBet','Happistar','ZhiFeng204','TGAA0813','Xiaojin','MICL','ECLBET','MYGAMECV','OBGM','Gampag','PINT','DTGJZ','Huangma','USSBET','Wcasino','GoldenF2CV','ROYAL88','ZFRT144CV','ZFRT219','TangChao','Tripleone','ZhiFeng262','IBO','WKPHIL','M88ASIA','lionsclub','livv88sw','ABcasino','TSLA','X2Dynamic','BigGaming','CandyA18','TCbet','DEWA','ZFRT165','LSM99','WINHX1','ID88','ZFRT175','DFGame','OYO','Xinli3CV','383sport','YSYBO688CV','ZhiFeng133','Happy8','HIDZ','ZF215CNY','VCBACV','BSSB168CV','Mybet88','Omni88','kbosportCV','WRSeamless','Uwoniwin','awc2','ZFRT259','e8casinoCV','NewFuture','WKCUR','VN88','B24VN','EclipseSW','Xtu168','CGame','ZFRT179','G4ALL','ZFRT155new','FHLMSABAS','ZhiFeng107','ZhiFeng032','Xinli2CV','ZFRT218','GoldenF2','VKGAMECV','GamingSoft','LIGAWLHKB','US8YAYOU','N8BK','IONclub','UGaming','Diamond','Xinbo','YakaGaming','XLMEDIA','dj888','FB88CV','368CashSW','BOG22','OPEBET','e8casino','DingTai','W88CV','BPLE','ZhiFeng012','Apollo369','TLC','Dawooxin','SDYSW','12bet','ZhiFeng009','OESports','Sunwin','AsiaBet88','SEAGaming','Riverich','Mayibet','ZhiFeng021','ig128','3ge888','Soon88CV','shengboyun','Bonanza88','loc','SampleSite','F88IN1SW','ZFRT126CV','bigbet','CENTRAL168','ZFRT132','VEGA77','bdtt2','Baji','ZhiFeng013','ZhiFeng183','Lode88','M8Credit','N8G','HY6','HBPT','SBObet','Bobo88','GmasterS','MARS','DongYing','beplay','ig128s','Leng4D','TYgaming','24AVIASL','JDJDAPI','9Club','WBS','ZF138VND','d3sports','ZhiFeng051','ZhiFeng222','OLE777CV','DCSDemo','ZhiFeng019','ZhiFeng055','OSUSDT','golden8','Zhifeng215','Wanfang','568WinSW','ZFRT240','Asiasigma','ZhiFeng142','DDwin','ZhiFeng030','wmcasino','TYM2','ZFRT126','998bet','Dawoo','win365','JDYGaming','Aladdin99','Ole777','ZFRT167','luckybuy','Twowin','GBET','ZF138THB','Heaven','ZhiFeng266','hjccasino','khmerA2','ZFRT156','LLgaming','Mopgaming','GMASTER','N8B','skykey','infini88','Weiwei','Wcasino88','HC6YAYOU','STEBBCBI','7kplatform','Datang001','ZhiFeng040','Webet88','ZhiFeng116','ZFRT090','Kzing2','Sunriseb2b','Sky88','Peakk','MayibetCV','OXPLAY','GMDFD','Monaco','aws03','AJJCV','Betway','XTSB','MAX88','SENBKK','A1game','UNOGAMING','ANGbet','ZhiFeng147','Towin','Yintai','SunriseCV','ALPHA88','ZFRT159','YongBao','OGWLS','GoldenF','LEIHUO','Callmeboss','ZFRT186','Hejiyongle','ZhiFeng138','ZFRT158CV','txwl002','KUTECH','Vwin88','OneSports','XinliCV','TXJT','ZFRT152','mbxusdt','ZhiFeng208','568Win','SWDemo','JBO','Pay4d','Heji888','SEAL888','Rio66','mtegames','LUCKYBET','Happy1668','JUYOU','allwincity','AE88','WGAMING','Niu8gaming','ZhiFeng228','Xiaoxiang','ZhiFeng132','KZSW','PKKing','VWIN66','beplayCV','ZFRT213','OXbet','HonorW','pmwint','YiboCV','FB88','JUNBOVN','ARYA','Raisetech','AG','AKYL99','golden88','Winbox','baowang188','SAGAME88','Gaobet','X33Asia','ZFRT80GPGT','IGSW','Test0112','DF88','KSTECH2','Bigwiner','Zowin','C88bet','Hecbet','18Luck','AOGcasino','JIBET','MultiSL88','ZhiFeng122','XTDGT','KSTECH','Yunji','SM88','ABCGAME','dfbetCV','V9betSW','GAMEBee','directapi','MANBETX','TT128','Test1607','ZFRT263','ZFRT195','awc','TGXI','ZFRT166','MTechCV','NLDSports','Boma365','Wanbo','ZF133FIN2','Dade','ZhiFeng094','VKGAME','ACsports','ZhiFeng084','ZhiFeng248','AEUGSW','OkadaSW','Letian','Rakyat4DSW','NFBI','H1royal','AnvoFH','starsoccer','ZhiFeng036','De365','kgsports','oddstest','FLC','BSSB168','ZhiFeng253','ZTech','MYGAME','WINCLUB88','dghash','dghashCV','HL8','Barcelo9','Alphalota','GSCFTWCV','ZFRT115','GoToWin','ZhiFeng168','OCMSS','Mancity2','V03','24aviaCV','YSYBO688','GSCSW','Saba789','ZF215aTR','SWSite','ZFRT166SW','BWGaming','TWWIN','ZFRT144','Nexus','GB888CV','TSXJCV','SKY1688','N88','4300','SDY','JJBGAMECV','C7YOUXI','CMBSW','ZhiFeng223','ZF026','kbosports','ManCity','GLive','ZFRT155','WBG88','WLSTAR','Jiuyou','bmwbet','TaoCai','LegendWin','ECBet88','9w','HOT99','KingBet','24AVIA','BBIN3','KzingP88','DMsports','khmer','FHLMSABA','IGPTech','C7YOUXICV','ab6688','BGCV','yuanbao','TopGame','HOroyal','WABET','ZhiFeng200','Bet88CV','Titanbet','ZFRT161','RBCV','TH3','Sin88','WRServices')
ORDER BY ci.custid 

INSERT INTO #Dummy(CustID)
SELECT CustID FROM Customer WITH(NOLOCK) 
WHERE srecommend IN (SELECT CustID FROM #supers) AND roleid=3 
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
	AND custid<=@max_custid 

INSERT INTO #tmpCust(CustID,srecommend)
SELECT CustID, srecommend
FROM custInfo ci WITH(NOLOCK)
WHERE ci.srecommend IN (SELECT CustID FROM #supers) AND ci.custid<=@max_custid 
	AND roleid = 1 AND ci.Enabled=1	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

INSERT INTO #tmpSMA(CustID,RoleID,srecommend)
SELECT CustID,RoleID,srecommend
FROM custInfo ci WITH(NOLOCK)
WHERE ci.srecommend IN (SELECT CustID FROM #supers) AND ci.custid<=@max_custid 
	AND roleid IN(2,3,4) AND ci.Enabled=1 AND mrecommend NOT IN (SELECT custid FROM #Dummy)		

DECLARE @BitOrder INT 
SELECT @BitOrder= bitmapOrder FROM Dep_ProductStatusProfile WITH(NOLOCK) WHERE SportType = 175 AND Bettype = 7901 -- SportType

DECLARE @super_cnt INT, @index INT = 0 , @DoneSM BIT, @DoneAgent BIT 
SET @super_cnt = (SELECT COUNT(*) FROM #supers )
DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

SELECT @srecommend = 0 ,@DoneSM = 0 , @DoneAgent = 0

WHILE (1 = 1)
BEGIN
	SELECT @CustIDs = ''
	IF EXISTS(SELECT TOP 1 1 
				FROM #tmpSMA
				WHERE isfinished = 0 AND srecommend = @srecommend
				UNION 
				SELECT TOP 1 1 
				FROM #tmpCust
				WHERE isfinished = 0 AND srecommend = @srecommend
			)
	BEGIN
		 UPDATE TOP (@batch) a
		SET a.isfinished = 1
		OUTPUT INSERTED.CustID INTO #tmpSMATemp(CustID)	
		FROM #tmpSMA a	
		WHERE isfinished = 0 AND RoleID <>  2 AND srecommend = @srecommend
		
		IF @@ROWCOUNT = 0 SET @DoneSM = 1
		IF @DoneSM = 0
		BEGIN
		  SELECT @CustIDs = @CustIDs + cast(custid AS VARCHAR(10)) + ',' FROM #tmpSMATemp
		END
		ELSE
		BEGIN
			UPDATE TOP (@batch) a
			SET a.isfinished = 1
			OUTPUT INSERTED.CustID INTO #tmpSMATemp(CustID)	
			FROM #tmpSMA a	
			WHERE isfinished = 0 AND RoleID = 2 AND srecommend = @srecommend
			
			IF @@ROWCOUNT = 0 SET @DoneAgent = 1
			IF @DoneAgent = 0
			BEGIN
				SELECT @CustIDs = @CustIDs + cast(custid AS VARCHAR(10)) + ',' FROM #tmpSMATemp
				SELECT @Role = 2
			END
			ELSE
			BEGIN
				UPDATE TOP (@batch) a
				SET a.isfinished = 1
				OUTPUT INSERTED.CustID INTO #tmpCustTemp(CustID)	
				FROM #tmpCust a	
				WHERE isfinished = 0 AND srecommend = @srecommend
				IF @@ROWCOUNT = 0 BREAK
				SELECT @CustIDs = @CustIDs + cast(custid AS VARCHAR(10)) + ','	FROM #tmpCustTemp
				SELECT @Role = 1
			END
		END

		EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @CustIDs = @CustIDs, @RoleID = @Role,@currency =@currency, @BitOrder = @BitOrder, @srecommend = @srecommend,@target = @target
		
		TRUNCATE TABLE #tmpCustTemp
		TRUNCATE TABLE #tmpSMATemp
		WAITFOR DELAY '00:00:00.280'	
	END
	ELSE
	BEGIN
		UPDATE TOP (1) #supers
		SET isfinished = 1
			,@srecommend = custid
			,@currency = currency
			,@DoneSM = 0
			,@DoneAgent = 0	
			,@Role  = 0	
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK
		SET @index = @index + 1
		RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
		
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend, ProductSettingID 
		FROM Dep_ProductSetting dp WITH(NOLOCK) 
		WHERE dp.ProductID IN ( 113, 114 )
			AND dp.SettingType IN (4,2) -- Product Status, BetLimit
			AND NOT EXISTS (SELECT 1 FROM Dep_LicenseeProductSetting WITH (NOLOCK) WHERE CustID = @srecommend AND ProductSettingID = dp.ProductSettingID)
	   END
END	

DROP TABLE #supers	
DROP TABLE #Dummy
DROP TABLE #tmpCust
DROP TABLE #tmpSMA
DROP TABLE #tmpCustTemp
DROP TABLE #tmpSMATemp	
GO
PRINT N'Step 4: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
