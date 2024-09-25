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


SELECT @max_custid = (	SELECT MAX(c.custid) 
				FROM Customer c WITH (NOLOCK)
				INNER JOIN #SuperID si ON c.srecommend = si.SuperID
			   )

CREATE TABLE #CustTemp
(
	CustID INT PRIMARY KEY CLUSTERED,
	RoleID TINYINT,
	Type   BIT		-- 0 : Direct Account || 1 : Dummy Account
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

INSERT INTO #CustTemp 
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


---------------------------------------Declare Deployed Info---------------------------------------
DECLARE
	  @Batch			INT = 2000
	, @JsonData			VARCHAR(MAX)
	, @Msg			VARCHAR(200)


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
-- GET PT Dummy Super If Not Exists
SELECT	--temp.RoleID,
		temp.CustID
	    , @SportType	AS SportType
	    , @BetType	AS BetType
	    , 0 AS IsLive
	    , 0 AS IsAutoMasterPT
	    , 0 AS IsAutoSuperPT
	    , 0 AS SuperPT
	    , 0 AS MasterPT
	    , 0 AS AgentPT
	    , 0 AS AutoSuperPT
	    , 0 AS AutoMasterPT
	    , 0 AS MinPT
	    , 100		AS MaxPT
FROM CustPTSetting3rd_Agent cpa WITH (NOLOCK)
RIGHT JOIN #CustTemp temp ON cpa.CustID = temp.CustID AND cpa.SportType = @SportType AND cpa.BetType = @BetType 
WHERE temp.RoleID = 4
AND cpa.CustID IS NULL

UNION ALL


-- GET PT Direct/Dummy Master If Not Exists
SELECT	--temp.RoleID,
		temp.CustID
	    , @SportType	AS SportType
	    , @BetType	AS BetType
	    , 0 AS IsLive
	    , 0 AS IsAutoMasterPT
	    , 0 AS IsAutoSuperPT
	    , 0 AS SuperPT
	    , CASE WHEN temp.Type = 0 THEN @MaxPT ELSE 0 END 	 AS MasterPT
	    , 0 AS AgentPT
	    , 0 AS AutoSuperPT
	    , 0 AS AutoMasterPT
	    , 0 AS MinPT
	    , 100		AS MaxPT
FROM CustPTSetting3rd_Agent cpa WITH (NOLOCK)
RIGHT JOIN #CustTemp temp ON cpa.CustID = temp.CustID AND cpa.SportType = @SportType AND cpa.BetType = @BetType 
WHERE temp.RoleID = 3
AND cpa.CustID IS NULL

UNION ALL

-- GET PT Direct/Dummy Agent If Not Exists
SELECT	--temp.RoleID,
		temp.CustID
	    , @SportType	AS SportType
	    , @BetType	AS BetType
	    , 0 AS IsLive
	    , 0 AS IsAutoMasterPT
	    , 0 AS IsAutoSuperPT
	    , 0 AS SuperPT
	    , 0 AS MasterPT
	    , CASE WHEN temp.Type = 0 THEN @MaxPT ELSE 0 END 	 AS AgentPT
	    , 0 AS AutoSuperPT
	    , 0 AS AutoMasterPT
	    , 0 AS MinPT
	    , 100		AS MaxPT
FROM CustPTSetting3rd_Agent cpa WITH (NOLOCK)
RIGHT JOIN #CustTemp temp ON cpa.CustID = temp.CustID AND cpa.SportType = @SportType AND cpa.BetType = @BetType 
WHERE temp.RoleID = 2
AND cpa.CustID IS NULL

UNION ALL

-- GET PT Direct Member If Not Exists
SELECT	--temp.RoleID,
		temp.CustID
	    , @SportType	AS SportType
	    , @BetType	AS BetType
	    , 0 AS IsLive
	    , 0 AS IsAutoMasterPT
	    , 0 AS IsAutoSuperPT
	    , 0 AS SuperPT
	    , 0 AS MasterPT
	    , 0 AS AgentPT
	    , 0 AS AutoSuperPT
	    , 0 AS AutoMasterPT
	    , NULL	 AS MinPT
	    , NULL	 AS MaxPT
FROM CustPTSetting3rd_Member cpa WITH (NOLOCK)
RIGHT JOIN #CustTemp temp ON cpa.CustID = temp.CustID AND cpa.SportType = @SportType AND cpa.BetType = @BetType 
WHERE temp.RoleID = 1
AND cpa.CustID IS NULL



WHILE (1=1)
BEGIN
	TRUNCATE TABLE #tmp_PTAffected

	DELETE TOP (@Batch) temp
	OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.IsLive , DELETED.IsAutoMasterPT , DELETED.IsAutoSuperPT , DELETED.SuperPT , DELETED.MasterPT , DELETED.AgentPT , DELETED.AutoSuperPT , DELETED.AutoMasterPT , DELETED.MinPT , DELETED.MaxPT
		INTO #tmp_PTAffected (CustID, SportType, BetType, IsLive, IsAutoMasterPT, IsAutoSuperPT, SuperPT, MasterPT, AgentPT, AutoSuperPT, AutoMasterPT, MinPT, MaxPT)
	FROM #tmp_PTSetting temp
	INNER JOIN #CustTemp tsa ON temp.CustID = tsa.CustID
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
	INNER JOIN #CustTemp tsa ON temp.CustID = tsa.CustID
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
RIGHT JOIN #CustTemp temp ON cpa.CustID = temp.CustID AND cpa.SportType = @SportType AND cpa.BetType = @BetType 
WHERE temp.RoleID IN (3,2)
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
RIGHT JOIN #CustTemp temp ON cpa.CustID = temp.CustID AND cpa.SportType = @SportType AND cpa.BetType = @BetType 
WHERE temp.RoleID IN (1)
AND cpa.CustID IS NULL


WHILE (1=1)
BEGIN
	TRUNCATE TABLE #tmp_BetSettingAffected

	DELETE TOP (@Batch) temp
	OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.MinBet , DELETED.MaxBet , DELETED.MaxPerMatch
		INTO #tmp_BetSettingAffected (CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
	FROM #tmp_BetSetting temp
	INNER JOIN #CustTemp tsa ON temp.CustID = tsa.CustID
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
	INNER JOIN #CustTemp tsa ON temp.CustID = tsa.CustID
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
			FROM #CustTemp tsa
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
	FROM #CustTemp tsa
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
	INNER JOIN #CustTemp tsa ON temp.CustID = tsa.CustID
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

DROP TABLE #CustTemp

DROP TABLE #tmp_PTSetting
DROP TABLE #tmp_PTAffected

DROP TABLE #tmp_BetSetting
DROP TABLE #tmp_BetSettingAffected

DROP TABLE #DirectMaster
DROP TABLE #DirectAgent
DROP TABLE #DirectMember

DROP TABLE #tmp_ProductStatus
DROP TABLE #tmp_ProductStatusAffected