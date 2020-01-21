/*
	Created: 20191028@Winnie
	Task: Insert product profile for SG
	DB: DBCUST/CustDB
*/

-- BEGIN STEP 1: DEPLOY THIS SCRIPT ON DBCUST/CustDB	 --
-----------------------------------------------------------
USE CustDB
GO

-- BEGIN STEP 2: DEPLOY THIS SCRIPT ON DBCUST/CustDB	 --
-----------------------------------------------------------
CREATE TABLE #tmpbettype (BettypeID INT PRIMARY KEY)
INSERT INTO #tmpbettype(BettypeID)
SELECT 4301 UNION ALL
SELECT 4302 UNION ALL
SELECT 4303 UNION ALL
SELECT 4304 UNION ALL
SELECT 4305

INSERT INTO StakeLevel(GameTypeID	,GameGroupID,	MinLabel,	MaxLabel,	MinStake,	MaxStake,	ExchangeID,	ResourceID)
SELECT 4301,	12,	NULL,	NULL,	NULL,	NULL,	exchangeid	,NULL
FROM exchange WITH(NOLOCK)
WHERE exchangeid=72

INSERT INTO StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT StakeLevelID,	t.BettypeID,	'0.25',	' 125.00',	 0.25 , 125.00 
FROM StakeLevel WITH(NOLOCK) 
		CROSS APPLY  #tmpbettype t
WHERE GameTypeID=4301 AND GameGroupID=12 AND ExchangeId=72

