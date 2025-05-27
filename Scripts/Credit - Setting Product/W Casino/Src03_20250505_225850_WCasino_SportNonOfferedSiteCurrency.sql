/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20250505
	Task: W Casino - Integrate new Live Casino product - Implement Setting and Initial data [RedmineID: #225850]
	DB: DBCUST-CustDB
*/
USE CustDB
GO

DECLARE @ProductID TINYINT = 98,
		@Sporttype SMALLINT = 136,
		@Bettype INT = 12000;

INSERT INTO SportNonOfferedSiteCurrency(SportType, BetType, Currency, SiteID, RealProductId, RepUpdateTime)
SELECT @Sporttype AS SportType, @Bettype AS BetType, exchangeid AS Currency, 0 AS SiteID, @ProductID AS RealProductId, dbo.f_GetDateTime2() AS RepUpdateTime
FROM exchange (NOLOCK)
WHERE IsActive = 1 
	And OfferSite IN (0,1) 
	AND currency NOT IN ('RM','HKK','RMB', 'HK$',
	'US$','Yen','$US','UT','USD','Won','THB', 'MMK',
	'IN','IND','IDD','IDR','DDD','INH','YNG','UUS', 'EURO')
