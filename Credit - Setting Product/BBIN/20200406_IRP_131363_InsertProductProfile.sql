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

--UPDATE dbo.ProductSettingDetail WITH (ROWLOCK)
--SET DisplayOrder = 6
--WHERE SettingType = 7 AND ProductID = 41

INSERT INTO	dbo.ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
VALUES	(241, 3300, @BitmapOrder)

CREATE TABLE #NonOfferedCurency (Currency INT) --KHR(KHR); PLN(PLN); CNY(RMB, CY, YUN);MMK(MMK, MKK); VND (INH);INR(INR);RUB(RUB);JPY (JPY); EUR(Euro, EUR); KRW (Won); SGD (SD$)
INSERT INTO #NonOfferedCurency (Currency)
SELECT 71 UNION ALL
SELECT 56 UNION ALL
SELECT 13 UNION ALL
SELECT 81 UNION ALL
SELECT 66 UNION ALL
SELECT 69 UNION ALL
SELECT 70 UNION ALL
SELECT 51 UNION ALL
SELECT 61 UNION ALL
SELECT 55 UNION ALL
SELECT 32 UNION ALL
SELECT 6 UNION ALL
SELECT 78 UNION ALL
SELECT 45 UNION ALL
SELECT 1

INSERT INTO ProductStatusSiteCurrency (SportType, BetType, SiteID, Currency, IsHidden, IsDisabled, HasSynced)
SELECT DISTINCT 241, 3300, 0, Currency, 1, 1, 1  
FROM #NonOfferedCurency WITH (NOLOCK)

DROP TABLE #NonOfferedCurency

--SELECT * FROM ProductSettingDetail WHERE sporttype = 241
--SELECT * FROM ProductStatusProfile  WHERE sporttype = 241
--SELECT * FROM dbo.SettingSystem
--SELECT *  FROM dbo.ProductSettingSystemDisplay WHERE ProductID = 41
--SELECT *  FROM dbo.ProductStatusSiteCurrency WHERE SportType = 241

--DELETE FROM ProductSettingDetail WHERE sporttype = 241
--DELETE FROM ProductStatusProfile WHERE Sporttype = 241





