/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20201116
	Task: Insert new Product [Leap Gaming Virtual Sports] RedmineID:#131370
	DB: DBCust/CustDB
*/

USE CustDB
GO

 /*
DECLARE @Sporttype INT = 231
DELETE FROM ProductSettingDetail WITH(ROWLOCK) WHERE Sporttype = @Sporttype
DELETE FROM ProductStatusProfile WITH(ROWLOCK) WHERE Sporttype = @Sporttype 
DELETE FROM ProductStatusSiteCurrency WITH(ROWLOCK) WHERE Sporttype = @Sporttype
GO
*/
DECLARE @productID SMALLINT ,@betType SMALLINT,
		@sportType SMALLINT,@RealProductID SMALLINT,@SettingStatus TINYINT
		,@IsSync BIT, @IsHidden BIT,@MaxPT TINYINT,@IsDisabled BIT
		,@IntervalValue DECIMAL(19,8)
		
SELECT @SettingStatus = 1 --0: Production, 1: UAT, 2: Hide	
	 , @productID = 5  -- Leap Gaming
	 , @sportType = 231
	 , @betType = 5301 
	 , @RealProductID = 5 -- 49 
	 , @IsSync = 1
	 , @IsHidden = 0
	 , @IsDisabled = 0
	 , @MaxPT = 90
	 --, @IntervalValue = 0.0005 
	 
IF NOT EXISTS(	SELECT TOP 1 1 
				FROM dbo.ProductSettingDetail psd WITH(NOLOCK)
				WHERE 	psd.ProductID = @productID 
					AND SportType  = @sportType 
					AND BetType = @betType			
			)
	BEGIN
		
		UPDATE ProductSettingDetail WITH (ROWLOCK, UPDLOCK) 
		SET DisplayOrder = CASE WHEN SettingType = 6 THEN 9
								WHEN SettingType = 2 THEN 3  
								WHEN SettingType = 1 THEN 7 END 
		WHERE ProductID = @productID AND SettingType in (1,6,2)
		
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
				(	1	         , @Sporttype		, @Bettype		, 0     , @ProductID	, @MaxPT, NULL			, NULL		, NULL		, NULL			, 2           , 7           , @SettingStatus, NULL, @RealProductId, NULL)
		--Comm	
			,	(	20	         , @Sporttype		, @Bettype		, 0     , @ProductID	, NULL, NUll	, NULL		, NULL		, NULL			, 4           , 5           , @SettingStatus, @IntervalValue, @RealProductId, NULL)

	END		


DELETE FROM ProductBetSetting WITH (ROWLOCK)  
WHERE Sporttype = @sportType AND Bettype = @betType

CREATE TABLE #TempBetLimit (currency NVARCHAR(50), MinBet MONEY,MaxBet MONEY)

INSERT INTO #TempBetLimit(currency,MinBet,MaxBet)
VALUES ('EURO',2,2500),
		('$US',2,2500),
		('CAN',2,2500),
		('DDD',18,18000),
		('GBP',1,2000),
		('HK$',10,20000),
		('HKK',5,10000),
		('IDD',18,18000),
		('IDR',18,18000),
		('IN',18,18000),
		('IND',18,18000),
		('MMK',2,3000),
		('RM',5,10000),
		('RMB',10,20000),
		('THB',50,50000),
		('US$',2,2500),
		('USD',2,2500),
		('UT',2,2500),
		('Won',2000,3000000),
		('Yen',2,2500)
INSERT INTO ProductBetSetting(Sporttype,Bettype,Currency,MinBet,IsDep,MaxBet,DefaultMinBet,DefaultMaxBet)
SELECT @sportType AS SportType,@betType AS BetType,b.ExchangeId AS Currency,a.MinBet,0 AS IsDep,a.MaxBet ,0 AS DefaultMinBet,0 AS DefaultMaxBet
FROM #TempBetLimit a
INNER JOIN exchange b WITH(NOLOCK) on a.currency = b.currency

DROP TABLE #TempBetLimit