/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20241218@Virgil
	Task: SABA Keno - Implement Setting and Initial data [RedmineID: #214757]
	DB: DBCUST-CustDB
*/

DECLARE @Sporttype SMALLINT = 133,
		@Bettype INT = 12300;

INSERT INTO SportNonOfferedSiteCurrency(SportType, BetType, Currency, SiteID, RealProductId, RepUpdateTime)
SELECT @Sporttype AS SportType, @Bettype AS BetType, 0 AS Currency, siteid AS SiteID, 102 AS RealProductId, dbo.f_GetDateTime2() AS RepUpdateTime
FROM dbo.Site (NOLOCK)
WHERE IsActive = 1 
	And isLicensee = 0 
	AND SiteLabel != '789y'
