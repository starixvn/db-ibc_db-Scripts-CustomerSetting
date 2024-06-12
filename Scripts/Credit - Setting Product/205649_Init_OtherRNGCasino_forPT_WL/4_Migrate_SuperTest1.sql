/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Date: 2024-05-31
	Created: @Helios
	Task: Database - Initialize Other RNG Casino for PT and Win Loss Limit [#205649]
	DB: DBCust-CustDB
*/

DECLARE 
	@SuperID		INT,
	@SportType		SMALLINT = 9918,
	@BetType		SMALLINT = 4601


SELECT @SuperID = (SELECT custid FROM Customer WITH (NOLOCk) WHERE username ='SuperTest1' )

-- Step 1: remove Master Direct Account
IF EXISTS (SELECT 1 FROM CustDirectAccount cda WITH (NOLOCK) WHERE cda.CustID = 113190340)
BEGIN
	DELETE cda FROM CustDirectAccount cda WITH (ROWLOCK) WHERE cda.CustID = 113190340
END

-- Step 2: Initial data
--Get Downline Account Affect
CREATE TABLE #TmpSuperAffected
		(
			RoleID	TINYINT,
			CustID	INT,
			srecommend	INT,
			mrecommend	INT,
			recommend	INT
			PRIMARY KEY CLUSTERED (CustID)
		)

INSERT INTO #TmpSuperAffected 
	(
		RoleID
	    , CustID
	    , srecommend
	    , mrecommend
	    , recommend
	)
SELECT	roleid
	    , CustID
	    , srecommend
	    , mrecommend
	    , recommend
FROM Customer cu WITH (NOLOCK)
WHERE cu.srecommend = @SuperID

---------------------------------------------------------------------------------------------------------
-- Clean Existing DataSetting

-- PT: Master , Agent
IF EXISTS (
		SELECT 1 
		FROM CustPTSetting3rd_Agent cpa WITH (NOLOCK)
		INNER JOIN #TmpSuperAffected tsa ON cpa.CustID = tsa.CustID
		WHERE cpa.SportType = @SportType
		AND cpa.BetType = @BetType
		AND tsa.RoleID IN (2,3)
	    )
BEGIN
	DELETE cpa
	FROM CustPTSetting3rd_Agent cpa WITH (ROWLOCK)
	INNER JOIN #TmpSuperAffected tsa ON cpa.CustID = tsa.CustID
	WHERE cpa.SportType = @SportType
	AND cpa.BetType = @BetType
	AND tsa.RoleID IN (2,3)
END

-- PT: Member
IF EXISTS (
		SELECT 1 
		FROM CustPTSetting3rd_Member cpa WITH (NOLOCK)
		INNER JOIN #TmpSuperAffected tsa ON cpa.CustID = tsa.CustID
		WHERE cpa.SportType = @SportType
		AND cpa.BetType = @BetType
		AND tsa.RoleID = 1
	    )
BEGIN
	DELETE cpa
	FROM CustPTSetting3rd_Member cpa WITH (ROWLOCK)
	INNER JOIN #TmpSuperAffected tsa ON cpa.CustID = tsa.CustID
	WHERE cpa.SportType = @SportType
	AND cpa.BetType = @BetType
	AND tsa.RoleID = 1
END

-- WL: Master , Agent
IF EXISTS (
		SELECT 1 
		FROM CustWinLossLimit_Agent cpa WITH (NOLOCK)
		INNER JOIN #TmpSuperAffected tsa ON cpa.CustID = tsa.CustID
		WHERE cpa.SportType = @SportType
		AND cpa.BetType = @BetType
		AND tsa.RoleID IN (2,3)
	    )
BEGIN
	DELETE cpa
	FROM CustWinLossLimit_Agent cpa WITH (ROWLOCK)
	INNER JOIN #TmpSuperAffected tsa ON cpa.CustID = tsa.CustID
	WHERE cpa.SportType = @SportType
	AND cpa.BetType = @BetType
	AND tsa.RoleID IN (2,3)
END

-- WL: Member
IF EXISTS (
		SELECT 1 
		FROM CustWinLossLimit_Member cpa WITH (NOLOCK)
		INNER JOIN #TmpSuperAffected tsa ON cpa.CustID = tsa.CustID
		WHERE cpa.SportType = @SportType
		AND cpa.BetType = @BetType
		AND tsa.RoleID = 1
	    )
BEGIN
	DELETE cpa
	FROM CustWinLossLimit_Member cpa WITH (ROWLOCK)
	INNER JOIN #TmpSuperAffected tsa ON cpa.CustID = tsa.CustID
	WHERE cpa.SportType = @SportType
	AND cpa.BetType = @BetType
	AND tsa.RoleID = 1
END


-- Migrate Data

CREATE TABLE #Tmp_PT
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

CREATE TABLE #Tmp_WL
	(
		CustId	 INT
	    , SportType	 SMALLINT
	    , BetType	 SMALLINT
	    , MaxWinLimit	 SMALLMONEY
	    , MaxLossLimit MONEY
	    , IsAutoReset	 BIT
	)


----------------------------------------------------------------------------
INSERT INTO #Tmp_PT 
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
		temp.CustID AS CustID
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
FROM CustPTSetting3rd_Agent cpa WITH (NOLOCK)
INNER JOIN #TmpSuperAffected temp_Super ON cpa.CustID = temp_Super.CustID
CROSS JOIN #TmpSuperAffected temp
WHERE cpa.SportType = @SportType
AND cpa.BetType = @BetType
AND temp_Super.RoleID = 4
AND temp.RoleID IN (1,2,3)

UPDATE tem
	SET 
		IsAutoMasterPT	= 0,
		IsAutoSuperPT	= 0,
		MasterPT		= 0,
		AgentPT		= 0,
		AutoSuperPT		= 0,
		AutoMasterPT	= 0,
		MinPT			= 0
FROM #Tmp_PT tem 
INNER JOIN #TmpSuperAffected tsa ON tem.CustID = tsa.CustID
WHERE tsa.RoleID  = 3

UPDATE tem
	SET 
		IsAutoMasterPT	= 0,
		IsAutoSuperPT	= 0,
		SuperPT		= 0,
		MasterPT		= 0,
		AgentPT		= 0,
		AutoSuperPT		= 0,
		AutoMasterPT	= 0,
		MinPT			= 0
FROM #Tmp_PT tem 
INNER JOIN #TmpSuperAffected tsa ON tem.CustID = tsa.CustID
WHERE tsa.RoleID  = 2

UPDATE tem
	SET 
		IsAutoMasterPT	= 0,
		IsAutoSuperPT	= 0,
		AutoSuperPT		= 0,
		AutoMasterPT	= 0,
		MasterPT = 0,
		AgentPT = 0
FROM #Tmp_PT tem 
INNER JOIN #TmpSuperAffected tsa ON tem.CustID = tsa.CustID
WHERE tsa.RoleID  = 1

--SELECT * FROM #Tmp_PT tp

INSERT INTO CustPTSetting3rd_Agent 
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
SELECT	tp.CustID
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
FROM #Tmp_PT tp
INNER JOIN #TmpSuperAffected tsa ON tp.CustID = tsa.CustID
WHERE tsa.RoleID IN (2,3)


INSERT INTO CustPTSetting3rd_Member 
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
SELECT	tp.CustID
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
FROM #Tmp_PT tp
INNER JOIN #TmpSuperAffected tsa ON tp.CustID = tsa.CustID
WHERE tsa.RoleID = 1



INSERT INTO #Tmp_WL 
	(
		CustId
	    , SportType
	    , BetType
	    , MaxWinLimit
	    , MaxLossLimit
	    , IsAutoReset
	)
SELECT 
	  temp.CustID AS CustID
	, SportType
	, BetType
	, MaxWinLimit
	, MaxLossLimit
	, IsAutoReset
FROM CustWinLossLimit_Agent  cpa WITH (NOLOCK)
INNER JOIN #TmpSuperAffected temp_Super ON cpa.CustID = temp_Super.CustID
CROSS JOIN #TmpSuperAffected temp
WHERE cpa.SportType = @SportType
AND cpa.BetType = @BetType
AND temp_Super.RoleID = 4
AND temp.RoleID IN (1,2,3)

--SELECT * FROM #Tmp_WL tw

INSERT INTO CustWinLossLimit_Agent 
	(
		CustId
	    , SportType
	    , BetType
	    , MaxWinLimit
	    , MaxLossLimit
	    , IsAutoReset
	)
SELECT 
		tw.CustId
	    , SportType
	    , BetType
	    , MaxWinLimit
	    , MaxLossLimit
	    , IsAutoReset
FROM #Tmp_WL tw
INNER JOIN #TmpSuperAffected tsa ON tw.CustId = tsa.CustID
WHERE tsa.RoleID IN (2,3)

INSERT INTO CustWinLossLimit_Member 
	(
		CustId
	    , SportType
	    , BetType
	    , MaxWinLimit
	    , MaxLossLimit
	    , IsAutoReset
	)
SELECT 
		tw.CustId
	    , SportType
	    , BetType
	    , MaxWinLimit
	    , MaxLossLimit
	    , IsAutoReset
FROM #Tmp_WL tw
INNER JOIN #TmpSuperAffected tsa ON tw.CustId = tsa.CustID
WHERE tsa.RoleID = 1

-- Reset IsHidden

DECLARE
	@bitmapOrder_OtherRNGCasino	 TINYINT

SELECT @bitmapOrder_OtherRNGCasino = (SELECT psp.bitmapOrder FROM ProductStatusProfile psp WITH(NOLOCK)  WHERE psp.Sporttype = @SportType)

--SELECT  RoleID, cps.* 
-- , Ishidden =  (SELECT value FROM dbo.f_CustSetting_ProductStatusSel (cps.bitmapIsHidden,  @bitmapOrder_OtherRNGCasino))
-- , BitMapIsHidden_Upd = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cps.bitmapIsHidden,  @bitmapOrder_OtherRNGCasino, 0))
-- , IsHidden = (SELECT value FROM dbo.f_CustSetting_ProductStatusSel ((SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cps.bitmapIsHidden,  @bitmapOrder_OtherRNGCasino, 0)),  @bitmapOrder_OtherRNGCasino))
UPDATE cps
	SET cps.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cps.bitmapIsHidden,  @bitmapOrder_OtherRNGCasino, 0))
FROM CustProductStatus cps WITH (NOLOCK)
INNER JOIN #TmpSuperAffected temp ON cps.CustID = temp.CustID
WHERE (SELECT value FROM dbo.f_CustSetting_ProductStatusSel (cps.bitmapIsHidden,  @bitmapOrder_OtherRNGCasino)) = 1



DROP TABLE #TmpSuperAffected
DROP TABLE #Tmp_PT
DROP TABLE #Tmp_WL