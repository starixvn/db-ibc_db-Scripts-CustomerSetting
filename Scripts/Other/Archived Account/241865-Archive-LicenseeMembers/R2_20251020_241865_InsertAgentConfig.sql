/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20251020@Tacy
	Task: ROUND 2 [Redmine: #241865]
		add temp linked server _tmpDBSite1, _tmpDBSite2 to connect Sitedb01,sitedb02
	DB: DBCUST-CustDB

	*** 317 Licensees ~ 4.9M
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
	AND NOT (c.username LIKE '%Acc%' OR c.username LIKE '%LocalBank%' OR c.username LIKE '%AFF%' OR c.username LIKE 'AB88' + 'CAS%')
	AND c.creatdate <= DATEADD(dd,-@Mindays,GETDATE())
	AND c.srecommend IN( SELECT CustID FROM Dep_CustSuper WITH(NOLOCK))
	AND c.site IN (
					 'livv88sw',	'AEUG',			'ZFRT534',		'PKKing',		'C7YOUXICV'
					,'Bet88CV',		'ig128',		'ASKMEBETS',	'HAGaming',		'IONclub'
					,'GSCSW',		'Yibo',			'khmer',		'liv66SW',		'MYGAME'
					,'zt828',		'NukeGaming',	'Slot7777',		'X2Dynamic',	'ZFRT304'
					,'IDNSPORT',	'OKBETPHP',		'TCGVNDK',		'Winbox',		'asiabet88'
					,'awc',			'LEIHUO',		'ZFRT534B',		'ZABBET',		'SENBKK'
					,'TSLAA',		'ZhiFeng013',	'Lucky99',		'OXPLAY',		'MultiSL88'
					,'ZFRT534SW',	'DEWA',			'VN88',			'OneLive',		'TSLAASD'
					,'KZSW',		'Happy8',		'gwtcgSW',		'crmps',		'ZFRT090SW'
					,'GamingSoft',	'PINT',			'365online',	'ZhiFeng303',	'Rakyat4DSW'
					,'aws06',		'OCMS',			'infini88',		'TSEnter',		'C7YOUXI'
					,'HAIFA',		'LIGAWLHKB',	'24AVIA',		'awc2',			'ZFRT299'
					,'Xtu168',		'ZhiFeng255',	'ARYA',			'bsports',		'Kingdom'
					,'DFGame',		'alog',			'mtegames',		'TCGBDT',		'w84sw'
					,'ZhiFeng088',	'368Cash',		'OneSports',	'SGALabel',		'Dawoo'
					,'W88CV',		'24AVIASL',		'TCGF3BDT',		'998bet',		'WPTglobal'
					,'Weiwei',		'KZV40SW',		'ZhiFeng133',	'TCGBRL',		'khmerA2'
					,'shengboyun',	'JBO',			'Omni88',		'KUTECH',		'HWPVNDK'
					,'SKGROUP',		'Xinli2CV',		'LSM99',		'TCGF3BRL',		'TCGF3THB'
					,'mpsphJS',		'FPGagent',		'FHLMSABA',		'ZT001asia',	'ZF183SW'
					,'CGame',		'Yunji',		'ZF215aTR',		'V9betSW',		'Abcasino'
					,'didihub',		'IBO',			'ZhiFeng208',	'SBCHOSSW',		'ZhiFeng138'
					,'Sunriseb2b',	'ZFRT680',		'TCGF4BDT',		'ZFRT693',		'BSSB168'
					,'TCGMYR',		'newtitan',		'DSBtech',		'TCGTHB',		'MLsports'
					,'DongYing',	'ZhiFeng032',	'BBsports',		'ZF462B',		'A1game'
					,'TCGMASTER',	'SSWANJS',		'ZhiFeng262',	'TCGF4THB',		'VBridge'
					,'ZF1044',		'ZhiFeng040',	'ZFRT166',		'ZhiFeng726',	'FB88CV'
					,'Mancity2',	'HWPCNY',		'HIDZ',			'MANBETX',		'TCGF4VNDK'
					,'Bet38',		'V03',			'ManCity',		'RAJALUCK',		'MTech'
					,'FB88',		'txwl002',		'gwtwr',		'Indolabel',	'DSTPLAY'
					,'WINCLUB88',	'Alphalota',	'DawooCV',		'ZhiFeng484',	'TCGF3VNDK'
					,'XTSB',		'BSSB168CV',	'Mybet88',		'RMneweraCV',	'HWPINR'
					,'JJBGAMECV',	'ZhiFeng895',	'Aladdin99',	'YiboCV',		'FLC'
					,'ZhiFeng689',	'Wanfang',		'RMnewera',		'ZhiFeng021',	'ZhiFeng683'
					,'FYISB',		'Mega88888',	'BDVNSW',		'JJBGAME',		'GoldenF2'
					,'CAT01',		'Nexus',		'ZFRT213',		'ZF138THB',		'IGSW'
					,'AG',			'KK8SW',		'ZFRT506',		'ZFRT132',		'HuangMa'
					,'ECLBET',		'Club99',		'SunriseCV',	'OCMSS',		'ZhiFeng164'
					,'Hackett',		'ZFRT598',		'filbet',		'ZhiFeng587',	'Niu8gaming'
					,'KzingP88',	'XINGFA',		'FYISL',		'TCGF3INR',		'LegendWin'
					,'HWPUSDT',		'AEUGSW',		'Mayibet',		'VNST6969',		'OLE777'
					,'TFTECH',		'TopGame',		'NLDSports',	'ZhiFeng565',	'WABET'
					,'wmcasino',	'ZhiFeng573',	'sp888CV',		'Zowin',		'blingwin'
					,'Monaco',		'i88SW',		'OkadaSW',		'GPIGAME',		'RBCV'
					,'ZF271SW',		'ab6688',		'TCGIDRK',		'easydream',	'iBET'
					,'DFBET',		'gwtcgJS',		'ZhiFeng009',	'HOHPLAY',		'Rivalo'
					,'ZhiFeng894',	'OBsystem',		'GDBET',		'VKGAMECV',		'sp888'
					,'ZT2J88',		'ALPHA88',		'VKGAME',		'DBP',			'JVD1'
					,'88Gaming',	'ZhiFeng229',	'ZhiFeng258',	'MXMSW',		'WGAME'
					,'DingTai',		'Zhifeng440',	'BPLE',			'SBCHOS',		'FYT'
					,'MayibetCV',	'aws03',		'MetaltexSW',	'Kzing2',		'TJGAME'
					,'TCGUSD',		'2826bet',		'M8Credit',		'BIGBAT',		'INSERTGAME'
					,'allwincity',	'JDYFR',		'SGWINS',		'BBIN3',		'zt8281'
					,'Bonanza88',	'JYB88',		'Mayayule',		'blingwinJS',	'Ganga7'
					,'Aoncash',		'SGWIN',		'WinboxSW',		'CCLVS',		'baiyi'
					,'ZF1046',		'ZhiFeng644',	'allwinCV',		'B24VN',		'Heaven'
					,'glo365',		'ZFRT151',		'ZhiFeng497',	'ZhiFeng041',	'XinliDivCV'
					,'TCGF4BRL',	'GBET',			'9Club',		'ND1688',		'ugsports'
					,'Rio66',		'18LuckV2',		'HWPKRW',		'TCGINR',		'ZhiFeng333'
					,'Bet38VN',		'Ae88',			'TWWIN',		'TCGF3MYR',		'AKYL99'
					,'ZhiFeng036',	'Dongfeng03',	'Lucklotter',	'Bobo88',		'YongBao'
					,'TCGF4IDRK',	'ZhiFeng365',	'TCGF4INR',		'AIPLAY',		'loc'
					,'Gampag',		'KT88',			'MYGAMECV',		'Sky9',			'OSUSDT'
					,'TCGF3IDRK',	'ZhiFeng147'
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
