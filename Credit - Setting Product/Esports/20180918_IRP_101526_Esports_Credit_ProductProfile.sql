/*
	Created: 20180703@Elodie
	Task: Insert product profile for Card Club
	DB: DBCUST/CustDB
*/

-- BEGIN STEP 1: DEPLOY THIS SCRIPT ON DBCUST/CustDB	 --
-----------------------------------------------------------
USE CustDB
GO

DECLARE @SettingStatus TINYINT, @ProductID INT, @MaxDiscount DECIMAL(9,8), @IsSync BIT, @IsHidden BIT, @IsDisabled BIT, @IntervalValue DECIMAL(19,8)
SELECT @SettingStatus = 1 --0: Production, 1: UAT, 2: Hide
SELECT @ProductID = 33
SELECT @IsSync = 1
SELECT @IsHidden = 1
SELECT @IsDisabled = 1
SELECT @MaxDiscount = 0.9
SELECT @IntervalValue = 0.05

--PT Setting
INSERT INTO	dbo.ProductSettingDetail
		(	SettingType, SportType	, BetType	, IsLive, ProductID		, MaxPT	, MaxDiscount	, IsSync	, IsHidden	, IsDisabled	, SettingLevel, DisplayOrder, SettingStatus, IntervalValue)
VALUES	
--Status Setting																																				
		(	13         , 163		, 1401		, 0     , @ProductID	, NULL	, NULL			, @IsSync	, @IsHidden	, @IsDisabled	, 3           , 1           , @SettingStatus, NULL)
	,	(	13         , 163		, 1402		, 0     , @ProductID	, NULL	, NULL			, @IsSync	, @IsHidden	, @IsDisabled	, 3           , 1           , @SettingStatus, NULL)
	,	(	13         , 163		, 1403		, 0     , @ProductID	, NULL	, NULL			, @IsSync	, @IsHidden	, @IsDisabled	, 3           , 1           , @SettingStatus, NULL)
	,	(	13         , 163		, 1404		, 0     , @ProductID	, NULL	, NULL			, @IsSync	, @IsHidden	, @IsDisabled	, 3           , 1           , @SettingStatus, NULL)
--WinLossLimit Setting																																				
	,	(	6		   , 163		, 1401		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 1           , 3           , @SettingStatus, NULL)
--Comm	
	,	(	3          , 163		, 1401		, 0     , @ProductID	, NULL	, @MaxDiscount	, NULL		, NULL		, NULL			, 2           , 2           , @SettingStatus, @IntervalValue)
	

-- BEGIN STEP 2: DEPLOY THIS SCRIPT ON DBCUST/CustDB	 --
-----------------------------------------------------------

INSERT INTO	dbo.ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
VALUES	(163, 1401, 13), (163, 1402, 14), (163, 1403, 15), (163, 1404, 16)

INSERT INTO dbo.ProductSettingSystemDisplay
        ( SystemID ,
          ProductID ,
          SettingType ,
          DisplayMode
        )
SELECT 5,@ProductID,13,3
UNION ALL 
SELECT 5,@ProductID,6,3
UNION ALL 
SELECT 5,@ProductID,3,3

INSERT INTO [dbo].[ProductStatusSiteCurrency]
           ([SportType]
           ,[BetType]
           ,[Currency]
           ,[SiteID]
           ,[IsHidden]
           ,[IsDisabled]
		   ,[HasSynced])
SELECT sb.Sporttype,sb.Bettype, 0 AS exchangeid, siteid, 0 AS IsHidden, 0 AS IsDisabled, 1 AS HasSynced
FROM site s WITH (NOLOCK)
	CROSS JOIN (SELECT 163 AS Sporttype, 1401 AS Bettype
				UNION SELECT 163, 1402
				UNION SELECT 163, 1403
				UNION SELECT 163, 1404) sb
WHERE s.site = '789y'

--SELECT * FROM ProductSettingDetail WHERE ProductID = 33
--SELECT * FROM ProductStatusProfile 
--SELECT * FROM dbo.SettingSystem
--SELECT *  FROM dbo.ProductSettingSystemDisplay WHERE ProductID = 33
--SELECT * FROM ProductStatusSiteCurrency WHERE Sporttype = 163

--DELETE FROM ProductSettingDetail WHERE ProductID = 33
--DELETE FROM ProductStatusProfile WHERE Sporttype = 163
--DELETE FROM dbo.ProductSettingSystemDisplay WHERE ProductID = 33
--DELETE FROM ProductStatusSiteCurrency WHERE Sporttype = 163



