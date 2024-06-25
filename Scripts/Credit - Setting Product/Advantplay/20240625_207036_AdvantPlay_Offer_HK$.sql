/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240625
	Task: AdvantPlay - Offer HK$ currency, all sites (exclude 789 sites, 76666b) [#RM:207036]
	DB: DBCUST/CustDB 
*/

USE CustDB
GO

DELETE TOP (17) non
FROM SportNonOfferedSiteCurrency non WITH (ROWLOCK)
INNER JOIN Site s WITH (NOLOCK) ON s.siteid=non.SiteID
INNER JOIN exchange E WITH (NOLOCK) ON e.ExchangeId=non.Currency
WHERE non.SportType=172 AND e.currency='HK$' 
AND s.SiteLabel<>'789y' AND s.site<>'76666b'
AND s.isActive=1 AND e.IsActive=1
GO