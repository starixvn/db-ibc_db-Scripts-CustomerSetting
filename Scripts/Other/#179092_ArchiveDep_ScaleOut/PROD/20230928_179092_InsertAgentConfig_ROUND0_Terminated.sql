/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
Created: 20230928@Eden
Task: ROUND 0: All terminated Licensees
	add temp linked server _tmpDBSite1, _tmpDBSite2 to connect Sitedb01,sitedb02
DB: DBCUST.CustDB
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
FROM #TempDeleted t
	INNER JOIN  Dep_Customer_Archived d WITH(ROWLOCK)  
		ON t.CustID = d.CustID
-------------------------------------

DECLARE @MinBalance money = 1000000000
,@Mindays INT = 0

CREATE TABLE #TempAgents (CustID INT PRIMARY KEY)

INSERT INTO #TempAgents(CustID)
SELECT c.custid
FROM customer c(NOLOCK) 
WHERE c.roleid = 2
	AND c.username NOT LIKE '%ACC%'
	AND c.creatdate <= DATEADD(dd,-@Mindays,GETDATE())
	AND c.srecommend IN( SELECT CustID FROM Dep_CustSuper WITH(NOLOCK))
	AND c.site IN (
		'Sky88'
		,'IGPTech'
		,'Xiaoxiang'
		,'Sin88'
		,'One88'
		,'11bet'
		,'WKCUR'
		,'Zbet'
		,'LUCKYBET'
		,'Liga'
		,'Five88'
		,'TLC'
		,'HonorW'
		,'IgameTech'
		,'18Luck'
		,'BBIN2'
		,'OXbet'
		,'Happy1668'
		,'Soon88'
		,'TGAA0813'
		,'lionsclub'
		,'WKPHIL'
		,'XinliCV'
		,'US8YAYOU'
		,'Comebet'
		,'HC6YAYOU'
		,'TSLA'
		,'ZhiFeng106'
		,'NewFuture'
		,'WRSeamless'
		,'Senibet'
		,'Okada'
		,'webet88'
		,'ZhiFeng098'
		,'Lode88'
		,'ANGbet'
		,'Letian'
		,'Zhifeng215'
		,'Titanbet'
		,'THECLUB'
		,'KOKVN2'
		,'ZFRT156'
		,'SDYSW'
		,'Unobet'
		,'WBS'
		,'5ATech'
		,'MAX88'
		,'USSBET'
		,'JIB88'
		,'SAGAME88'
		,'dj888'
		,'BOG22'
		,'starsoccer'
		,'KSTECH2'
		,'ZFRT115'
		,'Livebet365'
		,'Titank'
		,'YakaGaming'
		,'Hejiyongle'
		,'weicai'
		,'JUYOU'
		,'AJJCV'
		,'WGAMING'
		,'UNOGAMING'
		,'TH3'
		,'UGaming'
		,'Soon88CV'
		,'ZhiFeng201'
		,'ZhiFeng026'
		,'Datang001'
		,'CENTRAL168'
		,'KSTECH'
		,'HX9Candy'
		,'ZFRT143'
		,'GooBet'
		,'SEAGaming'
		,'KOKVN'
		,'88Goals'
		,'Royalebet'
		,'ZFRT155'
		,'Winsplay'
		,'VCBACV'
		,'XTDGT'
		,'BWGaming'
		,'UG2'
		,'NBCbet'
		,'SG8'
		,'Taipanbet'
		,'GGBOOK'
		,'BVCLLC'
		,'GoToWin'
		,'GGBOOKES'
		,'i668bet'
		,'LivebetIDR'
		,'Bodog'
		,'Starnet'
		,'afb99'
		,'GOAB88'
		,'KhmerG'
		,'GMDFD'
		,'RYB95'
		,'Aragon88'
		,'Vwin'
		,'Xinli3CV'
		,'AK318'
		,'Brown888'
		,'28BET'
		,'J9YAYOU'
		,'Wawabet'
		,'Asian88'
		,'Riverich'
		,'ABB688'
		,'luckybuy'
		,'Allbetclub'
		,'MayFair'
		,'Aonslot'
		,'Lexibet'
		,'hl5888'
		,'PLAYES'
		,'396Club'
		,'Tonybet'
		,'yq355'
		,'Sunrise'
		,'kgsports'
		,'ZhiFeng204'
		,'BoAPI02'
		,'ZeAPI01'
		,'OWAPI02'
		,'AMG'
		,'ReBoTest01'
		,'GWORLD'
		,'ReZeTest01'
		,'ENTAPLAY'
		,'Baobet'
		,'kzsbxjCV'
		,'DELA'
		,'ROYAL88'
		,'BoAPI07'
		,'ZF057SQ24'
		,'Emmyo'
		,'OWAPI01'
		,'BopingAPI0'
		,'BoAPI01'
		,'ENT22'
		,'ReZeTest02'
		,'ReBoTest02'
		,'SunGame'
		,'ZhiFeng156'
		,'ZhiFeng142'
		,'Asianbet'
		,'eb6688'
		,'wy6666'
		,'lwl8888'
		,'fl5688'
		,'Hengcai88'
		,'gi6688'
		,'gj7777'
		,'lj9888'
		,'wl5688'
		,'wg5688'
		,'cl668'
		,'Mgm88'
		,'Bwinning'
		,'cx5888'
		,'wsd666'
		,'bcr999'
		,'lebao8888'
		,'fg6666'
		,'gp1688'
		,'pg5688'
		,'Twowin'
		,'WeBet168'
		,'kh5688'
		,'wx7777'
		,'ks5555'
		,'fx9888'
		,'bvl8888'
		,'bw6688'
		,'db5688'
		,'gb688'
		,'hn555'
		,'i228bet'
		,'BananaTech'
		,'GOATbet'
		,'ZFRT125'
		,'Vwin88'
		,'ZhiFeng037'
		,'BoAPI08'
		,'liv66'
		,'Win88'
		,'zeapi02'
		,'ZeAPI03'
		,'demotest01'
		,'TitanCraft'
		,'24TECH'
		,'bpdemotest'
		,'9Wsports'
		,'Champion'
		,'ZhiFeng173'
		,'Onegaming'
		,'YAYOU'
		,'UwinY'
		,'Titan365'
		,'Uwin18'
		,'THEDEN'
		,'shicaigw'
		,'MarvelDH'
		,'King10'
		,'SHABAING'
		,'Sga88'
		,'Deebet'
		,'UUSS'
		,'Winner99'
		,'HONBET'
		,'ZFRT198'
		,'Newhonbet'
		,'108bet'
		,'Hongtu'
		,'Indowin'
		,'Bet2day'
		,'THBET'
		,'Avia'
		,'ZhiFeng168'
		,'CQ11'
		,'wmcasinoS'
		,'Kasking88'
		,'SDYCV'
		,'YHY1980'
		,'baowang188'
		,'QUBO'
		,'ZhiFeng267'
		,'ZF267SW'
		,'KaiHao'
		,'b88club'
		,'Aplus'
		,'HeleThai'
		,'Citybk'
		,'BetDeal'
		,'TitanOne'
		,'BoAPI06'
		,'BoAPI05'
		,'GoldenFCV'
		,'JZFortune'
		,'boapi03'
		,'Datang'
		,'XinYo'
		,'Junbet'
		,'Tycoon'
		,'KeenOcean'
		,'NEWBALL'
		,'LivebetKR'
		,'Holey'
		,'FKsport'
		,'Boying'
		,'sbcbet'
		,'TGO'
		,'KZO41'
		,'Hbobet'
		,'10BET'
		,'Bigwiner'
		,'ZhiFeng019'
		,'ZFRT081'
		,'12betco'
		,'BE7TH'
		,'Platinum'
		,'BlueOcean'
		,'Leon'
		,'Zzun88'
		,'DAYWIN'
		,'Doctorgame'
		,'Hong88'
		,'AOGcasino'
		,'Webet138'
		,'RICbet'
		,'mymbet'
		,'Lucky88'
		,'Mbet'
		,'Luckywin88'
		,'Winn69'
		,'Axiawin'
		,'Jumbo88'
		,'Monstergol'
		,'Lagadewa'
		,'Ratugg'
		,'ZhiFeng223'
		,'ZhiFeng050'
		,'OGWLS'
		,'ZhiFeng094'
		,'IDNUPVND'
		,'ZFRT264'
		,'ZFRT259'
		,'HaHaGaming'
		,'JUNBOVN'
		,'ZhiFeng248'
		,'TYVNZZXL'
		,'dghashCV'
		,'ZFRT263'
		,'dghash'
		,'ZFRT242'
		,'TYgamingSW'
		,'ZFRT155new'
		,'VCasia'
		,'alogeu'
		,'SLC88'
		,'DUOLE'
		,'May88'
		,'Swin'
		,'PanguGame'
		,'K8VN'
		,'818Bet'
		,'SSSSEA'
		,'Jinyazhou'
		,'HongChow'
		,'TIC88'
		,'Nbet'
		,'Kbet'
		,'Dabet'
		,'XO88'
		,'OBline'
		,'Saibo'
		,'Asia999'
		,'LS88'
		,'ZhiFeng046'
		,'9dianyule'
		,'Baolong'
		,'ZFRT122'
		,'ZFRT124'
		,'FYyule'
		,'ZFRT128'
		,'ZhiFeng076'
		,'ZFRT133'
		,'MSbet'
		,'Aongroup'
		,'ZF057Celeb'
		,'ZhiFeng132'
		,'ZhiFeng071'
		,'ZF132A'
		,'ZFRT193'
		,'ZFRT162'
		,'ZhiFeng083'
		,'d3sports'
		,'Apollo369'
		,'ZFRT069'
		,'ZFRT125MGT'
		,'ZFRT150'
		,'iuplay2'
		,'iuplay1'
		,'ZFRT142'
		,'ZFRT127'
		,'test021704'
		,'test021703'
		,'test021702'
		,'test021701'
		,'Test012902'
		,'Test012901'
		,'Easywin22'
		,'BB3'
		,'XINSHNEG'
		,'Gameroom'
		,'Fabet'
		,'Nbbet'
		,'SSSGaming'
		,'BETSUN'
		,'YBTech'
		,'ZhiFeng107'
		,'Arlocash'
		,'ZhiFeng180'
		,'HJTK'
		,'ZhiFeng178'
		,'Fugui'
		,'gbkj'
		,'LEGaming'
		,'Dachen'
		,'Bobbet'
		,'STEBBCBI'
		,'ZhiFeng200'
		,'JIDU'
		,'Bobbet2'
		,'YTX'
		,'Spark'
		,'G2Win'
		,'Siamgame'
		,'Apollo'
		,'BOSSB'
		,'Jarvis'
		,'Newbet'
		,'Yabo3'
		,'Red88'
		,'Vietwin88'
		,'DTGW'
		,'9wSB'
		,'test0624'
		,'WUYICP'
		,'dabo88'
		,'Tianbo'
		,'Storm88'
		,'HBO999'
		,'TYCgame'
		,'MFgame'
		,'tcycyl'
		,'XuanYuan'
		,'SV88'
		,'Calibet'
		,'Bsdbet'
		,'sbt88'
		,'ZFRT082'
		,'BoinGroup'
		,'ZhiFeng116'
		,'MRCATSB'
		,'Kudatogel'
		,'laba360'
		,'ZF138USD'
		,'ZhiFeng282'
		,'Salon365'
		,'XTD3'
		,'Sun988'
		,'MrCat'
		,'BetStar'
		,'TGame'
		,'Ty777'
		,'ZhiFeng266'
		,'BuyWin'
		,'K8sports'
		,'KGvip'
		,'Wuming'
		,'99UU'
		,'PCDD'
		,'Opadmin'
		,'Haoying'
		,'jinmangguo'
		,'IBG'
		,'Man1878'
		,'VGS'
		,'Win68Club'
		,'pinbo'
		,'Kraton'
		,'Debet'
		,'HCVIP'
		,'WinWin'
		,'WM8888'
		,'LZYQ'
		,'TCL'
		,'GDC'
		,'Star99'
		,'TooBet'
		,'21Cash'
		,'Citibet'
		,'Empire555'
		,'Mirabet'
		,'TS'
		,'Inbet'
		,'666VIP'
		,'Greenplay'
		,'LongBao'
		,'Lambo777'
		,'Saloncs'
		,'K8'
		,'XTD2'
		,'XTD1'
		,'Ibobet'
		,'67BET'
	)

DECLARE @tmpClearBalCustID INT, 
        @ErrCode           INT           = 0, 
        @ErrMsg            NVARCHAR(200) = '', 
        @CreatorID         INT           = 10278938, 
        @IP                VARCHAR(50)   = '0.0.0.0', 
        @Pass              VARCHAR(100)  = '8058095B7DDB08A608811097E5DB8D', 
        @tmpDumUserName    VARCHAR(30), 
        @AgentID			INT,
		@SiteDBGroupID		SMALLINT

SELECT c.custid AS Recommend,cu.site,@MinBalance AS MinBalance,@Mindays AS MinDays,ClearBal.CustID AS CustIDBalanceDummy, 0 AS Status,c.username AS Agent,s.SiteDBGroupID
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
	SELECT @AgentID = null, @tmpClearBalCustID = null, @tmpDumUserName = null, @ErrMsg = '',@ErrCode = 0, @SiteDBGroupID = NULL

	SELECT TOP(1) @AgentID = Recommend, @tmpDumUserName = Agent + 'ClearBal', @SiteDBGroupID = SiteDBGroupID
	FROM #Dep_Customer_Archived_Config
	WHERE CustIDBalanceDummy IS NULL

	IF @@ROWCOUNT = 0
	BREAK

	EXEC Acc_Dep_CustomerInsMember_Ag 
		@custid=@tmpClearBalCustID OUTPUT
		,@creator=@creatorID
		,@username=@tmpDumUserName
		,@userpwd=@Pass
		,@recommend=@AgentID
		,@IP=@IP
		,@ErrCode=@ErrCode OUTPUT
		,@ErrMsg=@ErrMsg OUTPUT

	IF @ErrMsg <> ''
	BEGIN
		PRINT 'AgentID ' + CAST(@AgentID AS VARCHAR) + ': ' + @ErrMsg

		UPDATE #Dep_Customer_Archived_Config
		SET CustIDBalanceDummy = 0
		WHERE Recommend = @AgentID
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
