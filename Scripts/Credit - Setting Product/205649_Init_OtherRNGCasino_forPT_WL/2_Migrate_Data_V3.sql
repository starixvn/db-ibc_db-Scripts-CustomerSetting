/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 2024-05-31
	Created: @Helios
	Task: Database - Initialize Other RNG Casino for PT and Win Loss Limit [#205649]
	DB: DBCUST-CustDB
*/

---------------------------VERIFY DATA-----------------------------------------

IF NOT EXISTS (SELECT 1 FROM tmp_CustProductStatus_DanielTest33 cps WITH (NOLOCK))
BEGIN
	RAISERROR ( N'Missing data tmp_CustProductStatus_DanielTest33', 0, 1)
	RETURN;
END
IF NOT EXISTS (SELECT 1 FROM tmp_CustPTSetting3rd_Agent_DanielTest33 cps WITH (NOLOCK))
BEGIN
	RAISERROR ( N'Missing data tmp_CustPTSetting3rd_Agent_DanielTest33', 0, 1)
	RETURN;
END
IF NOT EXISTS (SELECT 1 FROM tmp_CustPTSetting3rd_Member_DanielTest33 cps WITH (NOLOCK))
BEGIN
	RAISERROR ( N'Missing data tmp_CustPTSetting3rd_Member_DanielTest33', 0, 1)
	RETURN;
END
IF NOT EXISTS (SELECT 1 FROM tmp_CustWinLossLimit_Agent_DanielTest33 cps WITH (NOLOCK))
BEGIN
	RAISERROR ( N'Missing data tmp_CustWinLossLimit_Agent_DanielTest33', 0, 1)
	RETURN;
END
IF NOT EXISTS (SELECT 1 FROM tmp_CustWinLossLimit_Member_DanielTest33 cps WITH (NOLOCK))
BEGIN	
	RAISERROR ( N'Missing data tmp_CustWinLossLimit_Member_DanielTest33', 0, 1)
	RETURN;
END
-- Verify for Update:
IF NOT EXISTS  (  SELECT 1 
			FROM tmp_CustProductStatus_DanielTest33 cps WITH (NOLOCK)
			INNER JOIN CustProductStatus cps1 WITH (NOLOCK) ON cps.CustID = cps1.CustID
		   )
BEGIN
	RAISERROR ( N'Missing data CustProductStatus', 0, 1)
	RETURN;
END


-- Verify for Insert:
IF EXISTS  (  SELECT 1 
			FROM tmp_CustPTSetting3rd_Agent_DanielTest33 cps WITH (NOLOCK)
			INNER JOIN CustPTSetting3rd_Agent cps1 WITH (NOLOCK)
					ON cps.CustID = cps1.CustID
					AND cps.SportType = cps1.SportType 
					AND cps.BetType = cps1.BetType
					AND cps.IsLive = cps1.IsLive
		   )
BEGIN
	RAISERROR ( N'Existing data CustPTSetting3rd_Agent', 0, 1)
	RETURN;
END

IF EXISTS  (  SELECT 1 
			FROM tmp_CustPTSetting3rd_Member_DanielTest33 cps WITH (NOLOCK)
			INNER JOIN CustPTSetting3rd_Member cps1  WITH (NOLOCK)
					ON cps.CustID = cps1.CustID
					AND cps.SportType = cps1.SportType 
					AND cps.BetType = cps1.BetType
					AND cps.IsLive = cps1.IsLive
		   )
BEGIN
	RAISERROR ( N'Existing data CustPTSetting3rd_Member', 0, 1)
	RETURN;
END

IF EXISTS  (  SELECT 1 
			FROM tmp_CustWinLossLimit_Agent_DanielTest33 cps WITH (NOLOCK)
			INNER JOIN CustWinLossLimit_Agent cps1  WITH (NOLOCK)
					ON cps.CustID = cps1.CustID
					AND cps.SportType = cps1.SportType 
					AND cps.BetType = cps1.BetType
		   )
BEGIN
	RAISERROR ( N'Existing data CustWinLossLimit_Agent', 0, 1)
	RETURN;
END

IF EXISTS  (  SELECT 1 
			FROM tmp_CustWinLossLimit_Member_DanielTest33 cps WITH (NOLOCK)
			INNER JOIN CustWinLossLimit_Member cps1  WITH (NOLOCK)
					ON cps.CustID = cps1.CustID
					AND cps.SportType = cps1.SportType 
					AND cps.BetType = cps1.BetType
		   )
BEGIN		   
	RAISERROR ( N'Existing data CustWinLossLimit_Member', 0, 1)
	RETURN;
END

---------------------------MIGRATE DATA-----------------------------------------

UPDATE cps
	SET cps.bitmapIsHidden = temp.bitmapIsHidden
FROM CustProductStatus cps WITH (ROWLOCK , UPDLOCK)
INNER JOIN tmp_CustProductStatus_DanielTest33 temp WITH (NOLOCK) ON cps.CustID = temp.CustID

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
FROM tmp_CustPTSetting3rd_Agent_DanielTest33 WITH (NOLOCK)

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
FROM tmp_CustPTSetting3rd_Member_DanielTest33 WITH (NOLOCK)

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
		CustId
	    , SportType
	    , BetType
	    , MaxWinLimit
	    , MaxLossLimit
	    , IsAutoReset
FROM tmp_CustWinLossLimit_Agent_DanielTest33 WITH (NOLOCK)

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
		CustId
	    , SportType
	    , BetType
	    , MaxWinLimit
	    , MaxLossLimit
	    , IsAutoReset
FROM tmp_CustWinLossLimit_Member_DanielTest33 WITH (NOLOCK)

