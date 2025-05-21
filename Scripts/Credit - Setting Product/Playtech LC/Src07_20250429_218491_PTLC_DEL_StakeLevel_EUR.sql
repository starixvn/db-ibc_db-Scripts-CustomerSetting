/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250505@Tacy
	Task: Playtech Live - Include EURO currrency from SportNonOfferedSiteCurrency [RedmineID: #218491]
	DB: DBCUST-CustDB
*/
USE CustDB
GO

DECLARE @ProductID TINYINT = 101,
		@Sporttype SMALLINT = 129,
		@Bettype INT = 15600;

INSERT INTO SportNonOfferedSiteCurrency(SportType, BetType, Currency, SiteID, RealProductId, RepUpdateTime)
SELECT @Sporttype AS SportType, @Bettype AS BetType, exchangeid AS Currency, 0 AS SiteID, @ProductID AS RealProductId, dbo.f_GetDateTime2() AS RepUpdateTime
FROM exchange (NOLOCK)
WHERE IsActive = 1 
	And OfferSite IN (0,1) 
	AND currency IN ('EURO')
GO

------------------------------------------------------------------------------------------------------------------
USE GlobCustDB
GO

DELETE TOP (2) sl
	OUTPUT deleted.StakeLevelID, dbo.f_getdatetime2()
	INTO StakeLevel_Del_InHouse (StakeLevelID, RepUpdateTime)
FROM StakeLevel sl WITH (ROWLOCK)
WHERE GameTypeID=15600 AND ExchangeId=6
GO

DELETE TOP (7) sl
	OUTPUT deleted.StakeLevelID, dbo.f_getdatetime2()
	INTO StakeLevel_Del_InHouse (StakeLevelID, RepUpdateTime)
FROM Dep_StakeLevel sl WITH (ROWLOCK)
WHERE GameTypeID=15600 AND ExchangeId=6
GO