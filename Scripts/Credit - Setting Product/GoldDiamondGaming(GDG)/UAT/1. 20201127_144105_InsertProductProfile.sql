/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20201127@Tina
	Task: Insert product profile for Gold Diamond Gaming (GDG) [RedmineID: #144105]
	DB: DBCUST/CustDB
*/

USE CustDB
GO
/*
DELETE FROM ProductSettingDetail WITH(ROWLOCK) WHERE Sporttype = 236 
DELETE FROM ProductStatusProfile WITH(ROWLOCK) WHERE Sporttype = 236 
DELETE FROM ProductStatusSiteCurrency WITH(ROWLOCK) WHERE Sporttype = 236
*/


DECLARE @SettingStatus TINYINT, @ProductID INT, @RealProductID INT, @MaxPT TINYINT, @MaxDiscount DECIMAL(9,8), @IsSync BIT, @IsHidden BIT, 
	@IsDisabled BIT, @BitmapOrder TINYINT, @IntervalValue DECIMAL(19,8)
DECLARE @SportType INT, @BetType INT

SELECT @SettingStatus = 1 --0: Production, 1: UAT, 2: Hide
SELECT @ProductID = 41
SELECT @RealProductID = 59
SELECT @SportType = 236
SELECT @BetType = 5701
SELECT @IsSync = 1
SELECT @IsHidden = 0
SELECT @IsDisabled = 0
SELECT @BitmapOrder = 31
SELECT @MaxPT = 90
SELECT @MaxDiscount = 0.005
SELECT @IntervalValue = 0.0005

--PT Setting
INSERT INTO	dbo.ProductSettingDetail
		(	SettingType, SportType	, BetType	, IsLive, ProductID		, MaxPT	, MaxDiscount	, IsSync	, IsHidden	, IsDisabled	, SettingLevel, DisplayOrder, SettingStatus, IntervalValue,  RealProductId  , MaxChoice)
VALUES	
--PT	
		(	18         , @SportType	, @BetType	, 0     , @ProductID	, @MaxPT, NULL			, NULL		, NULL		, NULL			, 2           , 3           , @SettingStatus, NULL			, @RealProductID, NULL)
--Comm	
	,	(	19         , @SportType	, @BetType	, 0     , @ProductID	, NULL  , @MaxDiscount	, NULL		, NULL		, NULL			, 2           , 2           , @SettingStatus, @IntervalValue, @RealProductID, NULL)
--Status Setting																																				
	,	(	13         , @SportType	, @BetType	, 0     , @ProductID	, NULL	, NULL			, @IsSync	, @IsHidden	, @IsDisabled	, 2           , 1           , @SettingStatus, NULL			, @RealProductID, NULL)
--BetSetting																																				
	,	(	17         , @SportType	, @BetType	, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 2           , 6           , @SettingStatus, NULL			, @RealProductID, 6)
--WinLossLimit Setting																																				
	,	(	6		   , @SportType	, @BetType	, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 2           , 4           , @SettingStatus, NULL			, @RealProductID, NULL)


INSERT INTO	dbo.ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
VALUES	(@SportType, @BetType, @BitmapOrder)

CREATE TABLE #NonOfferedCurency (Currency INT) 

INSERT INTO #NonOfferedCurency (Currency)
SELECT exchangeid 
FROM exchange WITH(NOLOCK) 
WHERE exchangeid NOT IN (13,	--CNY(RMB)
						15,	--IDR(IN)
						22,	--IDR(IND)
						33,	--IDR(IDD)
						34,	--IDR(IDR)
						47,	--IDR(DDD)
						43,	--THB(THB)
						3,	--USD(US$)
						16,	--USD(Yen)
						35,	--USD($US)
						64,	--USD(UT)
						95,	--USD(USD)
						2,	--MYR(RM)
						5,	--HKD(HK$)
						67,	--HKD(HKK)
						69,	--MMK(MMK)
						72,	--YNG(YNG)
						20	--(UUS)
					) --support currencies 


INSERT INTO ProductStatusSiteCurrency (SportType, BetType, SiteID, Currency, IsHidden, IsDisabled, HasSynced)
SELECT DISTINCT @SportType, @BetType, 0 SiteID, Currency, 1 IsHidden, 1 IsDisabled, 1 HasSynced
FROM #NonOfferedCurency WITH (NOLOCK)

DROP TABLE #NonOfferedCurency

--SELECT * FROM ProductSettingDetail WHERE sporttype = 236
--SELECT * FROM ProductStatusProfile  WHERE sporttype = 236
--SELECT * FROM dbo.SettingSystem
--SELECT *  FROM dbo.ProductSettingSystemDisplay WHERE ProductID = 41
--SELECT *  FROM dbo.ProductStatusSiteCurrency WHERE SportType = 236

--DELETE FROM ProductSettingDetail WHERE sporttype = 236
--DELETE FROM ProductStatusProfile WHERE Sporttype = 236







