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
	@BetType			SMALLINT	= 1501

--Get Super Account Affect
CREATE TABLE #SuperID (SuperID INT , PRIMARY KEY CLUSTERED (SuperID))

INSERT INTO #SuperID 
	(
		SuperID
	)
SELECT c.custid 
FROM custInfo c WITH (NOLOCK) 
WHERE c.username IN ('SA-US$','SA-TB','SA-HK$','SA-EURO','SA-AUD','SA-GBP','SA-RMB','SA-IN','SH-HK$','SH-RMB','SS-RMB')
AND c.Enabled = 1

SELECT @maxcustid = xxx

-- Get Data Line Super / Master / Agemt / Member Related Direct Account
CREATE TABLE #TmpCustList
		(
			srecommend	INT,
			mrecommend	INT,
			recommend	INT,
			CustID	INT,
			RoleID	INT,
			Type		INT,		-- 0 : Direct Account || 1 : Dummy Account || 2 : Normal Account
			Enabled	BIT,
			PRIMARY KEY CLUSTERED (CustID)
		)


INSERT INTO #TmpCustList 
	(
		srecommend
	    , mrecommend
	    , recommend
	    , CustID 
	    , RoleID
	    , Type
	    , Enabled
	)
SELECT 
		i.srecommend
	    , i.mrecommend
	    , i.recommend
	    , i.CustID
	    , i.roleid
	    , CASE 
			WHEN acd.custid IS NULL AND cda.CustID IS NOT NULL	THEN  0	-- Direct Account 
			WHEN acd.custid IS NOT NULL AND cda.CustID IS NULL	THEN  1	-- Dummy Account 
			WHEN acd.custid IS NULL AND cda.CustID IS NULL		THEN  2	-- Normal Account
		END
	    , i.Enabled	
FROM  #SuperID si
INNER JOIN custInfo i WITH (NOLOCK) ON i.srecommend = si.SuperID
LEFT JOIN Acc_CustDirect acd WITH (NOLOCK) ON i.custid = acd.custid
LEFT JOIN CustDirectAccount cda WITH (NOLOCK) ON i.custid = cda.CustID
WHERE i.custid <= @maxcustid

-------------------------------------------1.PT-------------------------------------------------

CREATE TABLE #tmp_DataPTSettingCollected
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

-- Part 1: Collect Data Dummy Master , Direct Master If Not Exits Data Setting

-- Case 1 : Check Dummy Master is Not Exist and Collect Data
IF EXISTS (
			SELECT TOP 1 1
			FROM #TmpCustList tcl
			LEFT JOIN CustPTSetting3rd_Agent cpmaster WITH (NOLOCK) ON tcl.mrecommend = cpmaster.CustID AND cpmaster.SportType = @SportType AND cpmaster.BetType = @BetType
			WHERE tcl.RoleID = 3 AND tcl.Type = 1  AND cpmaster.CustID IS NULL -- Check Dummy Master Exist Or Not
		)
BEGIN
	INSERT INTO #tmp_DataPTSettingCollected 
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
		tcl.mrecommend	AS CustID
	    , @SportType		AS SportType
	    , @BetType		AS ASBetType
	    , 0			AS IsLive
	    , 0			AS IsAutoMasterPT
	    , 0			AS IsAutoSuperPT
	    , 0			AS SuperPT
	    , ISNULL(cpmaster.SuperPT, cpsuper.SuperPT)			AS MasterPT
	    , 0			AS AgentPT
	    , 0			AS AutoSuperPT
	    , 0			AS AutoMasterPT
	    , 0			AS MinPT
	    , 100			AS MaxPT
	FROM #TmpCustList tcl
	LEFT JOIN CustPTSetting3rd_Agent cpmaster WITH (NOLOCK) ON tcl.mrecommend = cpmaster.CustID AND cpmaster.SportType = @SportType AND cpmaster.BetType = @BetType
	LEFT JOIN CustPTSetting3rd_Agent cpsuper WITH (NOLOCK) ON tcl.srecommend = cpsuper.CustID AND cpsuper.SportType = @SportType AND cpsuper.BetType = @BetType
	WHERE tcl.RoleID = 3 AND tcl.Type = 1 AND cpmaster.CustID IS NULL -- Check Dummy Master Exist Or Not
	

END

-- Case 2: Collect Data Direct Master (Type = 0) If Not Exits Data Setting
IF EXISTS ( SELECT TOP 1 1
	      FROM #TmpCustList tcl
		LEFT JOIN CustPTSetting3rd_Agent cpmaster WITH (NOLOCK) ON tcl.mrecommend = cpmaster.CustID AND cpmaster.SportType = @SportType AND cpmaster.BetType = @Bettype
		WHERE tcl.RoleID = 3 AND tcl.Type = 0 AND cpmaster.CustID IS NULL )
BEGIN
	INSERT INTO #tmp_DataPTSettingCollected 
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
		tcl.mrecommend	AS CustID
	    , @SportType		AS SportType
	    , @BetType		AS ASBetType
	    , 0			AS IsLive
	    , 0			AS IsAutoMasterPT
	    , 0			AS IsAutoSuperPT
	    , 0			AS SuperPT
	    , ISNULL(cpmaster.MasterPT, cpSuper.MasterPT)		AS MasterPT
	    , 0			AS AgentPT
	    , 0			AS AutoSuperPT
	    , 0			AS AutoMasterPT
	    , 0			AS MinPT
	    , 100			AS MaxPT
	    FROM #TmpCustList tcl
	    LEFT JOIN CustPTSetting3rd_Agent cpmaster WITH (NOLOCK) ON tcl.mrecommend = cpmaster.CustID AND cpmaster.SportType = @SportType AND cpmaster.BetType = @Bettype
	    LEFT JOIN CustPTSetting3rd_Agent cpSuper WITH (NOLOCK) ON tcl.srecommend = cpSuper.CustID AND cpSuper.SportType = @SportType AND cpSuper.BetType = @Bettype 
	    WHERE tcl.RoleID = 3 AND tcl.Type = 0 AND cpmaster.CustID IS NULL
END

-- Part 2: Collect Data Dummy Agent , Direct Agent , Normal Agent If Not Exits Data Setting

-- Case 3 : Check Dummy Agent is Not Exist and Collect Data
IF EXISTS (
			SELECT TOP 1 1
			FROM #TmpCustList tcl
			LEFT JOIN CustPTSetting3rd_Agent cpagent WITH (NOLOCK) ON tcl.recommend = cpagent.CustID AND cpagent.SportType = @SportType AND cpagent.BetType = @BetType
			WHERE tcl.RoleID = 2 AND tcl.Type = 1  AND cpagent.CustID IS NULL -- Check Dummy Agent Exist Or Not
		)
BEGIN
	INSERT INTO #tmp_DataPTSettingCollected 
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
		tcl.recommend	AS CustID
	    , @SportType		AS SportType
	    , @BetType		AS ASBetType
	    , 0			AS IsLive
	    , 0			AS IsAutoMasterPT
	    , 0			AS IsAutoSuperPT
	    , 0			AS SuperPT
	    , 0			AS MasterPT
	    , ISNULL(ISNULL(cpagent.MasterPT, cpmaster.MasterPT) , cpsuper.MasterPT)		AS AgentPT
	    , 0			AS AutoSuperPT
	    , 0			AS AutoMasterPT
	    , 0			AS MinPT
	    , 100			AS MaxPT
	FROM #TmpCustList tcl
	LEFT JOIN CustPTSetting3rd_Agent cpagent WITH (NOLOCK) ON tcl.recommend = cpagent.CustID AND cpagent.SportType = @SportType AND cpagent.BetType = @BetType
	LEFT JOIN CustPTSetting3rd_Agent cpmaster WITH (NOLOCK) ON tcl.mrecommend = cpmaster.CustID AND cpmaster.SportType = @SportType AND cpmaster.BetType = @BetType
	LEFT JOIN CustPTSetting3rd_Agent cpsuper WITH (NOLOCK) ON tcl.srecommend = cpsuper.CustID AND cpsuper.SportType = @SportType AND cpsuper.BetType = @BetType
	WHERE tcl.RoleID = 2 AND tcl.Type = 1 AND cpagent.CustID IS NULL -- Check Dummy Agent Exist Or Not
END


-- Case 4: Collect Data Direct Agent (Type = 0) If Not Exits Data Setting
IF EXISTS ( SELECT TOP 1 1
	      FROM #TmpCustList tcl
		LEFT JOIN CustPTSetting3rd_Agent cpagent WITH (NOLOCK) ON tcl.recommend = cpagent.CustID AND cpagent.SportType = @SportType AND cpagent.BetType = @Bettype
		WHERE tcl.RoleID = 2 AND tcl.Type = 0 AND cpagent.CustID IS NULL )
BEGIN
	INSERT INTO #tmp_DataPTSettingCollected 
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
		tcl.recommend	AS CustID
	    , @SportType		AS SportType
	    , @BetType		AS ASBetType
	    , 0			AS IsLive
	    , 0			AS IsAutoMasterPT
	    , 0			AS IsAutoSuperPT
	    , 0			AS SuperPT
	    , 0			AS MasterPT
	    , ISNULL(ISNULL(cpagent.MasterPT, cpmaster.MasterPT) , tdpc.MasterPT)		AS AgentPT
	    , 0			AS AutoSuperPT
	    , 0			AS AutoMasterPT
	    , 0			AS MinPT
	    , 100			AS MaxPT
	FROM #TmpCustList tcl
	LEFT JOIN CustPTSetting3rd_Agent cpagent WITH (NOLOCK) ON tcl.recommend = cpagent.CustID AND cpagent.SportType = @SportType AND cpagent.BetType = @Bettype
	LEFT JOIN CustPTSetting3rd_Agent cpmaster WITH (NOLOCK) ON tcl.mrecommend = cpmaster.CustID AND cpmaster.SportType = @SportType AND cpmaster.BetType = @Bettype
	LEFT JOIN #tmp_DataPTSettingCollected tdpc WITH (NOLOCK) ON tcl.mrecommend = tdpc.CustID AND tdpc.SportType = @SportType AND tdpc.BetType = @Bettype
	WHERE tcl.RoleID = 2 AND tcl.Type = 0 AND cpagent.CustID IS NULL 
END

-- Case 5: Collect Data Normal Agent (Type = 2) If Not Exits Data Setting
IF EXISTS ( SELECT TOP 1 1
	      FROM #TmpCustList tcl
		LEFT JOIN CustPTSetting3rd_Agent cpagent WITH (NOLOCK) ON tcl.recommend = cpagent.CustID AND cpagent.SportType = @SportType AND cpagent.BetType = @Bettype
		WHERE tcl.RoleID = 2 AND tcl.Type = 2 AND cpagent.CustID IS NULL )
BEGIN
	INSERT INTO #tmp_DataPTSettingCollected 
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
		tcl.recommend	AS CustID
	    , @SportType		AS SportType
	    , @BetType		AS ASBetType
	    , 0			AS IsLive
	    , 0			AS IsAutoMasterPT
	    , 0			AS IsAutoSuperPT
	    , 0			AS SuperPT
	    , ISNULL(ISNULL(cpagent.MasterPT, cpmaster.MasterPT) , tdpc.MasterPT)		AS MasterPT
	    , 0			AS AgentPT
	    , 0			AS AutoSuperPT
	    , 0			AS AutoMasterPT
	    , 0			AS MinPT
	    , 100			AS MaxPT
	FROM #TmpCustList tcl
	LEFT JOIN CustPTSetting3rd_Agent cpagent WITH (NOLOCK) ON tcl.recommend = cpagent.CustID AND cpagent.SportType = @SportType AND cpagent.BetType = @Bettype
	LEFT JOIN CustPTSetting3rd_Agent cpmaster WITH (NOLOCK) ON tcl.mrecommend = cpmaster.CustID AND cpmaster.SportType = @SportType AND cpmaster.BetType = @Bettype
	LEFT JOIN #tmp_DataPTSettingCollected tdpc WITH (NOLOCK) ON tcl.mrecommend = tdpc.CustID AND tdpc.SportType = @SportType AND tdpc.BetType = @Bettype
	WHERE tcl.RoleID = 2 AND tcl.Type = 2 AND cpagent.CustID IS NULL 
END

-- Part 3: Collect Data Direct Member , Normal Member If Not Exits Data Setting

-- Case 6: Collect Data Direct Member (Type = 0) If Not Exits Data Setting
IF EXISTS ( SELECT TOP 1 1
	      FROM #TmpCustList tcl
		LEFT JOIN CustPTSetting3rd_Member cpmember WITH (NOLOCK) ON tcl.CustID = cpmember.CustID AND cpmember.SportType = @SportType AND cpmember.BetType = @Bettype
		WHERE tcl.RoleID = 1 AND tcl.Type = 0 AND cpmember.CustID IS NULL )
BEGIN
	INSERT INTO #tmp_DataPTSettingCollected 
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
		tcl.CustID		AS CustID
	    , @SportType		AS SportType
	    , @BetType		AS ASBetType
	    , 0			AS IsLive
	    , 0			AS IsAutoMasterPT
	    , 0			AS IsAutoSuperPT
	    , 0			AS SuperPT
	    , 0			AS MasterPT
	    , 0			AS AgentPT
	    , 0			AS AutoSuperPT
	    , 0			AS AutoMasterPT
	    , 0			AS MinPT
	    , 100			AS MaxPT
	FROM #TmpCustList tcl
	LEFT JOIN CustPTSetting3rd_Member cpmember WITH (NOLOCK) ON tcl.CustID = cpmember.CustID AND cpmember.SportType = @SportType AND cpmember.BetType = @Bettype
	WHERE tcl.RoleID = 1 AND tcl.Type = 0 AND cpmember.CustID IS NULL 
END

-- Case 8: Collect Data Normal Member (Type = 2) If Not Exits Data Setting - Init From Direct Agent (Type = 0)
IF EXISTS ( SELECT TOP 1 1
	      FROM #TmpCustList tcl
		LEFT JOIN CustPTSetting3rd_Member cpmember WITH (NOLOCK) ON tcl.CustID = cpmember.CustID AND cpmember.SportType = @SportType AND cpmember.BetType = @Bettype
		INNER JOIN #TmpCustList tcl_DirectAgent ON tcl.recommend = tcl_DirectAgent.CustID AND tcl_DirectAgent.Type = 0				-- Direct Agent
		WHERE tcl.RoleID = 1 AND tcl.Type = 2 AND cpmember.CustID IS NULL )
BEGIN
	INSERT INTO #tmp_DataPTSettingCollected 
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
		tcl.CustID		AS CustID
	    , @SportType		AS SportType
	    , @BetType		AS ASBetType
	    , 0			AS IsLive
	    , 0			AS IsAutoMasterPT
	    , 0			AS IsAutoSuperPT
	    , ISNULL(ISNULL(cpmember.SuperPT, cpmaster.SuperPT) , tdpcmaster.SuperPT)		AS SuperPT
	    , ISNULL(ISNULL(cpmember.MasterPT, cpagent.MasterPT) , tdpcagent.MasterPT)	AS MasterPT
	    , ISNULL(ISNULL(cpmember.AgentPT, cpagent.AgentPT) , tdpcagent.AgentPT)		AS AgentPT
	    , 0			AS AutoSuperPT
	    , 0			AS AutoMasterPT
	    , 0			AS MinPT
	    , 100			AS MaxPT
	FROM #TmpCustList tcl
	LEFT JOIN CustPTSetting3rd_Member cpmember WITH (NOLOCK) ON tcl.CustID = cpmember.CustID AND cpmember.SportType = @SportType AND cpmember.BetType = @Bettype
	-- Get Direct Agent > MasterPT ,AgentPT
	INNER JOIN #TmpCustList tcl_DirectAgent ON tcl.recommend = tcl_DirectAgent.CustID AND tcl_DirectAgent.Type = 0				
	LEFT JOIN CustPTSetting3rd_Agent cpagent WITH (NOLOCK) ON tcl.recommend = cpagent.CustID AND cpagent.SportType = @SportType AND cpagent.BetType = @BetType
	LEFT JOIN #tmp_DataPTSettingCollected tdpcagent ON tcl.recommend = tdpcagent.CustID AND tdpcagent.SportType = @SportType AND tdpcagent.BetType = @Bettype
	-- Get Dummy Master > SuperPT
	LEFT JOIN CustPTSetting3rd_Agent cpmaster WITH (NOLOCK) ON tcl.mrecommend = cpmaster.CustID AND cpmaster.SportType = @SportType AND cpmaster.BetType = @BetType
	LEFT JOIN #tmp_DataPTSettingCollected tdpcmaster ON tcl.mrecommend = tdpcmaster.CustID AND tdpcmaster.SportType = @SportType AND tdpcmaster.BetType = @Bettype
	WHERE tcl.RoleID = 1 AND tcl.Type = 2 AND cpmember.CustID IS NULL 

END

-- Case 9: Collect Data Normal Member (Type = 2) If Not Exits Data Setting - Init From Normal Agent (Type IS NULL)
IF EXISTS ( SELECT TOP 1 1
	      FROM #TmpCustList tcl
		LEFT JOIN CustPTSetting3rd_Member cpmember WITH (NOLOCK) ON tcl.CustID = cpmember.CustID AND cpmember.SportType = @SportType AND cpmember.BetType = @Bettype
		INNER JOIN #TmpCustList tcl_DirectAgent ON tcl.recommend = tcl_DirectAgent.CustID AND tcl_DirectAgent.Type = 2				-- Normal Agent
		WHERE tcl.RoleID = 1 AND tcl.Type = 2 AND cpmember.CustID IS NULL )
BEGIN
	INSERT INTO #tmp_DataPTSettingCollected 
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
		tcl.CustID		AS CustID
	    , @SportType		AS SportType
	    , @BetType		AS ASBetType
	    , 0			AS IsLive
	    , 0			AS IsAutoMasterPT
	    , 0			AS IsAutoSuperPT
	    , ISNULL(ISNULL(cpmember.SuperPT, cpmaster.SuperPT) , tdpcmaster.SuperPT)			AS SuperPT
	    , ISNULL(ISNULL(cpmember.MasterPT, cpagent.MasterPT) , tdpcagent.MasterPT)		AS MasterPT
	    , ISNULL(ISNULL(cpmember.AgentPT, cpagent.AgentPT) , tdpcagent.AgentPT)			AS AgentPT
	    , 0			AS AutoSuperPT
	    , 0			AS AutoMasterPT
	    , 0			AS MinPT
	    , 100			AS MaxPT
	FROM #TmpCustList tcl
	LEFT JOIN CustPTSetting3rd_Member cpmember WITH (NOLOCK) ON tcl.CustID = cpmember.CustID AND cpmember.SportType = @SportType AND cpmember.BetType = @Bettype
	--Get Normal Agent >> MasterPT , AgentPT
	INNER JOIN #TmpCustList tcl_NormalAgent ON tcl.recommend = tcl_NormalAgent.CustID AND tcl_NormalAgent.Type = 2				
	LEFT JOIN CustPTSetting3rd_Agent cpagent WITH (NOLOCK) ON tcl.recommend = cpagent.CustID AND cpagent.SportType = @SportType AND cpagent.BetType = @BetType
	LEFT JOIN #tmp_DataPTSettingCollected tdpcagent ON tcl.recommend = tdpcagent.CustID AND tdpcagent.SportType = @SportType AND tdpcagent.BetType = @Bettype

	-- Get Direct Master >> SuperPT
	LEFT JOIN CustPTSetting3rd_Agent cpmaster WITH (NOLOCK) ON tcl.mrecommend = cpmaster.CustID AND cpmaster.SportType = @SportType AND cpmaster.BetType = @BetType
	LEFT JOIN #tmp_DataPTSettingCollected tdpcmaster  ON tcl.mrecommend = tdpcmaster.CustID AND tdpcmaster.SportType = @SportType AND tdpcmaster.BetType = @Bettype
	WHERE tcl.RoleID = 1 AND tcl.Type = 2 AND cpmember.CustID IS NULL 

END

-- Remove Cust Don't need init data
DELETE tem
FROM #tmp_DataPTSettingCollected tem
INNER JOIN #TmpCustList tcl ON tem.CustID = tcl.CustID
WHERE tcl.Enabled = 0

DELETE FROM #TmpCustList WHERE Enabled = 0


---------------------------------------Declare Deployed Info---------------------------------------
DECLARE
	  @Batch			INT = 2000
	, @JsonData			VARCHAR(MAX)
	, @Msg			VARCHAR(200)

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
	FROM #tmp_DataPTSettingCollected temp
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
	FROM #tmp_DataPTSettingCollected temp
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

-----------------------------------------------2.BetSetting-------------------------------------------------

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
RIGHT JOIN #TmpCustList temp ON cpa.CustID = temp.CustID AND cpa.SportType = @SportType AND cpa.BetType = @BetType 
WHERE temp.RoleID IN (4,3,2)
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
RIGHT JOIN #TmpCustList temp ON cpa.CustID = temp.CustID AND cpa.SportType = @SportType AND cpa.BetType = @BetType 
WHERE temp.RoleID IN (1)
AND cpa.CustID IS NULL


WHILE (1=1)
BEGIN
	TRUNCATE TABLE #tmp_BetSettingAffected

	DELETE TOP (@Batch) temp
	OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.MinBet , DELETED.MaxBet , DELETED.MaxPerMatch
		INTO #tmp_BetSettingAffected (CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
	FROM #tmp_BetSetting temp
	INNER JOIN #TmpCustList tsa ON temp.CustID = tsa.CustID
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
	INNER JOIN #TmpCustList tsa ON temp.CustID = tsa.CustID
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

---------------------------------------------3.ProductStatus-------------------------------------------------

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
			FROM #TmpCustList tsa
			INNER JOIN CustProductStatus cps WITH (NOLOCK) ON tsa.CustId = cps.CustID
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
	FROM #TmpCustList tsa
	INNER JOIN CustProductStatus cps ON tsa.CustID = cps.CustID
END

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #tmp_ProductStatusAffected

	DELETE TOP (@Batch) temp
	OUTPUT DELETED.CustID 
		INTO #tmp_ProductStatusAffected (CustID)
	FROM #tmp_ProductStatus temp

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
DROP TABLE #TmpCustList

DROP TABLE #tmp_DataPTSettingCollected
DROP TABLE #tmp_PTAffected


DROP TABLE #tmp_BetSetting
DROP TABLE #tmp_BetSettingAffected

DROP TABLE #tmp_ProductStatus
DROP TABLE #tmp_ProductStatusAffected