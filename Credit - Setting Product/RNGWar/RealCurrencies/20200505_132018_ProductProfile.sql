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
SELECT @IsHidden = 1
SELECT @IsDisabled = 1
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

INSERT INTO [dbo].[ProductStatusSiteCurrency]
           ([SportType]
           ,[BetType]
           ,[Currency]
           ,[SiteID]
           ,[IsHidden]
           ,[IsDisabled]
		   ,[HasSynced])

SELECT 224,5500, 0 AS exchangeid, s.siteid, 0 AS IsHidden, 0 AS IsDisabled, 1 AS HasSynced
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site IN ('789y')

INSERT INTO dbo.LossLimit_GlobalSetting (ProductId, ExchangeId, MinLossLimit, DefaultLossLimit)
SELECT @ProductID, lg.ExchangeId, MinLossLimit, DefaultLossLimit
FROM LossLimit_GlobalSetting lg WITH (NOLOCK)
	INNER JOIN dbo.exchange e ON e.exchangeid = lg.ExchangeId
WHERE ProductId = 50 AND (e.Code = 'USD' OR e.exchangeid = 20)





