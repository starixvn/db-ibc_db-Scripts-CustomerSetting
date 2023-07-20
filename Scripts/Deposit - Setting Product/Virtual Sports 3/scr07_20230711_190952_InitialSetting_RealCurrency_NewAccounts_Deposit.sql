/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20230711
	Task: Create setting for Virtual Sports 3 Deposit (New accounts) [Redmine: #190952]
	DB: DBCust/CustDB
*/

DECLARE @max_custid INT = xxx

DECLARE	@Sporttype	SMALLINT = 178,
		@Bettype	SMALLINT = 5302,
		@fSporttype	SMALLINT = 190,
		@fBettype	SMALLINT = 2701

--> Athena & API Licensees
CREATE TABLE #supers(custid int)

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK)
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	CROSS APPLY Dep_ProductBetSetting ps WITH (NOLOCK)
WHERE ci.username NOT LIKE '3rdSuper%'
	AND ci.Enabled = 1
	AND site IN ('12Bet','18Luck','24AVIA','365online','383sport','3ge888','3star88','633esports','7kplatform','88Macao','9bet','9Club','9w','A1game','ab6688','Abcasino','ACsports','Ae88','AEUG','AKYL99','Aladdin99','allwincity','alog','Alphalota','AnvoFH','Aoncash','Athena000','B24VN','Baji','Barcelo9','BBIN2','BBIN3','bdtt','BE7','beplay','BigGaming','Bigwiner','bmwbet','Bobo88','Bolanation','Bonanza88','BPLE','C7YOUXI','C88bet','Callmeboss','CCLive','CGame','Dade','dafd','Dawoo','Dawooxin','DBP','DCSDemo','DDwin','DEWA','DFGame','Diamond','DingTai','DMsports','DTGJZ','e8casino','ECBet88','ECLBET','erhaozhan','FB88','FHLMSABA','G4ALL','GAMEBee','GamingSoft','Gampag','Gaobet','GESAB','haifa','HBPT','HC6YAYOU','Heaven','Hecbet','HFYX','HIDZ','hjccasino','HL8','HOT99','HuangMa','HY6','iBET','IBO','ig128','infini88','INSERTGAME','IONclub','ITCbet','JDJDAPI','JIBET','Jiuyou','JJBGAME','JUYOU','kbosports','KingBet','KUTECH','LegendWin','Leng4D','LIGAWLHKB','LLgaming','loc','Lode88','LUCKYBET','M8bola','M8Credit','Macaubet','ManCity','Mancity2','Mayayule','Mayibet','mbxusdt','MICL','Monaco','Mopgaming','MTech','MYGAME','N88','N8B','N8BK','N8G','NewFuture','OBGM','OBsystem','OCMS','OESports','OPEBET','Ot88','OYO','PLAYES','pmwint','Q8bola','Raisetech','Rio66','Saba789','SampleSite','ScaleDemo1','ScaleDemo2','SDY','sea168','SGM88','SKY1688','skykey','Soon88','spondemo','starsoccer','STEBBCBI','Sunriseb2b','Sunwin','SWSite','TangChao','TaoCai','TCbet','Tesla','TGAA0813','Titanbet','TopGame','Towin','Tripleone','TSLA','TT128','TXJT','txwl002','TYgaming','TYM2','US8YAYOU','Uwoniwin','VCBA','VEGA77','VKGAME','vnggame','VWIN66','WABET','Wanbo','Wanfang','WBG88','Wcasino','Wcasino88','webet88','win365','Winbox','WINCLUB88','WINHX1','WKCUR','WKPHIL','WLSTAR','wmcasino','WRServices','Xiaojin','Xinbo','XTSB','Yibo','Yintai','YongBao','YSYBO688','Yunji','YYHbet','ZF026','ZF055PMW','ZF133FIN2','ZF138THB','ZF138USD','ZF138VND','ZF215aTR','ZFRT090','ZFRT126','ZFRT132','ZFRT144','ZFRT155new','ZFRT156','ZFRT159','ZFRT161','ZFRT165','ZFRT166','ZFRT179','ZFRT195','ZFRT213','ZFRT218','ZFRT219','ZFRT263','ZFRT264','ZFRT276','ZFRT282','ZFRT80GPGT','ZhiFeng009','ZhiFeng012','ZhiFeng013','ZhiFeng021','ZhiFeng030','ZhiFeng032','ZhiFeng035','ZhiFeng036','ZhiFeng040','ZhiFeng041','ZhiFeng051','ZhiFeng138','ZhiFeng147','ZhiFeng183','ZhiFeng221','ZhiFeng222','ZhiFeng228','ZhiFeng253','ZhiFeng267','ZhiFeng271','ZhiFeng303','Zowin','zt828','ZTech')
	AND ps.Sporttype = @Sporttype AND ps.Bettype = @Bettype AND ps.Currency = ci.currency

CREATE TABLE #Dummy(CustID INT PRIMARY KEY)

INSERT INTO #Dummy(CustID)
SELECT CustID FROM Customer WITH(NOLOCK) 
WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 3 
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

CREATE TABLE #SMATemp
(
	CustID INT PRIMARY KEY 
	,RoleID TINYINT
	,mrecommend INT
	,currency INT
)
	
INSERT INTO #SMATemp(CustID, RoleID, mrecommend, currency)
SELECT custid, roleid, mrecommend, currency
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @max_custid 
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

CREATE TABLE #MemberTemp
(
	CustID INT PRIMARY KEY
	,mrecommend INT
	,currency INT
)

INSERT INTO #MemberTemp(CustID, mrecommend, currency)
SELECT custid, mrecommend, currency
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 1  AND Enabled = 1 AND custid > @max_custid	
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

DECLARE @bitmapOrder INT 
	 
SELECT @bitmapOrder = bitmapOrder 
FROM dbo.Dep_ProductStatusProfile m WITH (NOLOCK) 
WHERE m.Sporttype = @SportType AND m.Bettype = @BetType

--------------------------------------------Product Status------------------------------------------------
CREATE TABLE #AllUsers (CustID int PRIMARY KEY)

INSERT INTO #AllUsers (CustID)
SELECT DISTINCT SMA.CustID FROM #SMATemp SMA WITH (NOLOCK)
UNION 
SELECT DISTINCT M.CustID FROM #MemberTemp M WITH (NOLOCK)

CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY, bitmapIsHidden binary(32), bitmapIsDisabled binary(32))

INSERT INTO #Dep_CustProductStatus(CustID, bitmapIsHidden, bitmapIsDisabled)
SELECT c.CustID
	,bitmapIsHidden = dbo.f_GenerateProductStatus(c.bitmapIsHidden, psp.bitmapOrder, 0)
	,bitmapIsDisabled = dbo.f_GenerateProductStatus(c.bitmapIsDisabled, psp.bitmapOrder, 0)
FROM Dep_CustProductStatus c WITH(NOLOCK)
	INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON psp.Bettype = @BetType AND psp.Sporttype = @SportType
	INNER JOIN  #AllUsers temp ON temp.CustID = c.custid

UPDATE c 
SET  c.bitmapIsHidden = tmp.bitmapIsHidden
	,c.bitmapIsDisabled = tmp.bitmapIsDisabled
FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
	INNER JOIN #Dep_CustProductStatus tmp ON c.CustID = tmp.CustID

INSERT INTO Dep_CustProductStatus (CustID,bitmapIsDisabled,bitmapIsHidden)
SELECT	A.custid
		, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitMapOrder,0) AS bitmapIsDisabled
		, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitMapOrder,0)  AS bitmapIsHidden
FROM #AllUsers A WITH (NOLOCK)
WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = A.CustID)

INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
SELECT t.custid, 168
FROM #supers t
WHERE t.custid > @max_custid	
	AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting a WITH(NOLOCK) WHERE a.CustID = t.custid AND a.ProductSettingID = 168)

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
		,@Sporttype
		,@Bettype
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
		,@Sporttype
		,@Bettype
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
	,@Sporttype
	,@Bettype
	,cs.IsLive
	,cs.SuperPT
	,cs.MasterPT
	,cs.AgentPT
FROM #SMATemp d
	INNER JOIN Dep_CustPTGroupSetting_Member cs WITH (NOLOCK) ON cs.AgentID = d.CustID
WHERE d.roleid = 2
	AND cs.SportType = @fSporttype AND cs.BetType = @fBettype

INSERT INTO Dep_CustSettingMode(CustID, IsGroupedPT)
SELECT t.CustID, 1
FROM #MemberTemp t WITH (NOLOCK)
WHERE NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode WITH (NOLOCK) WHERE CustID=t.CustID)
AND NOT EXISTS (SELECT 1 FROM Dep_CustBAActive BA WITH (NOLOCK) WHERE BA.CustId=t.CustID)

INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
SELECT t.custid, 169
FROM #supers t
WHERE t.custid > @max_custid	
	AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting a WITH(NOLOCK) WHERE a.CustID = t.custid AND a.ProductSettingID = 169)

-------------------------------------------------BetSetting----------------------------------------------------------------
INSERT INTO Dep_CustBetSetting_Agent(
		CustID
	,SportType
	,BetType
	,MinBet
	,MaxBet
	,MaxPerMatch
)
SELECT t.CustID, ps.Sporttype, ps.Bettype, ps.MinBet, ps.MaxBet, ps.MaxPerMatch
FROM #SMATemp t
	CROSS APPLY Dep_ProductBetSetting ps WITH (NOLOCK)
	WHERE ps.SportType = @Sporttype AND ps.BetType = @Bettype AND ps.Currency = t.currency

INSERT INTO Dep_CustBetSetting_Member(
		CustID
	,SportType
	,BetType
	,MinBet
	,MaxBet
	,MaxPerMatch
)
SELECT t.CustID, ps.Sporttype, ps.Bettype, ps.MinBet, ps.MaxBet, ps.MaxPerMatch
FROM #MemberTemp t
	CROSS APPLY Dep_ProductBetSetting ps WITH (NOLOCK)
	WHERE ps.SportType = @Sporttype AND ps.BetType = @Bettype AND ps.Currency = t.currency

INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
SELECT t.custid, 170
FROM #supers t
WHERE t.custid > @max_custid	
	AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting a WITH(NOLOCK) WHERE a.CustID = t.custid AND a.ProductSettingID = 170)

DROP TABLE #SMATemp, #AllUsers, #Dep_CustProductStatus, #Dummy, #MemberTemp, #supers