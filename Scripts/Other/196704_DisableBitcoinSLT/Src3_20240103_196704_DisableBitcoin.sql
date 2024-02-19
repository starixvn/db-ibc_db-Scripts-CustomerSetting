/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240103@Winfred
	Task: Sitebuilder - Bitcoin/SLT - Enhance the settings when creating a new licensee [#196704]
	DB: DBCUST/CustDB and all subscriber of CustDB_custseting Pub

	Step 3 Disable sites not offer Bitcoin
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	 @CustIDs VARCHAR(MAX) 	= ''
	, @BitOrder INT
	, @target VARCHAR(20)
AS
BEGIN	
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbtrans only
	
	IF (dbo.f_CheckRepTable('CustInfo') = 0 
		OR dbo.f_CheckRepTable('Customer') = 0 
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
	
	DECLARE @batch SMALLINT = 5000
	--------------------------------------------Disable Status--------------------------------------------------
	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))

	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsHidden,@BitOrder,0))
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsDisabled,@BitOrder,1))
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  #CustList temp ON temp.CustID = c.custid
		CROSS APPLY (SELECT VALUE FROM f_CustSetting_ProductStatusSel (c.bitmapIsDisabled,@BitOrder)) isDisabled
		CROSS APPLY (SELECT VALUE FROM f_CustSetting_ProductStatusSel (c.bitmapIsHidden,@BitOrder)) isHidden
	WHERE NOT(isDisabled.value = 1 AND isHidden.value = 0)

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
	
	DROP TABLE #Dep_CustProductStatus
	DROP TABLE #TempProductStatus
END
GO
-- BEGIN STEP 2: Run this SP at replicated DB: DB06, DBTP, DBCUST-----
SET NOCOUNT ON
PRINT N'Step 5: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target


DECLARE @SportType INT = 175, @BetType INT=7901, @BitOrder INT
SELECT @BitOrder= bitmapOrder from Dep_ProductStatusProfile WITH(NOLOCK) where SportType=@Sporttype AND Bettype  = @BetType

IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
		DROP TABLE	#supers;
CREATE TABLE #supers			(CustID INT PRIMARY KEY, Currency INT, isfinished BIT DEFAULT(0))
CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)	
CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY CLUSTERED,srecommend INT,isfinished BIT DEFAULT(0))
CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY CLUSTERED,srecommend INT,RoleID INT,isfinished BIT DEFAULT(0))

CREATE TABLE #tmpCustTemp		(CustID INT PRIMARY KEY)
CREATE TABLE #tmpSMATemp		(CustID INT PRIMARY KEY)

DECLARE @batch INT = 20000
DECLARE @CustIDs VARCHAR(MAX)
DECLARE @max_custid INT, @srecommend INT, @currency INT , @Role SMALLINT = 0
SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	INNER JOIN Dep_CustProductStatus cps WITH (NOLOCK) ON ci.custid = cps.CustID
    CROSS APPLY (SELECT VALUE FROM f_CustSetting_ProductStatusSel (cps.bitmapIsDisabled,@BitOrder)) isDisabled
    CROSS APPLY (SELECT VALUE FROM f_CustSetting_ProductStatusSel (cps.bitmapIsHidden,@BitOrder)) isHidden
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND isDisabled.value = 0 
	AND isHidden.value =0
	AND cs.site IN ('4300', '0sServices', '18LuckDiv', '18LuckV2', '24aviaCV', '24AVIASL', '2826bet', '368CashSW', '442ball', '568WinSW', '58club', '58clubCV', '88Gaming', '998bet', '9wickets', '9wtest', 'ABCGAME', 'ABEMT', 'ACsports', 'AEUGSW', 'AgclubA19', 'AGStech', 'allwinCV', 'Apollobet', 'ARYA', 'asiabet88', 'Asiasigma', 'ASKMEBETS', 'ASKMEBETSD', 'awc', 'awc2', 'aws03', 'aws06', 'AWS08', 'bb168', 'BBBet', 'BBBetCV', 'BDGAME', 'bdtt2', 'BDVNSW', 'beplayCV', 'BET168GAME', 'Bet38', 'Bet88CV', 'BET9S', 'Betlead', 'BetleadJS', 'Betway', 'BGCV', 'bigbet', 'Bingo88', 'bmengine', 'BODemoCV', 'bolaroyal', 'Bonanza88', 'BSSB168CV', 'BUCLH', 'C7YOUXICV', 'C88JS', 'CAplusCV', 'CAT01', 'Cat368', 'CCLVS', 'CGame4', 'CGIEngine', 'CIKAtech', 'CloudRock', 'crmps', 'Cryptocity', 'CT2U99', 'Cullinan', 'CVFSW', 'DawooCV', 'DDwin', 'De365', 'DFBET', 'dfbetCV', 'didihub', 'directapi', 'Dogzilla', 'DongYing', 'DSBtech', 'DSTPLAY', 'DTGJZ', 'e8casinoCV', 'easydream', 'ECBet88', 'EclipseSW', 'EvoOddFeed', 'ez88', 'F88IN1SW', 'FB88CV', 'FHLMSABAS', 'filbet', 'FLC', 'FLCSW', 'FPGagent', 'FS1688', 'FYISB', 'FYT', 'G4ALL', 'Ganga7', 'GB888CV', 'GLive', 'GmasterS', 'golden8', 'golden88', 'GoldenF', 'GoldenF2', 'GoldenF2CV', 'Goldenfph', 'GSCFTWCV', 'GSCSW', 'GSOFTJS', 'GSOFTJSSW', 'gwtcg', 'gwtcgJS', 'gwteg', 'gwtyq', 'HAGaming', 'Happistar', 'Happy8', 'Heji888', 'HFYX', 'HL8IDSW', 'HT88', 'HY6', 'i88SW', 'i8MYlive', 'IBO', 'IDNSPORT', 'IDNUPB2KRW', 'ig128s', 'IGSW', 'iProBET', 'ISC888', 'ISLOT', 'IW5', 'IXGAMING', 'JBbet', 'JBO', 'JDJDAPI', 'JDYGaming', 'JJBGAMECV', 'Joker', 'JollyDemo', 'JZ888', 'kbosportCV', 'kbosports', 'KDSLOTS', 'khmer', 'khmerA2', 'King855', 'KingBet', 'Kingdom', 'KingFun', 'KK8SW', 'KUTECH', 'KzingP88', 'KZSW', 'LEIHUO', 'leobet', 'LG777', 'LiBo', 'liv66SW', 'livv88sw', 'lode365f3', 'LSM99', 'LT02', 'M18SW', 'M88ASIA', 'Mabe88', 'MayibetCV', 'mbxusdt', 'MCM1688', 'Mega7', 'MetaltexSW', 'MTechCV', 'MultiSL88', 'MXMSW', 'mxvt', 'Mybet88', 'MYGAMECV', 'N88', 'n88clubSW', 'N8B', 'N8BK2', 'N8G', 'N8I', 'NCCloudSW', 'NeftsoftSW', 'NeuronDemo', 'NEWQC', 'newtitan', 'NextBet', 'Nexus', 'NFBI', 'NGgame', 'Niu8gaming', 'NukeGaming', 'OCMSS', 'oddstest', 'OESports', 'OGGRPSW', 'OkadaSW', 'OlaTigerSW', 'OLE777CV', 'Ole7SW', 'OMGINR', 'Omni88', 'OneLive', 'OneSports', 'OpenApi', 'opsl', 'OSUSDT', 'Ot88', 'Owin', 'OXPLAY', 'OXPLAY2', 'OYO', 'Pay4d', 'Peakk', 'Pega', 'PINT', 'PKKing', 'Player12', 'PPGSW', 'QASite', 'Rakyat4DSW', 'RBCV', 'Rich11', 'SampleSite', 'SBCHOS', 'SBCHOSSW', 'SBObet', 'SEAL888', 'SENBKK', 'Sengroup', 'SGALabel', 'SGM88', 'SGWINS', 'SKGAMING', 'SKGROUP', 'skykey', 'SL88SW', 'Slot7777', 'SM88', 'sogogo', 'sp888', 'SSWANJS', 'Stavki', 'SunriseCV', 'SWDemo', 'SWDFBET', 'SWSite', 'T1SOFTSW', 'TangChao', 'TayaCV', 'TBETINR', 'TCGBDT', 'TCGCOP', 'TCGCV', 'TCGF3BDT', 'TCGF3BRL', 'TCGF3INR', 'TCGF3TRY', 'TCGF3VNDK', 'TCGPKR', 'TCGTRY', 'Tesla', 'Test0112', 'Test1607', 'TestDirCV', 'TFTECH', 'TGVN8888', 'TGXI', 'TGXICV', 'TSLAA', 'TSLAACV', 'TSLAASD', 'TSXJCV', 'TWWIN', 'TXJT', 'TYM2', 'ug396', 'V9betSW', 'vedagaming', 'VEGA77', 'VIPGAMING', 'VKGAMECV', 'VNMBX', 'w688', 'w84sw', 'W88', 'W88CV', 'W88KES', 'Wanfang', 'WBG88', 'Wcasino', 'Wcasino88', 'Weiwei', 'WGAME', 'WGsports', 'win365', 'WinboxSW', 'WINGAMING', 'WINHX1', 'winwinsw', 'WLSTAR', 'wsgaming', 'WSlots', 'X2Dynamic', 'X33Asia', 'Xiaojin', 'XINGFA', 'Xinli2CV', 'XinliDivCV', 'XJ888', 'XLMEDIA', 'XmenSW', 'YHTY', 'YiboCV', 'yongleCV', 'YSYBO688CV', 'yuanbao', 'yuanbaoCV', 'ZF035SW', 'ZF133FIN2', 'ZF147CV', 'ZF183SW', 'ZF215CNY', 'ZF301C', 'ZF365CV', 'ZF365SW', 'ZF462B', 'ZFRT080', 'ZFRT090SW', 'ZFRT129', 'ZFRT144CV', 'ZFRT152', 'ZFRT158CV', 'ZFRT159', 'ZFRT166SW', 'ZFRT167', 'ZFRT175', 'ZFRT179', 'ZFRT179SW', 'ZFRT219', 'ZFRT240', 'ZFRT276SW', 'ZFRT399', 'ZFRT443', 'ZFRT491', 'ZFRT495', 'ZFRT506', 'ZFRT520', 'ZFRT534', 'ZFRT534SW', 'ZFRT80GPGT', 'ZhiFeng021', 'ZhiFeng030', 'ZhiFeng051', 'ZhiFeng055', 'ZhiFeng084', 'ZhiFeng088', 'ZhiFeng112', 'ZhiFeng133', 'ZhiFeng164', 'ZhiFeng176', 'ZhiFeng208', 'ZhiFeng221', 'ZhiFeng242', 'ZhiFeng253', 'ZhiFeng255', 'ZhiFeng262', 'ZhiFeng299', 'ZhiFeng302', 'ZhiFeng303', 'ZhiFeng312', 'ZhiFeng317', 'ZhiFeng371', 'ZhiFeng381', 'ZhiFeng475', 'ZhiFeng476', 'ZhiFeng484', 'ZhiFeng487', 'ZhiFeng505', 'ZhiFeng543', 'ZhiFeng560', 'ZhiFeng573', 'ZhiFeng587', 'ZhiFeng601', 'ZhiFeng605', 'ZhiFeng613', 'ZhiFeng643', 'ZhiFeng667', 'ZhiFeng683', 'ZhiFeng689', 'ZhiFeng710', 'ZhiFeng727', 'ZhiFeng753', 'ZhiFeng779', 'ZhiFeng792', 'ZhiFeng793', 'ZhiFeng831', 'ZhiFeng871', 'ZhiFeng876', 'zincbet', 'ZT001asia', 'ZT001eur', 'zt828SW')
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

CREATE NONCLUSTERED INDEX IDX_tempCust ON #tmpCust(srecommend, isfinished)
CREATE NONCLUSTERED INDEX IDX_tempSMA ON #tmpSMA(srecommend, isfinished)

DECLARE @startRun DATETIME, @endRun DATETIME, @duration	INT, @msgtmp nvarchar(200), @indexDetail INT = 0
DECLARE @super_cnt INT, @index INT = 0 , @DoneSM BIT, @DoneAgent BIT 
SET @super_cnt = (SELECT COUNT(*) FROM #supers )
DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d.' 
DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

SELECT @srecommend = 0 ,@DoneSM = 0 , @DoneAgent = 0

WHILE (1 = 1)
BEGIN
	SELECT @CustIDs = ''
	SELECT @startRun = GETDATE()
	IF EXISTS(SELECT TOP 1 1 
				FROM #tmpSMA
				WHERE isfinished = 0 AND srecommend = @srecommend
				UNION ALL
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
			SET @CustIDs = @CustIDs + (SELECT STRING_AGG(CONVERT(VARCHAR(MAX),custid),',')  FROM #tmpSMATemp)
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
				SET @CustIDs = @CustIDs + (SELECT STRING_AGG(CONVERT(VARCHAR(MAX),custid),',')  FROM #tmpSMATemp)
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
				SET @CustIDs = @CustIDs + (SELECT STRING_AGG(CONVERT(VARCHAR(MAX),custid),',')  FROM #tmpCustTemp)
				SELECT @Role = 1
			END
		END
		SET @indexDetail = @indexDetail + 1
		EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @CustIDs = @CustIDs, @BitOrder = @BitOrder,@target = @target
		
		SELECT @endRun = GETDATE()
			, @duration = DATEDIFF(MILLISECOND, @startRun, @endRun)
		SELECT @msgtmp = @msg  + CAST(@duration AS VARCHAR(20))
		RAISERROR (@msgtmp, 0, 1,@indexDetail, @srecommend) WITH NOWAIT

		TRUNCATE TABLE #tmpCustTemp
		TRUNCATE TABLE #tmpSMATemp
		WAITFOR DELAY '00:00:00.050'	
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
		SET @indexDetail = 0
		RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT

	   END
END	

DROP TABLE #supers	
DROP TABLE #Dummy
DROP TABLE #tmpCust
DROP TABLE #tmpSMA
DROP TABLE #tmpCustTemp
DROP TABLE #tmpSMATemp	
GO
PRINT N'Step 5: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
SET NOCOUNT OFF