/*
	Created: Winnie
	Date: 20181011
	Task: Delete existing data of Deposit Esports
	DB: DBCust/CustDB
*/
 
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------


DECLARE @Sporttype INT = 43, @BetType INT = 1
DECLARE @maxcustid INT=xxx
DECLARE @BALogdate DATETIME=xxx
CREATE TABLE  #tmpCustBAActiveOn(CustID INT PRIMARY KEY)
CREATE TABLE  #tmpCustBAActiveOFF(CustID INT PRIMARY KEY)

CREATE TABLE #supers (custid int)

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.Enabled=1
	AND cs.site IN('Avia','GamingSoft','DBP','HL8','TLC','368Cash','Senibet','HonorW','Vwin','W88','12Bet','alog','mansion88','MayFair','OLE777','Salon365','SunGame'
					,'HAIFA','Bodog','Boma365','Happy1668','Hengcai88','KeenOcean','Unobet','ISC888','3star88','Newhonbet','Zzun88','Abcasino','Hecbet','iBET','Royal'
					,'XTD3','IBO','Liga','88Macao','9Club','Ae88','AG','HONBET','NBCbet','Aoncash','BE7','ITCBet','M8bola','Macaubet','Q8bola','9bet','TGO'
					,'WeBet168','KhmerG','365online','IONclub','Mayayule','Sun988','DEWA','Gampag','sbcbet','Bolanation','HuangMa','Webet138','Boying','webet88','MrCat','PKbet','BigGaming'
					,'NextBet','VCBA','Ty777','Taipanbet','Dawoo','BetStar','FLC','Sunrise','Uwoniwin','ECLBET','PanguGame','TGame','818Bet','Heaven','IGPTech','SSSSEA','K8VN'
					,'GPIGAME','Jinyazhou','Swin','Brown888','396Club','e8casino','HongChow','Lucky88','MAX88','OPEBET','BBIN2','Bobo88','GMASTER','Opal88','Sunriseb2b'
					,'YongBao','ALPHA88','11bet','Aplus','Fugui','zt828','ENTAPLAY','MICL','Tripleone','Yibo','TangChao','WBS','CGame','Xinbo','24TECH'
					,'FB88','9wickets','YBTech','jinmangguo','Monaco','GWORLD','BETSUN','Mybet88','JIBET','Gameroom','Fabet','WINCLUB88','Callmeboss'
					,'Uwin18','GOAB88','108bet','Citybk','HOT88','SSSGaming','ANGbet')

INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'	
		AND ci.Enabled=1
		AND cs.site IN('asiabet88')
		AND ci.currency NOT IN(3,6)


INSERT INTO #tmpCustBAActiveOn(h.CustID)
SELECT DISTINCT Custid FROM DBLIC.bodb_Licensee.dbo.[LicenseeBAHistory] h WITH(NOLOCK) 
WHERE h.OnDate>@BALogdate AND h.Custid<=@maxcustid AND h.Status='Running'
	AND NOT EXISTS(SELECT CustID FROM Dep_CustPTSetting_Member m WITH(NOLOCK) WHERE h.CustID=m.CustID )


INSERT INTO #tmpCustBAActiveOFF(CustID)
SELECT DISTINCT Custid FROM DBLIC.bodb_Licensee.dbo.[LicenseeBAHistory] WITH(NOLOCK) WHERE OffDate>@BALogdate AND Custid<=@maxcustid AND Status='Done'

DELETE t
FROM #tmpCustBAActiveOn t
	INNER JOIN Customer c WITH(NOLOCK) ON t.CustID=c.custid
WHERE c.srecommend NOT IN (SELECT CustID FROM #supers)

DELETE t
FROM #tmpCustBAActiveOFF t
	INNER JOIN Customer c WITH(NOLOCK) ON t.CustID=c.custid
WHERE c.srecommend NOT IN (SELECT CustID FROM #supers)

-- for new BA
INSERT INTO [dbo].[Dep_CustPTSetting_Member]
        (CustID
        ,[SportType]
        ,[BetType]
        ,[IsLive]
        ,[SuperPT]
        ,[MasterPT]
        ,[AgentPT])
SELECT 
		BA.CustId
        ,@Sporttype
        ,@BetType
        ,0
        ,0
        ,0
        ,0
FROM Dep_CustBAActive BA WITH(NOLOCK)
	INNER JOIN Customer c WITH(NOLOCK) ON BA.CustId=c.custid
WHERE BA.CustId>@maxcustid
	AND c.srecommend IN (SELECT CustID FROM #supers)

INSERT INTO [dbo].[Dep_CustPTSetting_Member]
        (CustID
        ,[SportType]
        ,[BetType]
        ,[IsLive]
        ,[SuperPT]
        ,[MasterPT]
        ,[AgentPT])
SELECT 
		BA.CustId
        ,SportType
        ,BetType
        ,0
        ,[SuperPT]
        ,[MasterPT]
        ,[AgentPT]
FROM Dep_CustBAActive BA WITH(NOLOCK)
	INNER JOIN Customer c WITH(NOLOCK) ON BA.CustId=c.custid
	INNER JOIN [Dep_CustPTGroupSetting_Member] s WITH(NOLOCK) ON c.recommend=s.AgentID
WHERE s.SportType<>@Sporttype AND s.BetType<>@BetType AND BA.CustId>@maxcustid
	AND c.srecommend IN (SELECT CustID FROM #supers)

UPDATE m
	SET m.IsGroupedPT=0
FROM Dep_CustSettingMode m WITH(NOLOCK)
	INNER JOIN Dep_CustBAActive ba WITH(NOLOCK) ON m.CustID=ba.CustId
	INNER JOIN Customer c WITH(NOLOCK) ON BA.CustId=c.custid
WHERE BA.CustId>@maxcustid AND c.srecommend IN (SELECT CustID FROM #supers)

INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
SELECT ba.CustId,0
FROM Dep_CustBAActive ba WITH(NOLOCK)
	INNER JOIN Customer c WITH(NOLOCK) ON BA.CustId=c.custid
WHERE c.srecommend IN (SELECT CustID FROM #supers)
	AND NOT EXISTS(SELECT 1 FROM Dep_CustSettingMode m WITH(NOLOCK) WHERE m.CustID=ba.CustId)
	AND ba.CustId>@maxcustid 
-- new on BA
INSERT INTO [dbo].[Dep_CustPTSetting_Member]
        (CustID
        ,[SportType]
        ,[BetType]
        ,[IsLive]
        ,[SuperPT]
        ,[MasterPT]
        ,[AgentPT])
SELECT 
		BA.CustId
        ,@Sporttype
        ,@BetType
        ,0
        ,0
        ,0
        ,0
FROM #tmpCustBAActiveOn BA 

INSERT INTO [dbo].[Dep_CustPTSetting_Member]
        (CustID
        ,[SportType]
        ,[BetType]
        ,[IsLive]
        ,[SuperPT]
        ,[MasterPT]
        ,[AgentPT])
SELECT 
		BA.CustId
        ,SportType
        ,BetType
        ,0
        ,[SuperPT]
        ,[MasterPT]
        ,[AgentPT]
FROM #tmpCustBAActiveOn BA WITH(NOLOCK)
	INNER JOIN Customer c WITH(NOLOCK) ON BA.CustId=c.custid
	INNER JOIN [Dep_CustPTGroupSetting_Member] s WITH(NOLOCK) ON c.recommend=s.AgentID
WHERE s.SportType<>@Sporttype AND s.BetType<>@BetType 

UPDATE m
	SET m.IsGroupedPT=0
FROM Dep_CustSettingMode m WITH(NOLOCK)
	INNER JOIN #tmpCustBAActiveOn ba WITH(NOLOCK) ON m.CustID=ba.CustId

INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
SELECT ba.CustId,0
FROM #tmpCustBAActiveOn ba WITH(NOLOCK)
WHERE NOT EXISTS(SELECT 1 FROM Dep_CustSettingMode m WITH(NOLOCK) WHERE m.CustID=ba.CustId)
	
-- new off BA

UPDATE m
	SET m.IsGroupedPT=1
FROM Dep_CustSettingMode m WITH(NOLOCK)
	INNER JOIN #tmpCustBAActiveOFF ba WITH(NOLOCK) ON m.CustID=ba.CustId

DELETE FROM [Dep_CustPTSetting_Member]
WHERE CustID IN(SELECT CustID FROM #tmpCustBAActiveOFF)


DROP TABLE #tmpCustBAActiveOFF
DROP TABLE #tmpCustBAActiveOn