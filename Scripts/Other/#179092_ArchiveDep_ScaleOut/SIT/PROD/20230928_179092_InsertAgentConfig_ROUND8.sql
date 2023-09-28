/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
Created: 20230928@Eden
Task: ROUND 8: Other licensees
DB: DBCUST.CustDB
*/
USE CustDB
GO
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

DECLARE @MinBalance money = 0
,@Mindays INT = 365

CREATE TABLE #TempAgents (CustID INT PRIMARY KEY)

INSERT INTO #TempAgents(CustID)
SELECT c.custid
FROM customer c(NOLOCK) 
WHERE c.roleid = 2
	AND c.username NOT LIKE '%ACC%'
	AND c.creatdate <= DATEADD(dd,-@Mindays,GETDATE())
	AND c.srecommend IN( SELECT CustID FROM Dep_CustSuper WITH(NOLOCK))
	AND c.site IN (
		'Macaubet'
		,'Winbox'
		,'IBO'
		,'infini88'
		,'Sunwin'
		,'BigGaming'
		,'KUTECH'
		,'SM88'
		,'TSEnter'
		,'MYGAME'
		,'MANBETX'
		,'PKbet'
		,'BSSB168'
		,'Sunriseb2b'
		,'Happy8'
		,'Kzing2'
		,'SL88SW'
		,'WKCUR'
		,'mtegames'
		,'txwl002'
		,'win365'
		,'A1game'
		,'BGCV'
		,'VWIN66'
		,'JDYGaming'
		,'MTech'
		,'633esports'
		,'FB88'
		,'LUCKYBET'
		,'HuangMa'
		,'livv88sw'
		,'9w'
		,'Abcasino'
		,'khmer'
		,'OCMS'
		,'Wanfang'
		,'Aoncash'
		,'Yunji'
		,'FB88CV'
		,'shengboyun'
		,'ab6688'
		,'LIGAWLHKB'
		,'awc'
		,'CGame'
		,'VN88'
		,'ZhiFeng013'
		,'ZhiFeng040'
		,'N8B'
		,'TGXICV'
		,'FHLMSABA'
		,'JJBGAMECV'
		,'ig128s'
		,'18Luck'
		,'BBIN2'
		,'YiboCV'
		,'X2Dynamic'
		,'AG'
		,'TLC'
		,'Callmeboss'
		,'BE7'
		,'Mayibet'
		,'998bet'
		,'Soon88'
		,'BSSB168CV'
		,'Peakk'
		,'Monaco'
		,'HOT99'
		,'iBET'
		,'568WinSW'
		,'TGAA0813'
		,'FLC'
		,'ZFRT090'
		,'WKPHIL'
		,'OLE777'
		,'N88'
		,'HL8'
		,'B24VN'
		,'Raisetech'
		,'ManCity'
		,'WINCLUB88'
		,'Ae88'
		,'DingTai'
		,'Mopgaming'
		,'US8YAYOU'
		,'XinliCV'
		,'9Club'
		,'DBP'
		,'W88CV'
		,'ITCBet'
		,'ARYA'
		,'7kplatform'
		,'ZhiFeng036'
		,'LEIHUO'
		,'Mayayule'
		,'Zowin'
		,'Saba789'
		,'liv66SW'
		,'ZFRT166'
		,'Bobo88'
		,'ZhiFeng035'
		,'HC6YAYOU'
		,'Mybet88'
		,'TopGame'
		,'DawooCV'
		,'JJBGAME'
		,'V9betSW'
		,'MayibetCV'
		,'ZF138THB'
		,'NLDSports'
		,'Tripleone'
		,'ECLBET'
		,'Xinli2CV'
		,'ZhiFeng009'
		,'ALPHA88'
		,'DEWA'
		,'ZhiFeng055'
		,'Diamond'
		,'N8G'
		,'hjccasino'
		,'Q8bola'
		,'RBCV'
		,'DFGame'
		,'GMASTER'
		,'SDY'
		,'JIBET'
		,'e8casino'
		,'JBO'
		,'AnvoFH'
		,'9bet'
		,'NewFuture'
		,'SunriseCV'
		,'V03'
		,'ZhiFeng021'
		,'GPIGAME'
		,'TSLA'
		,'Royal'
		,'WABET'
		,'TCbet'
		,'DongYing'
		,'N8BK'
		,'HIDZ'
		,'VKGAME'
		,'M8Credit'
		,'webet88'
		,'Hecbet'
		,'khmerA2'
		,'VKGAMECV'
		,'WRServices'
		,'OPEBET'
		,'Heaven'
		,'C7YOUXICV'
		,'ZhiFeng147'
		,'Gampag'
		,'allwincity'
		,'ZFRT126CV'
		,'GAMEBee'
		,'beplayCV'
		,'Bonanza88'
		,'BBIN3'
		,'ZFRT126'
		,'Lode88'
		,'INSERTGAME'
		,'Leng4D'
		,'ZhiFeng138'
		,'vssports'
		,'YongBao'
		,'Rio66'
		,'GESAB'
		,'ZFRT156'
		,'dfbetCV'
		,'ZFRT186'
		,'erhaozhan'
		,'CGame4'
		,'TSXJCV'
		,'Rakyat4DSW'
		,'bigbet'
		,'ZF026'
		,'bdtt'
		,'Jiuyou'
		,'Bolanation'
		,'C7YOUXI'
		,'BPLE'
		,'loc'
		,'VCBA'
		,'3star88'
		,'OLE777CV'
		,'88Macao'
		,'allwinCV'
		,'Xinbo'
		,'ID88'
		,'Betway'
		,'LSM99'
		,'GoldenF'
		,'ZhiFeng122'
		,'Weiwei'
		,'ZF055PMW'
		,'ZF138VND'
		,'3ge888'
		,'WINHX1'
		,'Alphalota'
		,'Boma365'
		,'wmcasino'
		,'TYgaming'
		,'e8casinoCV'
		,'ZFRT132'
		,'442ball'
		,'M8bola'
		,'ZhiFeng208'
		,'beplay'
		,'Mancity2'
		,'starsoccer'
		,'F88IN1SW'
		,'Gaobet'
		,'TaoCai'
		,'ABEMT'
		,'bdtt2'
		,'TT128'
		,'OSUSDT'
		,'OkadaSW'
		,'GB888CV'
		,'yuanbao'
		,'ZhiFeng012'
		,'Titanbet'
		,'vnggame'
		,'DF88'
		,'ZFRT195'
		,'YSYBO688'
		,'TH3'
		,'568Win'
		,'OYO'
		,'GBET'
		,'Soon88CV'
		,'ZFRT165'
		,'Omni88'
		,'Aladdin99'
		,'TangChao'
		,'ZFRT129'
		,'ZF215aTR'
		,'Uwoniwin'
		,'ZFRT213'
		,'KingFun'
		,'SEAL888'
		,'bmwbet'
		,'SKY1688'
		,'LLgaming'
		,'GSCSW'
		,'Towin'
		,'ZFRT144'
		,'ZFRT158CV'
		,'MYGAMECV'
		,'ZFRT161'
		,'UNOGAMING'
		,'JUYOU'
		,'HBPT'
		,'ZFRT080'
		,'Yintai'
		,'ZFRT167'
		,'MICL'
		,'Million'
		,'24AVIASL'
		,'FHLMSABAS'
		,'YYHbet'
		,'Nexus'
		,'0sServices'
		,'VCBACV'
		,'DMsports'
		,'383sport'
		,'Barcelo9'
		,'WLSTAR'
		,'ZhiFeng133'
		,'368CashSW'
		,'DTGJZ'
		,'ZFRT144CV'
		,'ZhiFeng084'
		,'OESports'
		,'TXJT'
		,'Dade'
		,'X33Asia'
		,'IGSW'
		,'H1royal'
		,'Dawooxin'
		,'ZFRT218'
		,'ZhiFeng222'
		,'AKYL99'
		,'ZTech'
		,'HFYX'
		,'9wickets'
		,'De365'
		,'Athena000'
		,'ZhiFeng051'
		,'OBGM'
		,'WKIBPH'
		,'XLMEDIA'
		,'NextBet'
		,'ECBet88'
		,'XmenSW'
		,'YSYBO688CV'
		,'OCMSS'
		,'GoToWin'
		,'UGaming'
		,'mbxusdt'
		,'THEDEN'
		,'GmasterS'
		,'spondemo'
		,'LegendWin'
		,'Lefu'
		,'IvoryBet'
		,'kbosports'
		,'ZhiFeng183'
		,'Opal88'
		,'AEUGSW'
		,'HY6'
		,'Bigwiner'
		,'12B'
		,'kbosportCV'
		,'Lucklotter'
		,'ZhiFeng255'
		,'Xinli3CV'
		,'pmwint'
		,'Sabademo'
		,'Riverich'
		,'GoldenF2CV'
		,'ZFRT240'
		,'GoldenF2'
		,'Niu8gaming'
		,'Sunbet138'
		,'STEBBCBI'
	)

DECLARE @tmpClearBalCustID INT, 
        @ErrCode           INT           = 0, 
        @ErrMsg            NVARCHAR(200) = '', 
        @CreatorID         INT           = 10278938, 
        @IP                VARCHAR(50)   = '0.0.0.0', 
        @Pass              VARCHAR(100)  = '8058095B7DDB08A608811097E5DB8D', 
        @tmpDumUserName    VARCHAR(30), 
        @AgentID      INT

SELECT c.custid AS Recommend,cu.site,@MinBalance AS MinBalance,@Mindays AS MinDays,ClearBal.CustID AS CustIDBalanceDummy, 0 AS Status,c.username AS Agent
INTO #Dep_Customer_Archived_Config
FROM custInfo c WITH(NOLOCK)
	INNER JOIN Customer cu WITH(NOLOCK) ON c.custid = cu.custid
	OUTER APPLY (	SELECT TOP 1 Custid 
					FROM custInfo ClearBal WITH(NOLOCK) 
					WHERE ClearBal.recommend = c.recommend
					AND ClearBal.roleid = 1
					AND ClearBal.username LIKE '%ClearBal'
					) ClearBal
WHERE c.srecommend IN ( SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND c.custid IN ( SELECT custid FROM #TempAgents)

CREATE CLUSTERED INDEX ix_TmpDep_Customer_Archived_Config_recommend ON #Dep_Customer_Archived_Config(recommend)

--> Insert new dummy clearbal if not exists yet
WHILE 1 = 1
BEGIN
	SELECT @AgentID = null, @tmpClearBalCustID = null, @tmpDumUserName = null, @ErrMsg = '',@ErrCode = 0

	SELECT TOP(1) @AgentID = Recommend, @tmpDumUserName = Agent + 'ClearBal'
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
