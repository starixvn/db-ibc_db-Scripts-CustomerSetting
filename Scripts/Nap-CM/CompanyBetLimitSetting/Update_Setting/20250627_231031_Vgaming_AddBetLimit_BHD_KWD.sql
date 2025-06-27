/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created by: Tacy@20250627
	Task: Vgaming & Virtual- Add Global Bet Setting for Deposit of some Currencies [Redmine:#231031] 
	DB:	DBGLOB-GlobCustDB

	** Currencies: BHD & KWD
*/
USE GlobCustDB
GO
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--add new group exchange
CREATE TABLE #tmpExchange (ExchangeId INT PRIMARY KEY, LicenseeGroupID TINYINT IDENTITY(1,1))

INSERT INTO #tmpExchange(ExchangeId)
SELECT ExchangeId
FROM exchange WITH (NOLOCK)
WHERE currency IN ('BHD', 'KWD')
	AND LicenseeGroupID IS NULL 
	AND OfferSite IN (0,2) AND IsActive=1

DECLARE @Max_LicenseeGroupID INT = 57

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
	  SELECT 171,		1,		58,		0.1,		300,		0,		 dbo.f_Getdatetime2()
UNION SELECT 171,		1,		59,		0.1,		300,		0,		 dbo.f_Getdatetime2()
UNION SELECT 171,		2,		58,		1,			1000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 171,		2,		59,		1,			1000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 245,		2,		58,		1,			200,		0,		 dbo.f_Getdatetime2()
UNION SELECT 245,		2,		59,		1,			200,		0,		 dbo.f_Getdatetime2()
GO