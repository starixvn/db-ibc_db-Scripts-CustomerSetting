/*
	Created: 20200713@Elodie
	Task: Insert missing setting of ION
	DB: DBCUST/CustDB
*/

USE CustDB
GO
DECLARE @SportType SMALLINT = 225, @Bettype SMALLINT = 5601
DECLARE @AgentList TABLE (CustIDTo INT, CustIDFrom INT)

INSERT INTO @AgentList (CustIDTo, CustIDFrom)
SELECT 44041137,	23710199
UNION ALL SELECT 44023361,	44022504
UNION ALL SELECT 43969174,	43913710

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
