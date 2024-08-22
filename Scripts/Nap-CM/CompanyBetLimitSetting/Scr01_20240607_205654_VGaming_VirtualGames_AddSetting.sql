/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20240607
	Task: initial data into Dep_ProductStakeLevelGroup for VGaming & Virtual Games  [Redmine:#205654] 
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--add new group exchange
UPDATE [exchange] WITH (ROWLOCK, UPDLOCK)
SET 
	LicenseeGroupID = CASE  WHEN currency IN ('GBP') THEN 24
							WHEN currency IN ('CAN') THEN 25
							WHEN currency IN ('SEK') THEN 26
							WHEN currency IN ('NOK') THEN 27
							WHEN currency IN ('PLN') THEN 28
							WHEN currency IN ('LIR') THEN 29
							WHEN currency IN ('KES') THEN 30
							WHEN currency IN ('GHS') THEN 31
							WHEN currency IN ('CLP') THEN 32
							WHEN currency IN ('PEN') THEN 33
							WHEN currency IN ('EGP') THEN 34
					END,
	RepUpdateTime = SYSDATETIME()
WHERE currency IN ('GBP','CAN','SEK','NOK','PLN','LIR','KES','GHS','CLP','PEN','EGP')
	AND OfferSite IN (2,0) AND IsActive=1
GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup (Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID)
--VGaming
	  SELECT 171,	2,	23,	0.01,	500000,		0
UNION SELECT 171,	2,	20,	0.01,	100000,		0
UNION SELECT 171,	2,	11,	0.01,	1500,		0
UNION SELECT 171,	2,	18,	0.01,	5000,		0
UNION SELECT 171,	2,	25,	0.01,	1000,		0
UNION SELECT 171,	2,	32,	0.01,	500000,		0
UNION SELECT 171,	2,	5,	0.01,	8000,		0
UNION SELECT 171,	2,	19,	0.01,	4000000,	0
UNION SELECT 171,	2,	4,	0.01,	1000,		0
UNION SELECT 171,	2,	24,	0.01,	500,		0
UNION SELECT 171,	2,	31,	0.01,	10000,		0
UNION SELECT 171,	2,	7,	0.01,	15000,		0
UNION SELECT 171,	2,	15,	0.01,	85000,		0
UNION SELECT 171,	2,	8,	0.01,	150000,		0
UNION SELECT 171,	2,	30,	0.01,	50000,		0
UNION SELECT 171,	2,	17,	0.01,	4000,		0
UNION SELECT 171,	2,	10,	0.01,	1000000,	0
UNION SELECT 171,	2,	16,	0.01,	2000,		0
UNION SELECT 171,	2,	12,	0.01,	15000,		0
UNION SELECT 171,	2,	1,	0.01,	5000,		0
UNION SELECT 171,	2,	27,	0.01,	5000,		0
UNION SELECT 171,	2,	22,	0.01,	100000,		0
UNION SELECT 171,	2,	33,	0.01,	2000,		0
UNION SELECT 171,	2,	21,	0.01,	300000,		0
UNION SELECT 171,	2,	28,	0.01,	2000,		0
UNION SELECT 171,	2,	14,	0.01,	100000,		0
UNION SELECT 171,	2,	26,	0.01,	5000,		0
UNION SELECT 171,	2,	3,	0.01,	35000,		0
UNION SELECT 171,	2,	3,	1,		2500,		875
UNION SELECT 171,	2,	29,	0.01,	15000,		0
UNION SELECT 171,	2,	2,	0.01,	1000,		0
UNION SELECT 171,	2,	6,	0.01,	1000,		0
UNION SELECT 171,	2,	6,	1,		2500,		875
UNION SELECT 171,	2,	13,	0.01,	25000,		0
UNION SELECT 171,	2,	34,	3,		60000,		0
--Virtual Games
UNION SELECT 245,	2,	23,	1,	300000,		0
UNION SELECT 245,	2,	20,	1,	40000,		0
UNION SELECT 245,	2,	11,	1,	500,		0
UNION SELECT 245,	2,	18,	1,	2000,		0
UNION SELECT 245,	2,	25,	1,	500000,		0
UNION SELECT 245,	2,	32,	1,	400000,		0
UNION SELECT 245,	2,	5,	1,	3000,		0
UNION SELECT 245,	2,	19,	1,	1000000,	0
UNION SELECT 245,	2,	4,	1,	500,		0
UNION SELECT 245,	2,	24,	1,	500,		0
UNION SELECT 245,	2,	31,	1,	5000,		0
UNION SELECT 245,	2,	7,	1,	6000000,	0
UNION SELECT 245,	2,	15,	1,	30000,		0
UNION SELECT 245,	2,	8,	1,	60000,		0
UNION SELECT 245,	2,	30,	1,	60000,		0
UNION SELECT 245,	2,	17,	1,	1000000,	0
UNION SELECT 245,	2,	10,	1,	500000,		0
UNION SELECT 245,	2,	16,	1,	800000,		0
UNION SELECT 245,	2,	12,	1,	5000,		0
UNION SELECT 245,	2,	1,	1,	2000,		0
UNION SELECT 245,	2,	27,	1,	5000,		0
UNION SELECT 245,	2,	22,	1,	50000,		0
UNION SELECT 245,	2,	33,	1,	1000,		0
UNION SELECT 245,	2,	9,	1,	20000,		0
UNION SELECT 245,	2,	21,	1,	100000,		0
UNION SELECT 245,	2,	28,	1,	1000,		0
UNION SELECT 245,	2,	14,	1,	30000,		0
UNION SELECT 245,	2,	26,	1,	5000,		0
UNION SELECT 245,	2,	3,	1,	20000,		0
UNION SELECT 245,	2,	2,	1,	500,		0
UNION SELECT 245,	2,	6,	1,	2000,		0
UNION SELECT 245,	2,	13,	1,	10000000,	0
GO