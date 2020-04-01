/*
	Created: 20200326@Elodie
	Task: Insert product profile for Table Games
	DB: DBCUST/CustDB
*/

USE CustDB
GO

DECLARE @SettingStatus TINYINT, @ProductID INT, @MaxPT TINYINT, @MaxDiscount DECIMAL(9,8), @IsSync BIT, @IsHidden BIT, @IsDisabled BIT, @BitmapOrder TINYINT, @IntervalValue DECIMAL(19,8)
SELECT @SettingStatus = 1 --0: Production, 1: UAT, 2: Hide
SELECT @ProductID = 44
SELECT @IsSync = 1
SELECT @IsHidden = 0
SELECT @IsDisabled = 0
SELECT @BitmapOrder = 23
SELECT @MaxPT = 85
--SELECT @MaxDiscount = 0.0025
--SELECT @IntervalValue = 0.0005

UPDATE dbo.ProductSettingDetail SET ProductID = 44 WHERE ProductID = 28
UPDATE dbo.ProductSettingSystemDisplay SET ProductID = 44 WHERE ProductID = 28
UPDATE dbo.LossLimit_GlobalSetting SET ProductID = 44 WHERE ProductID = 28

--PT Setting
INSERT INTO	dbo.ProductSettingDetail
		(	SettingType, SportType	, BetType	, IsLive, ProductID		, MaxPT	, MaxDiscount	, IsSync	, IsHidden	, IsDisabled	, SettingLevel, DisplayOrder, SettingStatus, IntervalValue)
VALUES	
--PT	
		(	1          , 222		, 4901		, 0     , @ProductID	, @MaxPT, NULL			, NULL		, NULL		, NULL			, 4           , 3           , @SettingStatus, NULL)
--Status Setting																																				
	,	(	13         , 222		, 4901		, 0     , @ProductID	, NULL	, NULL			, @IsSync	, @IsHidden	, @IsDisabled	, 2           , 1           , @SettingStatus, NULL)
--BetSetting																																				
	,	(	2          , 222		, 4901		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 4           , 2           , @SettingStatus, NULL)
--WinLossLimit Setting																																				
	,	(	6		   , 222		, 4901		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 2           , 4           , @SettingStatus, NULL)

INSERT INTO	dbo.ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
VALUES	(222, 4901, @BitmapOrder)

--INSERT INTO dbo.ProductSettingSystemDisplay
--        ( SystemID ,
--          ProductID ,
--          SettingType ,
--          DisplayMode
--        )
--SELECT 5,@ProductID,13,3
--UNION ALL 
--SELECT 5,@ProductID,1,3
--UNION ALL 
--SELECT 5,@ProductID,6,3
--UNION ALL
--SELECT 9,@ProductID,13,3
--UNION ALL 
--SELECT 9,@ProductID,1,3
--UNION ALL 
--SELECT 9,@ProductID,6,3
--UNION ALL
--SELECT 6,@ProductID,13,3
--UNION ALL
--SELECT 7,@ProductID,13,3
--UNION ALL
--SELECT 8,@ProductID,13,3

--INSERT INTO [dbo].[ProductStatusSiteCurrency]
--           ([SportType]
--           ,[BetType]
--           ,[Currency]
--           ,[SiteID]
--           ,[IsHidden]
--           ,[IsDisabled]
--		   ,[HasSynced])
--SELECT 222, 4901, 0 AS exchangeid, s.siteid, 0 AS IsHidden, 0 AS IsDisabled, 1 AS HasSynced
--FROM dbo.Site s WITH(NOLOCK)
--WHERE s.isActive = 1 AND s.isLicensee = 0

--INSERT INTO dbo.LossLimit_GlobalSetting (ProductId, ExchangeId, MinLossLimit, DefaultLossLimit)
--SELECT @ProductID, lg.ExchangeId, MinLossLimit, DefaultLossLimit
--FROM LossLimit_GlobalSetting lg WITH (NOLOCK)
--	INNER JOIN dbo.exchange e ON e.exchangeid = lg.ExchangeId
--WHERE ProductId = 22 AND (e.Code = 'USD' OR e.exchangeid = 20)

--SELECT * FROM ProductSettingDetail WHERE sporttype = 222
--SELECT * FROM ProductStatusProfile  WHERE sporttype = 222
--SELECT * FROM dbo.SettingSystem
--SELECT *  FROM dbo.ProductSettingSystemDisplay WHERE ProductID = 28
--SELECT *  FROM dbo.ProductStatusSiteCurrency WHERE SportType = 222

--DELETE FROM ProductSettingDetail WHERE sporttype = 222
--DELETE FROM ProductStatusProfile WHERE Sporttype = 222





