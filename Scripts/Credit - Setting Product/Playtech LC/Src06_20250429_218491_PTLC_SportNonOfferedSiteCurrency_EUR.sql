/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250429@Tacy
	Task: Playtech Live - Exclude EURO currrency from SportNonOfferedSiteCurrency [RedmineID: #218491]
	DB: DBCUST-CustDB
*/
USE CustDB
GO

DECLARE @Sporttype SMALLINT = 129,
		@Bettype INT = 15600;

DELETE TOP (2) non
	OUTPUT deleted.SportType, deleted.BetType, deleted.Currency, deleted.SiteID, dbo.f_GetDateTime2()
	INTO SportNonOfferedSiteCurrency_Del_InHouse (SportType, BetType, Currency, SiteID, RepUpdateTime)
FROM SportNonOfferedSiteCurrency non WITH (ROWLOCK)
WHERE SportType=@Sporttype AND BetType=@Bettype 
	AND Currency=6	--EURO
GO