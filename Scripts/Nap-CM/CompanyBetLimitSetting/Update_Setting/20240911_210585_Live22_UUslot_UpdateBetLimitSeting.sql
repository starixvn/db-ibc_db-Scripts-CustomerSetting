/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20240911
	Task: update bet limit setting for Live22 & UU slot  [Redmine:#210585] 
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--add new group exchange
UPDATE [exchange] WITH (ROWLOCK, UPDLOCK)
SET 
	LicenseeGroupID = 35,
	RepUpdateTime = SYSDATETIME()
WHERE currency IN ('CHF')
	AND OfferSite IN (2,0) AND IsActive=1
GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup (Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID)
	  SELECT 227,	1,	20,	0.01,	100000,	0
UNION SELECT 227,	1,	17,	0.01,	4000,	0
UNION SELECT 227,	1,	24,	0.01,	1000,	0
UNION SELECT 227,	1,	35,	0.01,	1000,	0
GO

----------------------------------------------------------------------------------------------------------------
--UPDATE:
CREATE TABLE #tmpSetting
	(
		Sporttype		SMALLINT,
		GameGroupID		TINYINT, 
		LicenseeGroupID TINYINT, 
		MaxBet			MONEY, 
		SiteID			INT,
		PRIMARY KEY (Sporttype, GameGroupID, LicenseeGroupID, SiteID)
	)


INSERT INTO #tmpSetting (Sporttype, GameGroupID, LicenseeGroupID, MaxBet, SiteID)
-- Live22
	  SELECT 227,	1,	5,	8000,		0
UNION SELECT 227,	1,	4,	1000,		0
UNION SELECT 227,	1,	7,	15000,		0
UNION SELECT 227,	1,	15,	80000,		0
UNION SELECT 227,	1,	8,	150000,		0
UNION SELECT 227,	1,	10,	1500000,	0
UNION SELECT 227,	1,	1,	5000,		0
UNION SELECT 227,	1,	14,	100000,		0
UNION SELECT 227,	1,	3,	40000,		0
UNION SELECT 227,	1,	2,	1000,		0
UNION SELECT 227,	1,	13,	30000,		0
UNION SELECT 227,	1,	6,	1000,		0
-- UU slot
UNION SELECT 216,	1,	5,	8000,		0
UNION SELECT 216,	1,	4,	1000,		0
UNION SELECT 216,	1,	7,	15000,		0
UNION SELECT 216,	1,	15,	80000,		0
UNION SELECT 216,	1,	8,	150000,		0
UNION SELECT 216,	1,	10,	1500000,	0
UNION SELECT 216,	1,	1,	5000,		0
UNION SELECT 216,	1,	14,	100000,		0
UNION SELECT 216,	1,	3,	40000,		0
UNION SELECT 216,	1,	2,	1000,		0
UNION SELECT 216,	1,	13,	30000,		0
UNION SELECT 216,	1,	6,	1000,		0


UPDATE psl
SET psl.MaxBet=s.MaxBet
	, psl.RepUpdateTime=dbo.f_GetDateTime2()
FROM Dep_ProductStakeLevelGroup psl WITH (ROWLOCK, UPDLOCK)
INNER JOIN #tmpSetting s ON s.Sporttype=psl.Sporttype
						AND s.GameGroupID=psl.GameGroupID
						AND s.LicenseeGroupID=psl.LicenseeGroupID
						AND s.SiteID=psl.SiteID
GO
