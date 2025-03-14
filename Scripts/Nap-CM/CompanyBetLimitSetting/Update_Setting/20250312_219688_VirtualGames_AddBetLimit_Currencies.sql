/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20250312
	Task: Virtual Games - Add Global Bet Setting for Deposit of some Currencies [Redmine:#219688] 
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--add new group exchange
CREATE TABLE #tmpExchange (ExchangeId INT PRIMARY KEY, LicenseeGroupID TINYINT IDENTITY(1,1))

INSERT INTO #tmpExchange(ExchangeId)
SELECT ExchangeId
FROM exchange WITH (NOLOCK)
WHERE currency IN (	 'ZAR'
					,'CZK'
					,'AED'
					,'KZT'
					,'TND'
					,'TZS'
					,'DZD'
					,'MAD'
					,'FRF'
					,'LBP')
	AND LicenseeGroupID IS NULL 
	AND OfferSite IN (0,2) AND IsActive=1

DECLARE @Max_LicenseeGroupID INT

SELECT @Max_LicenseeGroupID=MAX(LicenseeGroupID)
FROM exchange WITH (NOLOCK)

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
	  SELECT 245,	2,	44,		1,	200000,		0,	 dbo.f_Getdatetime2()
UNION SELECT 245,	2,	45,		1,	1000,		0,	 dbo.f_Getdatetime2()
UNION SELECT 245,	2,	43,		1,	2000,		0,	 dbo.f_Getdatetime2()
UNION SELECT 245,	2,	46,		1,	900000,		0,	 dbo.f_Getdatetime2()
UNION SELECT 245,	2,	39,		1,	500000,		0,	 dbo.f_Getdatetime2()
UNION SELECT 245,	2,	47,		1,	50000,		0,	 dbo.f_Getdatetime2()
UNION SELECT 245,	2,	48,		1,	3000,		0,	 dbo.f_Getdatetime2()
UNION SELECT 245,	2,	49,		1,	3000,		0,	 dbo.f_Getdatetime2()
UNION SELECT 245,	2,	29,		1,	20000,		0,	 dbo.f_Getdatetime2()
UNION SELECT 245,	2,	41,		1,	10000,		0,	 dbo.f_Getdatetime2()
UNION SELECT 245,	2,	42,		1,	10000,		0,	 dbo.f_Getdatetime2()
UNION SELECT 245,	2,	50,		1,	3500000,	0,	 dbo.f_Getdatetime2()
UNION SELECT 245,	2,	36,		1,	1000,		0,	 dbo.f_Getdatetime2()
UNION SELECT 245,	2,	37,		1,	50000,		0,	 dbo.f_Getdatetime2()
GO