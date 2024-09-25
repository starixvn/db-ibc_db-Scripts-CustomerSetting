/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: @Helios
	Date: 06/06/2024
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
	@RealProductID		INT		= 8,
	@SportType			SMALLINT	= 202,
	@BetType			SMALLINT	= 1501,
	@BitmapOrder_RNGKeno	TINYINT,
	@MaxPT			TINYINT

SELECT TOP 1 @MaxPT= MaxPT FROM ProductSettingDetail WITH(NOLOCK) WHERE RealProductId = @RealProductID and SettingType = 18 AND SportType = @SportType AND BetType = @BetType

SELECT TOP 1 @BitmapOrder_RNGKeno = bitmapOrder FROM ProductStatusProfile WITH(NOLOCK) WHERE Sporttype = @SportType AND Bettype = @BetType


--Get Super Account Affect
CREATE TABLE #SuperID (SuperID INT , IsHidden BIT , IsDisable BIT , PRIMARY KEY CLUSTERED (SuperID))

INSERT INTO #SuperID 
	(
		SuperID
	)
SELECT c.custid 
FROM Customer c WITH (NOLOCK) 
WHERE c.username IN ('999MYR','DT','JARWRONG','KOR','CSDTEST','MIRI SD','PPO','S2C','skwrongxxx','StarixSCYEN','SuperTestTH','PRU','S188AH','S1NT','S52RMB','S688T','SBSR','SJ','SMOT','SQE','SSP','SWT','SXRS','TL1','TL6')

UPDATE si 
	SET 
		IsHidden = (SELECT value FROM dbo.f_CustSetting_ProductStatusSel (cps.bitmapIsHidden,  @BitmapOrder_RNGKeno)) ,
		IsDisable = (SELECT value FROM dbo.f_CustSetting_ProductStatusSel (cps.bitmapIsDisabled,  @BitmapOrder_RNGKeno))
FROM CustProductStatus cps WITH (NOLOCK)
INNER JOIN #SuperID si ON cps.CustID = si.SuperID

-- Check Data
--SELECT @RealProductID AS RealProductID , @SportType AS SportType , @BetType AS BetType , @MaxPT AS MaxPT , @BitmapOrder_RNGKeno AS BitmapOrder_RNGKeno

--SELECT si.IsHidden , si.IsDisable , c.*
--FROM #SuperID si
--INNER JOIN Customer c WITH (NOLOCK) ON si.SuperID = c.srecommend

-- Step 1:
IF NOT EXISTS (SELECT 1 FROM #SuperID si WHERE si.IsHidden = 0)
BEGIN
	UPDATE cps
		SET 
		bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cps.bitmapIsHidden,  @BitmapOrder_RNGKeno, 0)) ,
		bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cps.bitmapIsDisabled,  @BitmapOrder_RNGKeno, 1))
	FROM CustProductStatus cps WITH (ROWLOCK , UPDLOCK)
	INNER JOIN #SuperID si ON cps.CustID = si.SuperID
END	

-- Step 2:

IF NOT EXISTS (	SELECT 1
			FROM CustPTSetting3rd_Agent cpa WITH (NOLOCK)
			INNER JOIN #SuperID si ON cpa.CustID = si.SuperID
			WHERE cpa.SportType = @SportType
			AND cpa.BetType = @BetType
		)
BEGIN

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
	SELECT
		si.SuperID AS CustID
	    , @SportType AS SportType
	    , @BetType   AS BetType
	    , 0 AS IsLive
	    , 0 AS IsAutoMasterPT
	    , 0 AS IsAutoSuperPT
	    , @MaxPT AS SuperPT
	    , @MaxPT AS MasterPT
	    , @MaxPT AS AgentPT
	    , 0 AS AutoSuperPT
	    , 0 AS AutoMasterPT
	    , 0 AS MinPT
	    , 100 AS MaxPT
	FROM #SuperID si


END


IF NOT EXISTS (	SELECT 1
			FROM CustBetSetting3rd_Agent cpa WITH (NOLOCK)
			INNER JOIN #SuperID si ON cpa.CustID = si.SuperID
			WHERE cpa.SportType = @SportType
			AND cpa.BetType = @BetType
		)
BEGIN
	INSERT INTO CustBetSetting3rd_Agent 
	(
		CustID
	    , SportType
	    , BetType
	    , MinBet
	    , MaxBet
	    , MaxPerMatch
	)
	SELECT
		si.SuperID AS CustID
	    , @SportType AS SportType
	    , @BetType   AS BetType
	    , 0 AS MinBet
	    , 0 AS MaxBet
	    , 0 AS MaxPerMatch
	FROM #SuperID si

END


-- Check data

--SELECT cpa.* 
--FROM CustPTSetting3rd_Agent cpa WITH (NOLOCK)
--INNER JOIN #SuperID si ON cpa.CustID = si.SuperID
--WHERE cpa.SportType = @SportType
--AND cpa.BetType = @BetType

--SELECT cpa.* 
--FROM CustBetSetting3rd_Agent cpa WITH (NOLOCK)
--INNER JOIN #SuperID si ON cpa.CustID = si.SuperID
--WHERE cpa.SportType = @SportType
--AND cpa.BetType = @BetType

DROP TABLE #SuperID