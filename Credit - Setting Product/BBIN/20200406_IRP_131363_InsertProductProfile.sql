/*
	Created: 20200406@Elodie
	Task: Insert product profile for BBIN
	DB: DBCUST/CustDB
*/

USE CustDB
GO
/*
DELETE FROM ProductSettingDetail WITH(ROWLOCK) WHERE Sporttype = 241 
DELETE FROM ProductStatusProfile WITH(ROWLOCK) WHERE Sporttype = 241 
DELETE FROM ProductStatusSiteCurrency WITH(ROWLOCK) WHERE Sporttype = 241
*/


DECLARE @SettingStatus TINYINT, @ProductID INT, @MaxPT TINYINT, @MaxDiscount DECIMAL(9,8), @IsSync BIT, @IsHidden BIT, @IsDisabled BIT, @BitmapOrder TINYINT, @IntervalValue DECIMAL(19,8)
SELECT @SettingStatus = 1 --0: Production, 1: UAT, 2: Hide
SELECT @ProductID = 41
SELECT @IsSync = 1
SELECT @IsHidden = 0
SELECT @IsDisabled = 0
SELECT @BitmapOrder = 24
SELECT @MaxPT = 90
SELECT @MaxDiscount = 0.005
SELECT @IntervalValue = 0.0005

--PT Setting
INSERT INTO	dbo.ProductSettingDetail
		(	SettingType, SportType	, BetType	, IsLive, ProductID		, MaxPT	, MaxDiscount	, IsSync	, IsHidden	, IsDisabled	, SettingLevel, DisplayOrder, SettingStatus, IntervalValue)
VALUES	
--PT	
		(	1          , 241		, 3300		, 0     , @ProductID	, @MaxPT, NULL			, NULL		, NULL		, NULL			, 2           , 3           , @SettingStatus, NULL)
--Comm	
	,	(	3          , 241		, 3300		, 0     , @ProductID	, NULL, @MaxDiscount	, NULL		, NULL		, NULL			, 2           , 2           , @SettingStatus, @IntervalValue)
--Status Setting																																				
	,	(	13         , 241		, 3300		, 0     , @ProductID	, NULL	, NULL			, @IsSync	, @IsHidden	, @IsDisabled	, 2           , 1           , @SettingStatus, NULL)
--BetSetting																																				
	,	(	7          , 241		, 3300		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 2           , 6           , @SettingStatus, NULL)
--WinLossLimit Setting																																				
	,	(	12		   , 241		, 3300		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 2           , 5           , @SettingStatus, NULL)

UPDATE dbo.ProductSettingDetail WITH (ROWLOCK)
SET DisplayOrder = 6
WHERE SettingType = 7 AND ProductID = 41

INSERT INTO	dbo.ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
VALUES	(241, 3300, @BitmapOrder)

CREATE TABLE #NonOfferedCurency (Currency INT) --KHR(KHR); PLN(PLN);MMK(MMK, MKK); JPY (JPY); SGD (SD$)

INSERT INTO #NonOfferedCurency (Currency)
SELECT exchangeid 
FROM exchange WITH(NOLOCK) 
WHERE exchangeid NOT IN (12,
						13,
						15,
						16,
						2,
						22,
						3,
						33,
						34,
						35,
						4,
						43,
						45,
						47,
						5,
						51,
						55,
						6,
						61,
						64,
						66,
						67,
						74,
						78,
						81,
						20,72 --test
					) --supported currencies


INSERT INTO ProductStatusSiteCurrency (SportType, BetType, SiteID, Currency, IsHidden, IsDisabled, HasSynced)
SELECT DISTINCT 241, 3300, 0, Currency, 1, 1, 1  
FROM #NonOfferedCurency WITH (NOLOCK)

DROP TABLE #NonOfferedCurency

INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (5,41,12,3)
INSERT INTO [dbo].[ProductSettingSystemDisplay] ([SystemID],[ProductID],[SettingType],[DisplayMode]) VALUES (9,41,12,3)

--SELECT * FROM ProductSettingDetail WHERE sporttype = 241
--SELECT * FROM ProductStatusProfile  WHERE sporttype = 241
--SELECT * FROM dbo.SettingSystem
--SELECT *  FROM dbo.ProductSettingSystemDisplay WHERE ProductID = 41
--SELECT *  FROM dbo.ProductStatusSiteCurrency WHERE SportType = 241

--DELETE FROM ProductSettingDetail WHERE sporttype = 241
--DELETE FROM ProductStatusProfile WHERE Sporttype = 241





