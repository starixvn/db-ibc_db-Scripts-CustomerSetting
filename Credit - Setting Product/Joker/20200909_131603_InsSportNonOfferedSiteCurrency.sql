/*
	Created: Winfred
	Date: 20200909
	Task: Insert value SportNonOfferedSiteCurrency real currency [Joker] - Credit RedmineID:#131603
	DB: DBCUST/CustDB
*/
DECLARE @SportType INT = 234,@BetType INT   = 6401
--Delete data exits
DELETE FROM SportNonOfferedSiteCurrency WHERE   SportType = @SportType AND BetType = @BetType
-- Sited non Offered
INSERT INTO SportNonOfferedSiteCurrency (SportType,BetType,Currency,SiteID)
SELECT 
	@SportType as SportType,
	@BetType as BetType,
	0 as Currency, -- all currency
	siteid 
from Site with(nolock) 
where site IN ('789y') 
AND isActive = 1 AND isLicensee = 0 AND isDeposit = 0

