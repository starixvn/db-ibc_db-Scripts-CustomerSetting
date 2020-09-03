/*
	Created: Winfred
	Date: 20200824
	Task: Insert value SportNonOfferedSiteCurrency real currency [Redmine: 137763]
	DB: DBCUST/CustDB
*/
SELECT * from SportNonOfferedSiteCurrency with(nolock) 
SELECT * FROM ProductSettingDetail with(nolock)   where ProductID = 22 and SettingType = 8

DECLARE @SportType INT = 232,@BetType INT   = 6001
--Delete data exits
DELETE FROM SportNonOfferedSiteCurrency WHERE   SportType = @SportType AND BetType = @BetType
-- Sited non Offered
INSERT INTO SportNonOfferedSiteCurrency (SportType,BetType,Currency,SiteID)
SELECT 
	@SportType as SportType,
	@BetType as BetType,
	0 as Currency, -- all currency
	siteid 
from Site with(nolock) 
where site NOT IN	 ('755555','IBCIndo','Indo','KORIBC','789y','BEST-ODDS') 
AND isActive = 1 AND isLicensee = 0 AND isDeposit = 0

-- Sited Offered not full currency
-- Credit
INSERT INTO SportNonOfferedSiteCurrency (SportType,BetType,Currency,SiteID)
SELECT 	@SportType as SportType,
	@BetType as BetType,
	e.ExchangeId as Currency,
	s.siteid
FROM Site s with(nolock) 
INNER JOIN exchange e with(nolock)   on s.isActive  = e.IsActive
 where s.isActive = 1   
 AND s.site IN('755555','IBCIndo','Indo','KORIBC','789y')
 AND e.ExchangeId not in  (SELECT ExchangeId from StakeLevel with(nolock) where GameTypeID  = 6001)
--Offered BEST-ODDS UUS TEST
INSERT INTO SportNonOfferedSiteCurrency (SportType,BetType,Currency,SiteID)
SELECT 	@SportType as SportType,
	@BetType as BetType,
	e.ExchangeId as Currency,
	s.siteid
FROM Site s with(nolock) 
INNER JOIN exchange e with(nolock)   on s.isActive  = e.IsActive
 where s.isActive = 1   
 AND s.site IN('BEST-ODDS')
 AND e.ExchangeId not in  (20,72)

