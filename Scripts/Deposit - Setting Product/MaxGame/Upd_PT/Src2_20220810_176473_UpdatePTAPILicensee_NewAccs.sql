/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220810
	Task: Update PT MaxGame new setting newly created customer for Licensee Deposit real currency RedmineID:#176473
	DB: DBCUST/CustDB
	
	P/s : Step 2 Update PT MaxGame new setting newly created customer for Licensee Deposit  real currency
*/
-- BEGIN STEP 2.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

USE CustDB
GO

DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx

CREATE TABLE #MemberTemp (CustID INT PRIMARY KEY CLUSTERED, isfinished BIT DEFAULT(0))
CREATE TABLE #SMATemp    (CustID INT PRIMARY KEY CLUSTERED, RoleID TINYINT, isfinished BIT DEFAULT(0))
CREATE TABLE #MemberBatch (CustID INT PRIMARY KEY CLUSTERED )
CREATE TABLE #SMABatch    (CustID INT PRIMARY KEY CLUSTERED, RoleID TINYINT)

CREATE TABLE #supers (custid INT PRIMARY KEY)
DECLARE @batch SMALLINT = 3000  ,@PT smallmoney = 93.00 
DECLARE @SportBetType TABLE
(
	SportType SMALLINT, 
	BetType   SMALLINT
)
INSERT INTO @SportBetType(SportType, BetType) VALUES (237, 5401)

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.Enabled=1
	AND (cs.site IN('4300', '0sServices', '12bet', '365online', '368Cash', '383sport', '3ge888', '3Star88', '5ATech', '633esports', '88Macao', '9Club', '9wtest', 'A1game', 'ab6688', 'ABcasino', 'AE88', 'AEUG', 'AG', 'Aladdin99', 'ALog', 'ALPHA88', 'Alphalota', 'ANGbet', 'AnvoFH', 'AOGcasino', 'AsiaBet88', 'B24VN', 'Barcelo9', 'beplay', 'Betway', 'BigGaming', 'Bigwiner', 'bmwbet', 'Bobo88', 'Boma365', 'Bonanza88', 'BPLE', 'BWGaming', 'CGame', 'CGame4', 'Dabet', 'Datang001', 'Dawoo', 'Dawooxin', 'DEWA', 'dj888', 'DongYing', 'e8casino', 'ECBet88', 'ECLBET', 'erhaozhan', 'F88IN1SW', 'FB88', 'GAMEBee', 'Gaobet', 'GESAB', 'GMASTER', 'GMDFD', 'GoldenF', 'GoldenF2', 'GPIgame', 'Happy1668', 'HBPT', 'Hecbet', 'Hejiyongle', 'HFYX', 'HIDZ', 'HL8', 'HonorW', 'HY6', 'iBET', 'IBO', 'ID88', 'IGPTech', 'infini88', 'INSERTGAME' , 'JBO', 'JIBET', 'Jiuyou', 'JJBGAME', 'JUNBOVN', 'JUYOU', 'Kbet', 'kgsports', 'KingBet', 'Kingfun', 'KSTECH', 'KSTECH2', 'Kzing2', 'KZSW', 'LegendWin', 'LEIHUO', 'Leng4D', 'Liga', 'LIGAWLHKB', 'LLgaming', 'loc', 'Lode88', 'MANBETX', 'ManCity', 'Mancity2', 'MAX88', 'Mayayule', 'mbxusdt', 'MICL', 'Million', 'MTech', 'Mybet88', 'MYGAME', 'n88clubSW', 'N8BK', 'Nexus', 'Niu8gaming', 'OBGM', 'OCMSS', 'Okada', 'Ole777', 'Opadmin', 'OXbet', 'PINT', 'PKbet', 'PLAYES', 'QASite', 'Rakyat4DSW', 'RICbet', 'Rio66', 'Riverich', 'ROYAL88' , 'SDYSW', 'SEAGaming', 'Senibet', 'Sin88', 'Sky88', 'SL88SW', 'SM88', 'Soon88', 'starsoccer', 'STEBBCBI', 'Sunwin', 'SWDemo', 'SWSite', 'TangChao', 'TaoCai', 'TCbet', 'TH3', 'TIC88', 'Titanbet', 'TLC', 'Towin', 'Tripleone', 'TSEnter', 'TSLA', 'Twowin', 'txwl002', 'UG2', 'ug396', 'UGaming', 'UNOGAMING', 'Uwoniwin', 'V03', 'VCBA', 'VEGA77', 'VKGAME', 'VN88', 'W88', 'WBG88', 'WBS', 'Wcasino', 'Wcasino88', 'Webet88', 'weicai', 'win365', 'WINCLUB88', 'WINHX1', 'Winsplay', 'WKCUR', 'WKPHIL', 'wmcasino', 'wmcasinoS', 'WRSeamless', 'WRServices', 'WSlots', 'X33Asia', 'Xiaojin', 'Xiaoxiang', 'Xinbo', 'XLMEDIA', 'XmenSW', 'XO88', 'XTDGT', 'YakaGaming', 'Yibo', 'Yintai', 'YongBao', 'YSYBO688', 'YYHbet', 'ZhiFeng132', 'Zowin', 'zt828', 'ZTech')
		AND ci.currency IN (2,3,4,6,12,13,15,20,45,46,51,56,61,70,72,94,96)) --RM,US$,TB,EURO,GBP,RMB,IN,UUS,Won,BND,INH,PLN,INR,MKK,MK,USDT

CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
INSERT INTO #Dummy(CustID)
SELECT CustID FROM Customer WITH(NOLOCK) 
WHERE srecommend IN (SELECT custid FROM #supers) AND roleid=3 
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
	
INSERT INTO #SMATemp(CustID,RoleID)
SELECT custid, roleid
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @maxcustID 
AND mrecommend NOT IN (SELECT custid FROM #Dummy)

INSERT INTO #MemberTemp(CustID)
SELECT custid
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 1  AND Enabled = 1 AND custid > @maxcustID	
AND mrecommend NOT IN (SELECT custid FROM #Dummy)

-- SMA LEVEL
WHILE(1 =1)
BEGIN
		
	UPDATE TOP (@batch) c WITH (ROWLOCK)
	SET c.isfinished = 1
	OUTPUT DELETED.CustID,DELETED.RoleID INTO #SMABatch(CustID,RoleID)
	FROM #SMATemp c 
	WHERE isfinished = 0
		
	IF @@ROWCOUNT = 0 BREAK

	-- SMA LEVEL
	UPDATE a 
	SET a.SuperPT = CASE WHEN c.RoleID = 4 THEN @PT ELSE 0 END
		,a.MasterPT = CASE WHEN c.RoleID IN (4,3) THEN @PT ELSE 0 END
		,a.AgentPT= CASE WHEN c.RoleID IN (4,2) THEN @PT ELSE 0 END
	FROM dbo.Dep_CustPTSetting_Agent a WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #SMABatch c WITH(NOLOCK) ON a.CustID = c.CustID
		INNER JOIN @SportBetType t	ON a.SportType = t.SportType AND a.BetType = t.BetType

	--Agent Level
	UPDATE a 
	SET a.AgentPT= @PT
	FROM dbo.Dep_CustPTGroupSetting_Member a WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #SMABatch c WITH(NOLOCK) ON a.AgentID = c.CustID
		INNER JOIN @SportBetType t	ON a.SportType = t.SportType AND a.BetType = t.BetType
	WHERE c.RoleID=2

	TRUNCATE TABLE #SMABatch
END		

--MEMBER LEVEL
	WHILE(1 =1)
	BEGIN
		
		UPDATE TOP (@batch) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID INTO #MemberBatch(CustID)
		FROM #MemberTemp c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK
		--Member Level
		UPDATE a 
		SET a.AgentPT= @PT
		FROM dbo.Dep_CustPTSetting_Member a WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #MemberBatch c WITH(NOLOCK) ON a.CustID = c.CustID
		INNER JOIN @SportBetType t	ON a.SportType = t.SportType AND a.BetType = t.BetType
					
		TRUNCATE TABLE #MemberBatch
	END 
	
DROP TABLE #supers	
DROP TABLE #Dummy
DROP TABLE #SMATemp
DROP TABLE #SMABatch
DROP TABLE #MemberTemp
DROP TABLE #MemberBatch	
GO
PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
