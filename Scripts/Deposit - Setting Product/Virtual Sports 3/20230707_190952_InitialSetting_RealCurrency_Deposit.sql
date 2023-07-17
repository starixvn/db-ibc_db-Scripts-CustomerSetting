/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke	
	Date: 20230707
	Task: Insert setting for Virtual Sports 3 DEPOSIT - Real Currency [Redmine: #190952] 
	DB: DBCust/CustDB
*/

-- BEGIN STEP 1: Deploy this SP at DBCUST--
-----------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	 @srecommend INT		
	,@target VARCHAR(20)
	,@max_custid INT
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','TESTDBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','TESTDBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductStatusProfile') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustSettingMode') = 0 RETURN

	DECLARE @batch INT = 3000

	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY
		,roleid	TINYINT
	)
	
	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)

	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend = @srecommend AND roleid = 3 
		AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
		AND custid <= @max_custid 

	INSERT INTO #MemberTemp(CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1  AND Enabled = 1 AND custid <= @max_custid
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	
	INSERT INTO #SMATemp(CustID, roleid)
	SELECT custid,roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND Enabled = 1 AND custid <= @max_custid
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	DECLARE 	@SportType	SMALLINT = 178, 
				@BetType	SMALLINT = 5302,
				@fSporttype SMALLINT = 231,
				@fBettype	SMALLINT = 5301,
				@BitMapOrder TINYINT
	
	SELECT @BitMapOrder = bitmapOrder
	FROM Dep_ProductStatusProfile WITH (NOLOCK)
	WHERE Sporttype = @SportType AND Bettype = @BetType

	--------------------------------------------Product Status------------------------------------------------
	CREATE TABLE #AllUsers (CustID int PRIMARY KEY)
	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY, bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY, bitmapIsHidden binary(32), bitmapIsDisabled binary(32))

	INSERT INTO #AllUsers (CustID)
	SELECT DISTINCT SMA.CustID FROM #SMATemp SMA WITH (NOLOCK)
	UNION 
	SELECT DISTINCT M.CustID FROM #MemberTemp M WITH (NOLOCK)

	INSERT INTO #Dep_CustProductStatus(CustID, bitmapIsHidden, bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus(c.bitmapIsHidden, psp.bitmapOrder, 0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus(c.bitmapIsDisabled, psp.bitmapOrder, 0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON psp.Bettype = @BetType AND psp.Sporttype = @SportType
		INNER JOIN  #SMATemp temp ON temp.CustID = c.custid
	UNION ALL
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus(c.bitmapIsHidden, psp.bitmapOrder, 0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus(c.bitmapIsDisabled, psp.bitmapOrder, 0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON psp.Bettype = @BetType AND psp.Sporttype = @SportType
		INNER JOIN  #MemberTemp temp ON temp.CustID = c.custid

	WHILE 1 = 1 
	BEGIN
		TRUNCATE TABLE #TempProductStatus

		DELETE TOP (@batch) a
		OUTPUT deleted.CustID, deleted.bitmapIsHidden, deleted.bitmapIsDisabled INTO #TempProductStatus(CustID, bitmapIsHidden, bitmapIsDisabled)
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

	INSERT INTO Dep_CustProductStatus(CustID, bitmapIsDisabled, bitmapIsHidden)
	SELECT	A.custid
			, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitMapOrder,0) AS bitmapIsDisabled
			, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitMapOrder,0)  AS bitmapIsHidden
	FROM #AllUsers A WITH (NOLOCK)
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = A.CustID)

	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid = @srecommend AND ProductSettingID = 168)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID, ProductSettingID)
		SELECT @srecommend, 168
	END

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
			,@SportType
			,@BetType
			,cs.IsLive
			,cs.SuperPT
			,cs.MasterPT
			,cs.AgentPT
	FROM #SMATemp d
		INNER JOIN Dep_CustPTSetting_Agent cs WITH (NOLOCK) ON cs.CustID = d.CustID
		WHERE cs.SportType = @fSporttype AND cs.BetType = @fBettype

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
			,@SportType
			,@BetType
			,cs.IsLive
			,cs.SuperPT
			,cs.MasterPT
			,cs.AgentPT
	FROM #MemberTemp d
		INNER JOIN Dep_CustPTSetting_Member cs WITH (NOLOCK) ON cs.CustID = d.CustID
		INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON d.CustID = m.CustID
	WHERE m.IsGroupedPT = 0
		AND cs.SportType = @fSporttype AND cs.BetType = @fBettype

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
		,@SportType
		,@BetType
		,cs.IsLive
		,cs.SuperPT
		,cs.MasterPT
		,cs.AgentPT
	FROM #SMATemp d WITH (NOLOCK)
		INNER JOIN Dep_CustPTGroupSetting_Member cs WITH (NOLOCK) ON cs.AgentID = d.CustID
	WHERE roleid = 2
		AND cs.SportType = @fSporttype AND cs.BetType = @fBettype

	INSERT INTO Dep_CustSettingMode(CustID, IsGroupedPT)
		SELECT t.CustID, 1
	FROM #MemberTemp t WITH (NOLOCK)
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode WITH (NOLOCK) WHERE CustID=t.CustID)
		AND NOT EXISTS (SELECT 1 FROM Dep_CustBAActive BA WITH (NOLOCK) WHERE BA.CustId=t.CustID)

	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID = 169)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID, ProductSettingID)
		SELECT @srecommend, 169
	END

	-------------------------------------------------BetSetting----------------------------------------------------------------
	INSERT INTO Dep_CustBetSetting_Agent(
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
	)
	SELECT t.CustID, @SportType, @BetType, cs.MinBet, cs.MaxBet, cs.MaxPerMatch
	FROM #SMATemp t
		INNER JOIN Dep_CustBetSetting_Agent cs WITH (NOLOCK) ON cs.CustID = t.CustID
	WHERE cs.SportType = @fSporttype AND cs.BetType = @fBettype

	CREATE TABLE #BatchMember(CustID INT)

	WHILE 1 = 1 
	BEGIN
		TRUNCATE TABLE #BatchMember

		DELETE TOP (@batch) a
		OUTPUT deleted.CustID INTO #BatchMember(CustID)
		FROM #MemberTemp a 

		IF @@ROWCOUNT = 0 
			BREAK

		INSERT INTO Dep_CustBetSetting_Member(
			 CustID
			,SportType
			,BetType
			,MinBet
			,MaxBet
			,MaxPerMatch
		)
		SELECT t.CustID, @SportType, @BetType, cs.MinBet, cs.MaxBet, cs.MaxPerMatch
		FROM #BatchMember t
			INNER JOIN Dep_CustBetSetting_Member cs WITH (NOLOCK) ON cs.CustID = t.CustID
			WHERE cs.SportType = @fSporttype AND cs.BetType = @fBettype

		WAITFOR DELAY '00:00:00.100'
	END

	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID = 170)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID, ProductSettingID)
		SELECT @srecommend, 170
	END

	DROP TABLE #SMATemp
				, #MemberTemp
				, #AllUsers
				, #BatchMember
				, #Dep_CustProductStatus
				, #Dummy
				, #TempProductStatus

END
GO
-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------

--------------------------------------------------------------------------------------
-- BEGIN STEP 2: Run this script at DBCUST & all replicated servers----- -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT , @max_custid INT,
		@target NVARCHAR(20)

IF @@SERVERNAME IN ('DBCUST', 'SITDBCUST', 'TESTDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'
Print 'Server Name : ' + @target

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND cs.site IN(
		'12Bet',
		'18Luck',
		'24AVIA',
		'365online',
		'383sport',
		'3ge888',
		'3star88',
		'633esports',
		'7kplatform',
		'88Macao',
		'9bet',
		'9Club',
		'9w',
		'A1game',
		'ab6688',
		'Abcasino',
		'ACsports',
		'Ae88',
		'AEUG',
		'AKYL99',
		'Aladdin99',
		'allwincity',
		'alog',
		'Alphalota',
		'AnvoFH',
		'Aoncash',
		'Athena000',
		'B24VN',
		'Baji',
		'Barcelo9',
		'BBIN2',
		'BBIN3',
		'bdtt',
		'BE7',
		'beplay',
		'BigGaming',
		'Bigwiner',
		'bmwbet',
		'Bobo88',
		'Bolanation',
		'Bonanza88',
		'BPLE',
		'C7YOUXI',
		'C88bet',
		'Callmeboss',
		'CCLive',
		'CGame',
		'Dade',
		'dafd',
		'Dawoo',
		'Dawooxin',
		'DBP',
		'DCSDemo',
		'DDwin',
		'DEWA',
		'DFGame',
		'Diamond',
		'DingTai',
		'DMsports',
		'DTGJZ',
		'e8casino',
		'ECBet88',
		'ECLBET',
		'erhaozhan',
		'FB88',
		'FHLMSABA',
		'G4ALL',
		'GAMEBee',
		'GamingSoft',
		'Gampag',
		'Gaobet',
		'GESAB',
		'H1royal',
		'Haifa',
		'HBPT',
		'HC6YAYOU',
		'Heaven',
		'Hecbet',
		'HFYX',
		'HIDZ',
		'hjccasino',
		'HL8',
		'HOT99',
		'HuangMa',
		'HY6',
		'iBET',
		'IBO',
		'ig128',
		'infini88',
		'INSERTGAME',
		'IONclub',
		'ITCbet',
		'JDJDAPI',
		'JIBET',
		'Jiuyou',
		'JJBGAME',
		'JUYOU',
		'kbosports',
		'KingBet',
		'KUTECH',
		'LegendWin',
		'Leng4D',
		'LIGAWLHKB',
		'LLgaming',
		'loc',
		'Lode88',
		'LUCKYBET',
		'M8bola',
		'M8Credit',
		'Macaubet',
		'ManCity',
		'Mancity2',
		'Mayayule',
		'Mayibet',
		'mbxusdt',
		'MICL',
		'Monaco',
		'Mopgaming',
		'MTech',
		'MYGAME',
		'N88',
		'N8B',
		'N8BK',
		'N8G',
		'NewFuture',
		'OBGM',
		'OBsystem',
		'OCMS',
		'OESports',
		'OPEBET',
		'Ot88',
		'OYO',
		'PLAYES',
		'pmwint',
		'Q8bola',
		'Raisetech',
		'Rio66',
		'Saba789',
		'SampleSite',
		'ScaleDemo1',
		'ScaleDemo2',
		'SDY',
		'sea168',
		'SEAL888',
		'SGM88',
		'SKY1688',
		'skykey',
		'Soon88',
		'spondemo',
		'starsoccer',
		'STEBBCBI',
		'Sunriseb2b',
		'Sunwin',
		'SWSite',
		'TangChao',
		'TaoCai',
		'TCbet',
		'Tesla',
		'Test1607',
		'TGAA0813',
		'Titanbet',
		'TopGame',
		'Towin',
		'Tripleone',
		'TSLA',
		'TT128',
		'TXJT',
		'txwl002',
		'TYgaming',
		'TYM2',
		'US8YAYOU',
		'Uwoniwin',
		'VCBA',
		'VEGA77',
		'VKGAME',
		'vnggame',
		'VWIN66',
		'WABET',
		'Wanbo',
		'Wanfang',
		'WBG88',
		'Wcasino',
		'Wcasino88',
		'webet88',
		'win365',
		'Winbox',
		'WINCLUB88',
		'WINHX1',
		'WKCUR',
		'WKPHIL',
		'WLSTAR',
		'wmcasino',
		'WRServices',
		'Xiaojin',
		'Xinbo',
		'XTSB',
		'Yibo',
		'Yintai',
		'YongBao',
		'YSYBO688',
		'Yunji',
		'YYHbet',
		'ZF026',
		'ZF055PMW',
		'ZF133FIN2',
		'ZF138THB',
		'ZF138USD',
		'ZF138VND',
		'ZF215aTR',
		'ZFRT090',
		'ZFRT126',
		'ZFRT132',
		'ZFRT144',
		'ZFRT155new',
		'ZFRT156',
		'ZFRT159',
		'ZFRT161',
		'ZFRT165',
		'ZFRT166',
		'ZFRT179',
		'ZFRT195',
		'ZFRT213',
		'ZFRT218',
		'ZFRT219',
		'ZFRT263',
		'ZFRT264',
		'ZFRT276',
		'ZFRT282',
		'ZFRT80GPGT',
		'ZhiFeng009',
		'ZhiFeng012',
		'ZhiFeng013',
		'ZhiFeng021',
		'ZhiFeng030',
		'ZhiFeng032',
		'ZhiFeng035',
		'ZhiFeng036',
		'ZhiFeng040',
		'ZhiFeng041',
		'ZhiFeng051',
		'ZhiFeng138',
		'ZhiFeng147',
		'ZhiFeng183',
		'ZhiFeng221',
		'ZhiFeng222',
		'ZhiFeng228',
		'ZhiFeng253',
		'ZhiFeng267',
		'ZhiFeng271',
		'ZhiFeng303',
		'Zowin',
		'zt828',
		'ZTech'
)

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_Dep_DynamicCustSetting_09 @srecommend = @srecommend
			,@target = @target
			,@max_custid = @max_custid
					
	waitfor delay '00:00:00.280'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DROP TABLE #supers
GO
-- END STEP 2: Run this script at DBCUST & all replicated servers-----
-----------------------------------------------------------------------------------