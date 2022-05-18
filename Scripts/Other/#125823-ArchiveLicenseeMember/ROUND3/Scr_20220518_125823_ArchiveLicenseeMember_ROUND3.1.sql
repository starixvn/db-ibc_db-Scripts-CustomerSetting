/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220518@Eden
	Task: https://nexdev.net/issues/125823
		ROUND 3.1: All terminated Licensees
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

DECLARE @MinBalance money = 1000000000
		,@Mindays INT = 0

CREATE TABLE #TempAgents (CustID INT PRIMARY KEY)

INSERT INTO #TempAgents
SELECT c.custid
FROM customer c(NOLOCK) 
WHERE c.site IN ('108bet'
				,'Fugui'
				,'ENTAPLAY'
				,'Aplus'
				,'YBTech'
				,'24TECH'
				,'BETSUN'
				,'SSSGaming'
				,'Nbbet'
				,'Fabet'
				,'Gameroom'
				,'Hong88'
				,'BetDeal'
				,'HJTK'
				,'TitanOne'
				,'gbkj'
				,'Dachen'
				,'Bobbet'
				,'laba360'
				,'XinYo'
				,'Mbet'
				,'WinWin'
				,'HCVIP'
				,'AMG'
				,'MRCATSB'
				,'Debet'
				,'Kraton'
				,'pinbo'
				,'Win68Club'
				,'GGBOOK'
				,'UwinY'
				,'YAYOU'
				,'Man1878'
				,'shicaigw'
				,'HeleThai'
				,'Onegaming'
				,'IBG'
				,'BoinGroup'
				,'Champion'
				,'sbt88'
				,'Calibet'
				,'Win88'
				,'Luckywin88'
				,'tcycyl'
				,'Asian88'
				,'Winn69'
				,'Axiawin'
				,'ENT22'
				,'Jumbo88'
				,'BOSSB'
				,'Siamgame'
				,'Datang'
				,'Spark'
				,'YTX'
				,'JIDU'
				,'G2Win'
				,'SunGame'
				,'MayFair'
				,'Zzun88'
				,'Bodog'
				,'Vwin'
				,'Avia'
				,'Salon365'
				,'Hengcai88'
				,'KeenOcean'
				,'XTD3'
				,'HONBET'
				,'NBCbet'
				,'WeBet168'
				,'Newhonbet'
				,'TGO'
				,'Starnet'
				,'sbcbet'
				,'KhmerG'
				,'Sun988'
				,'Webet138'
				,'Emmyo'
				,'Boying'
				,'Brown888'
				,'MrCat'
				,'Taipanbet'
				,'BetStar'
				,'TGame'
				,'Ty777'
				,'Sunrise'
				,'Swin'
				,'PanguGame'
				,'K8VN'
				,'Lucky88'
				,'818Bet'
				,'SSSSEA'
				,'Jinyazhou'
				,'396Club'
				,'HongChow'
				,'liv66'
				,'Nbet'
				,'Saibo'
				,'J9YAYOU'
				,'LS88'
				,'ZhiFeng037'
				,'9dianyule'
				,'Baolong'
				,'ZFRT124'
				,'FYyule'
				,'ZFRT128'
				,'ZFRT133'
				,'BB3'
				,'Easywin22'
				,'ZFRT142'
				,'ZFRT150'
				,'Jarvis'
				,'Red88'
				,'afb99'
				,'9Wsports'
				,'WUYICP'
				,'Tianbo'
				,'TitanCraft'
				,'Storm88'
				,'JZFortune'
				,'HBO999'
				,'TYCgame'
				,'GGBOOKES'
				,'MFgame'
				,'SV88'
				,'Junbet'
				,'Bsdbet'
				,'ZFRT082'
				)
	AND c.roleid = 2
	AND c.username NOT LIKE '%ACC%'
	AND c.creatdate <= DATEADD(dd,-@Mindays,GETDATE())

DECLARE @tmpClearBalCustID INT, 
        @ErrCode           INT           = 0, 
        @ErrMsg            NVARCHAR(200) = '', 
        @CreatorID         INT           = 10278938, 
        @IP                VARCHAR(50)   = '0.0.0.0', 
        @Pass              VARCHAR(100)  = '8058095B7DDB08A608811097E5DB8D', 
        @KenoListDummy     VARCHAR(MAX)  = '<products><product Bettype="1501" MaxBet="0" MinBet="0" MaxPerMatch="0" IsDisable="1" sPositionTaking="0" mPositionTaking="0" aPositionTaking="0"></product></products>', 
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

--> Insert new dummy clearbal if not exists yet
WHILE 1 = 1
BEGIN
	SELECT @AgentID = null, @tmpClearBalCustID = null, @tmpDumUserName = null, @ErrMsg = '',@ErrCode = 0

	SELECT @AgentID = Recommend, @tmpDumUserName = Agent + 'ClearBal'
	FROM #Dep_Customer_Archived_Config
	WHERE CustIDBalanceDummy IS NULL

	IF @@ROWCOUNT = 0
		BREAK

	
	EXEC Acc_Dep_CustomerInsMember_Ag @custid=@tmpClearBalCustID OUTPUT,
		@creator=@creatorID,@username=@tmpDumUserName,@userpwd=@Pass,@recommend=@AgentID,@DisableNumber=1,
		@MinBetv1=0,@MaxBetv1=0,@MaxPerMatchv1=0,
		@MinBetv2=0,@MaxBetv2=0,@MaxPerMatchv2=0,
		@MinBetv3=0,@MaxBetv3=0,@MaxPerMatchv3=0,
		@MinBetv5=0,@MaxBetv5=0,@MaxPerMatchv5=0,
		@MinBetv8=0,@MaxBetv8=0,@MaxPerMatchv8=0,
		@MinBetv10=0,@MaxBetv10=0,@MaxPerMatchv10=0,
		@MinBetv11=0,@MaxBetv11=0,@MaxPerMatchv11=0,					
		@MinBetv99=0,@MaxBetv99=0,@MaxPerMatchv99=0,
		@MinBetv1MP= 0,@MaxBetv1MP=0,@MaxPerMatchv1MP=0,
		@MinBetv99mp=0,@MaxBetv99mp=0,@MaxPerMatchv99mp=0,
		@MinBetv161=0,@MaxBetv161=0,@MaxPerMatchv161=0,@MaxPerBallv161=0,
		@v1apositiontaking_1=0,@v1apositiontaking_2=0,@v1apositiontaking_3=0,@v1apositiontaking_4=0,@v1apositiontaking_5=0,@v1apositiontaking_6=0,
		@v1apositiontaking_7=0,@v1apositiontaking_8=0,@v1apositiontaking_9=0,@v1apositiontaking_10=0,@v1alivepositiontaking_1=0,@v1alivepositiontaking_3=0,
		@v1alivepositiontaking_7=0,@v1alivepositiontaking_8=0,
		@v2apositiontaking_1=0,@v2apositiontaking_2=0,@v2apositiontaking_3=0,@v2apositiontaking_7=0,@v2apositiontaking_8=0,@v2apositiontaking_20=0,
		@v3apositiontaking_1=0,@v3apositiontaking_2=0,@v3apositiontaking_3=0,@v3apositiontaking_20=0,
		@v5apositiontaking_1=0,@v5apositiontaking_2=0,@v5apositiontaking_3=0,@v5apositiontaking_20=0,
		@v8apositiontaking_1=0,@v8apositiontaking_3=0,@v8apositiontaking_20=0,
		@v10apositiontaking_1=0,@v10apositiontaking_2=0,@v10apositiontaking_3=0,@v10apositiontaking_20=0,
		@v11apositiontaking_1=0,@v11apositiontaking_20=0,					
		@v99apositiontaking_1=0,@v99apositiontaking_2=0,@v99apositiontaking_3=0,@v99apositiontaking_20=0,@v99apositiontaking_9=0,
		@v161apositiontaking_81=0,@v161apositiontaking_83=0,@v161apositiontaking_86=0,@v161apositiontaking_88=0,@v161alivepositiontaking_85=0,
		@v161alivepositiontaking_86=0,@v161alivepositiontaking_87=0,@v161alivepositiontaking_89=0,@v161alivepositiontaking_90=0,
		@KenoList=@KenoListDummy,@IP=@IP,@ErrCode=@ErrCode OUTPUT,@ErrMsg=@ErrMsg OUTPUT

	IF @ErrMsg <> ''
		PRINT 'AgentID' + CAST(@AgentID AS VARCHAR) + ': ' + @ErrMsg
	ELSE 
	BEGIN
		PRINT 'AgentID ' + CAST(@AgentID AS VARCHAR) + ': Create ClearBal dummy successfully'

		UPDATE #Dep_Customer_Archived_Config
		SET CustIDBalanceDummy = @tmpClearBalCustID
		WHERE Recommend = @AgentID
	END
END

IF EXISTS (	SELECT TOP 1 1
			FROM #Dep_Customer_Archived_Config
			WHERE CustIDBalanceDummy IS NULL
)
BEGIN
	SELECT c.Recommend,c.Agent, 'This Agent have not ClearBal account' ERROR
	FROM #Dep_Customer_Archived_Config c (NOLOCK)
	WHERE c.CustIDBalanceDummy IS NULL
	
	RETURN
END

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
FROM #Dep_Customer_Archived_Config 	c
		 INNER JOIN Dep_Customer_Archived_Config cf WITH(ROWLOCK) ON c.Recommend = cf.Recommend
WHERE c.CustIDBalanceDummy IS NOT NULL

DROP TABLE #TempAgents
DROP TABLE #Dep_Customer_Archived_Config
DROP TABLE #TempDeleted

/*
SELECT * FROM Dep_Customer_Archived_Config WITH(NOLOCK) WHERE Status = 0
*/