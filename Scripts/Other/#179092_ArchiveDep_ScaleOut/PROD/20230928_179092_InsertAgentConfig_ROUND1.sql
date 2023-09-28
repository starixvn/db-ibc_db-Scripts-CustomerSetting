/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
Created: 20230928@Eden
Task: ROUND 1: All terminated Licensees
DB: DBCUST.CustDB
*/
USE CustDB
GO
--DELETE all data from Dep_Customer_Archived_Config
DELETE 
FROM Dep_Customer_Archived_Config WITH(ROWLOCK,UPDLOCK)

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
		,'Sin88'
		,'Xiaoxiang'
		,'One88'
		,'11bet'
		,'Zbet'
		,'Liga'
		,'Five88'
		,'HonorW'
		,'OXbet'
		,'Happy1668'
		,'Comebet'
		,'Okada'
		,'Senibet'
		,'Letian'
		,'ANGbet'
		,'IgameTech'
		,'THECLUB'
		,'ZhiFeng098'
		,'ZhiFeng106'
		,'WBS'
		,'5ATech'
		,'USSBET'
		,'MAX88'
		,'Zhifeng215'
		,'KOKVN2'
		,'dj888'
		,'BOG22'
		,'Titank'
		,'weicai'
		,'Hejiyongle'
		,'WRSeamless'
		,'ZFRT115'
		,'SAGAME88'
		,'AJJCV'
		,'JIB88'
		,'YakaGaming'
		,'Unobet'
		,'ZhiFeng201'
		,'ZhiFeng026'
		,'Datang001'
		,'SDYSW'
		,'KSTECH2'
		,'BOSSB'
		,'ZFRT143'
		,'KOKVN'
		,'ZFRT155'
		,'SEAGaming'
		,'BWGaming'
		,'UG2'
		,'WGAMING'
		,'CENTRAL168'
		,'BVCLLC'
		,'XTDGT'
		,'ROYAL88'
		,'KSTECH'
		,'Onegaming'
		,'ZhiFeng156'
		,'ZhiFeng142'
		,'Winsplay'
		,'kzsbxjCV'
		,'ZFRT125'
		,'Bodog'
		,'GGBOOK'
		,'sbt88'
		,'Aonslot'
		,'KhmerG'
		,'afb99'
		,'SunGame'
		,'Royalebet'
		,'QUBO'
		,'Aplus'
		,'GGBOOKES'
		,'NEWBALL'
		,'Vwin'
		,'J9YAYOU'
		,'MayFair'
		,'pinbo'
		,'KZO41'
		,'396Club'
		,'ZFRT198'
		,'ENT22'
		,'ZhiFeng019'
		,'Lucky88'
		,'Avia'
		,'Sunrise'
		,'WeBet168'
		,'ZFRT081'
		,'ENTAPLAY'
		,'ZFRT082'
		,'TitanCraft'
		,'24TECH'
		,'9Wsports'
		,'Red88'
		,'Nbbet'
		,'Fabet'
		,'gbkj'
		,'ZFRT150'
		,'Starnet'
		,'Easywin22'
		,'liv66'
		,'Zzun88'
		,'SG8'
		,'Livebet365'
		,'KeenOcean'
		,'ZhiFeng173'
		,'UwinY'
		,'MFgame'
		,'Jarvis'
		,'Datang'
		,'Siamgame'
		,'BetDeal'
		,'HeleThai'
		,'Asian88'
		,'Champion'
		,'Taipanbet'
		,'Jinyazhou'
		,'Hengcai88'
		,'ZFRT142'
		,'MrCat'
		,'TGO'
		,'Salon365'
		,'BetStar'
		,'GOAB88'
		,'Newhonbet'
		,'HongChow'
		,'TGame'
		,'Baolong'
		,'Brown888'
		,'BB3'
		,'SSSSEA'
		,'Boying'
		,'Nbet'
		,'Uwin18'
		,'818Bet'
		,'ZFRT124'
		,'Ty777'
		,'K8VN'
		,'NBCbet'
		,'ZFRT133'
		,'Saibo'
		,'RICbet'
		,'Emmyo'
		,'9dianyule'
		,'sbcbet'
		,'FYyule'
		,'hl5888'
		,'Sun988'
		,'HONBET'
		,'PanguGame'
		,'XTD3'
		,'LS88'
		,'Webet138'
		,'Swin'
		,'ZhiFeng037'
		,'ZFRT128'
		,'MRCATSB'
		,'AMG'
		,'HCVIP'
		,'WinWin'
		,'Mbet'
		,'XinYo'
		,'laba360'
		,'Bobbet'
		,'Dachen'
		,'TitanOne'
		,'HJTK'
		,'Hong88'
		,'Gameroom'
		,'SSSGaming'
		,'BETSUN'
		,'YBTech'
		,'Citybk'
		,'Fugui'
		,'108bet'
		,'Debet'
		,'Kraton'
		,'Win68Club'
		,'YAYOU'
		,'Man1878'
		,'Bsdbet'
		,'shicaigw'
		,'IBG'
		,'BoinGroup'
		,'Calibet'
		,'Win88'
		,'Luckywin88'
		,'tcycyl'
		,'Winn69'
		,'Axiawin'
		,'Junbet'
		,'Jumbo88'
		,'Spark'
		,'YTX'
		,'JIDU'
		,'G2Win'
		,'SV88'
		,'TYCgame'
		,'WUYICP'
		,'Tianbo'
		,'Storm88'
		,'JZFortune'
		,'HBO999'
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
