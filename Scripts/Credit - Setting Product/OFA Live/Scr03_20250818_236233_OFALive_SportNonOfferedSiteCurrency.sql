/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
        Created: Tacy@20250818
        Task: OFA Live - Integrate new Live Casino product - Implement Setting and Initial data [RedmineID: #236233]
        DB: DBCUST-CustDB
*/
USE CustDB
GO

DECLARE @ProductID TINYINT = 113,
                @Sporttype SMALLINT = 119,
                @Bettype INT = 12250;

INSERT INTO SportNonOfferedSiteCurrency(SportType, BetType, Currency, SiteID, RealProductId, RepUpdateTime)
SELECT @Sporttype AS SportType, @Bettype AS BetType, exchangeid AS Currency, 0 AS SiteID, @ProductID AS RealProductId, dbo.f_GetDateTime2() AS RepUpdateTime
FROM exchange (NOLOCK)
WHERE IsActive = 1 
        And OfferSite IN (0,1) 
        AND currency NOT IN ('RM','HKK','RMB','HK$',
							 'US$','Yen','$US','UT','USD',
							 'MMK','Won','THB',
							 'IN','IND','IDD','IDR','DDD',
							 'INH','EURO','YNG','UUS')
