/*
	Created: Elodie	
	Task: Add setting for STE8
	DB: DBCUST/CustDB
	Date: 20200708
*/ 

SELECT ci.custid, roleid
INTO #tmpCust
FROM custInfo ci WITH (NOLOCK)
WHERE ci.srecommend = 3984944 --STE8

--AGENT LEVEL
INSERT INTO dbo.CustPTSetting3rd_Agent
	(	[CustID]
		,[SportType]
		,[BetType]
		,[IsLive]
		,[SuperPT]
		,[MasterPT]
		,[AgentPT]
		,[IsAutoMasterPT]
		,[AutoMasterPT]
		,[IsAutoSuperPT]
		,[AutoSuperPT]
		,[MinPT]
		,[MaxPT])
SELECT 
	cs.custid, SportType, BetType, IsLive
	,0,0,0,0,0,0,0,0
	,100 --dtl.MaxPT
FROM #tmpCust cs
	CROSS JOIN ProductsettingDetail ps WITH (NOLOCK)
WHERE productid = 5 and settingtype = 1
	AND cs.roleid <> 1
	
INSERT INTO [dbo].[CustBetSetting3rd_Agent]
	([CustID]
	,[SportType]
	,[BetType]
	,[MinBet]
	,[MaxBet]
	,[MaxPerMatch])
SELECT
	cs.custid, SportType, BetType
	,0
	,0
	,0
FROM #tmpCust cs
	CROSS JOIN ProductsettingDetail ps WITH (NOLOCK)
WHERE productid = 5 and settingtype = 2
	AND cs.roleid <> 1
				
INSERT INTO [dbo].[CustWinLossLimit_Agent]
	([CustID]
	,[SportType]
	,[BetType]
	,[MaxWinLimit]
	,[MaxLossLimit]
	,[IsAutoReset])
SELECT
	CustID
	,SportType
	,BetType
	,0
	,500000
	,1
FROM #tmpCust cs
	CROSS JOIN ProductsettingDetail ps WITH (NOLOCK)
WHERE productid = 5 and settingtype = 6
	AND cs.roleid <> 1