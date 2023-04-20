/*<info serverAlias="DBCUST-CustDB"></info>*/ 
/*
	Created: 20240420@Helios
	Task: [Check CustDB] Missing setting super KM after move site from 22225 to 22223
	DB: DBCUST/CustDB

	Revisions:
	- Ininial Script [RM:#186094]
*/
 
USE CustDB

DECLARE @CustID_Miss INT = 194354
	,	@CustID_Source INT = 395075

/*1.Check PT Result*/ 

CREATE TABLE #CustPTSetting_Agent (CustID int , SportType smallint , BetType smallint , IsLive bit , IsAutoMasterPT bit , IsAutoSuperPT bit , SuperPT smallmoney , MasterPT smallmoney , AgentPT smallmoney , AutoSuperPT smallmoney , AutoMasterPT smallmoney , MinPT smallmoney , MaxPT smallmoney PRIMARY KEY (CustID , SportType , BetType , IsLive))

INSERT INTO #CustPTSetting_Agent
SELECT @CustID_Miss ,  SportType , BetType , IsLive , IsAutoMasterPT , IsAutoSuperPT  , SuperPT  , MasterPT  , AgentPT  , AutoSuperPT  , AutoMasterPT  , MinPT  , MaxPT  
FROM CustPTSetting3rd_Agent WITH (NOLOCK) WHERE CustID = @CustID_Source AND SportType = 171 AND BetType = 3801					-- Vgaming
UNION
SELECT @CustID_Miss ,  SportType , BetType , IsLive , IsAutoMasterPT , IsAutoSuperPT  , SuperPT  , MasterPT  , AgentPT  , AutoSuperPT  , AutoMasterPT  , MinPT  , MaxPT  
FROM CustPTSetting3rd_Agent WITH (NOLOCK) WHERE CustID = @CustID_Source AND SportType = 176 AND BetType = 8201			-- FGG
UNION
SELECT @CustID_Miss ,  SportType , BetType , IsLive , IsAutoMasterPT , IsAutoSuperPT  , SuperPT  , MasterPT  , AgentPT  , AutoSuperPT  , AutoMasterPT  , MinPT  , MaxPT  
FROM CustPTSetting3rd_Agent WITH (NOLOCK) WHERE CustID = @CustID_Source AND SportType = 9906 AND BetType = 4001		-- N/A
UNION
SELECT @CustID_Miss ,  SportType , BetType , IsLive , IsAutoMasterPT , IsAutoSuperPT  , SuperPT  , MasterPT  , AgentPT  , AutoSuperPT  , AutoMasterPT  , MinPT  , MaxPT  
FROM CustPTSetting3rd_Agent WITH (NOLOCK) WHERE CustID = @CustID_Source AND SportType = 9908 AND BetType = 1201		-- N/A

IF EXISTS (SELECT 1 FROM #CustPTSetting_Agent tmp 
INNER JOIN CustPTSetting3rd_Agent agent WITH (NOLOCK) 
ON tmp.CustID = agent.CustId AND tmp.SportType = agent.SportType AND tmp.BetType = agent.BetType)
BEGIN
	PRINT N'Error, Please Recheck Values Input!'
	RETURN
END
ELSE
BEGIN
	INSERT INTO dbo.CustPTSetting3rd_Agent 
	(CustID ,SportType ,BetType ,IsLive ,IsAutoMasterPT ,IsAutoSuperPT ,SuperPT ,MasterPT ,AgentPT ,AutoSuperPT ,AutoMasterPT ,MinPT ,MaxPT)
	SELECT * FROM #CustPTSetting_Agent
END

SELECT * FROM #CustPTSetting_Agent

/*2.Check Bet Limit Result*/ 

CREATE TABLE #CustBetSetting3rd_Agent (CustID int , SportType SMALLINT, BetType SMALLINT , MinBet MONEY , MaxBet MONEY , MaxPerMatch MONEY PRIMARY KEY (CustID , SportType , BetType))

INSERT INTO #CustBetSetting3rd_Agent
SELECT @CustID_Miss ,SportType ,BetType ,MinBet ,MaxBet ,MaxPerMatch 
FROM CustBetSetting3rd_Agent WITH (NOLOCK) WHERE CustID = @CustID_Source AND SportType = 9908 AND BetType = 1201		-- N/A

IF EXISTS (SELECT 1 FROM #CustBetSetting3rd_Agent tmp 
INNER JOIN CustBetSetting3rd_Agent agent WITH (NOLOCK) 
ON tmp.CustID = agent.CustId AND tmp.SportType = agent.SportType AND tmp.BetType = agent.BetType)
BEGIN
	PRINT N'Error, Please Recheck Values Input!'
	RETURN
END
ELSE
BEGIN
	INSERT INTO dbo.CustBetSetting3rd_Agent 
	(CustID ,SportType ,BetType ,MinBet ,MaxBet ,MaxPerMatch)
	SELECT * FROM #CustBetSetting3rd_Agent
END

SELECT * FROM #CustBetSetting3rd_Agent

/*3.Check Stake Level Result*/

CREATE TABLE #CustStakeLevel_Agent (CustID INT , SportType SMALLINT , BetType SMALLINT , StakeLevelList VARCHAR(200) PRIMARY KEY (CustID , SportType , BetType))

INSERT INTO #CustStakeLevel_Agent
SELECT @CustID_Miss , SportType ,BetType ,StakeLevelList
FROM CustStakeLevel_Agent WITH (NOLOCK) WHERE CustID = @CustID_Source AND SportType = 155 AND BetType = 8400	-- MG-RNG
UNION
SELECT @CustID_Miss , SportType ,BetType ,StakeLevelList
FROM CustStakeLevel_Agent WITH (NOLOCK) WHERE CustID = @CustID_Source AND SportType = 156 AND BetType = 8900	-- SEAL Entertainment
UNION
SELECT @CustID_Miss , SportType ,BetType ,StakeLevelList
FROM CustStakeLevel_Agent WITH (NOLOCK) WHERE CustID = @CustID_Source AND SportType = 158 AND BetType = 5299	-- Jili
UNION
SELECT @CustID_Miss , SportType ,BetType ,StakeLevelList
FROM CustStakeLevel_Agent WITH (NOLOCK) WHERE CustID = @CustID_Source AND SportType = 171 AND BetType = 3801	-- Vgaming
UNION
SELECT @CustID_Miss , SportType ,BetType ,StakeLevelList
FROM CustStakeLevel_Agent WITH (NOLOCK) WHERE CustID = @CustID_Source AND SportType = 176 AND BetType = 8201	-- FGG
UNION
SELECT @CustID_Miss , SportType ,BetType ,StakeLevelList
FROM CustStakeLevel_Agent WITH (NOLOCK) WHERE CustID = @CustID_Source AND SportType = 245 AND BetType = 4605	-- Virtual Games

IF EXISTS (SELECT 1 FROM #CustStakeLevel_Agent tmp 
INNER JOIN CustStakeLevel_Agent agent WITH (NOLOCK) 
ON tmp.CustID = agent.CustId AND tmp.SportType = agent.SportType AND tmp.BetType = agent.BetType)
BEGIN
	PRINT N'Error, Please Recheck Values Input!'
	RETURN
END
ELSE
BEGIN
	INSERT INTO dbo.CustStakeLevel_Agent (CustID ,SportType ,BetType ,StakeLevelList)
	SELECT *
	FROM #CustStakeLevel_Agent
END

SELECT * FROM #CustStakeLevel_Agent


/*4.Check Winloss Limit Result*/

CREATE TABLE #CustWinLossLimit_Agent (CustID INT , SportType SMALLINT ,BetType SMALLINT ,MaxWinLimit SMALLMONEY ,MaxLossLimit MONEY,IsAutoReset BIT PRIMARY KEY (CustID , SportType , BetType))

INSERT INTO #CustWinLossLimit_Agent 
SELECT @CustID_Miss ,SportType ,BetType ,MaxWinLimit ,MaxLossLimit ,IsAutoReset
FROM CustWinLossLimit_Agent WITH(NOLOCK) WHERE CustID = @CustID_Source AND SportType = 171 AND BetType = 3801	-- Vgaming
UNION
SELECT @CustID_Miss ,SportType ,BetType ,MaxWinLimit ,MaxLossLimit ,IsAutoReset 
FROM CustWinLossLimit_Agent WITH(NOLOCK) WHERE CustID = @CustID_Source AND SportType = 176 AND BetType = 8201	-- FGG
UNION
SELECT @CustID_Miss ,SportType ,BetType ,MaxWinLimit ,MaxLossLimit ,IsAutoReset
FROM CustWinLossLimit_Agent WITH(NOLOCK) WHERE CustID = @CustID_Source AND SportType = 9906 AND BetType = 4001	-- N/A
UNION
SELECT @CustID_Miss ,SportType ,BetType ,MaxWinLimit ,MaxLossLimit ,IsAutoReset 
FROM CustWinLossLimit_Agent WITH(NOLOCK) WHERE CustID = @CustID_Source AND SportType = 9908 AND BetType = 1201	-- N/A
UNION
SELECT @CustID_Miss ,SportType ,BetType ,MaxWinLimit ,MaxLossLimit ,IsAutoReset 
FROM CustWinLossLimit_Agent WITH(NOLOCK) WHERE CustID = @CustID_Source AND SportType = 9909 AND BetType = 3700	-- N/A

IF EXISTS (SELECT 1 FROM #CustWinLossLimit_Agent tmp 
INNER JOIN CustWinLossLimit_Agent agent WITH (NOLOCK) 
ON tmp.CustID = agent.CustId AND tmp.SportType = agent.SportType AND tmp.BetType = agent.BetType)
BEGIN
	PRINT N'Error, Please Recheck Values Input!'
	RETURN
END
ELSE
BEGIN
	INSERT INTO dbo.CustWinLossLimit_Agent (CustId ,SportType ,BetType ,MaxWinLimit ,MaxLossLimit ,IsAutoReset)
	SELECT *
	FROM #CustWinLossLimit_Agent
END

SELECT * FROM #CustWinLossLimit_Agent

