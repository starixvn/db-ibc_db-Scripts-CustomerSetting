/*
	Created: 20200318@Elodie
	Task: Insert product profile for Saba.club
	DB: DBCUST/CustDB
*/

USE CustDB
GO

DECLARE @SettingStatus TINYINT, @ProductID INT, @MaxPT TINYINT, @MaxDiscount DECIMAL(9,8), @IsSync BIT, @IsHidden BIT, @IsDisabled BIT, @BitmapOrder TINYINT, @IntervalValue DECIMAL(19,8)
SELECT @SettingStatus = 1 --0: Production, 1: UAT, 2: Hide
SELECT @ProductID = 42
SELECT @IsSync = 1
SELECT @IsHidden = 1
SELECT @IsDisabled = 1
SELECT @BitmapOrder = 21
SELECT @MaxPT = 90
--SELECT @MaxDiscount = 0.0025
--SELECT @IntervalValue = 0.0005

--PT Setting
INSERT INTO	dbo.ProductSettingDetail
		(	SettingType, SportType	, BetType	, IsLive, ProductID		, MaxPT	, MaxDiscount	, IsSync	, IsHidden	, IsDisabled	, SettingLevel, DisplayOrder, SettingStatus, IntervalValue)
VALUES	
--PT	
		(	1          , 200		, 1611		, 0     , @ProductID	, @MaxPT, NULL			, NULL		, NULL		, NULL			, 1           , 2           , @SettingStatus, NULL)
--Status Setting																																				
	,	(	13         , 200		, 1611		, 0     , @ProductID	, NULL	, NULL			, @IsSync	, @IsHidden	, @IsDisabled	, 1           , 1           , @SettingStatus, NULL)
--BetSetting																																				
	,	(	8          , 200		, 1611		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 2           , 4           , @SettingStatus, NULL)
--WinLossLimit Setting																																				
	,	(	6		   , 200		, 1611		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 1           , 3           , @SettingStatus, NULL)

INSERT INTO	dbo.ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
VALUES	(200, 1611, @BitmapOrder)

INSERT INTO dbo.ProductSettingSystemDisplay
        ( SystemID ,
          ProductID ,
          SettingType ,
          DisplayMode
        )
SELECT 9,@ProductID,13,3
UNION ALL 
SELECT 9,@ProductID,1,3
UNION ALL 
SELECT 9,@ProductID,6,3
UNION ALL
SELECT 6,@ProductID,13,3
UNION ALL
SELECT 7,@ProductID,13,3
UNION ALL
SELECT 8,@ProductID,13,3

INSERT INTO [dbo].[ProductStatusSiteCurrency]
           ([SportType]
           ,[BetType]
           ,[Currency]
           ,[SiteID]
           ,[IsHidden]
           ,[IsDisabled]
		   ,[HasSynced])
SELECT 200,1611, 0 AS exchangeid, s.siteid, 0 AS IsHidden, 0 AS IsDisabled, 1 AS HasSynced
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site IN ('789y')

INSERT INTO dbo.LossLimit_GlobalSetting (ProductId, ExchangeId, MinLossLimit, DefaultLossLimit)
SELECT @ProductID, lg.ExchangeId, MinLossLimit, DefaultLossLimit
FROM LossLimit_GlobalSetting lg WITH (NOLOCK)
	INNER JOIN dbo.exchange e ON e.exchangeid = lg.ExchangeId
WHERE ProductId = 22 AND (e.Code = 'USD' OR e.currency = 20)

--SELECT * FROM ProductSettingDetail WHERE ProductID = 42
--SELECT * FROM ProductStatusProfile 
--SELECT * FROM dbo.SettingSystem
--SELECT *  FROM dbo.ProductSettingSystemDisplay WHERE ProductID = 42
--SELECT *  FROM dbo.ProductStatusSiteCurrency WHERE SportType = 200

--DELETE FROM ProductSettingDetail WHERE ProductID = 42
--DELETE FROM ProductStatusProfile WHERE Sporttype = 200
--DELETE FROM dbo.ProductSettingSystemDisplay WHERE ProductID = 42
--DELETE FROM ProductStatusSiteCurrency WHERE Sporttype = 200
--DELETE FROM LossLimit_GlobalSetting WHERE ProductId = 42



