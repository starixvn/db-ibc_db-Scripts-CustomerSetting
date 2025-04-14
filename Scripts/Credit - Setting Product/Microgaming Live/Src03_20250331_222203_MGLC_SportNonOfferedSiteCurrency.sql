/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250331@Tacy
	Task: Microgaming Live - Integrate new Live Casino product - Implement Setting and Initial data [RedmineID: #222203]
	DB: DBCUST-CustDB
*/
USE CustDB
GO

DECLARE @ProductID TINYINT = 107,
		@Sporttype SMALLINT = 124,
		@Bettype INT = 13900;

INSERT INTO SportNonOfferedSiteCurrency(SportType, BetType, Currency, SiteID, RealProductId, RepUpdateTime)
SELECT @Sporttype AS SportType, @Bettype AS BetType, exchangeid AS Currency, 0 AS SiteID, @ProductID AS RealProductId, dbo.f_GetDateTime2() AS RepUpdateTime
FROM exchange (NOLOCK)
WHERE IsActive = 1 
	And OfferSite IN (0,1) 
	AND currency NOT IN ('MMK','RM','HKK','HK$','RMB',
	'US$','Yen','$US','UT','USD','Won','THB',
	'IN','IND','IDD','IDR','DDD', 'INH','EURO','UUS')
