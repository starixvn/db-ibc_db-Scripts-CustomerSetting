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
	@max_custid INT
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
CREATE TABLE #SuperID (SuperID INT , IsHidden BIT , IsDisable BIT , PRIMARY KEY CLUSTERED (SuperID))

INSERT INTO #SuperID 
	(
		SuperID
	)
SELECT c.custid 
FROM Customer c WITH (NOLOCK) 
WHERE c.username IN ('999MYR','DT','JARWRONG','KOR','CSDTEST','MIRI SD','PPO','S2C','skwrongxxx','StarixSCYEN','SuperTestTH','PRU','S188AH','S1NT','S52RMB','S688T','SBSR','SJ','SMOT','SQE','SSP','SWT','SXRS','TL1','TL6')

SELECT @max_custid = xxx 

--Get Downline Account Affect
CREATE TABLE #TmpCustAffected
		(
			Site		VARCHAR(10),
			ExchangeId	TINYINT,
			UserName	VARCHAR(30),
			RoleID	TINYINT,
			CustID	INT,
			srecommend	INT,
			mrecommend	INT,
			recommend	INT,
			PRIMARY KEY CLUSTERED (CustID)
		)

INSERT INTO #TmpCustAffected 
	(
		Site
	    , ExchangeId
	    , UserName
	    , RoleID
	    , CustID
	    , srecommend
	    , mrecommend
	    , recommend
	)
SELECT	Site
	    , currency
	    , UserName
	    , cu.roleid
	    , CustID
	    , srecommend
	    , mrecommend
	    , recommend
FROM Customer cu WITH (NOLOCK)
INNER JOIN #SuperID c ON cu.srecommend = c.SuperID
WHERE cu.custid <= @max_custid

-- Check Data
--SELECT @SportType AS SportType , @BetType AS BetType , @BitmapOrder_RNGKeno AS BitmapOrder_RNGKeno
--SELECT si.*
--FROM #TmpCustAffected si

---------------------------------------Declare Deployed Info---------------------------------------
DECLARE
	  @Batch			INT = 2000
	, @JsonData			VARCHAR(MAX)
	, @Msg			VARCHAR(200)

CREATE TABLE #tmp_CustCheck
	(
		CustId	 INT
	    , SportType	 SMALLINT
	    , BetType	 SMALLINT
	    , PRIMARY KEY (CustID , SportType , BetType)
	)


-------------------------------------------1.PT-------------------------------------------------

CREATE TABLE #tmp_PTSetting
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


-- MIGRATE DATA FOR Master
INSERT INTO #tmp_CustCheck 
	(
		CustId
	    , SportType
	    , BetType
	)
SELECT 
		tsa_Master.mrecommend AS CustID
	    , SportType
	    , BetType
FROM #TmpCustAffected tsa_Master
INNER JOIN #TmpCustAffected tsa_Super ON tsa_Master.srecommend = tsa_Super.srecommend
INNER JOIN CustPTSetting3rd_Agent cpa WITH (NOLOCK) ON cpa.CustID = tsa_Super.CustID
WHERE tsa_Master.RoleID = 3
AND tsa_Super.RoleID = 4
AND cpa.SportType = @SportType
AND cpa.BetType = @BetType


IF EXISTS (	
			SELECT 1
			FROM #tmp_CustCheck cc
			INNER JOIN CustPTSetting3rd_Agent cpa WITH (NOLOCK) ON cc.CustId = cpa.CustID AND cc.SportType = cpa.SportType AND cc.BetType = cpa.BetType
		)
BEGIN
	RAISERROR ( N'Error Data PT Master', 0, 1) ;
	RETURN;
END

ELSE
BEGIN
	INSERT INTO #tmp_PTSetting 
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
		tsa_Master.CustID AS CustID
	    , cpa.SportType
	    , cpa.BetType
	    , cpa.IsLive
	    , 0 AS IsAutoMasterPT
	    , 0 AS IsAutoSuperPT
	    , SuperPT
	    , 0 AS MasterPT
	    , 0 AS AgentPT
	    , 0 AS AutoSuperPT
	    , 0 AS utoMasterPT
	    , 0 AS MinPT
	    , MaxPT
	FROM #TmpCustAffected tsa_Master
	INNER JOIN #TmpCustAffected tsa_Super ON tsa_Master.srecommend = tsa_Super.srecommend
	INNER JOIN CustPTSetting3rd_Agent cpa WITH (NOLOCK) ON cpa.CustID = tsa_Super.srecommend
	WHERE tsa_Master.RoleID = 3
	AND tsa_Super.RoleID = 4
	AND cpa.SportType = @SportType
	AND cpa.BetType = @BetType

END


-- COPY DATA FOR Agent

TRUNCATE TABLE #tmp_CustCheck


INSERT INTO #tmp_CustCheck 
	(
		CustId
	    , SportType
	    , BetType
	)
SELECT 
		tsa_Agent.recommend AS CustId
	    , SportType
	    , BetType
FROM #TmpCustAffected tsa_Agent
INNER JOIN #TmpCustAffected tsa_Master ON tsa_Agent.mrecommend = tsa_Master.mrecommend
INNER JOIN #tmp_PTSetting cpa WITH (NOLOCK) ON cpa.CustID = tsa_Master.mrecommend
WHERE tsa_Agent.RoleID = 2
AND tsa_Master.RoleID = 3
AND cpa.SportType = @SportType
AND cpa.BetType = @BetType

IF EXISTS (	
			SELECT 1
			FROM #tmp_CustCheck cc
			INNER JOIN CustPTSetting3rd_Agent cpa WITH (NOLOCK) ON cc.CustId = cpa.CustID AND cc.SportType = cpa.SportType AND cc.BetType = cpa.BetType
		)
BEGIN
	RAISERROR ( N'Error Data PT Agent', 0, 1) ;
	RETURN;
END

ELSE
BEGIN
	INSERT INTO #tmp_PTSetting 
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
		tsa_Agent.CustID AS CustID
	    , cpa.SportType
	    , cpa.BetType
	    , cpa.IsLive
	    , IsAutoMasterPT
	    , 0 AS IsAutoSuperPT
	    , 0 AS SuperPT
	    , MasterPT
	    , 0 AS AgentPT
	    , 0 AS AutoSuperPT
	    , 0 AS AutoMasterPT
	    , 0 AS MinPT
	    , MaxPT
	FROM #TmpCustAffected tsa_Agent
	INNER JOIN #TmpCustAffected tsa_Master ON tsa_Agent.mrecommend = tsa_Master.mrecommend
	INNER JOIN #tmp_PTSetting cpa WITH (NOLOCK) ON cpa.CustID = tsa_Master.mrecommend
	WHERE tsa_Agent.RoleID = 2
	AND tsa_Master.RoleID = 3
	AND cpa.SportType = @SportType
	AND cpa.BetType = @BetType

END


-- COPY DATA FOR Member

TRUNCATE TABLE #tmp_CustCheck


INSERT INTO #tmp_CustCheck 
	(
		CustId
	    , SportType
	    , BetType
	)
SELECT
		tsa_Member.CustId
	    , SportType
	    , BetType
FROM #TmpCustAffected tsa_Member
INNER JOIN #TmpCustAffected tsa_Agent ON tsa_Member.recommend = tsa_Agent.recommend
INNER JOIN #tmp_PTSetting cpa WITH (NOLOCK) ON cpa.CustID = tsa_Agent.recommend
WHERE tsa_Member.RoleID = 1
AND tsa_Agent.RoleID = 2
AND cpa.SportType = @SportType
AND cpa.BetType = @BetType

IF EXISTS (	
			SELECT 1
			FROM #tmp_CustCheck cc
			INNER JOIN CustPTSetting3rd_Member cpa WITH (NOLOCK) ON cc.CustId = cpa.CustID AND cc.SportType = cpa.SportType AND cc.BetType = cpa.BetType
		)
BEGIN
	RAISERROR ( N'Error Data PT Member', 0, 1) ;
	RETURN;
END

ELSE
BEGIN
	INSERT INTO #tmp_PTSetting 
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
	)
	SELECT
		tsa_Member.CustID
	    , SportType
	    , BetType
	    , IsLive
	    , 0 AS IsAutoMasterPT
	    , 0 AS IsAutoSuperPT
	    , SuperPT
	    , 0 AS MasterPT
	    , 0 AS AgentPT
	    , 0 AS AutoSuperPT
	    , 0 AS AutoMasterPT
	FROM #TmpCustAffected tsa_Member
	INNER JOIN #TmpCustAffected tsa_Agent ON tsa_Member.recommend = tsa_Agent.recommend
	INNER JOIN #tmp_PTSetting cpa WITH (NOLOCK) ON cpa.CustID = tsa_Agent.recommend
	WHERE tsa_Member.RoleID = 1
	AND tsa_Agent.RoleID = 2
	AND cpa.SportType = @SportType
	AND cpa.BetType = @BetType

END

-- Check Data
--SELECT 'Check Data PT' AS Note, tsa.srecommend , tsa.RoleID , tp.*
--FROM #tmp_PTSetting tp
--INNER JOIN #TmpCustAffected tsa ON tp.CustID = tsa.CustID

--SELECT 'Check Data PT' AS Note,  tsa.RoleID , tp.*
--FROM CustPTSetting3rd_Agent tp
--INNER JOIN #TmpCustAffected tsa ON tp.CustID = tsa.CustID
--AND tp.SportType = @SportType
--AND tp.BetType = @BetType


WHILE (1=1)
BEGIN
	TRUNCATE TABLE #tmp_PTAffected

	DELETE TOP (@Batch) temp
	OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.IsLive , DELETED.IsAutoMasterPT , DELETED.IsAutoSuperPT , DELETED.SuperPT , DELETED.MasterPT , DELETED.AgentPT , DELETED.AutoSuperPT , DELETED.AutoMasterPT , DELETED.MinPT , DELETED.MaxPT
		INTO #tmp_PTAffected (CustID, SportType, BetType, IsLive, IsAutoMasterPT, IsAutoSuperPT, SuperPT, MasterPT, AgentPT, AutoSuperPT, AutoMasterPT, MinPT, MaxPT)
	FROM #tmp_PTSetting temp
	INNER JOIN #TmpCustAffected tsa ON temp.CustID = tsa.CustID
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
	FROM #tmp_PTSetting temp
	INNER JOIN #TmpCustAffected tsa ON temp.CustID = tsa.CustID
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


-------------------------------------------2.BetSetting-------------------------------------------------

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

IF EXISTS (	
			SELECT TOP 1 1
			FROM #TmpCustAffected cc
			INNER JOIN CustBetSetting3rd_Agent cpa WITH (NOLOCK) ON cc.CustId = cpa.CustID 
			WHERE cpa.SportType = @SportType 
			AND cpa.BetType = @BetType
			AND cc.RoleID IN (2,3)
		)
BEGIN
	RAISERROR ( N'Error Data BetSetting Master/Agent', 0, 1) ;
	RETURN;
END

ELSE IF EXISTS (	
			SELECT TOP 1 1
			FROM #TmpCustAffected cc
			INNER JOIN CustBetSetting3rd_Member cpa WITH (NOLOCK) ON cc.CustId = cpa.CustID 
			WHERE cpa.SportType = @SportType 
			AND cpa.BetType = @BetType
			AND cc.RoleID = 1
		)
BEGIN
	RAISERROR ( N'Error Data BetSetting Member', 0, 1) ;
	RETURN;
END

ELSE
BEGIN
	
	INSERT INTO #tmp_BetSetting 
	(
		CustID
	    , SportType
	    , BetType
	    , MinBet
	    , MaxBet
	    , MaxPerMatch
	)
	
	SELECT
		cc.mrecommend
	    , @SportType AS SportType
	    , @BetType AS BetType
	    , 0 AS MinBet
	    , 0 AS MaxBet
	    , 0.10 AS MaxPerMatch
	FROM #TmpCustAffected cc
	WHERE  cc.RoleID = 3

	UNION ALL

	SELECT
		cc.recommend
	    , @SportType AS SportType
	    , @BetType AS BetType
	    , 0 AS MinBet
	    , 0 AS MaxBet
	    , 0.10 AS MaxPerMatch
	FROM #TmpCustAffected cc
	WHERE  cc.RoleID = 2

	UNION ALL

	SELECT
		cc.CustID
	    , @SportType AS SportType
	    , @BetType AS BetType
	    , 0 AS MinBet
	    , 0 AS MaxBet
	    , 0.10 AS MaxPerMatch
	FROM #TmpCustAffected cc
	WHERE  cc.RoleID = 1
END


-- Check Data
--SELECT * FROM #TmpCustAffected
--SELECT 'Check Data BetSetting' AS Note, tsa.srecommend , tsa.RoleID , tp.*
--FROM #tmp_BetSetting tp
--INNER JOIN #TmpCustAffected tsa ON tp.CustID = tsa.CustID
--SELECT 'Check Data BetSetting' AS Note,  tsa.RoleID , tp.*
--FROM CustBetSetting3rd_Agent tp
--INNER JOIN #TmpCustAffected tsa ON tp.CustID = tsa.CustID
--AND tp.SportType = @SportType
--AND tp.BetType = @BetType

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #tmp_BetSettingAffected

	DELETE TOP (@Batch) temp
	OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.MinBet , DELETED.MaxBet , DELETED.MaxPerMatch
		INTO #tmp_BetSettingAffected (CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
	FROM #tmp_BetSetting temp
	INNER JOIN #TmpCustAffected tsa ON temp.CustID = tsa.CustID
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

	SET @Msg = 'Curdt BetSetting Master/Agent: ' + convert(varchar(50), GETDATE(), 121)
	RAISERROR (@Msg, 0, 1) WITH NOWAIT

END


WHILE (1=1)
BEGIN
	TRUNCATE TABLE #tmp_BetSettingAffected

	DELETE TOP (@Batch) temp
	OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.MinBet , DELETED.MaxBet , DELETED.MaxPerMatch
		INTO #tmp_BetSettingAffected (CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
	FROM #tmp_BetSetting temp
	INNER JOIN #TmpCustAffected tsa ON temp.CustID = tsa.CustID
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

	SET @Msg = 'Curdt BetSetting Member: ' + convert(varchar(50), GETDATE(), 121)
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
			FROM #TmpCustAffected tsa
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
	FROM #TmpCustAffected tsa
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
	INNER JOIN #TmpCustAffected tsa ON temp.CustID = tsa.CustID
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


DROP TABLE #SuperID
DROP TABLE #tmp_CustCheck

DROP TABLE #tmp_PTSetting
DROP TABLE #tmp_PTAffected

DROP TABLE #tmp_BetSetting
DROP TABLE #tmp_BetSettingAffected

DROP TABLE #tmp_ProductStatus
DROP TABLE #tmp_ProductStatusAffected

DROP TABLE #TmpCustAffected