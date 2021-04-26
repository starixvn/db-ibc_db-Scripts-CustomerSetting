/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210426@Eden
	Task: Insert product profile for VGaming [#RM:153938]
	DB: DBCUST/CustDB
*/

USE CustDB
GO
DECLARE @SettingStatus TINYINT = 1, --0: Production, 1: UAT, 2: Hide
        @ProductID     INT = 66, 
        @MaxPT         TINYINT = 90, 
        @IsSync        BIT = 1, 
        @IsHidden      BIT = 1, 
        @IsDisabled    BIT = 1, 
        @BitmapOrder   TINYINT = 34, 
        @sporttype     SMALLINT  = 171, 
        @Bettype       INT       = 3801
		--@MaxDiscount   DECIMAL(9, 8) = 0.0025, 
		--@IntervalValue DECIMAL(19, 8) = 0.0005,

--Profile Setting
INSERT INTO	dbo.ProductSettingDetail(	SettingType, SportType	, BetType	, IsLive, ProductID		, MaxPT	, MaxDiscount	, IsSync	, IsHidden	, IsDisabled	, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId)
--PT	
SELECT		1		   , @sporttype		, @Bettype		, 0     , @ProductID	, @MaxPT, NULL			, NULL		, NULL		, NULL			, 1           , 2           , @SettingStatus, NULL, @ProductID UNION ALL
--Status Setting																																												  
SELECT		13         , @sporttype		, @Bettype		, 0     , @ProductID	, NULL	, NULL			, @IsSync	, @IsHidden	, @IsDisabled	, 1           , 1           , @SettingStatus, NULL, @ProductID UNION ALL
--BetSetting																																													  
SELECT		8          , @sporttype		, @Bettype		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 2           , 4           , @SettingStatus, NULL, @ProductID UNION ALL
--WinLossLimit Setting																																											  
SELECT		6		   , @sporttype		, @Bettype		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 1           , 3           , @SettingStatus, NULL, @ProductID

INSERT INTO	dbo.ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
SELECT @sporttype, @Bettype, @BitmapOrder

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
SELECT 5,@ProductID,6,3
UNION ALL
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
SELECT @sporttype,@Bettype, 20 AS exchangeid, s.siteid, 0 AS IsHidden, 0 AS IsDisabled, 1 AS HasSynced
FROM dbo.Site s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site IN ('733333','722222','222223','222225')

INSERT INTO dbo.LossLimit_GlobalSetting (ProductId, ExchangeId, MinLossLimit, DefaultLossLimit)
SELECT @ProductID, lg.ExchangeId, MinLossLimit, DefaultLossLimit
FROM LossLimit_GlobalSetting lg WITH (NOLOCK)
	INNER JOIN dbo.exchange e ON e.exchangeid = lg.ExchangeId
WHERE ProductId = 42 
	AND e.exchangeid = 20

/*
SELECT * FROM ProductSettingDetail WHERE ProductID = 66
SELECT * FROM ProductStatusProfile where sporttype = 171
SELECT * FROM dbo.SettingSystem
SELECT * FROM dbo.ProductSettingSystemDisplay WHERE ProductID = 66
SELECT * FROM dbo.ProductStatusSiteCurrency WHERE SportType = 171
SELECT * FROM LossLimit_GlobalSetting WHERE ProductId = 66

DELETE FROM ProductSettingDetail WHERE ProductID = 66
DELETE FROM ProductStatusProfile WHERE Sporttype = 171
DELETE FROM dbo.ProductSettingSystemDisplay WHERE ProductID = 66
DELETE FROM ProductStatusSiteCurrency WHERE Sporttype = 171
DELETE FROM LossLimit_GlobalSetting WHERE ProductId = 66
*/



