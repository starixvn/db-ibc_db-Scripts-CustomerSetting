/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: @Helios
	Date: 07/06/2024
	Task: Migrate RNG Keno For Headline Is Hidden [#204358]
		- Indirect Account - Line Super:
			Scr 1: 
				product status = disable
				bet setting = 0 / 0/ 0
				Super max PT = 0.9 (max value của Keno đang offer)

			Scr 2:
				product status = disable
				bet setting = 0 / 0/ 0.1
				PT value= 0 (follow rule create new customer)

		- Direct Account:
			For direct Master/ Agent/ Members, will follow:
				product status = disable
				bet setting = 0 / 0/ 0.1
				PT value = max value
				
	DB: DBCust/CustDB
*/
SET NOCOUNT ON

DECLARE
	@maxcustid INT
	, @target     VARCHAR(20)

IF    @@servername IN ('DBCUST' , 'SITDBCUST' , 'TESTDBCUST')
	SET @target = 'DBCUST'
ELSE
	SET @target = 'REPLICATED'

PRINT 'Server Name : ' + @target

DECLARE 

	@SportType			SMALLINT	= 202,
	@BetType			SMALLINT	= 1501,
	@MaxPT			SMALLMONEY
	
SELECT TOP 1 @MaxPT = psd.MaxPT FROM ProductSettingDetail psd WITH (NOLOCK) WHERE psd.SettingType = 18 AND Sporttype = @SportType AND Bettype = @BetType

--Get Super Account Affect
CREATE TABLE #SuperID (SuperID INT , PRIMARY KEY CLUSTERED (SuperID))

INSERT INTO #SuperID 
	(
		SuperID
	)
SELECT c.custid 
FROM Customer c WITH (NOLOCK) 
WHERE c.username IN ('SA-US$','SA-TB','SA-HK$','SA-EURO','SA-AUD','SA-GBP','SA-RMB','SA-IN','SA-JPY','SA-PE','SH-HK$','SH-RMB','SS-RMB')


SELECT @maxcustid = (	SELECT MAX(c.custid) 
				FROM Customer c WITH (NOLOCK)
				INNER JOIN #SuperID si ON c.srecommend = si.SuperID
			   )

CREATE TABLE #DirectMaster (MasterID INT PRIMARY KEY, RoleID INT)
CREATE TABLE #DirectAgent  (AgentID INT PRIMARY KEY, MasterID INT, RoleID INT)
CREATE TABLE #DirectMember (MemberID INT PRIMARY KEY, AgentID INT, MasterID INT, RoleID INT)	


--- Get direct master
INSERT INTO #DirectMaster 
	(
		MasterID
	    , RoleID
	)
SELECT ci.custid, ci.roleid
FROM #SuperID si
INNER JOIN Customer ci WITH(NOLOCK) ON si.SuperID = ci.srecommend
WHERE EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
	AND ci.roleid=3
	AND ci.custid <= @maxcustid
		
--- Get direct agent
INSERT INTO #DirectAgent 
	(
		AgentID
	    , MasterID
	    , RoleID
	)
SELECT ci.custid, ci.mrecommend,ci.roleid
FROM #SuperID si
INNER JOIN Customer ci WITH(NOLOCK) ON si.SuperID = ci.srecommend
WHERE EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
	AND ci.roleid=2
	AND ci.custid <= @maxcustid

--- Get direct Member
INSERT INTO #DirectMember 
	(
		MemberID
	    , AgentID
	    , MasterID
	    , RoleID
	)
SELECT ci.custid, ci.recommend, ci.mrecommend, ci.roleid
FROM #SuperID si
INNER JOIN Customer ci WITH(NOLOCK) ON si.SuperID = ci.srecommend
WHERE EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
	AND ci.roleid=1
	AND ci.custid <= @maxcustid


CREATE TABLE #CustDirectDummyCollected
(
	CustID INT PRIMARY KEY CLUSTERED,
	RoleID TINYINT,
	Type   BIT		-- 0 : Direct Account || 1 : Dummy Account
)

-- Get data Dummy - Direct Account:
INSERT INTO #CustDirectDummyCollected 
	(
		CustID
	    , RoleID
	    , Type
	)
--Get Super Dummy
SELECT si.SuperID , 4 , 1  FROM #SuperID si
UNION
--Get Master
SELECT dm.MasterID , 3 , 0 FROM #DirectMaster dm		-- Direct Master
UNION
SELECT dm.MasterID , 3 , 1 FROM #DirectAgent dm			-- Dummy Master Of Direct Agent
UNION
SELECT dm.MasterID , 3 , 1 FROM #DirectMember dm		-- Dummy Master Of Direct Member
UNION
--Get Agent
SELECT dm.AgentID , 2 , 0 FROM #DirectAgent dm			-- Direct Agent
UNION
SELECT dm.AgentID , 2 , 1 FROM #DirectMember dm			-- Dummy Agent Of Direct Member
UNION
--Get Member
SELECT dm.MemberID , 1 , 0 FROM #DirectMember dm		-- Direct Member


-- Get Data Line Super / Master / Agemt / Member Related Direct Account
CREATE TABLE #TmpCustList
		(
			CustID	INT,
			srecommend	INT,
			mrecommend	INT,
			recommend	INT,
			RoleID	INT,
			PRIMARY KEY CLUSTERED (CustID)
		)

INSERT INTO #TmpCustList 
	(
		CustID
	    , srecommend
	    , mrecommend
	    , recommend
	    , RoleID
	)
SELECT 
		ct.CustID
	    , c.srecommend
	    , c.mrecommend
	    , c.recommend
	    , c.roleid
FROM Customer c WITH (NOLOCK)
INNER JOIN #CustDirectDummyCollected ct ON c.custid = ct.CustID




---------------------------------------Declare Deployed Info---------------------------------------
DECLARE
	  @Batch			INT = 2000
	, @JsonData			VARCHAR(MAX)
	, @Msg			VARCHAR(200)


-------------------------------------------1.PT-------------------------------------------------


SELECT 
	  tcl.srecommend  AS CustID			-- Dummy Super not Exists
	, @sporttype	AS SportType
	, @bettype		AS BetType
	, 0  AS IsLive
	, 0  AS IsAutoMasterPT
	, 0  AS IsAutoSuperPT
	, 85 AS SuperPT
	, 85 AS MasterPT
	, 85 AS AgentPT
	, 0  AS AutoSuperPT
	, 0  AS AutoMasterPT
	, 0  AS MinPT
	, 100 AS MaxPT
FROM #CustDirectDummyCollected ct
LEFT JOIN CustPTSetting3rd_Agent cps WITH (NOLOCK) ON tcl.srecommend = cps.CustID AND cps.SportType = @SportType AND cps.BetType = @BetType
WHERE 
ct.RoleID = 4
AND ct.Type = 1
AND cps.CustID IS NULL

-- Get Data Dummy Super , Dummy Master , Dummy Agent (Type = 1) If Not Exits Data Setting
CREATE TABLE #tmp_DummyMasterAgentPTSetting
	(
		CustID	   INT
	    , SportType	   SMALLINT
	    , BetType	   SMALLINT
	    , IsLive	   BIT
	    , IsAutoMasterPT BIT	
	    , IsAutoSuperPT  BIT	
	    , SuperPT	   SMALLMONEY
	    , MasterPT	   SMALLMONEY
	    , AgentPT	   SMALLMONEY
	    , AutoSuperPT	   SMALLMONEY
	    , AutoMasterPT   SMALLMONEY
	    , MinPT		   SMALLMONEY
	    , MaxPT		   SMALLMONEY
	    , PRIMARY KEY (CustID , SportType , BetType , IsLive)
	)

INSERT INTO #tmp_DummyMasterAgentPTSetting 
(
	CustID
	, SportType
	, BetType
	, IsLive
	, IsAutoMasterPT
	, IsAutoSuperPT
	, SuperPT
	, MasterPT
	, AgentPT
	, AutoSuperPT
	, AutoMasterPT
	, MinPT
	, MaxPT
)

SELECT 
	  tcl.mrecommend AS CustID			-- Dummy Master not Exists
	, cps.SportType
	, cps.BetType
	, cps.IsLive
	, 0 AS IsAutoMasterPT
	, 0 AS IsAutoSuperPT
	, cps.SuperPT
	, 0 AS MasterPT
	, 0 AS AgentPT
	, 0 AS AutoSuperPT
	, 0 AS AutoMasterPT
	, 0 AS MinPT
	, cps.MaxPT
FROM #CustDirectDummyCollected ct
INNER JOIN #TmpCustList tcl ON ct.CustID = tcl.CustID
LEFT JOIN CustPTSetting3rd_Agent cpa WITH (NOLOCK) ON ct.CustID = cpa.CustID AND cpa.SportType = @SportType AND cpa.BetType = @BetType
LEFT JOIN CustPTSetting3rd_Agent cps WITH (NOLOCK) ON tcl.srecommend = cps.CustID AND cps.SportType = @SportType AND cps.BetType = @BetType
WHERE 
ct.RoleID = 3
AND ct.Type = 1
AND cpa.CustID IS NULL
AND cps.CustID IS NOT NULL

UNION ALL

SELECT 
	  tcl1.CustID AS CustID				-- Dummy Agent not Exists Because Master not Exists
	, cps.SportType
	, cps.BetType
	, cps.IsLive
	, 0 AS IsAutoMasterPT
	, 0 AS IsAutoSuperPT
	, 0 AS SuperPT
	, 0 AS MasterPT
	, 0 AS AgentPT
	, 0 AS AutoSuperPT
	, 0 AS AutoMasterPT
	, 0 AS MinPT
	, cps.MaxPT
FROM #CustDirectDummyCollected ct
INNER JOIN #TmpCustList tcl ON ct.CustID = tcl.CustID
INNER JOIN #TmpCustList tcl1 ON tcl.CustID = tcl1.mrecommend AND tcl1.RoleID = 2
LEFT JOIN CustPTSetting3rd_Agent cpa WITH (NOLOCK) ON ct.CustID = cpa.CustID AND cpa.SportType = @SportType AND cpa.BetType = @BetType
LEFT JOIN CustPTSetting3rd_Agent cps WITH (NOLOCK) ON tcl.srecommend = cps.CustID AND cps.SportType = @SportType AND cps.BetType = @BetType
WHERE 
ct.RoleID = 3
AND ct.Type = 1
AND cpa.CustID IS NULL
AND cps.CustID IS NOT NULL

UNION ALL

SELECT 
	  tcl.recommend AS CustID			-- Dummy Agent not Exists
	, cpm.SportType
	, cpm.BetType
	, cpm.IsLive
	, 0 AS IsAutoMasterPT
	, 0 AS IsAutoSuperPT
	, 0 AS SuperPT
	, cpm.MasterPT
	, 0 AS AgentPT
	, 0 AS AutoSuperPT
	, 0 AS AutoMasterPT
	, 0 AS MinPT
	, cpm.MaxPT
	-- ct.* , '_____' AS '_____'  , tcl.* , '_____' AS '_____' , cpa.* ,  '_____' AS '_____', cpm.* 
FROM #CustDirectDummyCollected ct
INNER JOIN #TmpCustList tcl ON ct.CustID = tcl.CustID
LEFT JOIN CustPTSetting3rd_Agent cpa WITH (NOLOCK) ON ct.CustID = cpa.CustID AND cpa.SportType = @SportType AND cpa.BetType = @BetType
LEFT JOIN CustPTSetting3rd_Agent cpm WITH (NOLOCK) ON tcl.mrecommend = cpm.CustID AND cpm.SportType = @SportType AND cpm.BetType = @BetType
WHERE 
ct.RoleID IN (2,3)
AND ct.Type = 1
AND cpa.CustID IS NULL
AND cpm.CustID IS NOT NULL



-- Get Data Direct Account (Type = 0) Is Not Exist Data Setting
CREATE TABLE #tmp_DirectPT_MasterAgentMember		(CustID	   INT  , RoleID  INT, PRIMARY KEY (CustID) )


INSERT INTO #tmp_DirectPT_MasterAgentMember (CustID , RoleID)

SELECT ct.CustID , ct.RoleID
FROM #CustDirectDummyCollected ct
LEFT JOIN CustPTSetting3rd_Agent cpa WITH (NOLOCK) ON ct.CustID = cpa.CustID AND cpa.SportType = @SportType AND cpa.BetType = @BetType
WHERE ct.RoleID IN (2,3) AND ct.Type = 0 AND cpa.CustID IS NULL

UNION ALL

SELECT ct.CustID , ct.RoleID
FROM #CustDirectDummyCollected ct
LEFT JOIN CustPTSetting3rd_Member cpa WITH (NOLOCK) ON ct.CustID = cpa.CustID AND cpa.SportType = @SportType AND cpa.BetType = @BetType
WHERE ct.RoleID IN (1) AND ct.Type = 0AND cpa.CustID IS NULL


CREATE TABLE #tmp_DirectMasterAgentMemberPTSetting
	(
		CustID	   INT
	    , SportType	   SMALLINT
	    , BetType	   SMALLINT
	    , IsLive	   BIT
	    , IsAutoMasterPT BIT	
	    , IsAutoSuperPT  BIT	
	    , SuperPT	   SMALLMONEY
	    , MasterPT	   SMALLMONEY
	    , AgentPT	   SMALLMONEY
	    , AutoSuperPT	   SMALLMONEY
	    , AutoMasterPT   SMALLMONEY
	    , MinPT		   SMALLMONEY
	    , MaxPT		   SMALLMONEY
	    , PRIMARY KEY (CustID , SportType , BetType , IsLive)
	)

-- Get Values Dummy Account (Type = 1) For Insert Direct Account
INSERT INTO #tmp_DirectMasterAgentMemberPTSetting 
(
	  CustID
	, SportType
	, BetType
	, IsLive
	, IsAutoMasterPT
	, IsAutoSuperPT
	, SuperPT
	, MasterPT
	, AgentPT
	, AutoSuperPT
	, AutoMasterPT
	, MinPT
	, MaxPT
)
-- Corrrect Dummy Super For ins Dirrect Master
SELECT
	  tmp.mrecommend AS CustID
	, cpa.SportType
	, cpa.BetType
	, cpa.IsLive
	, 0 AS IsAutoMasterPT
	, 0 AS IsAutoSuperPT
	, cpa.SuperPT
	, 0 AS MasterPT
	, 0 AS AgentPT
	, 0 AS AutoSuperPT
	, 0 AS AutoMasterPT
	, 0 AS MinPT
	, cpa.MaxPT
FROM #tmp_DirectPT_MasterAgentMember APT
INNER JOIN #TmpCustList tmp ON APT.CustID = tmp.CustID AND APT.RoleID = tmp.RoleID
INNER JOIN #CustDirectDummyCollected ct ON tmp.srecommend = ct.CustID AND ct.RoleID = 4 AND ct.Type = 1
INNER JOIN CustPTSetting3rd_Agent cpa WITH (NOLOCK) ON tmp.srecommend = cpa.CustID  AND cpa.SportType = @SportType AND cpa.BetType = @BetType
WHERE tmp.RoleID  = 3

UNION ALL

-- Corrrect Dummy Master For ins Dirrect Agent
SELECT
	  tmp.recommend	AS CustID
	, @SportType	AS SportType
	, @BetType		AS BetType
	, ISNULL(cpa.IsLive , tdmap.IsLive)   AS IsLive
	, 0 AS IsAutoMasterPT
	, 0 AS IsAutoSuperPT
	, 0 AS SuperPT
	, ISNULL(cpa.MasterPT , tdmap.MasterPT)   AS MasterPT
	, 0 AS AgentPT
	, 0 AS AutoSuperPT
	, 0 AS AutoMasterPT
	, 0 AS MinPT
	, 100 AS MaxPT
FROM #tmp_DirectPT_MasterAgentMember APT
INNER JOIN #TmpCustList tmp ON APT.CustID = tmp.CustID AND APT.RoleID = tmp.RoleID
INNER JOIN #CustDirectDummyCollected ct ON tmp.mrecommend = ct.CustID AND ct.RoleID = 3 AND ct.Type = 1
LEFT JOIN CustPTSetting3rd_Agent cpa WITH (NOLOCK) ON tmp.mrecommend = cpa.CustID  AND cpa.SportType = @SportType AND cpa.BetType = @BetType
LEFT JOIN #tmp_DummyMasterAgentPTSetting tdmap  ON tmp.mrecommend = tdmap.CustID AND tdmap.SportType = @SportType AND tdmap.BetType = @BetType
WHERE tmp.RoleID  = 2

UNION ALL

-- Corrrect Dummy Master/Agent For ins Dirrect Member
SELECT
	  tmp.CustID AS CustID
	, @SportType	AS SportType
	, @BetType		AS BetType
	, ISNULL(cpa.IsLive , tdmapa.IsLive)	 AS IsLive
	, 0 AS IsAutoMasterPT
	, 0 AS IsAutoSuperPT
	, ISNULL(cpm.SuperPT , tdmapm.SuperPT)	 AS SuperPT
	, ISNULL(cpa.MasterPT , tdmapa.MasterPT)	 AS MasterPT
	, ISNULL(cpa.AgentPT , tdmapa.AgentPT)	 AS AgentPT
	, 0 AS AutoSuperPT
	, 0 AS AutoMasterPT
	, 0 AS MinPT
	, 0 AS MaxPT
FROM #tmp_DirectPT_MasterAgentMember APT
INNER JOIN #TmpCustList tmp ON APT.CustID = tmp.CustID AND APT.RoleID = tmp.RoleID

--Corrrect Dummy Agent
INNER JOIN #CustDirectDummyCollected cta ON tmp.recommend = cta.CustID AND cta.RoleID = 2 AND cta.Type = 1
LEFT JOIN CustPTSetting3rd_Agent cpa WITH (NOLOCK) ON tmp.recommend = cpa.CustID AND cpa.SportType = @SportType AND cpa.BetType = @BetType
LEFT JOIN #tmp_DummyMasterAgentPTSetting tdmapa ON tmp.recommend = tdmapa.CustID AND tdmapa.SportType = @SportType AND tdmapa.BetType = @BetType

--Corrrect Dummy Master
INNER JOIN #CustDirectDummyCollected ctm ON tmp.mrecommend = ctm.CustID AND ctm.RoleID = 3 AND ctm.Type = 1
LEFT JOIN CustPTSetting3rd_Agent cpm WITH (NOLOCK) ON tmp.mrecommend = cpm.CustID AND cpm.SportType = @SportType AND cpm.BetType = @BetType
LEFT JOIN #tmp_DummyMasterAgentPTSetting tdmapm ON tmp.mrecommend = tdmapm.CustID AND tdmapm.SportType = @SportType AND tdmapm.BetType = @BetType
WHERE  tmp.RoleID  = 1

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE #tmp_PTCollected
	(
		CustID	   INT
	    , SportType	   SMALLINT
	    , BetType	   SMALLINT
	    , IsLive	   BIT
	    , IsAutoMasterPT BIT
	    , IsAutoSuperPT  BIT
	    , SuperPT	   SMALLMONEY
	    , MasterPT	   SMALLMONEY
	    , AgentPT	   SMALLMONEY
	    , AutoSuperPT	   SMALLMONEY
	    , AutoMasterPT   SMALLMONEY
	    , MinPT		   SMALLMONEY
	    , MaxPT		   SMALLMONEY
	    , PRIMARY KEY (CustID , SportType , BetType , IsLive)
	)

INSERT INTO #tmp_PTCollected 
	(
		CustID
	    , SportType
	    , BetType
	    , IsLive
	    , IsAutoMasterPT
	    , IsAutoSuperPT
	    , SuperPT
	    , MasterPT
	    , AgentPT
	    , AutoSuperPT
	    , AutoMasterPT
	    , MinPT
	    , MaxPT
	)
SELECT
		CustID
	    , SportType
	    , BetType
	    , IsLive
	    , IsAutoMasterPT
	    , IsAutoSuperPT
	    , SuperPT
	    , MasterPT
	    , AgentPT
	    , AutoSuperPT
	    , AutoMasterPT
	    , MinPT
	    , MaxPT
FROM #tmp_DummyMasterAgentPTSetting
UNION
SELECT
		CustID
	    , SportType
	    , BetType
	    , IsLive
	    , IsAutoMasterPT
	    , IsAutoSuperPT
	    , SuperPT
	    , MasterPT
	    , AgentPT
	    , AutoSuperPT
	    , AutoMasterPT
	    , MinPT
	    , MaxPT
FROM #tmp_DirectMasterAgentMemberPTSetting


CREATE TABLE #tmp_PTAffected
	(
		CustID	   INT
	    , SportType	   SMALLINT
	    , BetType	   SMALLINT
	    , IsLive	   BIT
	    , IsAutoMasterPT BIT
	    , IsAutoSuperPT  BIT
	    , SuperPT	   SMALLMONEY
	    , MasterPT	   SMALLMONEY
	    , AgentPT	   SMALLMONEY
	    , AutoSuperPT	   SMALLMONEY
	    , AutoMasterPT   SMALLMONEY
	    , MinPT		   SMALLMONEY
	    , MaxPT		   SMALLMONEY
	)
	     	   
WHILE (1=1)
BEGIN
	TRUNCATE TABLE #tmp_PTAffected

	DELETE TOP (@Batch) temp
	OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.IsLive , DELETED.IsAutoMasterPT , DELETED.IsAutoSuperPT , DELETED.SuperPT , DELETED.MasterPT , DELETED.AgentPT , DELETED.AutoSuperPT , DELETED.AutoMasterPT , DELETED.MinPT , DELETED.MaxPT
		INTO #tmp_PTAffected (CustID, SportType, BetType, IsLive, IsAutoMasterPT, IsAutoSuperPT, SuperPT, MasterPT, AgentPT, AutoSuperPT, AutoMasterPT, MinPT, MaxPT)
	FROM #tmp_PTCollected temp
	INNER JOIN #TmpCustList tsa ON temp.CustID = tsa.CustID
	WHERE tsa.RoleID IN (2,3)

	IF @@ROWCOUNT = 0 
			BREAK ;

	SET @JsonData = (	SELECT CustID, SportType, BetType, IsLive, IsAutoMasterPT, IsAutoSuperPT, SuperPT, MasterPT, AgentPT, AutoSuperPT, AutoMasterPT, MinPT, MaxPT
					FROM	#tmp_PTAffected tp
					FOR JSON PATH
			    )

	EXEC dbo.[Acc_DynamicCustSetting3rd_17] @ModeCode = 'PT_MA'
								   , @JsonData = @JsonData
								   , @Target   = @target

	WAITFOR DELAY '00:00:0.050'

	SET @Msg = 'Curdt PT Master/Agent: ' + convert(varchar(50), GETDATE(), 121)
	RAISERROR (@Msg, 0, 1) WITH NOWAIT

END

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #tmp_PTAffected

	DELETE TOP (@Batch) temp
	OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.IsLive , DELETED.IsAutoMasterPT , DELETED.IsAutoSuperPT , DELETED.SuperPT , DELETED.MasterPT , DELETED.AgentPT , DELETED.AutoSuperPT , DELETED.AutoMasterPT
		INTO #tmp_PTAffected (CustID, SportType, BetType, IsLive, IsAutoMasterPT, IsAutoSuperPT, SuperPT, MasterPT, AgentPT, AutoSuperPT, AutoMasterPT)
	FROM #tmp_PTCollected temp
	INNER JOIN #TmpCustList tsa ON temp.CustID = tsa.CustID
	WHERE tsa.RoleID IN (1)

	IF @@ROWCOUNT = 0 
			BREAK ;

	SET @JsonData = (	SELECT CustID, SportType, BetType, IsLive, IsAutoMasterPT, IsAutoSuperPT, SuperPT, MasterPT, AgentPT, AutoSuperPT, AutoMasterPT
					FROM	#tmp_PTAffected tp
					FOR JSON PATH
			    )

	EXEC dbo.[Acc_DynamicCustSetting3rd_17] @ModeCode = 'PT_Member'
								   , @JsonData = @JsonData
								   , @Target   = @target

	WAITFOR DELAY '00:00:0.050'

	SET @Msg = 'Curdt PT Member: ' + convert(varchar(50), GETDATE(), 121)
	RAISERROR (@Msg, 0, 1) WITH NOWAIT

END

---------------------------------------------2.BetSetting-------------------------------------------------

CREATE TABLE #tmp_BetSetting
	(
		CustID	INT
	    , SportType   SMALLINT
	    , BetType     SMALLINT
	    , MinBet	MONEY
	    , MaxBet	MONEY
	    , MaxPerMatch MONEY
	    , PRIMARY KEY (CustID , SportType , BetType)
	)

CREATE TABLE #tmp_BetSettingAffected
	(
		CustID	INT
	    , SportType   SMALLINT
	    , BetType     SMALLINT
	    , MinBet	MONEY
	    , MaxBet	MONEY
	    , MaxPerMatch MONEY
	)

INSERT INTO #tmp_BetSetting 
	(
		CustID
	    , SportType
	    , BetType
	    , MinBet
	    , MaxBet
	    , MaxPerMatch
	)
-- Get BetSetting Master/Agent Direct If Not Exists
SELECT	--temp.RoleID,
		temp.CustID
	    , @SportType	AS SportType
	    , @BetType	AS BetType
	    , 0		AS MinBet
	    , 0		AS MaxBet
	    , 0.10		AS MaxPerMatch
FROM CustBetSetting3rd_Agent cpa WITH (NOLOCK)
RIGHT JOIN #CustDirectDummyCollected temp ON cpa.CustID = temp.CustID AND cpa.SportType = @SportType AND cpa.BetType = @BetType 
WHERE temp.RoleID IN (3,2)
AND temp.Type = 0
AND cpa.CustID IS NULL

UNION ALL

-- Get BetSetting Member Direct If Not Exists
SELECT	--temp.RoleID,
		temp.CustID
	    , @SportType	AS SportType
	    , @BetType	AS BetType
	    , 0		AS MinBet
	    , 0		AS MaxBet
	    , 0.10		AS MaxPerMatch
FROM CustBetSetting3rd_Member cpa WITH (NOLOCK)
RIGHT JOIN #CustDirectDummyCollected temp ON cpa.CustID = temp.CustID AND cpa.SportType = @SportType AND cpa.BetType = @BetType 
WHERE temp.RoleID IN (1)
AND temp.Type = 0
AND cpa.CustID IS NULL


WHILE (1=1)
BEGIN
	TRUNCATE TABLE #tmp_BetSettingAffected

	DELETE TOP (@Batch) temp
	OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.MinBet , DELETED.MaxBet , DELETED.MaxPerMatch
		INTO #tmp_BetSettingAffected (CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
	FROM #tmp_BetSetting temp
	INNER JOIN #CustDirectDummyCollected tsa ON temp.CustID = tsa.CustID
	WHERE tsa.RoleID IN (2,3)

	IF @@ROWCOUNT = 0 
			BREAK ;

	SET @JsonData = (	SELECT CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch
				FROM	#tmp_BetSettingAffected tp
				FOR JSON PATH
			    )

	EXEC dbo.[Acc_DynamicCustSetting3rd_17] @ModeCode = 'BetSetting_MA'
								   , @JsonData = @JsonData
								   , @Target   = @target

	WAITFOR DELAY '00:00:0.050'

	SET @Msg = 'Curdt BetSetting Direct Master/Agent: ' + convert(varchar(50), GETDATE(), 121)
	RAISERROR (@Msg, 0, 1) WITH NOWAIT

END


WHILE (1=1)
BEGIN
	TRUNCATE TABLE #tmp_BetSettingAffected

	DELETE TOP (@Batch) temp
	OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.MinBet , DELETED.MaxBet , DELETED.MaxPerMatch
		INTO #tmp_BetSettingAffected (CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
	FROM #tmp_BetSetting temp
	INNER JOIN #CustDirectDummyCollected tsa ON temp.CustID = tsa.CustID
	WHERE tsa.RoleID IN (1)

	IF @@ROWCOUNT = 0 
			BREAK ;

	SET @JsonData = (	SELECT CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch
					FROM	#tmp_BetSettingAffected tp
					FOR JSON PATH
			    )

	EXEC dbo.[Acc_DynamicCustSetting3rd_17] @ModeCode = 'BetSetting_Member'
								   , @JsonData = @JsonData
								   , @Target   = @target

	WAITFOR DELAY '00:00:0.050'

	SET @Msg = 'Curdt BetSetting Direct Member: ' + convert(varchar(50), GETDATE(), 121)
	RAISERROR (@Msg, 0, 1) WITH NOWAIT

END

-------------------------------------------3.ProductStatus-------------------------------------------------

CREATE TABLE #tmp_ProductStatus
	(
		CustID	     INT
	    , PRIMARY KEY (CustID)
	)

CREATE TABLE #tmp_ProductStatusAffected
	(
		CustID	     INT
	)

IF NOT EXISTS (	
			SELECT TOP 1 1
			FROM #CustDirectDummyCollected tsa
			INNER JOIN CustProductStatus cps WITH (NOLOCK) ON tsa.CustId = cps.CustID
			WHERE tsa.RoleID IN (1,2,3)
		)
BEGIN
	RAISERROR ( N'Error Data Cust ProductStatus', 0, 1) ;
	RETURN;
END
ELSE
BEGIN
	INSERT INTO #tmp_ProductStatus 
	(
		CustID
	)
	SELECT
		cps.CustID
	FROM #CustDirectDummyCollected tsa
	INNER JOIN CustProductStatus cps ON tsa.CustID = cps.CustID
	WHERE tsa.RoleID IN (1,2,3)

END

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #tmp_ProductStatusAffected

	DELETE TOP (@Batch) temp
	OUTPUT DELETED.CustID 
		INTO #tmp_ProductStatusAffected (CustID)
	FROM #tmp_ProductStatus temp
	INNER JOIN #CustDirectDummyCollected tsa ON temp.CustID = tsa.CustID
	WHERE tsa.RoleID IN (1,2,3)

	IF @@ROWCOUNT = 0 
			BREAK ;

	
	SELECT @JsonData = (	SELECT CustID
					FROM	#tmp_ProductStatusAffected tp
					FOR JSON PATH
			    )

	EXEC dbo.[Acc_DynamicCustSetting3rd_17] @ModeCode = 'CustPS'
								   , @JsonData = @JsonData
								   , @Target   = @target

	WAITFOR DELAY '00:00:0.050'

	SET @Msg = 'Curdt CustProductStatus: ' + convert(varchar(50), GETDATE(), 121)
	RAISERROR (@Msg, 0, 1) WITH NOWAIT

END


-----------------------------------------------------------------------------------------------------------




DROP TABLE #SuperID

DROP TABLE #DirectMaster
DROP TABLE #DirectAgent
DROP TABLE #DirectMember

DROP TABLE #CustDirectDummyCollected
DROP TABLE #TmpCustList


DROP TABLE #tmp_DummyMasterAgentPTSetting
DROP TABLE #tmp_DirectPT_MasterAgentMember
DROP TABLE #tmp_DirectMasterAgentMemberPTSetting
DROP TABLE #tmp_PTCollected
DROP TABLE #tmp_PTAffected


DROP TABLE #tmp_BetSetting
DROP TABLE #tmp_BetSettingAffected

DROP TABLE #tmp_ProductStatus
DROP TABLE #tmp_ProductStatusAffected