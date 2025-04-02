/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20250402
	Task: Vgaming & Virtual Games - Add Global Bet Setting for Deposit of some Currencies [Redmine:#221981] 
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--add new group exchange
CREATE TABLE #tmpExchange (ExchangeId INT PRIMARY KEY, LicenseeGroupID TINYINT IDENTITY(1,1))

INSERT INTO #tmpExchange(ExchangeId)
SELECT ExchangeId
FROM exchange WITH (NOLOCK)
WHERE currency IN (	 'AOA'
					,'XAF')
	AND LicenseeGroupID IS NULL 
	AND OfferSite IN (0,2) AND IsActive=1

DECLARE @Max_LicenseeGroupID INT = 50

--SELECT ExchangeId
--	, LicenseeGroupID+@Max_LicenseeGroupID AS LicenseeGroupID
--	, @Max_LicenseeGroupID AS Max_LicenseeGroupID
--FROM #tmpExchange t

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
INSERT INTO Dep_ProductStakeLevelGroup (Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID, RepUpdateTime)
-- Virtual Games
	  SELECT 245,		2,		51,		1,		335000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 245,		2,		52,		1,		200000,		0,		 dbo.f_Getdatetime2()
-- Vgaming
UNION SELECT 171,		1,		51,		0.01,	200000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 171,		1,		52,		0.01,	200000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 171,		2,		51,		0.01,	200000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 171,		2,		52,		0.01,	200000,		0,		 dbo.f_Getdatetime2()
GO