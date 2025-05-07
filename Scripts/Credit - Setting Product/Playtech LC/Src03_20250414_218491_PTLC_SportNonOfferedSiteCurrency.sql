/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250414@Tacy
	Task: Playtech Live - Integrate new Live Casino product - Implement Setting and Initial data [RedmineID: #218491]
	DB: DBCUST-CustDB
*/
USE CustDB
GO

DECLARE @ProductID TINYINT = 101,
		@Sporttype SMALLINT = 129,
		@Bettype INT = 15600;

IF EXISTS (SELECT TOP 1 1 FROM SportNonOfferedSiteCurrency WITH (NOLOCK) WHERE SportType=@Sporttype AND BetType=@Bettype)
BEGIN
	DELETE non
	OUTPUT deleted.SportType, deleted.BetType, deleted.Currency, deleted.SiteID, dbo.f_GetDateTime2()
	INTO SportNonOfferedSiteCurrency_Del_InHouse (SportType, BetType, Currency, SiteID, RepUpdateTime)
	FROM SportNonOfferedSiteCurrency non WITH (ROWLOCK)
	WHERE SportType=@Sporttype AND BetType=@Bettype 
END

INSERT INTO SportNonOfferedSiteCurrency(SportType, BetType, Currency, SiteID, RealProductId, RepUpdateTime)
SELECT @Sporttype AS SportType, @Bettype AS BetType, exchangeid AS Currency, 0 AS SiteID, @ProductID AS RealProductId, dbo.f_GetDateTime2() AS RepUpdateTime
FROM exchange (NOLOCK)
WHERE IsActive = 1 
	And OfferSite IN (0,1) 
	AND currency NOT IN ('RM','HKK','RMB',
	'US$','Yen','$US','UT','USD','Won','THB',
	'IN','IND','IDD','IDR','DDD','INH','YNG','UUS')
