/*
	Created: Winfred
	Date: 20200824
	Task: Insert value SportNonOfferedSiteCurrency [Redmine: 137763]
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
where site NOT IN('spondemo','Athena000','Macaubet','Aoncash','ITCBet','9bet','M8bola','Q8bola','BE7','NBCbet','Unobet','Bolanation','Luckywin88','Winn69','Axiawin','Jumbo88','Lagadewa','Ratugg','Monstergol')
AND site NOT IN	 ('755555','IBCIndo','Indo','KORIBC','789y') 
AND isActive = 1

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
-- Deposit
INSERT INTO SportNonOfferedSiteCurrency (SportType,BetType,Currency,SiteID)
SELECT 	@SportType as SportType,
	@BetType as BetType,
	e.ExchangeId as Currency,
	s.siteid
FROM Site s with(nolock) 
INNER JOIN exchange e with(nolock)   on s.isActive  = e.IsActive
 where s.isActive = 1   
 AND s.site IN('spondemo','Athena000','Macaubet','Aoncash','ITCBet','9bet','M8bola','Q8bola','BE7','NBCbet','Unobet','Bolanation','Luckywin88','Winn69','Axiawin','Jumbo88','Lagadewa','Ratugg','Monstergol')
 AND e.ExchangeId not in  (SELECT ExchangeId from Dep_StakeLevel with(nolock) where GameTypeID  = 6001)

