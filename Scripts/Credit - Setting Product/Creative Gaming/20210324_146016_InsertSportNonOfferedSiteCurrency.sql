/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created:	Winfred
	Date:		20210324
	Task:		Non offer 76666b [Creative Gaming] - Credit RedmineID:#146016
	DB:			DBCust/CustDB
*/
DECLARE @betType SMALLINT,@sportType SMALLINT
SET @sportType = 167
SET @betType = 7301 

DELETE FROM SportNonOfferedSiteCurrency WHERE   SportType = @SportType AND BetType = @BetType
-- Sited non Offered
INSERT INTO SportNonOfferedSiteCurrency (SportType,BetType,Currency,SiteID)
SELECT 
	@SportType AS SportType,
	@BetType AS BetType,
	0 AS Currency, -- all currency
	siteid 
FROM [Site] WITH(NOLOCK) 
WHERE [SITE] IN ('76666b') 
	AND isActive = 1 AND isLicensee = 0 AND isDeposit = 0

-- Sited Offered not full currency
-- Credit
INSERT INTO SportNonOfferedSiteCurrency (SportType,BetType,Currency,SiteID)
SELECT 	@SportType AS SportType,
	@BetType AS BetType,
	e.ExchangeId AS Currency,
	s.siteid
FROM Site s WITH(NOLOCK) 
INNER JOIN exchange e WITH(NOLOCK) ON s.isActive  = e.IsActive
 WHERE s.isActive = 1   AND s.site NOT IN('76666b')
	AND e.ExchangeId not in  (2,3,5,6,7,12,13,15,16,20,72,22,33,34,35,43,45,47,51,64,67,69,95)
	AND isLicensee = 0 AND isDeposit = 0