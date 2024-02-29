/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20240223
	Task:  WE Live Casino - Implement customer setting [RedmineID: #195886]
	DB: DBCUST/CustDB
*/

DECLARE @SiteID INT
SELECT @SiteID = SiteID 
FROM Site WITH (NOLOCK)
WHERE site = '777777' 

INSERT INTO SportNonOfferedSiteCurrency(SportType, BetType, SiteID, Currency, RealProductId)
SELECT 228, 10300, @SiteID, 0, 80