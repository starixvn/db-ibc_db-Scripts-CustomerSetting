/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 202401120@Virgil
	Task: GPI Live Casino - Integrate new Live Casino product - Implement Setting and Initial data [RedmineID: #213485]
	DB: DBCUST-CustDB
*/

DECLARE @ProductID TINYINT = 90,
		@Sporttype SMALLINT = 144,
		@Bettype INT = 11500;

INSERT INTO SportNonOfferedSiteCurrency(SportType, BetType, Currency, SiteID, RealProductId, RepUpdateTime)
SELECT @Sporttype AS SportType, @Bettype AS BetType, exchangeid AS Currency, 0 AS SiteID, @ProductID AS RealProductId, dbo.f_GetDateTime2() AS RepUpdateTime
FROM exchange (NOLOCK)
WHERE IsActive = 1 
	And OfferSite IN (0,1) 
	AND currency NOT IN ('RM','HKK','HK$','RMB',
	'US$','Yen','$US','UT','USD','Won','THB',
	'IN','IND','IDD','IDR','DDD', 'INH','EURO','UUS')
