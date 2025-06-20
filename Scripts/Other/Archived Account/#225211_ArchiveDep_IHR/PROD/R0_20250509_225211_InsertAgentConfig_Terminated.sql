/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250509@Tacy
	Task: ROUND 0 - ALL Terminated Licensees [Redmine: #225211 / #226916]
		add temp linked server _tmpDBSite1, _tmpDBSite2 to connect Sitedb01,sitedb02
	DB: DBCUST-CustDB
*/
USE CustDB
GO

--Check LinkedServer
SELECT TOP 1 1 AS CheckLinkedServer FROM _tmpDBSite1.bodb02.dbo.Task_Cust_CheckBalance_Exception WITH(NOLOCK) WHERE 1 <> 1 UNION ALL
SELECT TOP 1 1						FROM _tmpDBSite2.bodb02.dbo.Task_Cust_CheckBalance_Exception WITH(NOLOCK) WHERE 1 <> 1

IF @@ERROR <> 0
	RETURN

--DELETE all data from Dep_Customer_Archived_Config
--TRUNCATE TABLE Dep_Customer_Archived_Config

--> Delete waiting agents before new scan
SELECT CustID
INTO #TempDeleted
FROM Dep_Customer_Archived WITH(NOLOCK) 
WHERE status = 'waiting'

DELETE d
OUTPUT deleted.CustID, dbo.f_GetDateTime2()
INTO Dep_Customer_Archived_Del_InHouse (CustID, RepUpdateTime)
FROM  Dep_Customer_Archived d WITH(ROWLOCK)  
	INNER JOIN #TempDeleted t
		ON t.CustID = d.CustID
-------------------------------------

DECLARE  @MinBalance MONEY = 1000000000
		,@Mindays INT = 0

CREATE TABLE #TempAgents (CustID INT PRIMARY KEY)

INSERT INTO #TempAgents(CustID)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
WHERE c.roleid = 2
	AND c.username NOT LIKE '%ACC%'
	AND c.creatdate <= DATEADD(dd,-@Mindays,GETDATE())
	AND c.srecommend IN( SELECT CustID FROM Dep_CustSuper WITH(NOLOCK))
	AND c.site IN (
					'WRServices',	'JunosoTech',	'dddbet',		'BigGaming'
					,'H1royal',		'win365',		'ZhiFeng055',	'HL8IDSW'
					,'BGCV',		'n88clubSW',	'Betway',		'HL8'
					,'HBPT',		'Callmeboss',	'vnggame',		'beplayCV',		'ZhiFeng035'
					,'GoldenF',		'Bindasbet',	'Owin',			'ZFRT186',		'vssports'
					,'ZhiFeng122',	'CGame4',		'Mopgaming',	'Royal',		'7kplatform'
					,'TCbet',		'AnvoFH',		'CIKAtech',		'mxvt',			'hjccasino'
					,'OPEBET',		'Player12',		'ZFRT276',		'WINHX1'		--exclude SampleSite (for testing)
					,'ZF035SW',		'ZhiFeng299',	'ZFRT276SW',	'ZFRT165',		'ZhiFeng353'
					,'erhaozhan',	'ZFRT126CV',	'GESAB',		'ID88',			'dfbetCV'
					,'VCBA',		'ZFRT158CV',	'TYgaming',		'VIPGAMING',	'ZFRT126'
					,'Boma365',		'ZF055PMW',		'Ot88',			'yuanbao',		'AGCGlobal'
					,'FIC88',		'ZhiFeng543',	'Betlead',		'58club',		'DMsports'
					,'ZhiFeng792',	'beplay',		'ZFRT664',		'BOSSB',		'Victorys'
					,'YYHbet',		'3ge888',		'B8KRW',		'HFTH',			'ZFRT179'
					,'ZhiFeng012',	'TaoCai',		'Gaobet',		'OLE777CV',		'568Win'
					,'ZF596bSW',	'Mega7',		'XJ888',		'SKY1688',		'ZhiFeng605'
					,'ZFRT167',		'F88KRW',		'NCCloudSW',	'Dade',			'ZhiFeng228'
					,'ZFRT144',		'ZFRT219',		'LDPRO',		'KingFun',		'0sServices'
					,'1shot888',	'BET9S',		'ZFRT611',		'bmwbet',		'ZFRT195'
					,'KOIWIN',		'ZhiFeng222',	'K8ioSW',		'LLgaming',		'ZhiFeng183'
					,'ZFRT549',		'ZF138VND',		'ZhiFeng084',	'ZhiFeng727',	'ZFRT480'
					,'N8BK2',		'thang888',		'DF88',			'NaVip',		'ZhiFeng381'
					,'ZhiFeng643',	'C88JS',		'weicai',		'TGVN8888',		'Soon88'
					,'ZFRT144CV',	'ZF215CNY',		'HX9Candy',		'NewFuture',	'HOroyal'
					,'ZF301C',		'ZFRT161',		'KSTECH2',		'De365',		'VNS888'
					,'Yintai',		'Sunrise',		'pmwint',		'ZhiFeng396',	'Xiaoxiang'
					,'BUCLH',		'IgameTech',	'ZhiFeng037',	'dewatatoto',	'THEDEN'
					,'Cryptocity',	'WGAMING',		'YakaGaming',	'GMDFD',		'Opal88'
					,'Webet',		'MICL',			'MCM1688',		'VNMBX',		'GooBet'
					,'THECLUB',		'DELA',			'Titanbet',		'UGaming',		'NBCbet'
					,'UNOGAMING',	'Titank',		'AOBOCV',		'BVCLLC',		'liv66'
					,'SEAGaming',	'Onegaming',	'HFYX',			'396Club',		'Unobet'
					,'JZFortune',	'Datang',		'Datang001',	'HCVIP',		'ZF309B'
					,'Pockerdewa',	'Kun188',		'GGBOOK',		'Taipanbet',	'IGPTech'
					,'Bodog',		'Aplus',		'shicaigw',		'WRSeamless',	'Winsplay'
					,'sbt88',		'dghash',		'ZhiFeng266',	'USSBET',		'VCBACV'
					,'kzsbxjCV',	'ZFRT460',		'BBIN2',		'XTDGT',		'UG2'
					,'Aragon88',	'webet88',		'i668bet',		'MayFair',		'KhmerG'
					,'Starnet',		'GGBOOKES',		'TitanCraft',	'Vwin',			'Sky88'
					,'ZF138USD',	'Calibet',		'afb99',		'AK318',		'AMG'
					,'Brown888',	'28BET',		'starsoccer',	'TSLA',			'ZFRT115'
					,'KOKVN2',		'JIB88',		'SAGAME88',		'CENTRAL168',	'ZhiFeng106'
					,'ZhiFeng282',	'ZhiFeng306',	'lionsclub',	'SDYSW',		'TYCgame'
					,'Soon88CV',	'sea168',		'MFgame',		'Jarvis',		'Bsdbet'
					,'ZFRT282',		'ZFRT081',		'ZFRT082',		'JIDU',			'Siamgame'
					,'5ATech',		'JUYOU',		'ROYAL88',		'AJJCV',		'gbkj'
					,'LUCKYBET',	'QUBO',			'ZhiFeng026',	'ZhiFeng098',	'Easywin22'
					,'TH3',			'Comebet',		'KOKVN',		'KZO41',		'Letian'
					,'RYB95',		'ZFRT150',		'J9YAYOU',		'ZFRT143',		'ZFRT125'
					,'dj888',		'Baolong',		'ZFRT155',		'ABB688',		'Pinbo'
					,'Allbetclub',	'SunGame',		'Asian88',		'Coinbet',		'ENTAPLAY'
					,'GWORLD',		'Lexibet',		'Emmyo',		'Baobet',		'ENT22'
					,'Senibet',		'Bwinning',		'WeBet168',		'Ty777',		'Hengcai88'
					,'tcycyl',		'G2Win',		'HBO999',		'Apollo',		'NEWBALL'
					,'FYyule',		'Indowin',		'WKPHIL',		'WKCUR',		'Champion'
					,'UwinY',		'9Wsports',		'24TECH',		'Asianbet',		'Mgm88'
					,'Avia',		'Newhonbet',	'HONBET',		'YHY1980',		'Zzun88'
					,'sbcbet',		'Winner99',		'YAYOU',		'Ｗin88',		'108bet'
					,'King10',		'XTD3',			'MarvelDH',		'Liga',			'SHABAING'
					,'Bet2day',		'ZhiFeng201',	'ZhiFeng168',	'Xinli3CV',		'BetDeal'
					,'TitanOne',	'BOG22',		'HeleThai',		'XinYo',		'Hejiyongle'
					,'US8YAYOU',	'THBET',		'TLC',			'Happy1668',	'KeenOcean'
					,'Hbobet',		'Boying',		'Junbet',		'TGO',			'Holey'
					,'GOAB88',		'CQ11',			'HonorW',		'Kasking88',	'KaiHao'
					,'Webet138',	'Hong88',		'11bet',		'Tycoon',		'Lucky88'
					,'XinliCV',		'10BET',		'Luckywin88',	'Winn69',		'Axiawin'
					,'One88',		'Jumbo88',		'Lagadewa',		'Bobbet',		'Ratugg'
					,'Monstergol',	'Mbet',			'AOGcasino',	'Leon',			'K8VN'
					,'TGAA0813',	'BETSUN',		'Zhifeng215',	'Spark',		'YTX'
					,'SSSGaming',	'Nbbet',		'Citybk',		'MRCATSB',		'BWGaming'
					,'Fabet',		'STEBBCBI',		'Gameroom',		'ANGbet',		'SV88'
					,'YBTech',		'Tianbo',		'Red88',		'HJTK',			'Five88'
					,'MAX88',		'BoinGroup',	'WUYICP',		'Lode88',		'ZhiFeng156'
					,'PanguGame',	'818Bet',		'SSSSEA',		'Jinyazhou',	'HongChow'
					,'HC6YAYOU',	'Swin',			'Nbet',			'May88',		'ZFRT133'
					,'ZFRT142',		'ZFRT156',		'GS003',		'ZFRT128',		'Uwin18'
					,'OXbet',		'Sun988',		'Saibo',		'WBS',			'18Luck'
					,'laba360',		'Doctorgame',	'Platinum',		'DAYWIN',		'Man1878'
					,'WM8888',		'IBG',			'Dachen',		'VGS',			'Fugui'
					,'WinWin',		'Debet',		'Win68Club',	'Zbet',			'Sin88'
					,'Haoying',		'jinmangguo',	'Kraton',		'Storm88',		'DUOLE'
					,'BuyWin',		'Wuming',		'Okada',		'TGame',		'Salon365'
					,'VCAsia',		'9dianyule',	'LS88',			'BetStar',		'MrCat'
					,'99UU',		'LongBao',		'SLC88',		'Inbet',		'TCL'
					,'Saloncs',		'K8',			'Star99',		'LZYQ',			'GDC'
					,'666VIP',		'Empire555',	'21Cash',		'TooBet',		'67BET'
					,'DOBET',		'Luckyking',	'MMISW',		'PF7IN',		'RS3T616SW'
					,'ZF1056',		'ZF1172'
	)

DECLARE @tmpClearBalCustID INT, 
        @ErrCode           INT           = 0, 
        @ErrMsg            NVARCHAR(200) = '', 
		@ErrExtraInfo	   VARCHAR(MAX)  = '',
        @CreatorID         INT           = 10278938, 
        @IP                VARCHAR(50)   = '0.0.0.0', 
        @Pass              VARCHAR(100)  = '8058095B7DDB08A608811097E5DB8D', 
        @tmpDumUserName    VARCHAR(30), 
        @AgentID			INT,
		@SiteDBGroupID		SMALLINT,
		@CustDBGroupID		SMALLINT,
		@Site				VARCHAR(10)

SELECT c.custid AS Recommend,cu.site
	,@MinBalance AS MinBalance,@Mindays AS MinDays
	,ClearBal.CustID AS CustIDBalanceDummy
	,0 AS Status,c.username AS Agent
	,s.SiteDBGroupID, s.CustDBGroupID
INTO #Dep_Customer_Archived_Config
FROM custInfo c WITH(NOLOCK)
	INNER JOIN Customer cu WITH(NOLOCK) ON c.custid = cu.custid
	OUTER APPLY (	SELECT TOP 1 Custid 
					FROM custInfo ClearBal WITH(NOLOCK) 
					WHERE ClearBal.recommend = c.recommend
						AND ClearBal.roleid = 1
						AND ClearBal.username LIKE '%ClearBal'
				) ClearBal
	INNER JOIN Site s WITH(NOLOCK) ON s.site = cu.site
WHERE c.srecommend IN ( SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND c.custid IN ( SELECT custid FROM #TempAgents)

CREATE CLUSTERED INDEX ix_TmpDep_Customer_Archived_Config_recommend ON #Dep_Customer_Archived_Config(recommend)

--> Insert new dummy clearbal if not exists yet
WHILE 1 = 1
BEGIN
	SELECT @AgentID = null, @tmpClearBalCustID = null, @tmpDumUserName = null
		, @ErrExtraInfo='', @ErrMsg = '',@ErrCode = 0
		, @SiteDBGroupID = NULL, @CustDBGroupID = NULL, @Site = NULL

	SELECT TOP(1) @AgentID = Recommend, @tmpDumUserName = Agent + 'ClearBal', @Site = site
				, @SiteDBGroupID = SiteDBGroupID, @CustDBGroupID = CustDBGroupID
	FROM #Dep_Customer_Archived_Config
	WHERE CustIDBalanceDummy IS NULL

	IF @@ROWCOUNT = 0
		BREAK

	-- Insert dummy account on GlobCustDB
	EXEC GlobCustDB.dbo.API_CustomerIns_Register
			@UserName		= @tmpDumUserName
			,@UplineID		= @AgentID
			,@roleid		= 1
			,@SiteDBGroupID	= @CustDBGroupID
			,@site			= @site
			,@CustID		= @tmpClearBalCustID OUT
			,@ErrCode		= @ErrCode OUT
			,@ErrMsg		= @ErrMsg OUT
			,@ErrExtraInfo	= @ErrExtraInfo OUT

	IF @ErrMsg <> ''
	BEGIN
		PRINT 'On GlobCustDB - AgentID ' + CAST(@AgentID AS VARCHAR) + ': ' + @ErrMsg
		PRINT 'ErrExtraInfo: ' + @ErrExtraInfo

		UPDATE #Dep_Customer_Archived_Config
		SET CustIDBalanceDummy = 0
		WHERE Recommend = @AgentID
	END
	ELSE
	BEGIN
		-- Insert dummy account on CustDB
		EXEC Acc_Dep_CustomerInsMember_Ag 
				 @custid=@tmpClearBalCustID
				,@creator=@creatorID
				,@username=@tmpDumUserName
				,@userpwd=@Pass
				,@recommend=@AgentID
				,@IP=@IP
				,@ErrCode=@ErrCode OUTPUT
				,@ErrMsg=@ErrMsg OUTPUT
				,@ErrExtraInfo=@ErrExtraInfo OUTPUT

		IF @ErrMsg <> ''
		BEGIN
			PRINT 'On CustDB - AgentID ' + CAST(@AgentID AS VARCHAR) + ': ' + @ErrMsg
			PRINT 'ErrExtraInfo: ' + @ErrExtraInfo
			PRINT 'GlobCustDB: Rollback ClearBalCust - ' + CAST(@tmpClearBalCustID AS VARCHAR)

			UPDATE #Dep_Customer_Archived_Config
			SET CustIDBalanceDummy = 0
			WHERE Recommend = @AgentID

			EXEC GlobCustDB.dbo.Acc_CustomerIns_Rollback @custid = @tmpClearBalCustID
		END
		ELSE 
		BEGIN
			PRINT 'AgentID ' + CAST(@AgentID AS VARCHAR) + ': Create ClearBal dummy successfully'

			UPDATE #Dep_Customer_Archived_Config
			SET CustIDBalanceDummy = @tmpClearBalCustID
			WHERE Recommend = @AgentID

			IF @SiteDBGroupID = 1
			BEGIN
				--> Use LinkedServer to connect Sitedb --> Insert Task_Cust_CheckBalance_Exception on SiteDB
				IF NOT EXISTS( SELECT 1 FROM _tmpDBSite1.bodb02.dbo.Task_Cust_CheckBalance_Exception WITH(NOLOCK) WHERE custid = @tmpClearBalCustID)
				BEGIN
					INSERT INTO _tmpDBSite1.bodb02.dbo.Task_Cust_CheckBalance_Exception(custid, remark) values(@tmpClearBalCustID, @tmpDumUserName)
				END
			END
			ELSE IF @SiteDBGroupID = 2
			BEGIN
				--> Use LinkedServer to connect Sitedb --> Insert Task_Cust_CheckBalance_Exception on SiteDB
				IF NOT EXISTS( SELECT 1 FROM _tmpDBSite2.bodb02.dbo.Task_Cust_CheckBalance_Exception WITH(NOLOCK) WHERE custid = @tmpClearBalCustID)
				BEGIN
					INSERT INTO _tmpDBSite2.bodb02.dbo.Task_Cust_CheckBalance_Exception(custid, remark) values(@tmpClearBalCustID, @tmpDumUserName)
				END
			END
		END
	END
END

--IF EXISTS (SELECT TOP 1 1
--FROM #Dep_Customer_Archived_Config
--WHERE CustIDBalanceDummy IS NULL
--)
--BEGIN
--SELECT c.Recommend,c.Agent, 'This Agent have not ClearBal account' ERROR
--FROM #Dep_Customer_Archived_Config c
--WHERE c.CustIDBalanceDummy IS NULL

--RETURN
--END

--> Set Status = 2 (pending - do not scan now) for Agent can not create CustIDBalanceDummy
UPDATE cf 
SET cf.Status = 2 --Pending
FROM #Dep_Customer_Archived_Config cf
WHERE cf.CustIDBalanceDummy = 0

IF @@ROWCOUNT > 0
	SELECT cf.Agent, 'Adding CustIDBalanceDummy failed'
	FROM #Dep_Customer_Archived_Config cf
	WHERE cf.CustIDBalanceDummy = 0

--> Update another agents to pending (do not scan now)
UPDATE cf 
SET cf.Status = 2 --Pending
FROM Dep_Customer_Archived_Config cf WITH(ROWLOCK)
WHERE cf.Status = 0

--> INSERT/UPDATE agents ready to scan
INSERT INTO Dep_Customer_Archived_Config (Recommend,Site,MinBalance,MinDays,CustIDBalanceDummy,Status)
SELECT Recommend,Site,MinBalance,MinDays,CustIDBalanceDummy,Status
FROM #Dep_Customer_Archived_Config 
WHERE CustIDBalanceDummy IS NOT NULL
	AND Recommend NOT IN( SELECT Recommend FROM Dep_Customer_Archived_Config WITH(NOLOCK))

UPDATE cf
SET cf.MinDays = c.MinDays,
	cf.MinBalance = c.MinBalance,
	cf.CustIDBalanceDummy = c.CustIDBalanceDummy,
	cf.Status = c.Status
FROM #Dep_Customer_Archived_Config c
	INNER JOIN Dep_Customer_Archived_Config cf WITH(ROWLOCK) ON c.Recommend = cf.Recommend
WHERE c.CustIDBalanceDummy IS NOT NULL

DROP TABLE #TempAgents
DROP TABLE #Dep_Customer_Archived_Config
DROP TABLE #TempDeleted

/*
SELECT * FROM Dep_Customer_Archived_Config WITH(NOLOCK) WHERE Status = 0 AND CustIDBalanceDummy = 0

SELECT * 
FROM Dep_Customer_Archived_Config WITH(NOLOCK) WHERE Status = 0 
*/
