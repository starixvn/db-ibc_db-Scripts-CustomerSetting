/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211227@Eden
	Task: Insert product profile for Saba Casino [#164280]
	DB: DBCUST/CustDB
*/

USE CustDB
GO

DECLARE @SettingStatus TINYINT  = 1, 
        @ProductID     INT      = 6, 
        @MaxPT         TINYINT  = 90, 
        @IsSync        BIT      = 1, 
        @IsHidden      BIT      = 0, 
        @IsDisabled    BIT      = 0, 
        @BitmapOrder   TINYINT  = 37, 
        @Sporttype     SMALLINT = 208, 
        @Bettype       SMALLINT = 2101;

--PT Setting
INSERT INTO	dbo.ProductSettingDetail
		(	SettingType, SportType	, BetType	, IsLive, ProductID		, MaxPT	, MaxDiscount	, IsSync	, IsHidden	, IsDisabled	, SettingLevel, DisplayOrder, SettingStatus, IntervalValue	, RealProductId)
VALUES	
--PT	
		(	18         , @Sporttype	, @Bettype	, 0     , @ProductID	, @MaxPT, NULL			, NULL		, NULL		, NULL			, 1           , 2           , @SettingStatus, NULL			, @ProductID)
--Status Setting																																											
	,	(	13         , @Sporttype	, @Bettype	, 0     , @ProductID	, NULL	, NULL			, @IsSync	, @IsHidden	, @IsDisabled	, 1           , 1           , @SettingStatus, NULL			, @ProductID)
--BetSetting																																												
	,	(	8          , @Sporttype	, @Bettype	, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 1           , 4           , @SettingStatus, NULL			, @ProductID)
--WinLossLimit Setting																																									
	,	(	6		   , @Sporttype	, @Bettype	, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 1           , 3           , @SettingStatus, NULL			, @ProductID)

INSERT INTO	dbo.ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
VALUES	(@Sporttype, @Bettype, @BitmapOrder)

--INSERT INTO [dbo].[ProductStatusSiteCurrency]
--           ([SportType]
--           ,[BetType]
--           ,[Currency]
--           ,[SiteID]
--           ,[IsHidden]
--           ,[IsDisabled]
--		   ,[HasSynced])
--SELECT @Sporttype,@Bettype, e.exchangeid, 0 AS siteid, 0 AS IsHidden, 0 AS IsDisabled, 1 AS HasSynced
--FROM exchange e WITH(NOLOCK)
--WHERE e.ExchangeId IN(
--					 2	-- 	RM
--					,3	-- 	US$
--					,13	-- 	RMB
--					,15	-- 	IN
--					,16	-- 	Yen
--					,22	-- 	IND
--					,33	-- 	IDD
--					,34	-- 	IDR
--					,35	-- 	$US
--					,43	-- 	THB
--					,47	-- 	DDD
--					,61	-- 	INR
--					,64	-- 	UT
--					,69	-- 	MMK
--					)
--		AND e.IsActive = 1

--INSERT INTO dbo.LossLimit_GlobalSetting (ProductId, ExchangeId, MinLossLimit, DefaultLossLimit)
--SELECT @ProductID, lg.ExchangeId, MinLossLimit, DefaultLossLimit
--FROM LossLimit_GlobalSetting lg WITH (NOLOCK)
--	INNER JOIN dbo.exchange e ON e.exchangeid = lg.ExchangeId
--WHERE ProductId = 22 AND (e.Code = 'USD' OR e.exchangeid = 20)

----SportNonOfferedSiteCurrency
--INSERT INTO SportNonOfferedSiteCurrency(SportType,BetType,Currency,SiteID)
--SELECT @Sporttype,@Bettype,e.ExchangeId,0
--FROM exchange e WITH(NOLOCK)
--WHERE e.ExchangeId NOT IN(
--					 2	-- 	RM
--					,3	-- 	US$
--					,13	-- 	RMB
--					,15	-- 	IN
--					,16	-- 	Yen
--					,22	-- 	IND
--					,33	-- 	IDD
--					,34	-- 	IDR
--					,35	-- 	$US
--					,43	-- 	THB
--					,47	-- 	DDD
--					,61	-- 	INR
--					,64	-- 	UT
--					,69	-- 	MMK
--					)
--		AND e.IsActive = 1
--ORDER BY e.ExchangeId

--GameGroup
INSERT INTO	dbo.GameGroup (GameGroupID, RefSportType, RefBetType, GroupName, IsDeposit)      
VALUES	
	(33, @Sporttype, @Bettype, 'Level 1', 1),
	(34, @Sporttype, @Bettype, 'Level 1', 0),
	(35, @Sporttype, @Bettype, 'Level 2', 1),
	(36, @Sporttype, @Bettype, 'Level 2', 0)

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
/*
SELECT * FROM ProductSettingDetail(NOLOCK) WHERE ProductID = 6
SELECT * FROM ProductStatusProfile(NOLOCK) WHERE SportType = 208
SELECT * FROM dbo.ProductStatusSiteCurrency(NOLOCK) WHERE SportType = 208
SELECT * FROM dbo.SportNonOfferedSiteCurrency WITH (NOLOCK) WHERE SportType = 208 
--SELECT * FROM LossLimit_GlobalSetting(NOLOCK) WHERE ProductId = 6
SELECT * FROM dbo.GameGroup WITH (NOLOCK) WHERE RefBetType = 2101 
SELECT * FROM dbo.ProductSettingSystemDisplay WHERE ProductID = 6

DELETE FROM ProductSettingDetail WHERE ProductID = 6
DELETE FROM ProductStatusProfile WHERE SportType = 208
DELETE FROM dbo.ProductStatusSiteCurrency WHERE SportType = 208
DELETE FROM dbo.SportNonOfferedSiteCurrency  WHERE SportType = 208 
--DELETE FROM LossLimit_GlobalSetting WHERE ProductId = 6
DELETE FROM dbo.GameGroup WHERE RefBetType = 2101 
DELETE FROM dbo.ProductSettingSystemDisplay WHERE ProductID = 6
*/
