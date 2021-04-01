/*
	Created: 20210224@Tina
	Task: Insert value SportNonOfferedSiteCurrency for Habanero
	Redmine: https://nexdev.net/issues/145459
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO

DECLARE @SportType INT = 238,@BetType INT   = 7001
--Delete data exits
DELETE FROM SportNonOfferedSiteCurrency WHERE   SportType = @SportType AND BetType = @BetType
-- Sited non Offered
INSERT INTO SportNonOfferedSiteCurrency (SportType,BetType,Currency,SiteID)
SELECT 
	@SportType as SportType,
	@BetType as BetType,
	0 as Currency, -- all currency
	siteid 
FROM [Site] WITH(NOLOCK) 
WHERE [SITE] IN ('76666b') 
	AND isActive = 1 AND isLicensee = 0 AND isDeposit = 0

