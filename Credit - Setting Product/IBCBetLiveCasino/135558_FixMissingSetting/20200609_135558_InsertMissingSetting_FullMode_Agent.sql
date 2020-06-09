/*
	Created: 20200609@Elodie
	Task: Insert missing setting of IBCBet
	DB: DBCUST/CustDB
*/

USE CustDB
GO
DECLARE @SportType SMALLINT = 242, @Bettype SMALLINT = 3201
DECLARE @AgentList TABLE (CustID INT, UplineId INT)

INSERT INTO @AgentList (CustID, UplineId)
SELECT custid, mrecommend
FROM custInfo WITH (NOLOCK)
WHERE custid IN (43321784
,43322414
,43322838
,43323098
,43330938
,43331303
,43331410
,43331778
,43385489
,43398319
,43398532
,43398658
,43398733
,43401853
,43427774
,43437158
,43448455
,43491411
,43522200)

-- Insert Agent
--PT
INSERT INTO CustPTSetting3rd_Agent (CustID, SportType, BetType, IsLive, SuperPT, MasterPT, AgentPT, IsAutoMasterPT, AutoMasterPT, IsAutoSuperPT, AutoSuperPT, MinPT, MaxPT)
SELECT c.custid, SportType, BetType, IsLive, 0, MasterPT,0,0,0,0,0,0 , MaxPT
FROM CustPTSetting3rd_Agent cs WITH (NOLOCK)
	INNER JOIN @AgentList c ON cs.CustID = c.UplineId
WHERE cs.SportType = @SportType AND BetType = @Bettype

--Comm
INSERT INTO CustDiscount3rd_Agent (CustID, SportType, BetType, Discount)
SELECT c.CustID, SportType, BetType, 0
FROM CustDiscount3rd_Agent cs WITH (NOLOCK)
	INNER JOIN @AgentList c ON cs.CustID = c.UplineId
WHERE cs.SportType = @SportType AND BetType = @Bettype

--BetSetting	
INSERT INTO CustStakeLevel_Agent(CustID, SportType, BetType, StakeLevelList)
SELECT c.CustID, SportType, BetType, StakeLevelList
FROM CustStakeLevel_Agent cs WITH (NOLOCK)
	INNER JOIN @AgentList c ON cs.CustID = c.UplineId
WHERE cs.SportType = @SportType AND BetType = @Bettype

--WinLossLimit Setting
INSERT INTO CustWinLossLimit_Agent(CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
SELECT c.CustID, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset
FROM CustWinLossLimit_Agent cs WITH (NOLOCK)
	INNER JOIN @AgentList c ON cs.CustID = c.UplineId
WHERE cs.SportType = @SportType AND BetType = @Bettype
