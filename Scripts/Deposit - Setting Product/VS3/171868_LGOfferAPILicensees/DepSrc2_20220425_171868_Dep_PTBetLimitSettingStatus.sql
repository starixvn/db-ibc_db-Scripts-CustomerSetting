/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220425
	Task: Insert PT and Betlimit for Leap Gaming Virtual Sports 3 - Deposit API Licensees [Redmine: 171868]
	DB: DBCUST/CustDB
	
	P/s : Step 2 Insert PT and Betlimit for Leap Gaming Virtual Sports 3 - Deposit API Licensees
*/
-- BEGIN STEP 2.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
-----------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	 @srecommend INT	
	, @max_custid INT
	, @target VARCHAR(20)
	
AS
BEGIN	
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbtrans only
	
	IF (dbo.f_CheckRepTable('Dep_CustSettingMode') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0
		
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
	
	CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)	
	CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY CLUSTERED,isfinished BIT DEFAULT(0))
	CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY CLUSTERED,RoleID INT,isfinished BIT DEFAULT(0))

	CREATE TABLE #tmpCustTemp		(CustID INT PRIMARY KEY)
	CREATE TABLE #tmpSMATemp		(CustID INT PRIMARY KEY ,RoleID INT)

	DECLARE @SportType SMALLINT = 231
	DECLARE @betType SMALLINT = 5301
	DECLARE @BitOrder INT 
	DECLARE @batch SMALLINT = 5000
	DECLARE @PT smallmoney = 88.00 

	DECLARE @Currency INT 
	SELECT @currency = ci.currency FROM dbo.custInfo ci WITH (NOLOCK) WHERE ci.custid = @srecommend
		
	SELECT @BitOrder= bitmapOrder 
	FROM Dep_ProductStatusProfile WITH(NOLOCK)   
	WHERE SportType=@Sporttype AND Bettype = @betType

	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend=@srecommend AND roleid=3 
		AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
		AND custid<=@max_custid 

	INSERT INTO #tmpCust(CustID)
	SELECT CustID
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend = @srecommend AND ci.custid<=@max_custid 
		AND roleid = 1 
		AND ci.Enabled=1
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	
	INSERT INTO #tmpSMA(CustID,RoleID)
	SELECT CustID,RoleID
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend = @srecommend AND ci.custid<=@max_custid 
		AND roleid IN(2,3,4)
		AND ci.Enabled=1
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)	

	DECLARE @SportBetType TABLE
	(
		SportType	SMALLINT, 
		BetType		SMALLINT,
		fSportType	SMALLINT,
		fBettype	SMALLINT, 
		MinBet		MONEY,
		MaxBet		MONEY
	)
	INSERT INTO @SportBetType(SportType, BetType, fSportType, fBettype, MinBet, MaxBet) 
	SELECT @SportType AS SportType, @betType AS BetType, 
		   180 AS fSportType,1201 AS fBettype,
		   a.MinBet , a.MaxBet
	FROM Dep_ProductBetSetting a  WITH(NOLOCK)
	WHERE a.Currency = @Currency AND a.Sporttype = @SportType AND a.Bettype = @betType

	-- SMA LEVEL
	WHILE(1 =1)
	BEGIN
		
		UPDATE TOP (@batch) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID,DELETED.RoleID INTO #tmpSMATemp(CustID,RoleID)
		FROM #tmpSMA c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK
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
				a.CustID
			   ,t.SportType
			   ,t.BetType
			   ,0 AS IsLive
			   ,CASE WHEN a.RoleID = 4 THEN @PT ELSE 0 END AS SuperPT
			   ,CASE WHEN a.RoleID IN (3,4) THEN @PT ELSE 0 END AS MasterPT
			   ,CASE WHEN a.RoleID IN (2,4) THEN @PT ELSE 0 END AS AgentPT
		FROM #tmpSMATemp a WITH(NOLOCK)
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
			   ,0
			   ,0
			   ,0
			   ,@PT AS AgentPT
		FROM #tmpSMATemp a WITH(NOLOCK)
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
				WHEN cs.MinBet <  b.MinBet THEN b.MinBet ELSE cs.MinBet END AS MinBet,
			CASE 
				WHEN (cs.MinBet = 0 AND (cs.MaxBet = 0 OR cs.MaxBet = 0.1)) THEN cs.MaxBet 
				WHEN cs.MaxBet >  b.MaxBet THEN b.MaxBet ELSE cs.MaxBet END AS MaxBet,	
			0 AS MaxPerMatch
			FROM #tmpSMATemp t WITH(NOLOCK)
				CROSS APPLY @SportBetType b 
				INNER JOIN Dep_CustBetSetting_Agent cs WITH (NOLOCK) ON cs.CustID = t.CustID AND b.fBetType = cs.BetType AND b.fSportType = cs.SportType
			UNION 
			SELECT t.CustID,b.SportType,b.BetType,b.MinBet,b.MaxBet, 0 AS MaxPerMatch
			FROM #tmpSMATemp t WITH(NOLOCK)
				CROSS APPLY @SportBetType b 
			WHERE NOT EXISTS(SELECT TOP 1 1 FROM Dep_CustBetSetting_Agent WITH(NOLOCK) WHERE Custid=t.CustID AND SportType = b.fSportType And BetType = b.fBetType)
			) KQ
			
		TRUNCATE TABLE #tmpSMATemp
	END
	--MEMBER LEVEL
	WHILE(1 =1)
	BEGIN
		
		UPDATE TOP (@batch) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID INTO #tmpCustTemp(CustID)
		FROM #tmpCust c 
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
			   ,0
			   ,0
			   ,0
			   ,@PT AS AgentPT
		FROM #tmpCustTemp a WITH(NOLOCK)
			INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON m.CustID=a.CustID
			CROSS APPLY @SportBetType t 
		WHERE m.IsGroupedPT=0

		INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
		SELECT t.CustID,1
		FROM #tmpCustTemp t WITH(NOLOCK) 
		WHERE NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode D WITH(NOLOCK) WHERE D.CustID=t.CustID)
			AND NOT EXISTS (SELECT 1 FROM Dep_CustBAActive BA WITH (NOLOCK) WHERE BA.CustId=t.CustID)
		-------------------------------------Betlimit Setting----------------------------------------------
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
				WHEN cs.MinBet <  b.MinBet THEN b.MinBet ELSE cs.MinBet END AS MinBet,
			CASE 
				WHEN (cs.MinBet = 0 AND (cs.MaxBet = 0 OR cs.MaxBet = 0.1)) THEN cs.MaxBet 
				WHEN cs.MaxBet >  b.MaxBet THEN b.MaxBet ELSE cs.MaxBet END AS MaxBet,	
			0 AS MaxPerMatch
			FROM #tmpCustTemp t WITH(NOLOCK)
				CROSS APPLY @SportBetType b 
				INNER JOIN Dep_CustBetSetting_Member cs WITH (NOLOCK) ON cs.CustID = t.CustID AND b.fBetType = cs.BetType AND b.fSportType = cs.SportType
			UNION 
			SELECT t.CustID,b.SportType,b.BetType,b.MinBet,b.MaxBet, 0 AS MaxPerMatch
			FROM #tmpSMATemp t WITH(NOLOCK)
				CROSS APPLY @SportBetType b 
			WHERE NOT EXISTS(SELECT TOP 1 1 FROM Dep_CustBetSetting_Member WITH(NOLOCK) WHERE Custid=t.CustID AND SportType = b.fSportType And BetType = b.fBetType)
			) KQ			
		TRUNCATE TABLE #tmpCustTemp
	END 	
	---------------------------------Check Licensee-----------------------------------------------------
	
	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID=124)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,124
	END
	
	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID=125)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,125
	END
	--------------------------------------------Enable Status--------------------------------------------------
	CREATE TABLE #AllUsers (CustID int PRIMARY KEY)
	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	INSERT INTO #AllUsers (CustID)
	SELECT DISTINCT SMA.CustID FROM #tmpSMA SMA WITH (NOLOCK)
	UNION 
	SELECT DISTINCT M.CustID FROM #tmpCust M WITH (NOLOCK)

	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsHidden,@BitOrder,0))
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsDisabled,@BitOrder,0))
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		CROSS APPLY @SportBetType t
		INNER JOIN  #tmpSMA temp ON temp.CustID = c.custid
	UNION ALL
	SELECT c.CustID
		,bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsHidden,@BitOrder,0))
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsDisabled,@BitOrder,0))
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		CROSS APPLY @SportBetType t
		INNER JOIN  #tmpCust temp ON temp.CustID = c.custid

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

	INSERT INTO Dep_CustProductStatus (CustID,bitmapIsDisabled,bitmapIsHidden)
	SELECT	A.custid
			, (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0)) AS bitmapIsDisabled
			, (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0))  AS bitmapIsHidden
	FROM #AllUsers A WITH (NOLOCK)
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = A.CustID)

	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) 
								WHERE Custid=@srecommend AND ProductSettingID=123)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,123
	END

	DROP TABLE #Dummy
	DROP TABLE #tmpCust
	DROP TABLE #tmpSMA
	DROP TABLE #Dep_CustProductStatus
	DROP TABLE #TempProductStatus
	DROP TABLE #AllUsers
END
GO
-- END STEP 2.1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 2.2: Run this SP at replicated DB: DB06, DBTP -----
--------------------------------------------------------------------------------------
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
DROP TABLE	#supers;
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND cs.site IN('12bet','ALog','Haifa','W88','3Star88','Ole777','Boma365','88Macao','AE88','368Cash','Royal','Senibet','Happy1668','AG','9Club','iBET','Liga','HonorW','DEWA','IBO','GamingSoft','DBP','Hecbet','HL8','ABcasino','365online','IONclub','Gampag','Mayayule','Huangma','Webet88','BigGaming','PKbet','CGame','VCBA','FLC','IGPTech','Dawoo','Uwoniwin','ECLBET','GPIgame','Bobo88','OPEBET','Sunriseb2b','Okada','Heaven','e8casino','TangChao','MAX88','YongBao','BBIN2','GMASTER','ALPHA88','Tripleone','11bet','MICL','9wickets','zt828','WBS','Yibo','FB88','Xinbo','Monaco','Opadmin','Bonanza88','JIBET','WINCLUB88','MARS','Dade','ANGbet','Callmeboss','One88','VWIN66','A1game','skykey','AEUG','18Luck','ig128','VN88','Zbet','Sin88','Sunwin','Gaobet','Five88','Raisetech','txwl002','DF88','GESAB','AnvoFH','WKPHIL','WKCUR','weicai','Leng4D','Xtu168','Mopgaming','TopGame','DingTai','BBIN3','INSERTGAME','ID88','B24VN','allwincity','BWGaming','KingBet','BOG22','Wanfang','24AVIA','KUTECH','WBG88','NewFuture','erhaozhan','MTech','Wanbo','568Win','shengboyun','Datang001','633esports','starsoccer','N88','hjccasino','OCMS','Lode88','Soon88','XTDGT','mtegames','Yunji','OneSports','TCbet','TaoCai','ZhiFeng032','Zowin','N8G','N8B','BPLE','ZhiFeng035','ZhiFeng036','ZhiFeng009','M8Credit','ZhiFeng012','MANBETX','wmcasino','Winbox','pmwint','ZhiFeng021','HC6YAYOU','TIC88','Sky88','Kbet','Dabet','AOGcasino','Hejiyongle','XO88','US8YAYOU','RICbet','OXbet','WABET','Kzing2','TSEnter','ZhiFeng046','Vwin88','TT128','N8BK','ManCity','ZhiFeng051','Mayibet','Alphalota','GAMEBee','SBObet','ZFRT125','Diamond','Saba789','bdtt','HOT99','BSSB168','OSUSDT','7kplatform','ZFRT128','ZhiFeng040','Bigwiner','win365','ZFRT132','MSbet','Baji','HY6','ZhiFeng030','SDY','ECBet88','Comebet','9w','3ge888','ZFRT127','ZFRT80GPGT','ZFRT125MGT','ZFRT144','MYGAME','FHLMSABA','LegendWin','UG2','ab6688','Mancity2','VEGA77','dj888','ZFRT155','Barcelo9','directapi','OYO','ZFRT156','LLgaming','Tesla','ZhiFeng083','Aladdin99','ZFRT166','ZFRT165','G4ALL','loc','ZFRT090','OBGM','Jiuyou','ZF055PMW','V03','TH3','LIGAWLHKB','ZFRT161','Towin','ZhiFeng132','TGXI','XTSB','ZhiFeng098','ZhiFeng138','HFYX','ZFRT179','KZO41','ZhiFeng147','HBPT','infini88','TGAA0813','Yintai','Rio66','ZFRT186','JJBGAME','VKGAME','Xiaojin','YakaGaming','Wcasino','Wcasino88','Letian','ZFRT195','ZFRT126','beplay','DTGJZ','WRServices','Million','NFBI','STEBBCBI','383sport','ZF138THB','ZhiFeng178','Titanbet','ZhiFeng183','Xiaoxiang','ZhiFeng013','ZhiFeng019','H1royal','YSYBO688','SEAGaming','kgsports','GLive','YYHbet','NLDSports','ZFRT213','ZF138VND','mbxusdt','ZTech','OESports','5ATech','LEGaming','ZFRT218','ROYAL88','TYM2','kbosports','DDwin','USSBET','ZhiFeng201','DFGame','ZF133FIN2','TSLA','Dawooxin','ZFRT198','SKY1688','SampleSite')  
		AND ci.currency IN (2,3,4,5,6,12,13,15,20,45,46,50,51,61,70,92,94,96,97,121)  -- RM,US$,TB,HK$,EURO,GBP,RMB,IN,UUS,Won,BND,CAN,INH,INR,MKK,HID,MK,USDT,BDT,PKR
ORDER BY ci.custid 

DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	
	
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @srecommend = @srecommend, @max_custid=@max_custid,@target = 'REPLICATED' 	
				
	WAITFOR DELAY '00:00:00.280'			
END	

DROP TABLE #supers		
GO

-- END STEP 2.2: Run this SP at replicated DB: DB06, DBTP -----
-----------------------------------------------------------------------------------
-- BEGIN STEP 2.3: Run this SP at DBCust -----
-------------------------------------------------
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
DROP TABLE	#supers;
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND cs.site IN('12bet','ALog','Haifa','W88','3Star88','Ole777','Boma365','88Macao','AE88','368Cash','Royal','Senibet','Happy1668','AG','9Club','iBET','Liga','HonorW','DEWA','IBO','GamingSoft','DBP','Hecbet','HL8','ABcasino','365online','IONclub','Gampag','Mayayule','Huangma','Webet88','BigGaming','PKbet','CGame','VCBA','FLC','IGPTech','Dawoo','Uwoniwin','ECLBET','GPIgame','Bobo88','OPEBET','Sunriseb2b','Okada','Heaven','e8casino','TangChao','MAX88','YongBao','BBIN2','GMASTER','ALPHA88','Tripleone','11bet','MICL','9wickets','zt828','WBS','Yibo','FB88','Xinbo','Monaco','Opadmin','Bonanza88','JIBET','WINCLUB88','MARS','Dade','ANGbet','Callmeboss','One88','VWIN66','A1game','skykey','AEUG','18Luck','ig128','VN88','Zbet','Sin88','Sunwin','Gaobet','Five88','Raisetech','txwl002','DF88','GESAB','AnvoFH','WKPHIL','WKCUR','weicai','Leng4D','Xtu168','Mopgaming','TopGame','DingTai','BBIN3','INSERTGAME','ID88','B24VN','allwincity','BWGaming','KingBet','BOG22','Wanfang','24AVIA','KUTECH','WBG88','NewFuture','erhaozhan','MTech','Wanbo','568Win','shengboyun','Datang001','633esports','starsoccer','N88','hjccasino','OCMS','Lode88','Soon88','XTDGT','mtegames','Yunji','OneSports','TCbet','TaoCai','ZhiFeng032','Zowin','N8G','N8B','BPLE','ZhiFeng035','ZhiFeng036','ZhiFeng009','M8Credit','ZhiFeng012','MANBETX','wmcasino','Winbox','pmwint','ZhiFeng021','HC6YAYOU','TIC88','Sky88','Kbet','Dabet','AOGcasino','Hejiyongle','XO88','US8YAYOU','RICbet','OXbet','WABET','Kzing2','TSEnter','ZhiFeng046','Vwin88','TT128','N8BK','ManCity','ZhiFeng051','Mayibet','Alphalota','GAMEBee','SBObet','ZFRT125','Diamond','Saba789','bdtt','HOT99','BSSB168','OSUSDT','7kplatform','ZFRT128','ZhiFeng040','Bigwiner','win365','ZFRT132','MSbet','Baji','HY6','ZhiFeng030','SDY','ECBet88','Comebet','9w','3ge888','ZFRT127','ZFRT80GPGT','ZFRT125MGT','ZFRT144','MYGAME','FHLMSABA','LegendWin','UG2','ab6688','Mancity2','VEGA77','dj888','ZFRT155','Barcelo9','directapi','OYO','ZFRT156','LLgaming','Tesla','ZhiFeng083','Aladdin99','ZFRT166','ZFRT165','G4ALL','loc','ZFRT090','OBGM','Jiuyou','ZF055PMW','V03','TH3','LIGAWLHKB','ZFRT161','Towin','ZhiFeng132','TGXI','XTSB','ZhiFeng098','ZhiFeng138','HFYX','ZFRT179','KZO41','ZhiFeng147','HBPT','infini88','TGAA0813','Yintai','Rio66','ZFRT186','JJBGAME','VKGAME','Xiaojin','YakaGaming','Wcasino','Wcasino88','Letian','ZFRT195','ZFRT126','beplay','DTGJZ','WRServices','Million','NFBI','STEBBCBI','383sport','ZF138THB','ZhiFeng178','Titanbet','ZhiFeng183','Xiaoxiang','ZhiFeng013','ZhiFeng019','H1royal','YSYBO688','SEAGaming','kgsports','GLive','YYHbet','NLDSports','ZFRT213','ZF138VND','mbxusdt','ZTech','OESports','5ATech','LEGaming','ZFRT218','ROYAL88','TYM2','kbosports','DDwin','USSBET','ZhiFeng201','DFGame','ZF133FIN2','TSLA','Dawooxin','ZFRT198','SKY1688','SampleSite')  
		AND ci.currency IN (2,3,4,5,6,12,13,15,20,45,46,50,51,61,70,92,94,96,97,121)  -- RM,US$,TB,HK$,EURO,GBP,RMB,IN,UUS,Won,BND,CAN,INH,INR,MKK,HID,MK,USDT,BDT,PKR
ORDER BY ci.custid 

DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
		
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid
			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @srecommend = @srecommend,@max_custid=@max_custid,@target = 'DBCUST'
		
	WAITFOR DELAY '00:00:00.280'			
END	

DROP TABLE #supers		
GO		

-- END STEP 2.3: Run this SP at DBCust -----
-------------------------------------------------
