/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
/*
	Created by: Elodie
	Date: 12042024
	Task: sync exchange from PRO to SIT 
	DB: DBCUST/CustDB
*/
USE CustDB
GO

SELECT ep.ExchangeId, ep.currency, ep.code, ep.stakerate, ep.actualrate, ep.commaxpayout, ep.creator, ep.minbet, ep.minbetlive, ep.AUDRate, ep.ZARRate, ep.GBPRate, ep.EURORate, ep.US$Rate, ep.Description, ep.MultipliedBy, ep.ExVirtualRate, 
	ep.IsActive, ep.OfferSite, ep.CurrencyType, ep.CreditGroupID, ep.LicenseeGroupID INTO #TmpCurrency
FROM Exchange e WITH (NOLOCK)
	RIGHT JOIN exchange_staging_tmp ep WITH (NOLOCK) ON e.ExchangeId = ep.ExchangeId
WHERE (e.currency = ep.currency AND e.Code = ep.Code) 
	OR ep.ExchangeId IN (11,123)


UPDATE e
SET e.currency = ep.currency,
	e.code = ep.code, 
	e.stakerate = ep.stakerate, 
	e.actualrate = ep.actualrate, 
	e.commaxpayout = ep.commaxpayout, 
	e.creator = ep.creator,
	e.minbet = ep.minbet,
	e.minbetlive = ep.minbetlive, 
	e.AUDRate = ep.AUDRate, 
	e.ZARRate = ep.ZARRate, 
	e.GBPRate = ep.GBPRate, 
	e.EURORate = ep.EURORate,
	e.US$Rate = ep.[US$Rate], 
	e.Description = ep.Description, 
	e.MultipliedBy = ep.MultipliedBy, 
	e.ExVirtualRate = ep.ExVirtualRate,
	e.IsActive = ep.IsActive, 
	e.OfferSite = ep.OfferSite, 
	e.CurrencyType = ep.CurrencyType,
	e.CreditGroupID = ep.CreditGroupID,
	e.LicenseeGroupID = ep.LicenseeGroupID
FROM Exchange e (ROWLOCK)
	INNER JOIN #TmpCurrency ep ON e.ExchangeId = ep.ExchangeId

INSERT INTO exchange ([currency], [stakerate], [actualrate], [commaxpayout], [creator], [minbet], [minbetlive], [AUDRate], [ZARRate], [GBPRate], [EURORate], [US$Rate], [Code], [Description], [MultipliedBy], [ExVirtualRate], [IsActive], [OfferSite], [ExchangeId], [CurrencyType], [CreditGroupID], [LicenseeGroupID])
SELECT [currency], [stakerate], [actualrate], [commaxpayout], [creator], [minbet], [minbetlive], [AUDRate], [ZARRate], [GBPRate], [EURORate], [US$Rate], [Code], [Description], [MultipliedBy], [ExVirtualRate], [IsActive], [OfferSite], [ExchangeId], [CurrencyType], [CreditGroupID], [LicenseeGroupID]
FROM #TmpCurrency
WHERE exchangeid = 123