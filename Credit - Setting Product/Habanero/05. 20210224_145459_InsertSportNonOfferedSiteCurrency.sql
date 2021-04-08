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


-- Sited Offered not full currency
-- Credit
INSERT INTO SportNonOfferedSiteCurrency (SportType,BetType,Currency,SiteID)
SELECT @SportType AS SportType,
	   @BetType AS BetType,
	   e.ExchangeId AS Currency,
	   s.siteid
FROM Site s WITH(NOLOCK) 
INNER JOIN exchange e WITH(NOLOCK) ON s.isActive  = e.IsActive
 WHERE s.isActive = 1 AND s.site NOT IN('76666b')
	AND e.ExchangeId NOT IN  (13      --RMB
							 ,6       --EURO
							 ,12      --GBP
							 ,5       --HK$
							 ,67      --HKK
							 ,15      --IN
							 ,22      --IND
							 ,33      --IDD
							 ,34      --IDR
							 ,47      --DDD
							 ,45      --Won
							 ,69      --MMK
							 ,2       --RM
							 ,43      --THB
							 ,35      --$US
							 ,3       --US$
							 ,16      --Yen
							 ,95      --USD
							 ,64      --UT
							 ,7       --DON
							 ,51      --INH
							 ,20	  --UUS
							 ,72 	  --YNG
							)
	AND s.isLicensee = 0 AND s.isDeposit = 0 AND e.OfferSite in (0,1)
