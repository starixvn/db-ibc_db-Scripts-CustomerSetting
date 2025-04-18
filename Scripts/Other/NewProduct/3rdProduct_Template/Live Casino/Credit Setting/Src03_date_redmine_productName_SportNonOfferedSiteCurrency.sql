/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: {Nickname}@{date}
	Task: {ProductName} - Integrate new Live Casino product - Implement Setting and Initial data [RedmineID: #xxx]
	DB: DBCUST-CustDB
*/
USE CustDB
GO

DECLARE @ProductID TINYINT = {ProductID},
		@Sporttype SMALLINT = {Sporttype},
		@Bettype INT = {Bettype};

INSERT INTO SportNonOfferedSiteCurrency(SportType, BetType, Currency, SiteID, RealProductId, RepUpdateTime)
SELECT @Sporttype AS SportType, @Bettype AS BetType, exchangeid AS Currency, 0 AS SiteID, @ProductID AS RealProductId, dbo.f_GetDateTime2() AS RepUpdateTime
FROM exchange (NOLOCK)
WHERE IsActive = 1 
	And OfferSite IN (0,1) 
	AND currency NOT IN ('RM','HKK','RMB',
	'US$','Yen','$US','UT','USD','Won','THB',
	'IN','IND','IDD','IDR','DDD','INH','YNG','UUS')
