/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210806
	Task:  Insert new Product profile for Bitcoin RedmineID:#159039
	DB: DBCust/CustDB
*/
USE CustDB
GO
 /*
DECLARE @Sporttype INT = 175
DELETE FROM ProductSettingDetail WITH(ROWLOCK) WHERE Sporttype = @Sporttype
DELETE FROM ProductStatusProfile WITH(ROWLOCK) WHERE Sporttype = @Sporttype 
DELETE FROM ProductStatusSiteCurrency WITH(ROWLOCK) WHERE Sporttype = @Sporttype
GO
*/
DECLARE @productID SMALLINT ,@betType SMALLINT,
		@sportType SMALLINT,@RealProductID SMALLINT,@SettingStatus TINYINT,
		@MaxDiscount DECIMAL(9,8), @IsSync BIT, @IsHidden BIT,@MaxPT TINYINT,		
		@IsDisabled BIT, @BitmapOrder TINYINT, @IntervalValue DECIMAL(19,8)
		
SELECT @SettingStatus = 1 --0: Production, 1: UAT, 2: Hide	
	 , @productID = 69 -- Bitcoin Betting
	 , @sportType = 175
	 , @betType = 7901 
	 , @RealProductID = 69 
	 , @IsSync = 1
	 , @IsHidden = 0
	 , @IsDisabled = 0
	 , @BitmapOrder = 35
	 , @MaxPT = 90
	 , @MaxDiscount = 0.01
	 , @IntervalValue = 0.0005 
	 
IF NOT EXISTS(	SELECT TOP 1 1 
				FROM dbo.ProductSettingDetail psd WITH(NOLOCK)
				WHERE 	psd.ProductID = @productID 
					AND SportType  = @sportType 
					AND BetType = @betType			
			)
	BEGIN
		INSERT INTO [ProductSettingDetail]
           ([SettingType]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[ProductID]
           ,[MaxPT]
           ,[MaxDiscount]
           ,[IsSync] 
           ,[IsHidden]
           ,[IsDisabled]
           ,[SettingLevel]
           ,[DisplayOrder]
           ,[SettingStatus]
           ,[IntervalValue]
           ,[RealProductId]
           ,[MaxChoice])
		VALUES	
		--PT	
				(	1         , @Sporttype		, @Bettype		, 0     , @ProductID	, @MaxPT, NULL			, NULL		, NULL		, NULL			, 2           , 4           , @SettingStatus, NULL, @RealProductId, NULL)
		--Comm	
			,	(	3         , @Sporttype		, @Bettype		, 0     , @ProductID	, NULL, @MaxDiscount	, NULL		, NULL		, NULL			, 2           , 2           , @SettingStatus, @IntervalValue, @RealProductId, NULL)
		--Status Setting																																				
			,	(	13         , @Sporttype		, @Bettype		, 0     , @ProductID	, NULL	, NULL			, @IsSync	, @IsHidden	, @IsDisabled	, 2           , 1           , @SettingStatus, NULL, @RealProductId, NULL)
		--BetSetting																																				
			,	(	16         , @Sporttype		, @Bettype		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 2           , 3           , @SettingStatus, NULL, @RealProductId , NULL)
		--WinLossLimit Setting																																				
			,	(	6		   , @Sporttype		, @Bettype		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 2           , 5           , @SettingStatus, NULL, @RealProductId, NULL)

	END		

DELETE P
FROM ProductStatusProfile P WITH (ROWLOCK)
WHERE P.Sporttype = @Sporttype

INSERT INTO	dbo.ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
VALUES	(@Sporttype, @Bettype, @BitmapOrder)

DELETE P
FROM ProductSettingSystemDisplay P WITH (ROWLOCK)
WHERE P.ProductID = @ProductID

INSERT INTO dbo.ProductSettingSystemDisplay
        ( SystemID ,
          ProductID ,
          SettingType ,
          DisplayMode
        )
SELECT 5,@ProductID,13,3
UNION ALL 
SELECT 5,@ProductID,1,3
UNION ALL 
SELECT 5,@ProductID,3,3
UNION ALL 
SELECT 5,@ProductID,6,3
UNION ALL
SELECT 9,@ProductID,13,3
UNION ALL 
SELECT 9,@ProductID,1,3
UNION ALL 
SELECT 9,@ProductID,3,3
UNION ALL 
SELECT 9,@ProductID,6,3
UNION ALL
SELECT 6,@ProductID,13,3
UNION ALL
SELECT 7,@ProductID,13,3
UNION ALL
SELECT 8,@ProductID,13,3

--============================Bet Setting
DELETE P
FROM ProductBetSetting P WITH (ROWLOCK)
WHERE P.Sporttype = @Sporttype AND p.Bettype = @betType

CREATE TABLE #ProductBetSetting (Currency INT,MinBet	money,MaxBet	money,MaxPerMatch	money,
								DefaultMinBet	money,DefaultMaxBet	money,DefaultMaxPerMatch	money)
				
INSERT INTO #ProductBetSetting(Currency,MinBet,MaxBet,MaxPerMatch,DefaultMinBet,DefaultMaxBet,DefaultMaxPerMatch)
SELECT 2 AS Currency ,10 AS MinBet,5000 AS MaxBet,30000 AS MaxPerMatch,10 AS DefaultMinBet,5000 AS DefaultMaxBet,30000  AS DefaultMaxPerMatch UNION  ALL --RM---MYR
SELECT 3 AS Currency ,3 AS MinBet,1500 AS MaxBet,9000 AS MaxPerMatch,3 AS DefaultMinBet,1500 AS DefaultMaxBet,9000  AS DefaultMaxPerMatch UNION  ALL --US$---USD
SELECT 5 AS Currency ,15 AS MinBet,10000 AS MaxBet,60000 AS MaxPerMatch,15 AS DefaultMinBet,10000 AS DefaultMaxBet,60000  AS DefaultMaxPerMatch UNION  ALL --HK$---HKD
SELECT 6 AS Currency ,2 AS MinBet,1000 AS MaxBet,6000 AS MaxPerMatch,2 AS DefaultMinBet,1000 AS DefaultMaxBet,6000  AS DefaultMaxPerMatch UNION  ALL --EURO---EUR
SELECT 7 AS Currency ,50000 AS MinBet,25000000 AS MaxBet,150000000 AS MaxPerMatch,50000 AS DefaultMinBet,25000000 AS DefaultMaxBet,150000000  AS DefaultMaxPerMatch UNION  ALL --DON---VND
SELECT 9 AS Currency ,3 AS MinBet,1500 AS MaxBet,9000 AS MaxPerMatch,3 AS DefaultMinBet,1500 AS DefaultMaxBet,9000  AS DefaultMaxPerMatch UNION  ALL --AUD---AUD
SELECT 12 AS Currency ,2 AS MinBet,1000 AS MaxBet,6000 AS MaxPerMatch,2 AS DefaultMinBet,1000 AS DefaultMaxBet,6000  AS DefaultMaxPerMatch UNION  ALL --GBP---GBP
SELECT 13 AS Currency ,15 AS MinBet,10000 AS MaxBet,60000 AS MaxPerMatch,15 AS DefaultMinBet,10000 AS DefaultMaxBet,60000  AS DefaultMaxPerMatch UNION  ALL --RMB---CNY
SELECT 15 AS Currency ,35 AS MinBet,20000 AS MaxBet,120000 AS MaxPerMatch,35 AS DefaultMinBet,20000 AS DefaultMaxBet,120000  AS DefaultMaxPerMatch UNION  ALL --IN---IDR
SELECT 16 AS Currency ,3 AS MinBet,1500 AS MaxBet,9000 AS MaxPerMatch,3 AS DefaultMinBet,1500 AS DefaultMaxBet,9000  AS DefaultMaxPerMatch UNION  ALL --Yen---USD
SELECT 22 AS Currency ,35 AS MinBet,20000 AS MaxBet,120000 AS MaxPerMatch,35 AS DefaultMinBet,20000 AS DefaultMaxBet,120000  AS DefaultMaxPerMatch UNION  ALL --IND---IDR
SELECT 33 AS Currency ,35 AS MinBet,20000 AS MaxBet,120000 AS MaxPerMatch,35 AS DefaultMinBet,20000 AS DefaultMaxBet,120000  AS DefaultMaxPerMatch UNION  ALL --IDD---IDR
SELECT 34 AS Currency ,35 AS MinBet,20000 AS MaxBet,120000 AS MaxPerMatch,35 AS DefaultMinBet,20000 AS DefaultMaxBet,120000  AS DefaultMaxPerMatch UNION  ALL --IDR---IDR
SELECT 35 AS Currency ,3 AS MinBet,1500 AS MaxBet,9000 AS MaxPerMatch,3 AS DefaultMinBet,1500 AS DefaultMaxBet,9000  AS DefaultMaxPerMatch UNION  ALL --$US---USD
SELECT 41 AS Currency ,2 AS MinBet,1000 AS MaxBet,6000 AS MaxPerMatch,2 AS DefaultMinBet,1000 AS DefaultMaxBet,6000  AS DefaultMaxPerMatch UNION  ALL --CHF---CHF
SELECT 42 AS Currency ,120 AS MinBet,60000 AS MaxBet,360000 AS MaxPerMatch,120 AS DefaultMinBet,60000 AS DefaultMaxBet,360000  AS DefaultMaxPerMatch UNION  ALL --PE---PHP
SELECT 43 AS Currency ,100 AS MinBet,40000 AS MaxBet,240000 AS MaxPerMatch,100 AS DefaultMinBet,40000 AS DefaultMaxBet,240000  AS DefaultMaxPerMatch UNION  ALL --THB---THB
SELECT 45 AS Currency ,2500 AS MinBet,1500000 AS MaxBet,9000000 AS MaxPerMatch,2500 AS DefaultMinBet,1500000 AS DefaultMaxBet,9000000  AS DefaultMaxPerMatch UNION  ALL --Won---KRW
SELECT 47 AS Currency ,35 AS MinBet,20000 AS MaxBet,120000 AS MaxPerMatch,35 AS DefaultMinBet,20000 AS DefaultMaxBet,120000  AS DefaultMaxPerMatch UNION  ALL --DDD---IDR
SELECT 50 AS Currency ,3 AS MinBet,1500 AS MaxBet,9000 AS MaxPerMatch,3 AS DefaultMinBet,1500 AS DefaultMaxBet,9000  AS DefaultMaxPerMatch UNION  ALL --CAN---CAD
SELECT 51 AS Currency ,50 AS MinBet,25000 AS MaxBet,150000 AS MaxPerMatch,50 AS DefaultMinBet,25000 AS DefaultMaxBet,150000  AS DefaultMaxPerMatch UNION  ALL --INH---VND
SELECT 52 AS Currency ,15 AS MinBet,10000 AS MaxBet,60000 AS MaxPerMatch,15 AS DefaultMinBet,10000 AS DefaultMaxBet,60000  AS DefaultMaxPerMatch UNION  ALL --DKK---DKK
SELECT 53 AS Currency ,15 AS MinBet,10000 AS MaxBet,60000 AS MaxPerMatch,15 AS DefaultMinBet,10000 AS DefaultMaxBet,60000  AS DefaultMaxPerMatch UNION  ALL --SEK---SEK
SELECT 54 AS Currency ,15 AS MinBet,10000 AS MaxBet,60000 AS MaxPerMatch,15 AS DefaultMinBet,10000 AS DefaultMaxBet,60000  AS DefaultMaxPerMatch UNION  ALL --NOK---NOK
SELECT 57 AS Currency ,50 AS MinBet,25000 AS MaxBet,150000 AS MaxPerMatch,50 AS DefaultMinBet,25000 AS DefaultMaxBet,150000  AS DefaultMaxPerMatch UNION  ALL --CZK---CZK
SELECT 58 AS Currency ,10 AS MinBet,5000 AS MaxBet,30000 AS MaxPerMatch,10 AS DefaultMinBet,5000 AS DefaultMaxBet,30000  AS DefaultMaxPerMatch UNION  ALL --RON---RON
SELECT 64 AS Currency ,3 AS MinBet,1500 AS MaxBet,9000 AS MaxPerMatch,3 AS DefaultMinBet,1500 AS DefaultMaxBet,9000  AS DefaultMaxPerMatch UNION  ALL --UT---USD
SELECT 67 AS Currency ,10 AS MinBet,5000 AS MaxBet,30000 AS MaxPerMatch,10 AS DefaultMinBet,5000 AS DefaultMaxBet,30000  AS DefaultMaxPerMatch UNION  ALL --HKK---HKD
SELECT 69 AS Currency ,4 AS MinBet,1800 AS MaxBet,10800 AS MaxPerMatch,4 AS DefaultMinBet,1800 AS DefaultMaxBet,10800  AS DefaultMaxPerMatch UNION  ALL --MMK---MMK
SELECT 71 AS Currency ,10 AS MinBet,5000 AS MaxBet,30000 AS MaxPerMatch,10 AS DefaultMinBet,5000 AS DefaultMaxBet,30000  AS DefaultMaxPerMatch UNION  ALL --KHR---KHR
SELECT 81 AS Currency ,15 AS MinBet,10000 AS MaxBet,60000 AS MaxPerMatch,15 AS DefaultMinBet,10000 AS DefaultMaxBet,60000  AS DefaultMaxPerMatch UNION  ALL --CY---CNY
SELECT 95 AS Currency ,3 AS MinBet,1500 AS MaxBet,9000 AS MaxPerMatch,3 AS DefaultMinBet,1500 AS DefaultMaxBet,9000  AS DefaultMaxPerMatch UNION  ALL --USD---USD
SELECT 20 AS Currency ,3 AS MinBet,1500 AS MaxBet,9000 AS MaxPerMatch,3 AS DefaultMinBet,1500 AS DefaultMaxBet,9000  AS DefaultMaxPerMatch UNION  ALL --UUS---UUS
SELECT 72 AS Currency ,50 AS MinBet,25000 AS MaxBet,150000 AS MaxPerMatch,50 AS DefaultMinBet,25000 AS DefaultMaxBet,150000  AS DefaultMaxPerMatch	 --YNG---YNG


INSERT INTO dbo.ProductBetSetting
        ( Sporttype ,
          Bettype ,
          Currency ,
          MinBet ,
          IsDep ,
          MaxBet ,
          MaxPerMatch ,
          DefaultMinBet ,
          DefaultMaxBet ,
          DefaultMaxPerMatch
        )
SELECT @sportType ,
	   @betType ,
	   Currency ,
	   MinBet ,
	   0 AS IsDep ,
	   MaxBet ,
	   MaxPerMatch ,
	   DefaultMinBet ,
	   DefaultMaxBet ,
	   DefaultMaxPerMatch
FROM #ProductBetSetting 

DROP Table #ProductBetSetting

DELETE P
FROM LossLimit_GlobalSetting P WITH (ROWLOCK)
WHERE P.ProductId = @ProductID

INSERT INTO dbo.LossLimit_GlobalSetting (ProductId, ExchangeId, MinLossLimit, DefaultLossLimit)
SELECT @ProductID, lg.ExchangeId, MinLossLimit, DefaultLossLimit
FROM LossLimit_GlobalSetting lg WITH (NOLOCK)
	INNER JOIN dbo.exchange e ON e.exchangeid = lg.ExchangeId
WHERE ProductId = 44 AND e.exchangeid IN ( 20 ,72)




/*
DELETE FROM ProductStatusSiteCurrency WHERE SportType=@Sporttype and Bettype = @betType

INSERT INTO ProductStatusSiteCurrency (SportType, BetType, SiteID, Currency, IsHidden, IsDisabled, HasSynced)
SELECT @Sporttype, @Bettype, SiteID, Currency, IsHidden, IsDisabled, HasSynced  
FROM ProductStatusSiteCurrency WITH (NOLOCK)
WHERE Sporttype = 220 AND Bettype = 1024
*/