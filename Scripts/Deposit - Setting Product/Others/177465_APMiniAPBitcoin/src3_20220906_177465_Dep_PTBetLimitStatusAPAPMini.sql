/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220907
	Task:  Insert PT and Betlimit all Licensee for AdvantPlay & AdvantPlay Mini - deposit RedmineID:#177465
	DB: DBCUST/CustDB
	
	P/s : Step 3 Insert PT and Betlimit all Licensee for AdvantPlay & AdvantPlay Mini
*/
-- BEGIN STEP 3.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@CustIDs VARCHAR(MAX) 	= ''
	,@srecommend INT
 	,@RoleID INT = 0
 	,@StakeLevelID INT 
 	,@StakeLevelMiniID INT 
 	,@PT SMALLMONEY
 	,@BitOrder INT
 	,@BitOrderMini INT
 	,@IsAdvantPlay INT = 0
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('custInfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_custsuper') = 0 RETURN	 
	IF dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductStatusProfile') = 0 RETURN 
	
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
	INSERT INTO @SportBetType(SportType, BetType, StakeLevelID) 
	VALUES (174, 7801, @StakeLevelMiniID) -- AdvantPlay Mini

	IF @IsAdvantPlay = 1
	BEGIN
		INSERT INTO @SportBetType(SportType, BetType, StakeLevelID) 
		VALUES (172, 7701, @StakeLevelID) -- AdvantPlay
	END
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
			-------------------------------------PT Setting-----------------------------------------------
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
				   ,CASE WHEN @RoleID = 0 AND a.CustID = @srecommend THEN @PT ELSE 0 END AS SuperPT
				   ,CASE WHEN @RoleID = 0 THEN @PT ELSE 0 END AS MasterPT
				   ,CASE WHEN @RoleID = 2 OR a.CustID = @srecommend  THEN @PT ELSE 0 END AS AgentPT
			FROM #CustListTemp a WITH(NOLOCK)
				CROSS APPLY @SportBetType t
				
			--Agent Level
			IF @RoleID = 2
			BEGIN
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
					   ,@PT AS AgentPT
				FROM #CustListTemp a WITH(NOLOCK)
					CROSS APPLY @SportBetType t

			END 
			-------------------------------------Betlimit Setting----------------------------------------------
			INSERT INTO [dbo].[Dep_CustStakeLevel_Agent]
				   ([CustID]
				   ,[SportType]
				   ,[BetType]
				   ,[StakeLevelList])
			SELECT t.CustID, sp.sporttype, sp.BetType, sp.StakeLevelID
			FROM #CustListTemp t
				CROSS APPLY @SportBetType sp
			
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
			-------------------------------------PT Setting-----------------------------------------------
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
					a.CustID
				   ,t.SportType
				   ,t.BetType
				   ,0 AS IsLive
				   ,0 AS SuperPT
				   ,0 AS MasterPT
				   ,@PT AS AgentPT
			FROM #CustListTemp a WITH(NOLOCK)
				INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON m.CustID=a.CustID
				CROSS APPLY @SportBetType t
			WHERE m.IsGroupedPT=0

			INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
			SELECT t.CustID,1
			FROM #CustListTemp t WITH(NOLOCK) 
			WHERE NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode D WITH(NOLOCK) WHERE D.CustID=t.CustID)
				AND NOT EXISTS (SELECT 1 FROM Dep_CustBAActive BA WITH (NOLOCK) WHERE BA.CustId=t.CustID)
			-------------------------------------Betlimit Setting----------------------------------------------
			INSERT INTO [dbo].[Dep_CustStakeLevel_Member]
				   ([CustID]
				   ,[SportType]
				   ,[BetType]
				   ,[StakeLevelList]
				   ,[LastUpdated])
			SELECT CustID, sp.sporttype, sp.BetType, sp.StakeLevelID, GetDate()
			FROM #CustListTemp
			CROSS APPLY @SportBetType sp
		
			TRUNCATE TABLE #CustListTemp
		END 	
	END
	
	--------------------------------------------Enable Status--------------------------------------------------

	CREATE TABLE #Dep_CustProductStatus(CustID INT PRIMARY KEY,bitmapIsHidden BINARY(32), bitmapIsDisabled BINARY(32))
	CREATE TABLE #TempProductStatus(CustID INT PRIMARY KEY,bitmapIsHidden BINARY(32), bitmapIsDisabled BINARY(32))
	CREATE TABLE #Dep_NotExistsStatus(CustID INT PRIMARY KEY,bitmapIsHidden BINARY(32), bitmapIsDisabled BINARY(32))

	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsHidden,@BitOrderMini,0))
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsDisabled,@BitOrderMini,0))
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  #CustList temp ON temp.CustID = c.custid
	
	IF @IsAdvantPlay = 1
	BEGIN
		UPDATE c 
		SET bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsHidden,@BitOrder,0))
			,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsDisabled,@BitOrder,0))
		FROM #Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
	END

	WHILE (1 = 1) 
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

	INSERT INTO #Dep_NotExistsStatus (CustID,bitmapIsDisabled,bitmapIsHidden)
	SELECT	A.custid
			, (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrderMini,0)) AS bitmapIsDisabled
			, (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrderMini,0))  AS bitmapIsHidden
	FROM #CustList A WITH (NOLOCK)
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = A.CustID)

	IF @IsAdvantPlay = 1
	BEGIN
		UPDATE c 
		SET bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsHidden,@BitOrder,0))
			,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsDisabled,@BitOrder,0))
		FROM #Dep_NotExistsStatus c WITH(ROWLOCK, UPDLOCK)
	END

	INSERT INTO Dep_CustProductStatus (CustID,bitmapIsDisabled,bitmapIsHidden)
	SELECT	A.custid
			, A.bitmapIsDisabled
			, A.bitmapIsHidden
	FROM #Dep_NotExistsStatus A WITH (NOLOCK)

	DROP TABLE #CustList
	DROP TABLE #CustListTemp
	DROP TABLE #Dep_CustProductStatus
	DROP TABLE #TempProductStatus
END
GO
-- END STEP 3: DEPLOY THIS SP @ DBCUST.CustDB -------

-- BEGIN STEP 3: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  AND DBCUST (Run last) -----		
PRINT N'Step 3: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
		DROP TABLE	#supers;

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

CREATE TABLE #supers			(CustID INT PRIMARY KEY, Currency INT, IsAdvantPlay INT,isfinished bit default(0))
CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)	
CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY CLUSTERED,srecommend INT,isfinished BIT DEFAULT(0))
CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY CLUSTERED,srecommend INT,RoleID INT,isfinished BIT DEFAULT(0))

CREATE TABLE #tmpCustTemp		(CustID INT PRIMARY KEY)
CREATE TABLE #tmpSMATemp		(CustID INT PRIMARY KEY)

DECLARE @batch SMALLINT = 5000
DECLARE @CustIDs VARCHAR(MAX)
DECLARE @max_custid INT, @srecommend INT ,@PT smallmoney = 93.00 , @currency INT , @Role SMALLINT = 0 ,@IsAdvantPlay INT = 0
SELECT @max_custid = xxx

INSERT INTO #supers(custid,Currency,IsAdvantPlay)
SELECT ci.custid,ci.currency, CASE WHEN  Ci.currency IN (2,3,4,7,13,15,20,45,51,61,66,72,96) THEN 1 ELSE 0 END AS IsAdvantPlay
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND cs.site IN('ZhiFeng255','JIB88','GESAB','Mayayule','CGame4','ZhiFeng201','FLCSW','iBET','vnggame','Million','erhaozhan','vssports','ug396','VCBA','OCMS','YYHbet','442ball','zt828','CloudRock','W88','n88clubSW','BBIN2','9wtest','Ot88','ZhiFeng242','ZFRT129','QASite','PLAYES','NukeGaming','3Star88','bdtt','TSEnter','SGM88','ZhiFeng176','368Cash','wmcasinoS','365online','9wickets','PKbet','IDNSPORT','ZF055PMW','ABEMT','liv66SW','XmenSW','ZhiFeng221','ZhiFeng035','MTech','Lucklotter','INSERTGAME','SL88SW','0sServices','FKsport','WSlots','ZFRT242','633esports','Royal','ISC888','ALog','UG2','Soon88','88Macao','5ATech','Kingfun','Haifa','AEUG','HFYX','Winsplay','JJBGAME','ZhiFeng050','Tesla','GPIgame','DBP','Okada','Yibo','ZFRT080','NextBet','Happistar','ZhiFeng204','TGAA0813','Xiaojin','MICL','ECLBET','OBGM','Gampag','PINT','DTGJZ','Huangma','USSBET','Wcasino','ROYAL88','ZFRT219','TangChao','Tripleone','ZhiFeng262','IBO','WKPHIL','M88ASIA','lionsclub','livv88sw','ABcasino','TSLA','X2Dynamic','BigGaming','CandyA18','TCbet','DEWA','ZFRT165','LSM99','WINHX1','ID88','ZFRT175','DFGame','OYO','383sport','ZhiFeng133','Happy8','HIDZ','ZF215CNY','Mybet88','Omni88','WRSeamless','Uwoniwin','awc2','ZFRT259','NewFuture','WKCUR','VN88','B24VN','EclipseSW','Xtu168','CGame','ZFRT179','G4ALL','ZFRT155new','FHLMSABAS','ZhiFeng107','ZhiFeng032','ZFRT218','GoldenF2','GamingSoft','LIGAWLHKB','US8YAYOU','N8BK','IONclub','UGaming','Diamond','Xinbo','YakaGaming','XLMEDIA','dj888','368CashSW','BOG22','OPEBET','e8casino','DingTai','BPLE','ZhiFeng012','Apollo369','TLC','Dawooxin','SDYSW','12bet','ZhiFeng009','OESports','Sunwin','AsiaBet88','SEAGaming','Riverich','Mayibet','ZhiFeng021','ig128','3ge888','shengboyun','Bonanza88','loc','SampleSite','F88IN1SW','bigbet','CENTRAL168','ZFRT132','VEGA77','bdtt2','Baji','ZhiFeng013','ZhiFeng183','Lode88','M8Credit','N8G','HY6','HBPT','SBObet','Bobo88','GmasterS','MARS','DongYing','beplay','ig128s','Leng4D','TYgaming','24AVIASL','JDJDAPI','9Club','WBS','ZF138VND','d3sports','ZhiFeng051','ZhiFeng222','DCSDemo','ZhiFeng019','ZhiFeng055','OSUSDT','Zhifeng215','Wanfang','568WinSW','ZFRT240','Asiasigma','ZhiFeng142','DDwin','ZhiFeng030','wmcasino','TYM2','ZFRT126','998bet','Dawoo','win365','JDYGaming','Aladdin99','Ole777','ZFRT167','luckybuy','Twowin','GBET','ZF138THB','Heaven','ZhiFeng266','hjccasino','khmerA2','ZFRT156','LLgaming','Mopgaming','GMASTER','N8B','skykey','infini88','Weiwei','Wcasino88','HC6YAYOU','STEBBCBI','7kplatform','Datang001','ZhiFeng040','Webet88','ZhiFeng116','ZFRT090','Kzing2','Sunriseb2b','Sky88','Peakk','OXPLAY','GMDFD','Monaco','aws03','Betway','XTSB','MAX88','SENBKK','A1game','UNOGAMING','ANGbet','ZhiFeng147','Towin','Yintai','ALPHA88','ZFRT159','YongBao','OGWLS','GoldenF','LEIHUO','Callmeboss','ZFRT186','Hejiyongle','ZhiFeng138','txwl002','KUTECH','Vwin88','OneSports','TXJT','ZFRT152','mbxusdt','ZhiFeng208','568Win','SWDemo','JBO','Pay4d','Heji888','SEAL888','Rio66','mtegames','LUCKYBET','Happy1668','JUYOU','allwincity','AE88','WGAMING','Niu8gaming','ZhiFeng228','Xiaoxiang','ZhiFeng132','KZSW','PKKing','VWIN66','ZFRT213','OXbet','HonorW','pmwint','FB88','JUNBOVN','ARYA','Raisetech','AG','AKYL99','Winbox','baowang188','SAGAME88','Gaobet','X33Asia','ZFRT80GPGT','IGSW','Test0112','DF88','KSTECH2','Bigwiner','Zowin','C88bet','Hecbet','18Luck','AOGcasino','JIBET','MultiSL88','ZhiFeng122','XTDGT','KSTECH','Yunji','SM88','ABCGAME','V9betSW','GAMEBee','directapi','MANBETX','TT128','Test1607','ZFRT263','ZFRT195','awc','TGXI','ZFRT166','NLDSports','Boma365','Wanbo','ZF133FIN2','Dade','ZhiFeng094','VKGAME','ACsports','ZhiFeng084','ZhiFeng248','AEUGSW','OkadaSW','Letian','Rakyat4DSW','NFBI','H1royal','AnvoFH','starsoccer','ZhiFeng036','De365','kgsports','oddstest','FLC','BSSB168','ZhiFeng253','ZTech','MYGAME','WINCLUB88','dghash','HL8','Barcelo9','Alphalota','ZFRT115','GoToWin','ZhiFeng168','OCMSS','Mancity2','V03','YSYBO688','GSCSW','Saba789','ZF215aTR','SWSite','ZFRT166SW','BWGaming','TWWIN','ZFRT144','Nexus','SKY1688','N88','4300','SDY','C7YOUXI','CMBSW','ZhiFeng223','ZF026','kbosports','ManCity','GLive','ZFRT155','WBG88','WLSTAR','Jiuyou','bmwbet','TaoCai','LegendWin','ECBet88','9w','HOT99','KingBet','24AVIA','BBIN3','KzingP88','DMsports','khmer','FHLMSABA','IGPTech','ab6688','yuanbao','TopGame','HOroyal','WABET','ZhiFeng200','Titanbet','ZFRT161','TH3','Sin88','WRServices')
	  AND Ci.currency IN (2,3,4,5,6,7,12,13,15,20,32,45,46,49,51,55,56,61,66,70,71,72,79,80,82,83,85,86,92,93,94,96,97)
		--,RM,US$,TB,HK$,EURO,DON,GBP,RMB,IN,UUS,JPY,Won,BND,MXN,INH,RUB,PLN,INR,YUN,MKK,KHR,YNG,KES,GHS,BRL,CLP,PEN,ARS,HID,LAK,MK,USDT,BDT
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

DECLARE @BitOrder INT , @BitOrderMini INT
SELECT @BitOrder= bitmapOrder FROM Dep_ProductStatusProfile WITH(NOLOCK) WHERE SportType = 172 AND Bettype = 7701 -- SportType
SELECT @BitOrderMini= bitmapOrder FROM Dep_ProductStatusProfile WITH(NOLOCK) WHERE SportType = 174 AND Bettype = 7801 -- SportType

DECLARE @super_cnt INT, @index INT = 0 , @DoneSM BIT, @DoneAgent BIT 
DECLARE @StakeLevelID INT, @StakeLevelMiniID INT

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

		EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @CustIDs = @CustIDs, @RoleID = @Role, @StakeLevelID = @StakeLevelID, @StakeLevelMiniID = @StakeLevelMiniID, @PT = @PT, @BitOrder = @BitOrder,
				 @BitOrderMini = @BitOrderMini, @IsAdvantPlay = @IsAdvantPlay, @srecommend = @srecommend,@target = @target
		
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
			,@IsAdvantPlay = IsAdvantPlay
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK
		SET @index = @index + 1
		RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
		
		SELECT @StakeLevelID = StakeLevelID	
		FROM dbo.Dep_StakeLevel WITH(NOLOCK) 
		WHERE ExchangeID = @currency AND GameTypeID = 7701 AND GameGroupID = 28

		SELECT @StakeLevelMiniID = StakeLevelID	
		FROM dbo.Dep_StakeLevel WITH(NOLOCK) 
		WHERE ExchangeID = @currency AND GameTypeID = 7801 AND GameGroupID = 30
		
		SET @PT = 93.00	
		
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend, ProductSettingID 
		FROM Dep_ProductSetting dp WITH(NOLOCK) 
		WHERE dp.ProductID IN ( 67, 68 )
			AND dp.SettingType IN (4,1,8) -- Product Status, PT, StakeLevel
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
PRINT N'Step 3: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 