/*
	Created: 20170915@Elodie
	Task: Insert data into relevant table when inserting new site/currency
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype INT, @Bettype INT, @site INT, @currency INT, @IsTest BIT

SELECT @site = 257, @currency = 74

----------------ProductStatusSiteCurrency-----------------(already run)
--SELECT @Sporttype = 213, @Bettype = 2501	
--INSERT INTO ProductStatusSiteCurrency (SportType, BetType, SiteID, Currency, IsHidden, IsDisabled, HasSynced)
--SELECT @Sporttype, @Bettype, @site, @currency, 0, 1, 0 UNION ALL
--SELECT @Sporttype, @Bettype, @site, 20, 0, 1, 0

--------------ProductLaunchedSiteCurrency-----------------
SELECT @IsTest = 1

SELECT @Sporttype = 44
INSERT INTO ProductLaunchedSiteCurrency (SportType, SiteID, Currency, IsLaunched, IsTest)
SELECT @Sporttype, @site, 0, 1, @IsTest

SELECT @Sporttype = 180
INSERT INTO ProductLaunchedSiteCurrency (SportType, SiteID, Currency, IsLaunched, IsTest)
SELECT @Sporttype, @site, 0, 1, @IsTest

SELECT @Sporttype = 211
INSERT INTO ProductLaunchedSiteCurrency (SportType, SiteID, Currency, IsLaunched, IsTest)
SELECT @Sporttype, @site, 0, 1, @IsTest

SELECT @Sporttype = 219
INSERT INTO ProductLaunchedSiteCurrency (SportType, SiteID, Currency, IsLaunched, IsTest)
SELECT @Sporttype, @site, 0, 1, @IsTest

SELECT @Sporttype = 220
INSERT INTO ProductLaunchedSiteCurrency (SportType, SiteID, Currency, IsLaunched, IsTest)
SELECT @Sporttype, @site, 20, 0, @IsTest

--------------ProductBetSetting-----------------
INSERT INTO dbo.ProductBetSetting (Sporttype, Bettype, Currency, MinBet, IsDep, MaxBet, MaxPerMatch, DefaultMinBet, DefaultMaxBet, DefaultMaxPerMatch)
SELECT 180, 1201, @currency, 0, 0, 0, 0, NULL, NULL, NULL UNION ALL 
SELECT 181, 1231, @currency, 0, 0, 0, 0, NULL, NULL, NULL UNION ALL 
SELECT 182, 1231, @currency, 0, 0, 0, 0, NULL, NULL, NULL UNION ALL 
SELECT 183, 1231, @currency, 0, 0, 0, 0, NULL, NULL, NULL UNION ALL 
SELECT 184, 1231, @currency, 0, 0, 0, 0, NULL, NULL, NULL UNION ALL 
SELECT 185, 1231, @currency, 0, 0, 0, 0, NULL, NULL, NULL UNION ALL 
SELECT 186, 1220, @currency, 0, 0, 0, 0, NULL, NULL, NULL UNION ALL 
SELECT 190, 2701, @currency, 0, 0, 0, 0, NULL, NULL, NULL UNION ALL 
SELECT 191, 2701, @currency, 0, 0, 0, 0, NULL, NULL, NULL UNION ALL 
SELECT 199, 2799, @currency, 0, 0, 0, 0, NULL, NULL, NULL 

----------------StakeLevel-----------------(already run)
--INSERT INTO dbo.StakeLevel (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ExchangeId, ResourceId, GameGroupID)
--SELECT 1701, '10', '10000', 10, 10000, 74, NULL, 0 UNION ALL 
--SELECT 1702, '10', '10000', 10, 10000, 74, NULL, 0  

UPDATE dbo.StakeLevel WITH (ROWLOCK,UPDLOCK)
SET GameGroupID = 1
WHERE StakeLevelID = 782   

UPDATE dbo.StakeLevel WITH (ROWLOCK,UPDLOCK)
SET GameGroupID = 2
WHERE StakeLevelID = 783

----------------StakeLevelGroupDetail-----------------
INSERT INTO dbo.StakeLevelGroupDetail (StakeLevelID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ParentTypeID)
SELECT 782, 4001,'0.01','25',0.01,25,NULL UNION ALL 
SELECT 782, 4002,'0.25','25',0.25,25,NULL UNION ALL 
SELECT 782, 4003,'0.2','20',0.2,20,NULL UNION ALL 
SELECT 782, 4004,'1','200',1,200,NULL UNION ALL 
SELECT 782, 4005,'0.25','25',0.25,25,NULL UNION ALL 
SELECT 782, 4006,'0.01','9',0.01,9,NULL UNION ALL 
SELECT 782, 4007,'0.01','9',0.01,9,NULL UNION ALL 
SELECT 782, 4008,'0.1','10',0.1,10,NULL UNION ALL 
SELECT 782, 4009,'0.5','50',0.5,50,NULL UNION ALL 
SELECT 782, 4010,'0.25','25',0.25,25,NULL UNION ALL 
SELECT 782, 4011,'0.25','25',0.25,25,NULL UNION ALL 
SELECT 782, 4012,'0.5','50',0.5,50,NULL UNION ALL 
SELECT 782, 4013,'0.09','9',0.09,9,NULL UNION ALL 
SELECT 782, 4014,'0.25','25',0.25,25,NULL UNION ALL 
SELECT 782, 4015,'0.1','10',0.1,10,NULL UNION ALL 
SELECT 782, 4016,'0.01','20',0.01,20,NULL UNION ALL 
SELECT 782, 4017,'0.01','9',0.01,9,NULL UNION ALL 
SELECT 782, 4018,'0.25','25',0.25,25,NULL UNION ALL 
SELECT 782, 4019,'0.2','20',0.2,20,NULL UNION ALL 
SELECT 782, 4020,'0.1','10',0.1,10,NULL UNION ALL 
SELECT 782, 4021,'0.2','20',0.2,20,NULL UNION ALL 
SELECT 782, 4022,'1','500',1,500,NULL UNION ALL 
SELECT 782, 4023,'0.25','25',0.25,25,NULL UNION ALL 
SELECT 782, 4024,'0.1','10',0.1,10,NULL UNION ALL 
SELECT 782, 4025,'0.2','20',0.2,20,NULL UNION ALL 
SELECT 782, 4026,'0.2','20',0.2,20,NULL UNION ALL 
SELECT 782, 4027,'0','0',0,0,NULL UNION ALL 
SELECT 782, 4028,'0.1','10',0.1,10,NULL UNION ALL 
SELECT 782, 4029,'0.5','50',0.5,50,NULL UNION ALL 
SELECT 782, 4030,'0.15','15',0.15,15,NULL UNION ALL 
SELECT 783, 4001,'0.01','50',0.01,50,NULL UNION ALL 
SELECT 783, 4002,'0.25','50',0.25,50,NULL UNION ALL 
SELECT 783, 4003,'0.2','40',0.2,40,NULL UNION ALL 
SELECT 783, 4004,'1','400',1,400,NULL UNION ALL 
SELECT 783, 4005,'0.25','50',0.25,50,NULL UNION ALL 
SELECT 783, 4006,'0.01','18',0.01,18,NULL UNION ALL 
SELECT 783, 4007,'0.01','18',0.01,18,NULL UNION ALL 
SELECT 783, 4008,'0.1','20',0.1,20,NULL UNION ALL 
SELECT 783, 4009,'0.5','100',0.5,100,NULL UNION ALL 
SELECT 783, 4010,'0.25','50',0.25,50,NULL UNION ALL 
SELECT 783, 4011,'0.25','50',0.25,50,NULL UNION ALL 
SELECT 783, 4012,'0.5','100',0.5,100,NULL UNION ALL 
SELECT 783, 4013,'0.09','18',0.09,18,NULL UNION ALL 
SELECT 783, 4014,'0.25','50',0.25,50,NULL UNION ALL 
SELECT 783, 4015,'0.1','20',0.1,20,NULL UNION ALL 
SELECT 783, 4016,'0.01','40',0.01,40,NULL UNION ALL 
SELECT 783, 4017,'0.01','18',0.01,18,NULL UNION ALL 
SELECT 783, 4018,'0.25','50',0.25,50,NULL UNION ALL 
SELECT 783, 4019,'0.2','40',0.2,40,NULL UNION ALL 
SELECT 783, 4020,'0.1','20',0.1,20,NULL UNION ALL 
SELECT 783, 4021,'0.2','40',0.2,40,NULL UNION ALL 
SELECT 783, 4022,'1','1000',1,1000,NULL UNION ALL 
SELECT 783, 4023,'0.25','50',0.25,50,NULL UNION ALL 
SELECT 783, 4024,'0.1','20',0.1,20,NULL UNION ALL 
SELECT 783, 4025,'0.2','40',0.2,40,NULL UNION ALL 
SELECT 783, 4026,'0.2','40',0.2,40,NULL UNION ALL 
SELECT 783, 4027,'0','0',0,0,NULL UNION ALL 
SELECT 783, 4028,'0.1','20',0.1,20,NULL UNION ALL 
SELECT 783, 4029,'0.5','100',0.5,100,NULL UNION ALL 
SELECT 783, 4030,'0.15','30',0.15,30,NULL 

----------------LossLimit_GlobalSetting-----------------(already run)
--INSERT INTO dbo.LossLimit_GlobalSetting	(ProductId, ExchangeId, MinLossLimit, DefaultLossLimit)
--SELECT 6,@currency,150,30000 UNION ALL 
--SELECT 21,@currency,100,122400 UNION ALL 
--SELECT 22,@currency,150,30000 UNION ALL 
--SELECT 24,@currency,100,22300 UNION ALL 
--SELECT 28,@currency,100,22300 

--------------PlayCurrencySetting-----------------
INSERT INTO dbo.PlayCurrencySetting(SiteId, SiteName, SportType, MemberCurrency, PlayCurrency, FromDate, ToDate)
SELECT @site,'Y987',211,74,5,GETDATE(),'2050-01-01'

--------------WinLimit_ProductSettingDetail-----------------
INSERT INTO dbo.WinLimit_ProductSettingDetail(ProductID, GroupID, ExchangeID, SiteID, LevelID, MaxWinLimit, IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM)
SELECT 3, 1, @currency, @site, 1, 25885.95, 0, 0, 100000 UNION ALL 
SELECT 3, 1, @currency, @site, 2, 77657.84, 0, 0, 300000 UNION ALL 
SELECT 3, 1, @currency, @site, 3, 129429.73, 0, 0, 500000 UNION ALL 
SELECT 5, 2, @currency, @site, 1, 25885.95, 0, 0, 100000 UNION ALL 
SELECT 5, 2, @currency, @site, 2, 77657.84, 0, 0, 300000 UNION ALL 
SELECT 5, 2, @currency, @site, 3, 129429.73, 0, 0, 500000 UNION ALL 
SELECT 6, 3, @currency, @site, 1, 2588.59, 0, 0, 10000 UNION ALL 
SELECT 6, 3, @currency, @site, 2, 7765.78, 0, 0, 30000 UNION ALL 
SELECT 6, 3, @currency, @site, 3, 25885.95, 0, 0, 100000 UNION ALL 
SELECT 8, 4, @currency, @site, 1, 25885.95, 0, 0, 100000 UNION ALL 
SELECT 8, 4, @currency, @site, 2, 77657.84, 0, 0, 300000 UNION ALL 
SELECT 8, 4, @currency, @site, 3, 129429.73, 0, 0, 500000 UNION ALL 
SELECT 12, 5, @currency, @site, 1, 25885.95, 0, 0, 100000 UNION ALL 
SELECT 12, 5, @currency, @site, 2, 77657.84, 0, 0, 300000 UNION ALL 
SELECT 12, 5, @currency, @site, 3, 129429.73, 0, 0, 500000 UNION ALL 
SELECT 21, 8, @currency, @site, 1, 51771.89, 0, 0, 200000 UNION ALL 
SELECT 21, 8, @currency, @site, 2, 129429.73, 0, 0, 500000 UNION ALL 
SELECT 21, 8, @currency, @site, 3, 207087.57, 0, 0, 800000 UNION ALL 
SELECT 21, 9, @currency, @site, 1, 25885.95, 0, 0, 100000 UNION ALL 
SELECT 21, 9, @currency, @site, 2, 77657.84, 0, 0, 300000 UNION ALL 
SELECT 21, 9, @currency, @site, 3, 129429.73, 0, 0, 500000 UNION ALL 
SELECT 22, 10, @currency, @site, 1, 2588.59, 0, 0, 10000 UNION ALL 
SELECT 22, 10, @currency, @site, 2, 7765.78, 0, 0, 30000 UNION ALL 
SELECT 22, 10, @currency, @site, 3, 25885.95, 0, 0, 100000 UNION ALL 
SELECT 24, 11, @currency, @site, 1, 2588.59, 0, 0, 10000 UNION ALL 
SELECT 24, 11, @currency, @site, 2, 7765.78, 0, 0, 30000 UNION ALL 
SELECT 24, 11, @currency, @site, 3, 25885.95, 0, 0, 100000 UNION ALL 
SELECT 27, 12, @currency, @site, 1, 25885.95, 0, 0, 100000 UNION ALL 
SELECT 27, 12, @currency, @site, 2, 77657.84, 0, 0, 300000 UNION ALL 
SELECT 27, 12, @currency, @site, 3, 129429.73, 0, 0, 500000 UNION ALL 
SELECT 28, 13, @currency, @site, 1, 25885.95, 0, 0, 100000 UNION ALL 
SELECT 28, 13, @currency, @site, 2, 77657.84, 0, 0, 300000 UNION ALL 
SELECT 28, 13, @currency, @site, 3, 129429.73, 0, 0, 500000

UPDATE PSD
SET MaxWinLimit = CASE WHEN psd.ExchangeID = 20 THEN MaxWinLimit_RM ELSE ROUND(MaxWinLimit_RM / e.actualrate,2) END
FROM WinLimit_ProductSettingDetail PSD WITH(ROWLOCK, UPDLOCK)          
	INNER JOIN Exchange e WITH (NOLOCK)  ON e.ExchangeId = psd.ExchangeID
WHERE PSD.MaxWinLimit_RM IS NOT NULL 
		AND PSD.ExchangeID = @Currency
		AND PSD.SiteID = @Site


