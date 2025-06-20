/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250428@Tacy
	Task: SIT - ALL Terminated Licensees [Redmine: #225211]
		add temp linked server _tmpDBSite1, _tmpDBSite2 to connect Sitedb01,sitedb02
	DB: DBCUST-CustDB

	Revision:
		- 20250509@Tacy: Code IHR - Dep_Customer_Archived
*/
USE CustDB
GO

--Check LinkedServer
SELECT TOP 1 1 AS CheckLinkedServer FROM _tmpDBSite1.bodb02.dbo.Task_Cust_CheckBalance_Exception WITH(NOLOCK) WHERE 1 <> 1 UNION ALL
SELECT TOP 1 1						FROM _tmpDBSite2.bodb02.dbo.Task_Cust_CheckBalance_Exception WITH(NOLOCK) WHERE 1 <> 1

IF @@ERROR <> 0
	RETURN

--DELETE all data from Dep_Customer_Archived_Config
TRUNCATE TABLE Dep_Customer_Archived_Config

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
	AND c.site IN (	 'WRServices'
					,'H1royal'
					,'HL8IDSW'
					,'ZhiFeng055'
					,'SGM88'
					,'n88clubSW'
					,'HBPT'
					,'win365'
					,'BGCV'
					,'BigGaming'
					,'Fabbet'
					,'GoldenF'
					,'ZFRT276'
					,'ZFRT276SW'
					,'CGame4'
					,'CIKAtech'
					,'vnggame'
					,'ZhiFeng122'
					,'vssports'
					,'AnvoFH'
					,'ZFRT186'
					,'beplayCV'
					,'AGCGlobal'
					,'ZFRT158CV'
					,'HFTH'
					,'3ge888'
					,'Victorys'
					,'ZF055PMW'
					,'ZFRT165'
					,'HL8'
					,'YYHbet'
					,'TYgaming'
					,'dfbetCV'
					,'ZhiFeng605'
					,'ID88'
					,'WINHX1'
					,'1shot888'
					,'FIC88'
					,'CandyA18'
					,'Ot88'
					,'Callmeboss'
					,'ZhiFeng543'
					,'BET9S'
					,'IW5'
					,'Mega7'
					,'TCbet'
					,'hjccasino'
					,'beplay'
					,'ZFRT126'
					,'ZhiFeng012'
					,'ZhiFeng727'
					,'ASKMEBETSW'
					,'TGVN8888'
					,'ZFRT126CV'
					,'HX9Candy'
					,'ZhiFeng643'
					,'ZhiFeng381'
					,'OLE777CV'
					,'ZFRT167'
					,'ZFRT179'
					,'erhaozhan'
					,'NaVip'
					,'DF88'
					,'N8BK2'
					,'VNS888'
					,'XJ888'
					,'Royal'
					,'thang888'
					,'SKY1688'
					,'ZhiFeng228'
					,'88Goals'
					,'KOIWIN'
					,'LLgaming'
					,'ZhiFeng505'
					,'SDY'
					,'ZhiFeng222'
					,'K8ioSW'
					,'Opal88'
					,'VCBA'
					,'wsgaming'
					,'NBCbet'
					,'ZFRT399'
					,'Taipanbet'
					,'GGBOOK'
					,'ZhiFeng271'
					,'Unobet'
					,'GGBOOKES'
					,'ZFRT384'
					,'XTDGT'
					,'IGPTech'
					,'ZFRT195'
					,'BBIN2'
					,'ZhiFeng183'
					,'Soon88'
					,'0sServices'
					,'dewatatoto'
					,'webet88'
					,'Starnet'
					,'bmwbet'
					,'afb99'
					,'KhmerG'
					,'GESAB'
					,'Bodog'
					,'Dreamland'
					,'RYB95'
					,'Gaobet'
					,'ZFRT144'
					,'Vwin'
					,'TaoCai'
					,'Brown888'
					,'AK318'
					,'ACGame'
					,'Aragon88'
					,'Cryptocity'
					,'NewFuture'
					,'Asian88'
					,'KzingJ51'
					,'AIG88'
					,'Boma365'
					,'J9YAYOU'
					,'ZF301C'
					,'ABB688'
					,'Wawabet'
					,'BUCLH'
					,'ZF112D'
					,'MayFair'
					,'ZF365CV'
					,'Lexibet'
					,'ZFRT179SW'
					,'GooBet'
					,'Xiaoxiang'
					,'ABCGAME'
					,'kgsports'
					,'Happistar'
					,'BoAPI02'
					,'ZeAPI01'
					,'ZhiFeng302'
					,'ZhiFeng204'
					,'OWAPI02'
					,'IN2GAME'
					,'PLAYES'
					,'ABCgamevip'
					,'ReBoTest01'
					,'ReZeTest01'
					,'AMG'
					,'yq355'
					,'BBBetCV'
					,'BBBet'
					,'Sunrise'
					,'GWORLD'
					,'ENTAPLAY'
					,'396Club'
					,'Livebet365'
					,'OPEBET'
					,'hl5888'
					,'Baobet'
					,'Royalebet'
					,'28BET'
					,'HOroyal'
					,'ZhiFeng112'
					,'i668bet'
					,'Yintai'
					,'VFUN88'
					,'UGaming'
					,'BoAPI01'
					,'King855'
					,'BopingAPI0'
					,'KSTECH'
					,'OWAPI01'
					,'KSTECH2'
					,'ReBoTest02'
					,'ReZeTest02'
					,'GMDFD'
					,'Titanbet'
					,'luckybuy'
					,'MCM1688'
					,'Emmyo'
					,'BoAPI07'
					,'CT2U99'
					,'GoToWin'
					,'WGAMING'
					,'ZFRT144CV'
					,'ZFRT80GPGT'
					,'Wcasino88'
					,'Aonslot'
					,'ZF057SQ24'
					,'Wcasino'
					,'Tonybet'
					,'ENT22'
					,'YakaGaming'
					,'Webet'
					,'ZhiFeng353'
					,'SunGame'
					,'Senibet'
					,'Asianbet'
					,'wg5688'
					,'cl668'
					,'cx5888'
					,'fg6666'
					,'wl5688'
					,'gp1688'
					,'kh5688'
					,'bvl8888'
					,'bw6688'
					,'gb688'
					,'db5688'
					,'gi6688'
					,'fl5688'
					,'wy6666'
					,'eb6688'
					,'lwl8888'
					,'gj7777'
					,'lj9888'
					,'wsd666'
					,'pg5688'
					,'wx7777'
					,'hn555'
					,'fx9888'
					,'ks5555'
					,'lebao8888'
					,'bcr999'
					,'WeBet168'
					,'Hengcai88'
					,'ZF301B'
					,'DELA'
					,'ZhiFeng487'
					,'UwinY'
					,'YAYOU'
					,'bpdemotest'
					,'Win88'
					,'SEAGaming'
					,'FLCSW'
					,'TitanCraft'
					,'Riverich'
					,'demotest01'
					,'Titan365'
					,'WKPHIL'
					,'WKCUR'
					,'Champion'
					,'9Wsports'
					,'Onegaming'
					,'zeapi02'
					,'ZeAPI03'
					,'GOATbet'
					,'PlayBetz'
					,'PlayBetzSW'
					,'Vwin88'
					,'ZhiFeng037'
					,'BoAPI08'
					,'liv66'
					,'Titank'
					,'BananaTech'
					,'UNOGAMING'
					,'VEGA77'
					,'BVCLLC'
					,'Sengroup'
					,'shicaigw'
					,'24TECH'
					,'ZhiFeng396'
					,'ZFRT460'
					,'ZF215CNY'
					,'King10'
					,'MarvelDH'
					,'OMGINR'
					,'UUSS'
					,'SHABAING'
					,'Deebet'
					,'Sga88'
					,'108bet'
					,'Hongtu'
					,'HONBET'
					,'Newhonbet'
					,'Kun188'
					,'ZF309B'
					,'ZhiFeng425'
					,'ZFRT443'
					,'Bet2day'
					,'boapi03'
					,'USSBET'
					,'wmcasinoS'
					,'ZhiFeng201'
					,'VCBACV'
					,'GoldenFCV'
					,'WRSeamless'
					,'HeleThai'
					,'Xinli3CV'
					,'dghash'
					,'ZFRT198'
					,'baowang188'
					,'Datang'
					,'XinYo'
					,'BetDeal'
					,'bigbet'
					,'Mabe88'
					,'Dade'
					,'Aplus'
					,'BoAPI06'
					,'BoAPI05'
					,'ZhiFeng267'
					,'ZF267SW'
					,'ZhiFeng168'
					,'TitanOne'
					,'ZF138USD'
					,'Junbet'
					,'M18SW'
					,'b88club'
					,'SV6789'
					,'kzsbxjCV'
					,'G4ALL'
					,'Kasking88'
					,'Cullinan'
					,'greatwall'
					,'SDYCV'
					,'Winsplay'
					,'AgclubA19'
					,'KaiHao'
					,'ZhiFeng516'
					,'sogogo'
					,'US8YAYOU'
					,'Avia'
					,'Hejiyongle'
					,'CQ11'
					,'ZhiFeng266'
					,'JZFortune'
					,'BOG22'
					,'i228bet'
					,'YHY1980'
					,'Tycoon'
					,'Happy1668'
					,'LivebetKR'
					,'TLC'
					,'skykey'
					,'MICL'
					,'Coinbet'
					,'GOAB88'
					,'Holey'
					,'Boying'
					,'TGO'
					,'KeenOcean'
					,'Liga'
					,'10BET'
					,'Mgm88'
					,'Hong88'
					,'Zzun88'
					,'Bwinning'
					,'Leon'
					,'Platinum'
					,'Winner99'
					,'12betco'
					,'Hbobet'
					,'Allbetclub'
					,'BE7TH'
					,'BlueOcean'
					,'Doctorgame'
					,'HonorW'
					,'Monstergol'
					,'11bet'
					,'starsoccer'
					,'ZhiFeng876'
					,'Mbet'
					,'Ratugg'
					,'Lagadewa'
					,'One88'
					,'Lucky88'
					,'ZF310b'
					,'Indowin'
					,'Webet138'
					,'sbcbet'
					,'Uwin18'
					,'AOGcasino'
					,'DAYWIN'
					,'THBET'
					,'mymbet'
					,'ZhiFeng306'
					,'ZF881SW'
					,'Citybk'
					,'Fugui'
					,'Dachen'
					,'ZFRT282'
					,'Bobbet'
					,'ST888'
					,'laba360'
					,'MAX88'
					,'w1royal'
					,'sea168'
					,'zhsl1234'
					,'18Luck'
					,'ZhiFeng784'
					,'JK8API'
					,'YYGacor'
					,'ZhiFeng282'
					,'Kudatogel'
					,'ZFRT264'
					,'HaHaGaming'
					,'Pay4d2'
					,'Pay4d3'
					,'58clubCV'
					,'Cat368'
					,'ZhiFeng476'
					,'gbkj'
					,'NBGAMES'
					,'HJTK'
					,'Supers99'
					,'bb168'
					,'ANGbet'
					,'Arlocash'
					,'WBS'
					,'YBTech'
					,'BETSUN'
					,'ZhiFeng831'
					,'CGIEngine'
					,'Joker'
					,'BET168GAME'
					,'ZhiFeng753'
					,'Gameroom'
					,'iProBET'
					,'Fabet'
					,'ZhiFeng667'
					,'SSSGaming'
					,'Nbbet'
					,'yongleCV'
					,'Stavki'
					,'ZFRT520'
					,'Jumbo88'
					,'Yabo3'
					,'Zhifeng215'
					,'SDYSW'
					,'BOSSB'
					,'TYM2'
					,'ZhiFeng200'
					,'BWGaming'
					,'LEGaming'
					,'5ATech'
					,'OESports'
					,'WSlots'
					,'KingBet'
					,'yuanbaoCV'
					,'mbxusdt'
					,'ZF138VND'
					,'Apollo'
					,'Siamgame'
					,'Spark'
					,'YTX'
					,'JIDU'
					,'Bobbet2'
					,'ZhiFeng107'
					,'ZhiFeng173'
					,'ZhiFeng180'
					,'ZhiFeng178'
					,'ZhiFeng084'
					,'G2Win'
					,'STEBBCBI'
					,'Newbet'
					,'Soon88CV'
					,'Red88'
					,'Lode88'
					,'DTGW'
					,'9wSB'
					,'WUYICP'
					,'dabo88'
					,'ZhiFeng116'
					,'Tianbo'
					,'Storm88'
					,'ZFRT082'
					,'Bsdbet'
					,'HBO999'
					,'SV88'
					,'TYCgame'
					,'MFgame'
					,'MRCATSB'
					,'IDNUPVND'
					,'CCLive'
					,'TYgamingSW'
					,'ZFRT155new'
					,'ZFRT263'
					,'BoinGroup'
					,'Five88'
					,'ZFRT259'
					,'lionsclub'
					,'ZhiFeng253'
					,'Calibet'
					,'FKsport'
					,'weicai'
					,'ZhiFeng050'
					,'XuanYuan'
					,'OGWLS'
					,'ZhiFeng094'
					,'ZhiFeng248'
					,'dghashCV'
					,'ZFRT242'
					,'ZhiFeng242'
					,'tcycyl'
					,'TSLA'
					,'Twowin'
					,'JUYOU'
					,'CMBSW'
					,'KingFun'
					,'test0624'
					,'AJJCV'
					,'ZhiFeng223'
					,'ZhiFeng221'
					,'JUNBOVN'
					,'LUCKYBET'
					,'Axiawin'
					,'Asiasigma'
					,'Winn69'
					,'TYVNZZXL'
					,'ZhiFeng142'
					,'Vietwin88'
					,'Dabet'
					,'Kbet'
					,'Sky88'
					,'ZFRT372'
					,'XO88'
					,'Nbet'
					,'OBline'
					,'RICbet'
					,'OXbet'
					,'TIC88'
					,'HC6YAYOU'
					,'bolaroyal'
					,'Asia999'
					,'LS88'
					,'ZhiFeng046'
					,'ZhiFeng442'
					,'Baolong'
					,'ZFRT122'
					,'ZhiFeng937'
					,'HongChow'
					,'QQCLUBS'
					,'Bindasbet'
					,'dylive'
					,'ZhiFeng945'
					,'Jinyazhou'
					,'SSSSEA'
					,'818Bet'
					,'CCLV'
					,'K8VN'
					,'PanguGame'
					,'Swin'
					,'Powerslot'
					,'May88'
					,'okbanoi'
					,'Taya'
					,'TayaCV'
					,'Rich11'
					,'NGgame'
					,'DUOLE'
					,'OXPLAY2'
					,'OlaTigerSW'
					,'AGCasia'
					,'KDSLOTS'
					,'LivebetIDR'
					,'alogeu'
					,'Dogzilla'
					,'ACE99'
					,'VCasia'
					,'ZhiFeng710'
					,'ZhiFeng613'
					,'iuplay1'
					,'FBstorm'
					,'iuplay2'
					,'ZFRT150'
					,'ZFRT125MGT'
					,'ZFRT069'
					,'Apollo369'
					,'IgameTech'
					,'CENTRAL168'
					,'dj888'
					,'ZhiFeng106'
					,'ZFRT156'
					,'NEWBALL'
					,'d3sports'
					,'ZFRT143'
					,'ZhiFeng083'
					,'ZFRT162'
					,'LABTESTING'
					,'ZFRT167T'
					,'ZF371'
					,'CAplusCV'
					,'KOKVN'
					,'TH3'
					,'ZhiFeng371'
					,'ZFRT161'
					,'Towin'
					,'KOKVN2'
					,'ZhiFeng071'
					,'QUBO'
					,'ZhiFeng132'
					,'ZF057Celeb'
					,'ZhiFeng026'
					,'AOBOCV'
					,'ZhiFeng098'
					,'HFYX'
					,'KZO41'
					,'Aongroup'
					,'De365'
					,'vedagaming'
					,'TGAA0813'
					,'ZhiFeng156'
					,'ZF132A'
					,'XinliCV'
					,'ZFRT193'
					,'ZF316SW'
					,'ZF215c'
					,'Letian'
					,'ZFRT155jiu'
					,'B2YCLUB'
					,'ZFRT292'
					,'ZhiFeng030'
					,'ZhiFeng312'
					,'Test012901'
					,'Test012902'
					,'Easywin22'
					,'SAGAME88'
					,'ZhiFeng462'
					,'JIB88'
					,'Comebet'
					,'test021701'
					,'BB3'
					,'XINSHNEG'
					,'Pockerdewa'
					,'THEDEN'
					,'THECLUB'
					,'MSbet'
					,'ZFRT133'
					,'ZhiFeng076'
					,'test021702'
					,'ZFRT115'
					,'Bigwiner'
					,'JudoSlot'
					,'ZFRT128'
					,'7kplatform'
					,'FYyule'
					,'test021703'
					,'ZFRT124'
					,'test021704'
					,'ZFRT127'
					,'ZhiFeng428'
					,'ZFRT125'
					,'HCVIP'
					,'WinWin'
					,'Sin88'
					,'Zbet'
					,'ZFRT480'
					,'Debet'
					,'ZFRT081'
					,'Kraton'
					,'WM8888'
					,'pinbo'
					,'Win68Club'
					,'Man1878'
					,'Opadmin'
					,'IBG'
					,'ROYAL88'
					,'sbt88'
					,'Haoying'
					,'Jarvis'
					,'Datang001'
					,'PCDD'
					,'Luckywin88'
					,'ZhiFeng019'
					,'jinmangguo'
					,'Saibo'
					,'Salon365'
					,'SLC88'
					,'9dianyule'
					,'XTD3'
					,'GS003'
					,'KGvip'
					,'ZFRT142'
					,'Okada'
					,'K8sports'
					,'99UU'
					,'UG2'
					,'BuyWin'
					,'Ty777'
					,'TGame'
					,'BetStar'
					,'ZFRT155'
					,'MrCat'
					,'Sun988'
					,'ECBet88'
					,'F88KRW'
					,'VGS'
					,'GDC'
					,'Lambo777'
					,'TCL'
					,'Saloncs'
					,'XTD2'
					,'XTD1'
					,'TooBet'
					,'LZYQ'
					,'Greenplay'
					,'Star99'
					,'666VIP'
					,'21Cash'
					,'LongBao'
					,'Citibet'
					,'Inbet'
					,'Ibobet'
					,'Wuming'
					,'Empire555'
					,'SG8'
					,'TS'
					,'Mirabet'
					,'K8'
					,'67BET'
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
