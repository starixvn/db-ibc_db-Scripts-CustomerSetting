/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250528@Tacy
	Task: ROUND 1 - Normal Licensees [Redmine: #225211 / #226916]
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

DECLARE  @MinBalance MONEY = 0
		,@Mindays INT = 365

CREATE TABLE #TempAgents (CustID INT PRIMARY KEY)

INSERT INTO #TempAgents(CustID)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
WHERE c.roleid = 2
	AND c.username NOT LIKE '%ACC%'
	AND c.creatdate <= DATEADD(dd,-@Mindays,GETDATE())
	AND c.srecommend IN( SELECT CustID FROM Dep_CustSuper WITH(NOLOCK))
	AND c.site IN (
					 'bsports',		'Dawoo',		'LIGAWLHKB',	'Lucky99',		'DEWA'
					,'ZFRT304',		'Macaubet',		'ZhiFeng032',	'KUTECH',		'MARS'
					,'TSLAA',		'C7YOUXI',		'mtegames',		'Sunriseb2b',	'DFGame'
					,'shengboyun',	'IBO',			'XTSB',			'TCGF4VNDK',	'FB88'
					,'Sunwin',		'FB88CV',		'TCGF3BDT',		'Aoncash',		'TCGBRL'
					,'CGame',		'Yunji',		'BSSB168',		'PKbet',		'MANBETX'
					,'HuangMa',		'txwl002',		'JJBGAMECV',	'Abcasino',		'A1game'
					,'WPTglobal',	'Wanfang',		'TCGF3BRL',		'TCGF4BDT',		'BBsports'
					,'ZhiFeng021',	'ZhiFeng138',	'MLsports',		'HIDZ'
					,'Mancity2',	'TCGMYR',		'TCGTHB',		'ZF215aTR',		'MTech'
					,'FYISB',		'FHLMSABA',		'WINCLUB88',	'JJBGAME',		'OBGM'
					,'ZFRT166',		'AG',			'FLC',			'ManCity'
					,'Bet38',		'gwtwr',		'RAJALUCK',		'Ae88',			'iBET'
					,'TCGF3THB',	'TCGMASTER',	'Monaco',		'V03',			'SGM88'
					,'ZhiFeng895',	'YiboCV',		'Alphalota',	'MXM',			'BSSB168CV'
					,'DawooCV',		'HOT99',		'ab6688',		'SunriseCV',	'HWPVNDK'
					,'ZhiFeng040',	'NLDSports',	'VNST6969',		'OLE777',		'Kzing2'
					,'ZF1044',		'TCGF4THB',		'ZFRT213',		'RMnewera',		'Zowin'
					,'FPGagent',	'ITCBet',		'ECLBET',		'ZhiFeng036',	'VBridge'
					,'DBP',			'HWPCNY',		'TopGame',		'TCGF3VNDK',	'DingTai'
					,'Mayibet',		'Aladdin99',	'RMneweraCV',	'ZhiFeng683',	'SSWANJS'
					,'Mega88888',	'TCGF3INR',		'Mayayule',		'ZhiFeng573',	'9Club'
					,'ZF138THB',	'B24VN',		'Hackett',		'9bet',			'BPLE'
					,'VKGAMECV',	'RBCV',			'Heaven',		'ZFRT598',		'LegendWin'
					,'TCGPKR',		'VKGAME',		'ZhiFeng009',	'TCGINR',		'Raisetech'
					,'allwincity',	'Q8bola',		'ZhiFeng147',	'INSERTGAME',	'ZFRT321'
					,'2826bet',		'Zhifeng440',	'GAMEBee',		'TCGIDRK',		'WABET'
					,'ZhiFeng229',	'DFBET',		'gwtcgJS',		'SBCHOS',		'Hecbet'
					,'zt8281',		'MayibetCV',	'GBET',			'Bobo88',		'ZhiFeng258'
					,'HWPINR',		'GMASTER',		'JIBET',		'e8casino',		'allwinCV'
					,'HWPUSDT',		'OSUSDT',		'ZFRT132',		'BBIN3',		'YongBao'
					,'M8Credit',	'ZhiFeng894',	'3star88',		'ZhiFeng587',	'ZhiFeng041'
					,'Club99',		'Gampag',		'sp888CV',		'TSXJCV'
					,'sp888',		'Leng4D',		'TJGAME',		'SDY',			'JYB88'
					,'ZFRT151',		'XYZgame',		'Rio66',		'TCGUSD'
					,'loc',			'Bolanation',	'bdtt',		'	wmcasino',		'Tripleone'
					,'ZhiFeng333',	'Xinbo',		'88Macao',		'M8bola',		'OBsystem'
					,'Lucklotter',	'ZhiFeng365',	'TCGMXN',		'OG1688',		'Ganga7'
					,'ZF147CV',		'YSYBO688',		'ZhiFeng497',	'blingwin',		'TBETINR'
					,'TCGF4INR',	'ZhiFeng644',	'VFUN88',		'SGWIN',		'BIGBAT'
					,'TCGF3MYR',	'e8casinoCV',	'glo365',		'ZFRT090',		'MYGAMECV'
					,'Million',		'AKYL99',		'ASKMEBETSW',	'TT128',		'Bet38VN'
					,'KT88',		'JVD1',			'Dongfeng03',	'Jiuyou',		'TangChao'
					,'Sky9',		'ZFRT218',		'HWPKRW',		'bdtt2',		'DemoCV'
					,'Elite',		'9w',			'Barcelo9',		'TCGF4BRL',		'blingwinJS'
					,'383sport',	'INFI688',		'BoAPI09',		'DTGJZ',		'TBET'
					,'AGStech',		'ez88',			'WLSTAR',		'YES888',		'Test1607'
					,'9wickets',	'TCGF4IDRK',	'Apollobet',	'NossaSlots',	'ZhiFeng871'
					,'OYO',			'Pega',			'Uwoniwin',		'EGaming',		'gwteg'
					,'ZhiFeng271',	'GB888CV',		'NextBet',		'ZhiFeng946',	'ZhiFeng737'
					,'Dawooxin',	'HF888',		'TXJT',			'FS1688',		'Cat368go'
					,'WOWAdmin',	'95ASIA',		'TCGF3IDRK',	'ZhiFeng875',	'OGGRP'
					,'Bingo88',		'Betsmooth',	'Towin',		'ZF365CV',		'QASite'
					,'Wcasino88',	'ZhiFeng505',	'ZFRT80GPGT',	'Wcasino',		'golden88'
					,'RS3T616',		'ZTech',		'YSYBO688CV',	'ZeAPI01',		'kbosportCV'
					,'PLAYES',		'kgsports',		'AIG88',		'ZFRT384',		'TCGF4MYR'
					,'RS16888',		'MTechCV',		'VEGA77',		'PPG',			'ACGame'
					,'Aonslot',		'luckybuy',		'OWAPI01',		'ZhiFeng051',	'SV6789'
					,'EU88',		'88Goals',		'OESports',		'kbosports',	'gwtyq'
					,'EGamingCV',	'X2transfer',	'Hongtubet',	'BODemoCV',		'GSCFTWCV'
					,'G4ALL',		'24aviaCV',		'ZhiFeng030',	'ZF371',		'PlayBetz'
					,'BananaTech',	'HT88',			'GOATbet',		'zeapi02',		'BODemoJS'
					,'TCGTRY',		'ZhiFeng982',	'ZhiFeng742',	'ZFRT198',		'ZhiFeng442'
					,'ReZeTest01',	'DDwin',		'3g8',			'TCGJPY',		'LLGAME'
					,'JollyTest',	'BoAPI10',		'DCSDemo',		'oddstest',		'mbxusdt'
					,'JZ888',		'ZFRT619',		'Goldenfph',	'TCGCV',		'ZFRT346'
					,'CCLive',		'ZhiFeng253',	'WBG88',		'ZFRT159',		'4300'
					,'TestDirCV',	'ZF133FIN2',	'Cexsea',		'JDJDAPI',		'ZhiFeng221'
					,'Xiaojin',		'Tesla',		'TSLAACV',		'ZhiFeng937',	'VT999'
					,'ZFRT523',		'ZF6449W',		'ZFRT167T',		'Livebet365',	'ECBet88'
					,'WKIBPH',		'lode365f3',	'9wtest',		'ZF1002',		'greatwall'
					,'Test0112',	'baowang188',	'ZhiFeng267',	'GPgaming88',	'BoAPI06'
					,'SDYCV',		'ZhiFeng516',	'369588vip',	'7Kplatfrom',	'TXTHB'
					,'IvoryBet',	'WB101',		'JGQP8',		'FHC',			'ZhiFeng560'
					,'eezy9',		'directapi',	'SBObet',		'67Live',		'ZFRT392'
					,'BoAPI11',		'ZhiFeng919',	'GSOFTJS',		'Mega7vndk',	'bong68'
					,'NGgame',		'BBIN4',		'ZhiFeng779',	'ACE99',		'ZFRT704'
					,'ZhiFeng433',	'ZhiFeng945',	'ZFRT520',		'zyylc',		'zhsl1234'
					,'ZhiFeng631',	'Joker',		'PandaCN',		'ZhiFeng753',	'royale666'
					,'Flexgaming',	'TCGF3COP',		'TCGCOP',		'ZhiFeng667',	'TCGF3MXN'
					,'Supers99',	'QQCLUBS',		'TCGF3TRY',		'XYGAME',		'NBGAMES'
					,'HHTY888',		'KingBet',		'okbanoi',		'LDPROPHP',		'CVF01'
					,'ZF1023',		'ZhiFeng511',	'OpenApi',		'HLB138',		'ZhiFeng710'
					,'EvoOddFeed',	'JollyDemo',	'UN168',		'ZFRT372',		'Lefu'
					,'ZhiFeng876',	'bb168',		'YYGacor',		'ST888',		'ZhiFeng889'
					,'Cat368',		'HOT88',		'ZF301B',		'ZhiFeng457',	'ZhiFeng425'
					,'C88bet',		'OneLiveGam',	'Wawabet',		'AgclubA19',	'd3sports'
					,'Royalebet',	'ZFRT264',		'JK8API',		'dabo88',		'DTGW'
					,'w1royal',		'Newbet',		'ZFRT155new',	'ZFRT263',		'ZhiFeng178'
					,'Vietwin88',	'ZhiFeng019',	'skykey',		'dghashCV',		'TYVNZZXL'
					,'ZhiFeng223',	'ZhiFeng142',	'OGWLS',		'ZhiFeng132',	'MSbet'
					,'HY6',			'ZF215c',		'ZhiFeng462',	'CCLV',			'XO88'
					,'AGCasia',		'ZFRT155jiu',	'ZFRT127',		'iuplay1',		'ZFRT193'
					,'ZFRT162',		'ZFRT125MGT',	'ZhiFeng083',	'ZhiFeng046',	'ZFRT069'
					,'ZFRT122',		'TXG',			'TYM2',			'yq355',		'Zeus888'
					,'Rich11',		'CloudRock',	'CAplusCV',		'ZFRT491',		'FBstorm'
					,'Nova88',		'Heji888',		'ACsports',		'GLive',		'ZhiFeng242'
					,'Sabademo',	'58clubCV',		'NFBI',			'ReBoTest01',	'Sunbet138'
					,'7Konline',	'hl5888',		'OWAPI02',		'BoAPI02',		'BoAPI01'
					,'BopingAPI0',	'Cali',			'RICbet',		'dafd',			'Tonybet'
					,'BoAPI07',		'ReBoTest02',	'ReZeTest02',	'XuanYuan',		'ZhiFeng071'
					,'ZF132A',		'iuplay2',		'XINSHNEG',		'ZeAPI03',		'demotest01'
					,'bpdemotest',	'Vwin88',		'lj9888',		'wsd666',		'pg5688'
					,'gj7777',		'lwl8888',		'eb6688',		'wx7777',		'db5688'
					,'hn555',		'fx9888',		'gb688',		'wy6666',		'ks5555'
					,'fl5688',		'bw6688',		'gi6688',		'lebao8888',	'wl5688'
					,'wg5688',		'bcr999',		'cl668',		'cx5888',		'bvl8888'
					,'kh5688',		'gp1688',		'fg6666',		'BoAPI08',		'Hongtu'
					,'Deebet',		'Sga88',		'UUSS',			'BE7TH',		'boapi03'
					,'LivebetKR',	'BoAPI05',		'i228bet',		'mymbet',		'OddsFeed'
					,'LivebetIDR',	'ZhiFeng180',	'LEGaming',		'Yabo3',		'Arlocash'
					,'test0624',	'Kudatogel',	'ZFRT242',		'Dabet',		'Kbet'
					,'OBline',		'TIC88',		'ZFRT124',		'BB3',			'Bigwiner'
					,'12betco',		'BlueOcean',	'PCDD',			'Bobbet2',		'Opadmin'
					,'9wSB',		'Test012901',	'test021704',	'test021703',	'test021702'
					,'Test012902',	'test021701',	'KGvip',		'K8sports',		'alogeu'
					,'Ibobet',		'XTD1',			'XTD2',			'Lambo777',		'Greenplay'
					,'TS',			'Mirabet',		'Citibet',		'SG8'
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
