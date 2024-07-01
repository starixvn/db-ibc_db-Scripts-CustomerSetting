/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240701
	Task: Credit - Adjust data in table SportNonOfferedSiteCurrency [#RM:207360]
	DB: DBCUST/CustDB 
*/

USE CustDB
GO

DELETE TOP (5) non
FROM SportNonOfferedSiteCurrency non WITH (ROWLOCK)
INNER JOIN Site s WITH (NOLOCK) ON s.siteid=non.SiteID
INNER JOIN exchange E WITH (NOLOCK) ON e.ExchangeId=non.Currency
WHERE s.site='BEST-ODDS'
AND s.isActive=1 AND e.IsActive=1
AND (
	(non.SportType=165 AND e.currency='EURO')
	OR
	(non.SportType=171 AND e.currency='USD')
	OR
	(non.SportType=172 AND e.currency IN ('EURO','MMK'))
	)
GO