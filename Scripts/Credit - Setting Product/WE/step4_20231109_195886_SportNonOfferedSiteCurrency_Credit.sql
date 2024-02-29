/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20231109
	Task:  WE Live Casino - Implement customer setting [RedmineID: #195886]
	DB: DBCUST/CustDB
*/

DECLARE @Sporttype SMALLINT = 228,
		@Bettype SMALLINT = 10300,
		@RealProductID	SMALLINT = 80

DECLARE @data AS TABLE(	
	[SiteID] [int],
	[Currency] [int]
)
INSERT INTO @data(SiteID, Currency)
SELECT 	SiteID,
		Currency
FROM SportNonOfferedSiteCurrency WITH (NOLOCK)
WHERE Sporttype = 159 AND BetType = 3151

INSERT INTO SportNonOfferedSiteCurrency(SportType, BetType, SiteID, Currency, RealProductId)
SELECT @SportType, @BetType, SiteID, Currency, @RealProductID
FROM @data
