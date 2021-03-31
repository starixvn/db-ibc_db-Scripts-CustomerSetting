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
	@SportType as SportType,
	@BetType as BetType,
	0 as Currency, -- all currency
	siteid 
FROM [Site] WITH(NOLOCK) 
WHERE [SITE] IN ('76666b') 
	AND isActive = 1 AND isLicensee = 0 AND isDeposit = 0

