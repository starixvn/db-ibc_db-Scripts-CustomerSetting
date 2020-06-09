/*
	Created: 20200609@Elodie
	Task: Insert missing setting of IBCBet
	DB: DBCUST/CustDB
*/

USE CustDB
GO
DECLARE @SportType SMALLINT = 242, @Bettype SMALLINT = 3201
DECLARE @MasterList TABLE (CustIDTo INT, CustIDFrom INT)
DECLARE @AgentList TABLE (CustIDTo INT, CustIDFrom INT)

INSERT INTO @MasterList (CustIDTo, CustIDFrom)
SELECT 43220651,	28430575
UNION ALL SELECT 43238471,	43063799
UNION ALL SELECT 43314765,	26820094
UNION ALL SELECT 43315409,	43314765
UNION ALL SELECT 43355281,	43314765
UNION ALL SELECT 43359218,	43354953
UNION ALL SELECT 43374888,	43314765
UNION ALL SELECT 43404220,	43314765
UNION ALL SELECT 43434772,	25068235
UNION ALL SELECT 43442906,	29267193
UNION ALL SELECT 43443886,	29267193
UNION ALL SELECT 43480032,	43314765
UNION ALL SELECT 43480280,	43314765

INSERT INTO @AgentList (CustIDTo, CustIDFrom)
SELECT 43217461,	43217106
UNION ALL SELECT 43269113,	43269100
UNION ALL SELECT 43272290,	38006798
UNION ALL SELECT 43287157,	32843206
UNION ALL SELECT 43322647,	43322414
UNION ALL SELECT 43323274,	43321784
UNION ALL SELECT 43331984,	43331778
UNION ALL SELECT 43351282,	42760666
UNION ALL SELECT 43401680,	40804828
UNION ALL SELECT 43404485,	32843206
UNION ALL SELECT 43427917,	43427774
UNION ALL SELECT 43428691,	43428046
UNION ALL SELECT 43438152,	43187610
UNION ALL SELECT 43484290,	42447914
UNION ALL SELECT 43540496,	43187610

--Insert Master
--PT
INSERT INTO CustPTSetting3rd_Agent (CustID, SportType, BetType, IsLive, SuperPT, MasterPT, AgentPT, IsAutoMasterPT, AutoMasterPT, IsAutoSuperPT, AutoSuperPT, MinPT, MaxPT)
SELECT CustIDTo, SportType, BetType, IsLive, SuperPT, MasterPT, AgentPT, IsAutoMasterPT, AutoMasterPT, IsAutoSuperPT, AutoSuperPT, MinPT, MaxPT
FROM CustPTSetting3rd_Agent cs WITH (NOLOCK)
	INNER JOIN @MasterList c ON cs.CustID = c.CustIDFrom
WHERE cs.SportType = @SportType AND BetType = @Bettype

--Comm
INSERT INTO CustDiscount3rd_Agent (CustID, SportType, BetType, Discount)
SELECT CustIDTo, SportType, BetType, Discount
FROM CustDiscount3rd_Agent cs WITH (NOLOCK)
	INNER JOIN @MasterList c ON cs.CustID = c.CustIDFrom
WHERE cs.SportType = @SportType AND BetType = @Bettype

--BetSetting	
INSERT INTO CustStakeLevel_Agent(CustID, SportType, BetType, StakeLevelList)
SELECT CustIDTo, SportType, BetType, StakeLevelList
FROM CustStakeLevel_Agent cs WITH (NOLOCK)
	INNER JOIN @MasterList c ON cs.CustID = c.CustIDFrom
WHERE cs.SportType = @SportType AND BetType = @Bettype

--WinLossLimit Setting
INSERT INTO CustWinLossLimit_Agent(CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
SELECT CustIDTo, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset
FROM CustWinLossLimit_Agent cs WITH (NOLOCK)
	INNER JOIN @MasterList c ON cs.CustID = c.CustIDFrom
WHERE cs.SportType = @SportType AND BetType = @Bettype

--Insert Agent
--PT
INSERT INTO CustPTSetting3rd_Agent (CustID, SportType, BetType, IsLive, SuperPT, MasterPT, AgentPT, IsAutoMasterPT, AutoMasterPT, IsAutoSuperPT, AutoSuperPT, MinPT, MaxPT)
SELECT CustIDTo, SportType, BetType, IsLive, SuperPT, MasterPT, AgentPT, IsAutoMasterPT, AutoMasterPT, IsAutoSuperPT, AutoSuperPT, MinPT, MaxPT
FROM CustPTSetting3rd_Agent cs WITH (NOLOCK)
	INNER JOIN @AgentList c ON cs.CustID = c.CustIDFrom
WHERE cs.SportType = @SportType AND BetType = @Bettype

--Comm
INSERT INTO CustDiscount3rd_Agent (CustID, SportType, BetType, Discount)
SELECT CustIDTo, SportType, BetType, Discount
FROM CustDiscount3rd_Agent cs WITH (NOLOCK)
	INNER JOIN @AgentList c ON cs.CustID = c.CustIDFrom
WHERE cs.SportType = @SportType AND BetType = @Bettype

--BetSetting	
INSERT INTO CustStakeLevel_Agent(CustID, SportType, BetType, StakeLevelList)
SELECT CustIDTo, SportType, BetType, StakeLevelList
FROM CustStakeLevel_Agent cs WITH (NOLOCK)
	INNER JOIN @AgentList c ON cs.CustID = c.CustIDFrom
WHERE cs.SportType = @SportType AND BetType = @Bettype

--WinLossLimit Setting
INSERT INTO CustWinLossLimit_Agent(CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
SELECT CustIDTo, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset
FROM CustWinLossLimit_Agent cs WITH (NOLOCK)
	INNER JOIN @AgentList c ON cs.CustID = c.CustIDFrom
WHERE cs.SportType = @SportType AND BetType = @Bettype