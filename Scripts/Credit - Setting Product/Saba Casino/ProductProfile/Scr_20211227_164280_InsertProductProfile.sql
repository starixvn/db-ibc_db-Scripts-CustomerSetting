/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211227@Eden
	Task: Insert product profile for Saba Casino [#164280]
	DB: DBCUST/CustDB
*/

USE CustDB
GO

DECLARE @SettingStatus TINYINT, @ProductID INT, @MaxPT TINYINT, @MaxDiscount DECIMAL(9,8), @IsSync BIT, @IsHidden BIT, @IsDisabled BIT, @BitmapOrder TINYINT, @IntervalValue DECIMAL(19,8)
SELECT @SettingStatus = 1 --0: Production, 1: UAT, 2: Hide
SELECT @ProductID = 6
SELECT @IsSync = 1
SELECT @IsHidden = 0
SELECT @IsDisabled = 0
SELECT @BitmapOrder = 37
SELECT @MaxPT = 90

--PT Setting
INSERT INTO	dbo.ProductSettingDetail
		(	SettingType, SportType	, BetType	, IsLive, ProductID		, MaxPT	, MaxDiscount	, IsSync	, IsHidden	, IsDisabled	, SettingLevel, DisplayOrder, SettingStatus, IntervalValue	, RealProductId)
VALUES	
--PT	
		(	18         , 208		, 2101		, 0     , @ProductID	, @MaxPT, NULL			, NULL		, NULL		, NULL			, 1           , 2           , @SettingStatus, NULL			, @ProductID)
--Status Setting																																													
	,	(	13         , 208		, 2101		, 0     , @ProductID	, NULL	, NULL			, @IsSync	, @IsHidden	, @IsDisabled	, 1           , 1           , @SettingStatus, NULL			, @ProductID)
--BetSetting																																														
	,	(	8          , 208		, 2101		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 1           , 4           , @SettingStatus, NULL			, @ProductID)
--WinLossLimit Setting																																											
	,	(	6		   , 208		, 2101		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 1           , 3           , @SettingStatus, NULL			, @ProductID)

INSERT INTO	dbo.ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
VALUES	(208, 2101, @BitmapOrder)

--INSERT INTO [dbo].[ProductStatusSiteCurrency]
--           ([SportType]
--           ,[BetType]
--           ,[Currency]
--           ,[SiteID]
--           ,[IsHidden]
--           ,[IsDisabled]
--		   ,[HasSynced])
--SELECT 208,2101, 0 AS exchangeid, s.siteid, 0 AS IsHidden, 0 AS IsDisabled, 1 AS HasSynced
--FROM dbo.Site s WITH(NOLOCK)
--WHERE s.isActive = 1 AND s.isLicensee = 0
--	AND s.site IN ('789y')

--INSERT INTO dbo.LossLimit_GlobalSetting (ProductId, ExchangeId, MinLossLimit, DefaultLossLimit)
--SELECT @ProductID, lg.ExchangeId, MinLossLimit, DefaultLossLimit
--FROM LossLimit_GlobalSetting lg WITH (NOLOCK)
--	INNER JOIN dbo.exchange e ON e.exchangeid = lg.ExchangeId
--WHERE ProductId = 22 AND (e.Code = 'USD' OR e.exchangeid = 20)

--SELECT * FROM ProductSettingDetail(NOLOCK) WHERE ProductID = 6
--SELECT * FROM ProductStatusProfile(NOLOCK) 
--SELECT * FROM dbo.ProductStatusSiteCurrency(NOLOCK) WHERE SportType = 208
--SELECT * FROM LossLimit_GlobalSetting(NOLOCK) WHERE ProductId = 6

--DELETE FROM ProductSettingDetail(NOLOCK) WHERE ProductID = 6
--DELETE FROM ProductStatusProfile(NOLOCK) WHERE Sporttype = 208
--DELETE FROM LossLimit_GlobalSetting(NOLOCK) WHERE ProductId = 6



