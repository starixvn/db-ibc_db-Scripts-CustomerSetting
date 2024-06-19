/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20240617
	Task: initial data into ProductStakeLevelGroup for some currencies  [Redmine:#206515] 
	DB:	DBCUST-CustDB
*/
USE CustDB
GO
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--add new group exchange
UPDATE [exchange] WITH (ROWLOCK, UPDLOCK)
SET 
	CreditGroupID = CASE 
						WHEN currency IN ('AUD') THEN 15
						WHEN currency IN ('INR1') THEN 16
						WHEN currency IN ('GBP') THEN 17
						WHEN currency IN ('CHF') THEN 18
						WHEN currency IN ('CAN') THEN 19
						WHEN currency IN ('DKK') THEN 20
						WHEN currency IN ('SEK') THEN 21
						WHEN currency IN ('NOK') THEN 22
						WHEN currency IN ('CZK') THEN 23
						WHEN currency IN ('RON') THEN 24
					END,
	RepUpdateTime = SYSDATETIME()
WHERE currency IN ('AUD','CAN','CHF','CZK','DKK','GBP','INR1','NOK','RON','SEK')
	AND OfferSite IN (1,0)
GO
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--ProductStakeLevelGroup
CREATE TABLE #Temp_StakeLevelGroup (
		Sporttype		SMALLINT
	    , GameGroupID	TINYINT 	--GameGroupID = 1 : Slot Game;  2 : Others only
	    , MinBet		MONEY
	    , MaxBet		MONEY
	    , CreditGroupID	TINYINT
	    , Remark		VARCHAR(1000)
	    PRIMARY KEY (Sporttype , GameGroupID , CreditGroupID)
	)

INSERT INTO #Temp_StakeLevelGroup 
	(
		Sporttype
		, GameGroupID
		, CreditGroupID
		, MinBet
		, MaxBet
		, Remark
	)
-- Macau Games
	  SELECT 212,	1,	5,	0.1,	7500,	NULL
UNION SELECT 212,	1,	13,	0.1,	2500,	'Temporary add for EC.'
UNION SELECT 212,	1,	15,	0.1,	3000,	'Temporary add for EC.'
UNION SELECT 212,	1,	19,	0.1,	3000,	'Temporary add for EC.'
UNION SELECT 212,	1,	18,	0.1,	2000,	'Temporary add for EC.'
UNION SELECT 212,	1,	23,	0.1,	40000,	'Temporary add for EC.'
UNION SELECT 212,	1,	20,	0.1,	10000,	'Temporary add for EC.'
UNION SELECT 212,	1,	17,	0.1,	1500,	'Temporary add for EC.'
UNION SELECT 212,	1,	16,	0.1,	150000,	'Temporary add for EC.'
UNION SELECT 212,	1,	22,	0.1,	20000,	'Temporary add for EC.'
UNION SELECT 212,	1,	24,	0.1,	10000,	'Temporary add for EC.'
UNION SELECT 212,	1,	21,	0.1,	20000,	'Temporary add for EC.'
UNION SELECT 212,	2,	5,	0.1,	2000,	NULL
UNION SELECT 212,	2,	13,	0.1,	500,	'Temporary add for EC.'
UNION SELECT 212,	2,	15,	0.1,	500,	'Temporary add for EC.'
UNION SELECT 212,	2,	19,	0.1,	500,	'Temporary add for EC.'
UNION SELECT 212,	2,	18,	0.1,	500,	'Temporary add for EC.'
UNION SELECT 212,	2,	23,	0.1,	10000,	'Temporary add for EC.'
UNION SELECT 212,	2,	20,	0.1,	2000,	'Temporary add for EC.'
UNION SELECT 212,	2,	17,	0.1,	500,	'Temporary add for EC.'
UNION SELECT 212,	2,	16,	0.1,	50000,	'Temporary add for EC.'
UNION SELECT 212,	2,	22,	0.1,	5000,	'Temporary add for EC.'
UNION SELECT 212,	2,	24,	0.1,	2000,	'Temporary add for EC.'
UNION SELECT 212,	2,	21,	0.1,	5000,	'Temporary add for EC.'
-- PP
UNION SELECT 248,	1,	9,	0.1,	50000,	NULL
UNION SELECT 248,	1,	13,	0.1,	2500,	'Temporary add for EC.'
UNION SELECT 248,	1,	17,	0.1,	1500,	'Temporary add for EC.'
UNION SELECT 248,	1,	16,	0.1,	150000,	'Temporary add for EC.'
UNION SELECT 248,	2,	9,	0.1,	6500,	NULL
UNION SELECT 248,	2,	13,	0.1,	500,	'Temporary add for EC.'
UNION SELECT 248,	2,	17,	0.1,	500,	'Temporary add for EC.'
UNION SELECT 248,	2,	16,	0.1,	50000,	'Temporary add for EC.'
-- SG
UNION SELECT 247,	1,	9,	0.1,	50000,	NULL
UNION SELECT 247,	1,	13,	0.1,	2500,	'Temporary add for EC.'
UNION SELECT 247,	1,	15,	0.1,	3000,	'Temporary add for EC.'
UNION SELECT 247,	1,	17,	0.1,	1500,	'Temporary add for EC.'
UNION SELECT 247,	1,	22,	0.1,	20000,	'Temporary add for EC.'
UNION SELECT 247,	1,	21,	0.1,	20000,	'Temporary add for EC.'
UNION SELECT 247,	2,	9,	0.01,	100000,	NULL
UNION SELECT 247,	2,	13,	0.01,	25000,	'Temporary add for EC.'
UNION SELECT 247,	2,	15,	0.01,	5000,	'Temporary add for EC.'
UNION SELECT 247,	2,	17,	0.01,	2500,	'Temporary add for EC.'
UNION SELECT 247,	2,	22,	0.01,	50000,	'Temporary add for EC.'
UNION SELECT 247,	2,	21,	0.01,	50000,	'Temporary add for EC.'
-- MG-RNG
UNION SELECT 155,	1,	5,	0.1,	7500,	NULL
UNION SELECT 155,	1,	4,	0.1,	10000,	NULL
UNION SELECT 155,	1,	8,	0.1,	700000,	NULL
UNION SELECT 155,	1,	9,	0.1,	50000,	NULL
UNION SELECT 155,	1,	13,	0.1,	2500,	'Temporary add for EC.'
UNION SELECT 155,	2,	5,	0.1,	2000,	NULL
UNION SELECT 155,	2,	4,	0.1,	2500,	NULL
UNION SELECT 155,	2,	8,	0.1,	350000,	NULL
UNION SELECT 155,	2,	9,	0.1,	6500,	NULL
UNION SELECT 155,	2,	13,	0.1,	500,	'Temporary add for EC.'
-- Jili
UNION SELECT 158,	1,	4,	0.1,	5000,	NULL
UNION SELECT 158,	1,	9,	0.1,	50000,	NULL
UNION SELECT 158,	1,	13,	0.1,	1000,	'Temporary add for EC.'
UNION SELECT 158,	1,	17,	0.1,	1000,	'Temporary add for EC.'
UNION SELECT 158,	2,	4,	0.1,	2500,	NULL
UNION SELECT 158,	2,	9,	0.1,	6500,	NULL
UNION SELECT 158,	2,	13,	0.1,	500,	'Temporary add for EC.'
UNION SELECT 158,	2,	17,	0.1,	500,	'Temporary add for EC.'
-- VGaming
UNION SELECT 171,	1,	3,	0.1,	2000,	NULL
UNION SELECT 171,	1,	13,	0.1,	2000,	'Temporary add for EC.'
UNION SELECT 171,	1,	14,	0.1,	2000,	'Temporary add for EC.'
UNION SELECT 171,	1,	17,	0.1,	1000,	'Temporary add for EC.'
UNION SELECT 171,	2,	3,	0.1,	2000,	NULL
UNION SELECT 171,	2,	13,	0.1,	2000,	'Temporary add for EC.'
UNION SELECT 171,	2,	14,	0.1,	2000,	'Temporary add for EC.'
UNION SELECT 171,	2,	17,	0.1,	500,	'Temporary add for EC.'
--Funky Games
UNION SELECT 224,	1,	13,	0.1,	500,	'Temporary add for EC.'
UNION SELECT 224,	2,	13,	0.1,	500,	'Temporary add for EC.'
-- SEAL
UNION SELECT 156,	1,	4,	0.1,	5000,	NULL
UNION SELECT 156,	1,	10,	0.1,	1000,	NULL
UNION SELECT 156,	1,	13,	0.1,	1000,	'Temporary add for EC.'
UNION SELECT 156,	2,	4,	0.1,	2500,	NULL
UNION SELECT 156,	2,	10,	0.1,	500,	NULL
UNION SELECT 156,	2,	13,	0.1,	500,	'Temporary add for EC.'
-- AdvantPlay
UNION SELECT 172,	1,	4,	0.1,	10000,	NULL
UNION SELECT 172,	1,	10,	0.1,	2000,	NULL
UNION SELECT 172,	1,	9,	0.1,	50000,	NULL
UNION SELECT 172,	1,	13,	0.1,	2500,	'Temporary add for EC.'
UNION SELECT 172,	1,	17,	0.1,	1500,	'Temporary add for EC.'
UNION SELECT 172,	1,	16,	0.1,	150000,	'Temporary add for EC.'
-- Joker
UNION SELECT 234,	1,	5,	0.01,	3500,	NULL
UNION SELECT 234,	1,	4,	0.01,	5000,	NULL
UNION SELECT 234,	1,	10,	0.01,	1000,	NULL
UNION SELECT 234,	1,	13,	0.01,	1000,	'Temporary add for EC.'
UNION SELECT 234,	1,	16,	0.01,	50000,	'Temporary add for EC.'
-- Habanero
UNION SELECT 238,	1,	9,	0.1,	50000,	NULL
UNION SELECT 238,	1,	13,	0.1,	1000,	'Temporary add for EC.'
UNION SELECT 238,	1,	17,	0.1,	1000,	'Temporary add for EC.'
-- CG
UNION SELECT 167,	1,	10,	0.1,	1000,	NULL
UNION SELECT 167,	1,	9,	0.1,	50000,	NULL
UNION SELECT 167,	1,	13,	0.1,	1000,	'Temporary add for EC.'
UNION SELECT 167,	1,	17,	0.1,	1000,	'Temporary add for EC.'
-- PG Soft
UNION SELECT 232,	1,	9,	0.1,	50000,	NULL
UNION SELECT 232,	1,	13,	0.1,	2500,	'Temporary add for EC.'
-- Live22
UNION SELECT 227,	1,	9,	0.01,	50000,	NULL
UNION SELECT 227,	1,	13,	0.01,	1250,	'Temporary add for EC.'
--UU Slots
UNION SELECT 216,	1,	9,	0.01,	50000,	NULL
UNION SELECT 216,	1,	13,	0.01,	1250,	'Temporary add for EC.'
-- AdvantPlay Mini
UNION SELECT 174,	2,	4,	0.1,	2500,	NULL
UNION SELECT 174,	2,	10,	0.1,	500,	NULL
UNION SELECT 174,	2,	9,	0.1,	50000,	NULL
UNION SELECT 174,	2,	13,	0.1,	100,	'Temporary add for EC.'
UNION SELECT 174,	2,	17,	0.1,	100,	'Temporary add for EC.'
UNION SELECT 174,	2,	16,	0.1,	5000,	'Temporary add for EC.'
-- MaxGame
UNION SELECT 237,	2,	13,	0.1,	2000,	'Temporary add for EC.'
--Arcadia Gaming
UNION SELECT 165,	2,	13,	0.1,	500,	'Temporary add for EC.'
UNION SELECT 165,	2,	16,	0.1,	15000,	'Temporary add for EC.'
-- Virtual Games
UNION SELECT 245,	2,	13,	1,		2000,	'Temporary add for EC.'

-------------------------------------------------------------------
--update setting:
UPDATE p
SET p.MinBet=t.MinBet
	,p.MaxBet=t.MaxBet
	,p.Remark=t.Remark
	,p.RepUpdateTime=SYSDATETIME()
FROM ProductStakeLevelGroup p WITH (ROWLOCK, UPDLOCK)
INNER JOIN #Temp_StakeLevelGroup t ON t.Sporttype=p.Sporttype
								  AND t.GameGroupID=p.GameGroupID
								  AND t.CreditGroupID=p.CreditGroupID

--Add new currency setting
INSERT INTO ProductStakeLevelGroup (Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, Remark)
SELECT t.Sporttype, t.GameGroupID, t.CreditGroupID, t.MinBet, t.MaxBet, t.Remark
FROM #Temp_StakeLevelGroup t
LEFT JOIN ProductStakeLevelGroup p WITH (NOLOCK)  
		ON t.Sporttype=p.Sporttype
		AND t.GameGroupID=p.GameGroupID
		AND t.CreditGroupID=p.CreditGroupID
WHERE p.Sporttype IS NULL
GO
