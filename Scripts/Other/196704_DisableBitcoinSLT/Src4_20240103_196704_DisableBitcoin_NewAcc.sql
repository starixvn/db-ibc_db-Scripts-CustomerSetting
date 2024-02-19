/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240103@Winfred
	Task: Sitebuilder - Bitcoin/SLT - Enhance the settings when creating a new licensee [#196704]
	DB: DBCUST/CustDB and all subscriber of CustDB_custseting Pub

	Step 4 Disable sites not offer Bitcoin adjust new customer
*/
------------------------------------------------------
-- BEGIN STEP 1.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	(@maxcustID INT)
AS
BEGIN
	SET NOCOUNT ON
	
	IF dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductStatusProfile') = 0 RETURN
	IF dbo.f_CheckRepTable('custInfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_custsuper') = 0 RETURN	
	
	DECLARE @BatchSize SMALLINT = 5000, @Sporttype INT = 175, @Bettype INT = 7901 , @BitOrder INT
	CREATE TABLE #supers (CustID INT PRIMARY KEY, Currency INT,isfinished BIT DEFAULT(0))
	CREATE TABLE #Member ( CustID INT PRIMARY KEY CLUSTERED )
	CREATE TABLE #SMATemp ( CustID INT PRIMARY KEY CLUSTERED )

	SELECT @BitOrder= bitmapOrder 
	FROM Dep_ProductStatusProfile WITH(NOLOCK) 
	WHERE SportType=@Sporttype	

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'	
		AND ci.Enabled=1
		AND cs.site IN ('4300', '0sServices', '18LuckDiv', '18LuckV2', '24aviaCV', '24AVIASL', '2826bet', '368CashSW', '442ball', '568WinSW', '58club', '58clubCV', '88Gaming', '998bet', '9wickets', '9wtest', 'ABCGAME', 'ABEMT', 'ACsports', 'AEUGSW', 'AgclubA19', 'AGStech', 'allwinCV', 'Apollobet', 'ARYA', 'asiabet88', 'Asiasigma', 'ASKMEBETS', 'ASKMEBETSD', 'awc', 'awc2', 'aws03', 'aws06', 'AWS08', 'bb168', 'BBBet', 'BBBetCV', 'BDGAME', 'bdtt2', 'BDVNSW', 'beplayCV', 'BET168GAME', 'Bet38', 'Bet88CV', 'BET9S', 'Betlead', 'BetleadJS', 'Betway', 'BGCV', 'bigbet', 'Bingo88', 'bmengine', 'BODemoCV', 'bolaroyal', 'Bonanza88', 'BSSB168CV', 'BUCLH', 'C7YOUXICV', 'C88JS', 'CAplusCV', 'CAT01', 'Cat368', 'CCLVS', 'CGame4', 'CGIEngine', 'CIKAtech', 'CloudRock', 'crmps', 'Cryptocity', 'CT2U99', 'Cullinan', 'CVFSW', 'DawooCV', 'DDwin', 'De365', 'DFBET', 'dfbetCV', 'didihub', 'directapi', 'Dogzilla', 'DongYing', 'DSBtech', 'DSTPLAY', 'DTGJZ', 'e8casinoCV', 'easydream', 'ECBet88', 'EclipseSW', 'EvoOddFeed', 'ez88', 'F88IN1SW', 'FB88CV', 'FHLMSABAS', 'filbet', 'FLC', 'FLCSW', 'FPGagent', 'FS1688', 'FYISB', 'FYT', 'G4ALL', 'Ganga7', 'GB888CV', 'GLive', 'GmasterS', 'golden8', 'golden88', 'GoldenF', 'GoldenF2', 'GoldenF2CV', 'Goldenfph', 'GSCFTWCV', 'GSCSW', 'GSOFTJS', 'GSOFTJSSW', 'gwtcg', 'gwtcgJS', 'gwteg', 'gwtyq', 'HAGaming', 'Happistar', 'Happy8', 'Heji888', 'HFYX', 'HL8IDSW', 'HT88', 'HY6', 'i88SW', 'i8MYlive', 'IBO', 'IDNSPORT', 'IDNUPB2KRW', 'ig128s', 'IGSW', 'iProBET', 'ISC888', 'ISLOT', 'IW5', 'IXGAMING', 'JBbet', 'JBO', 'JDJDAPI', 'JDYGaming', 'JJBGAMECV', 'Joker', 'JollyDemo', 'JZ888', 'kbosportCV', 'kbosports', 'KDSLOTS', 'khmer', 'khmerA2', 'King855', 'KingBet', 'Kingdom', 'KingFun', 'KK8SW', 'KUTECH', 'KzingP88', 'KZSW', 'LEIHUO', 'leobet', 'LG777', 'LiBo', 'liv66SW', 'livv88sw', 'lode365f3', 'LSM99', 'LT02', 'M18SW', 'M88ASIA', 'Mabe88', 'MayibetCV', 'mbxusdt', 'MCM1688', 'Mega7', 'MetaltexSW', 'MTechCV', 'MultiSL88', 'MXMSW', 'mxvt', 'Mybet88', 'MYGAMECV', 'N88', 'n88clubSW', 'N8B', 'N8BK2', 'N8G', 'N8I', 'NCCloudSW', 'NeftsoftSW', 'NeuronDemo', 'NEWQC', 'newtitan', 'NextBet', 'Nexus', 'NFBI', 'NGgame', 'Niu8gaming', 'NukeGaming', 'OCMSS', 'oddstest', 'OESports', 'OGGRPSW', 'OkadaSW', 'OlaTigerSW', 'OLE777CV', 'Ole7SW', 'OMGINR', 'Omni88', 'OneLive', 'OneSports', 'OpenApi', 'opsl', 'OSUSDT', 'Ot88', 'Owin', 'OXPLAY', 'OXPLAY2', 'OYO', 'Pay4d', 'Peakk', 'Pega', 'PINT', 'PKKing', 'Player12', 'PPGSW', 'QASite', 'Rakyat4DSW', 'RBCV', 'Rich11', 'SampleSite', 'SBCHOS', 'SBCHOSSW', 'SBObet', 'SEAL888', 'SENBKK', 'Sengroup', 'SGALabel', 'SGM88', 'SGWINS', 'SKGAMING', 'SKGROUP', 'skykey', 'SL88SW', 'Slot7777', 'SM88', 'sogogo', 'sp888', 'SSWANJS', 'Stavki', 'SunriseCV', 'SWDemo', 'SWDFBET', 'SWSite', 'T1SOFTSW', 'TangChao', 'TayaCV', 'TBETINR', 'TCGBDT', 'TCGCOP', 'TCGCV', 'TCGF3BDT', 'TCGF3BRL', 'TCGF3INR', 'TCGF3TRY', 'TCGF3VNDK', 'TCGPKR', 'TCGTRY', 'Tesla', 'Test0112', 'Test1607', 'TestDirCV', 'TFTECH', 'TGVN8888', 'TGXI', 'TGXICV', 'TSLAA', 'TSLAACV', 'TSLAASD', 'TSXJCV', 'TWWIN', 'TXJT', 'TYM2', 'ug396', 'V9betSW', 'vedagaming', 'VEGA77', 'VIPGAMING', 'VKGAMECV', 'VNMBX', 'w688', 'w84sw', 'W88', 'W88CV', 'W88KES', 'Wanfang', 'WBG88', 'Wcasino', 'Wcasino88', 'Weiwei', 'WGAME', 'WGsports', 'win365', 'WinboxSW', 'WINGAMING', 'WINHX1', 'winwinsw', 'WLSTAR', 'wsgaming', 'WSlots', 'X2Dynamic', 'X33Asia', 'Xiaojin', 'XINGFA', 'Xinli2CV', 'XinliDivCV', 'XJ888', 'XLMEDIA', 'XmenSW', 'YHTY', 'YiboCV', 'yongleCV', 'YSYBO688CV', 'yuanbao', 'yuanbaoCV', 'ZF035SW', 'ZF133FIN2', 'ZF147CV', 'ZF183SW', 'ZF215CNY', 'ZF301C', 'ZF365CV', 'ZF365SW', 'ZF462B', 'ZFRT080', 'ZFRT090SW', 'ZFRT129', 'ZFRT144CV', 'ZFRT152', 'ZFRT158CV', 'ZFRT159', 'ZFRT166SW', 'ZFRT167', 'ZFRT175', 'ZFRT179', 'ZFRT179SW', 'ZFRT219', 'ZFRT240', 'ZFRT276SW', 'ZFRT399', 'ZFRT443', 'ZFRT491', 'ZFRT495', 'ZFRT506', 'ZFRT520', 'ZFRT534', 'ZFRT534SW', 'ZFRT80GPGT', 'ZhiFeng021', 'ZhiFeng030', 'ZhiFeng051', 'ZhiFeng055', 'ZhiFeng084', 'ZhiFeng088', 'ZhiFeng112', 'ZhiFeng133', 'ZhiFeng164', 'ZhiFeng176', 'ZhiFeng208', 'ZhiFeng221', 'ZhiFeng242', 'ZhiFeng253', 'ZhiFeng255', 'ZhiFeng262', 'ZhiFeng299', 'ZhiFeng302', 'ZhiFeng303', 'ZhiFeng312', 'ZhiFeng317', 'ZhiFeng371', 'ZhiFeng381', 'ZhiFeng475', 'ZhiFeng476', 'ZhiFeng484', 'ZhiFeng487', 'ZhiFeng505', 'ZhiFeng543', 'ZhiFeng560', 'ZhiFeng573', 'ZhiFeng587', 'ZhiFeng601', 'ZhiFeng605', 'ZhiFeng613', 'ZhiFeng643', 'ZhiFeng667', 'ZhiFeng683', 'ZhiFeng689', 'ZhiFeng710', 'ZhiFeng727', 'ZhiFeng753', 'ZhiFeng779', 'ZhiFeng792', 'ZhiFeng793', 'ZhiFeng831', 'ZhiFeng871', 'ZhiFeng876', 'zincbet', 'ZT001asia', 'ZT001eur', 'zt828SW')
	
	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend IN(SELECT CustID FROM #supers) AND roleid=3 AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%')

	INSERT INTO #SMATemp(CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @maxcustID 
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO #Member(CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 1  AND Enabled = 1 AND custid > @maxcustID	
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))

	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsHidden,@BitOrder,0))
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsDisabled,@BitOrder,1))
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  #SMATemp temp ON temp.CustID = c.custid
		CROSS APPLY (SELECT VALUE FROM f_CustSetting_ProductStatusSel (c.bitmapIsDisabled,@BitOrder)) isDisabled
		CROSS APPLY (SELECT VALUE FROM f_CustSetting_ProductStatusSel (c.bitmapIsHidden,@BitOrder)) isHidden
	WHERE NOT(isDisabled.value = 1 AND isHidden.value = 0)
	UNION ALL
	SELECT c.CustID
		,bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsHidden,@BitOrder,0))
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsDisabled,@BitOrder,1))
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  #Member temp ON temp.CustID = c.custid
		CROSS APPLY (SELECT VALUE FROM f_CustSetting_ProductStatusSel (c.bitmapIsDisabled,@BitOrder)) isDisabled
		CROSS APPLY (SELECT VALUE FROM f_CustSetting_ProductStatusSel (c.bitmapIsHidden,@BitOrder)) isHidden
	WHERE NOT(isDisabled.value = 1 AND isHidden.value = 0)

	WHILE 1 = 1 
	BEGIN
		TRUNCATE TABLE #TempProductStatus

		DELETE TOP (@BatchSize) a
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

	DROP TABLE #supers
	DROP TABLE #Dummy
	DROP TABLE #SMATemp
END
GO
PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx
EXEC dbo.Acc_Dep_DynamicCustSetting_09 @MaxCustID=@MaxCustID
