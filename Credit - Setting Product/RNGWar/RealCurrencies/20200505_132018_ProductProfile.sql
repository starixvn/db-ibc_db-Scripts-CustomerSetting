/*
	Created: Tiara
	Date: 20200505
	Task: Insert Product Profile for RNG War  [Redmine: 132018]
	DB: DBCUST/CustDB
*/

USE CustDB
GO

DECLARE @SettingStatus TINYINT, @ProductID TINYINT, @RealProductID TINYINT, @MaxPT TINYINT, @IsSync BIT, @IsHidden BIT, @IsDisabled BIT, @BitmapOrder TINYINT
SELECT @SettingStatus = 1 --0: Production, 1: UAT, 2: Hide
SELECT @ProductID = 44
SELECT @RealProductID = 50
SELECT @IsSync = 1
SELECT @IsHidden = 0
SELECT @IsDisabled = 0
SELECT @BitmapOrder = 26
SELECT @MaxPT = 85


DELETE P
FROM ProductSettingDetail P WITH (ROWLOCK)
WHERE P.SportType = 224
--PT Setting
INSERT INTO	dbo.ProductSettingDetail
		(	SettingType, SportType	, BetType	, IsLive, ProductID		, MaxPT	, MaxDiscount	, IsSync	, IsHidden	, IsDisabled	, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId)
VALUES	
--PT	
		(	1          , 224		, 5500		, 0     , @ProductID	, @MaxPT, NULL			, NULL		, NULL		, NULL			, 4           , 3           , @SettingStatus, NULL, @RealProductId)
--Status Setting																																				
	,	(	13         , 224		, 5500		, 0     , @ProductID	, NULL	, NULL			, @IsSync	, @IsHidden	, @IsDisabled	, 2           , 1           , @SettingStatus, NULL, @RealProductId)
--BetSetting																																				
	,	(	2          , 224		, 5500		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 4           , 2           , @SettingStatus, NULL, @RealProductId)
--WinLossLimit Setting																																				
	,	(	6		   , 224		, 5500		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 2           , 4           , @SettingStatus, NULL, @RealProductId)

DELETE P
FROM ProductStatusProfile P WITH (ROWLOCK)
WHERE P.Sporttype = 224

INSERT INTO	dbo.ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
VALUES	(224, 5500, @BitmapOrder)


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
SELECT 224 ,
	   5500 ,
	   Currency ,
	   MinBet ,
	   IsDep ,
	   MaxBet ,
	   MaxPerMatch ,
	   DefaultMinBet ,
	   DefaultMaxBet ,
	   DefaultMaxPerMatch
FROM ProductBetSetting WITH (NOLOCK)
WHERE Sporttype = 220 AND Bettype = 1024





