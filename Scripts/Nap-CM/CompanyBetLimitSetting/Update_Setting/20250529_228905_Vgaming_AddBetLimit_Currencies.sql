/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created by: Tacy@20250529
	Task: Vgaming - Add Global Bet Setting for Deposit of some Currencies [Redmine:#228905] 
	DB:	DBGLOB-GlobCustDB

	** Currencies: BOB, PYG, UYU, VES, CRC
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--add new group exchange
CREATE TABLE #tmpExchange (ExchangeId INT PRIMARY KEY, LicenseeGroupID TINYINT IDENTITY(1,1))

INSERT INTO #tmpExchange(ExchangeId)
SELECT ExchangeId
FROM exchange WITH (NOLOCK)
WHERE currency IN ('BOB', 'PYG', 'UYU', 'VES', 'CRC')
	AND LicenseeGroupID IS NULL 
	AND OfferSite IN (0,2) AND IsActive=1

DECLARE @Max_LicenseeGroupID INT = 52

SELECT ExchangeId
	, LicenseeGroupID+@Max_LicenseeGroupID AS LicenseeGroupID
FROM #tmpExchange t

--UPDATE
UPDATE E
SET 
	LicenseeGroupID = T.LicenseeGroupID + @Max_LicenseeGroupID,
	RepUpdateTime = dbo.f_GetDateTime2()
FROM [exchange] e WITH (ROWLOCK, UPDLOCK)
INNER JOIN #tmpExchange t ON T.ExchangeId=e.ExchangeId

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup 
		(Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID, RepUpdateTime)
	  SELECT 171,		1,		56,		0.01,		8000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 171,		1,		54,		0.01,		10000000,	0,		 dbo.f_Getdatetime2()
UNION SELECT 171,		1,		55,		0.01,		50000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 171,		1,		53,		0.01,		100000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 171,		1,		57,		0.01,		500000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 171,		2,		56,		0.01,		8000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 171,		2,		54,		0.01,		10000000,	0,		 dbo.f_Getdatetime2()
UNION SELECT 171,		2,		55,		0.01,		50000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 171,		2,		53,		0.01,		100000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 171,		2,		57,		0.01,		500000,		0,		 dbo.f_Getdatetime2()
GO