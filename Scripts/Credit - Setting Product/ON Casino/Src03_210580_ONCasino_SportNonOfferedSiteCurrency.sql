/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 202409009@Virgil
	Task:  ON Casino - Implement customer setting [RedmineID: #210025]
	DB: DBCUST-CustDB
*/

DECLARE @Sporttype SMALLINT = 138,
		@Bettype INT = 11850;

INSERT INTO SportNonOfferedSiteCurrency(SportType, BetType, Currency, SiteID, RealProductId)
SELECT @Sporttype AS SportType, @Bettype AS BetType, exchangeid AS Currency, 0 AS SiteID, 96 AS RealProductId
FROM exchange (NOLOCK)
WHERE IsActive = 1 
	And OfferSite IN (0,1) 
	AND currency NOT IN ('RM','HKK','HK$','RMB',
	'US$','Yen','$US','UT','USD',
	'MMK','Won','THB',
	'IN','IND','IDD','IDR','DDD',
	'INH','EURO','PC','UUS')