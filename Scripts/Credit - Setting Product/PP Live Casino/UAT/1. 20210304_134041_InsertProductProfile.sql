/*
	Created: 20210304@Tina
	Task: Insert product profile for PP Live Casino
	DB: DBCUST/CustDB
*/

USE CustDB
GO
/*
DELETE FROM ProductSettingDetail WITH(ROWLOCK) WHERE Sporttype = 170 
DELETE FROM ProductStatusProfile WITH(ROWLOCK) WHERE Sporttype = 170 
*/


DECLARE @SettingStatus TINYINT, @ProductID INT, @RealProductID INT, @MaxPT TINYINT, @MaxDiscount DECIMAL(9,8), @IsSync BIT, @IsHidden BIT, 
	@IsDisabled BIT, @BitmapOrder TINYINT, @IntervalValue DECIMAL(19,8)
SELECT @SettingStatus = 1 --0: Production, 1: UAT, 2: Hide
SELECT @ProductID = 41
SELECT @RealProductID = 65
SELECT @IsSync = 1
SELECT @IsHidden = 0
SELECT @IsDisabled = 0
SELECT @BitmapOrder = 33
SELECT @MaxPT = 90
SELECT @MaxDiscount = 0.005
SELECT @IntervalValue = 0.0005

--PT Setting
INSERT INTO	dbo.ProductSettingDetail
		(	SettingType, SportType	, BetType	, IsLive, ProductID		, MaxPT	, MaxDiscount	, IsSync	, IsHidden	, IsDisabled	, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice)
VALUES	
--PT	
		(	18          , 170		, 3701		, 0     , @ProductID	, @MaxPT, NULL			, NULL		, NULL		, NULL			, 2           , 3           , @SettingStatus, NULL, @RealProductID, NULL)
--Comm	
	,	(	19          , 170		, 3701		, 0     , @ProductID	, NULL, @MaxDiscount	, NULL		, NULL		, NULL			, 2           , 2           , @SettingStatus, @IntervalValue, @RealProductID, NULL)
--Status Setting																																				
	,	(	13          , 170		, 3701		, 0     , @ProductID	, NULL	, NULL			, @IsSync	, @IsHidden	, @IsDisabled	, 2           , 1           , @SettingStatus, NULL, @RealProductID, NULL)
--BetSetting																																				
	,	(	7           , 170		, 3701		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 2           , 6           , @SettingStatus, NULL, @RealProductID, NULL)
--WinLossLimit Setting																																				
	,	(	6		    , 170		, 3701		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 2           , 4           , @SettingStatus, NULL, @RealProductID, NULL)


INSERT INTO	dbo.ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
VALUES	(170, 3701, @BitmapOrder)


--SELECT * FROM ProductSettingDetail WHERE sporttype = 170
--SELECT * FROM ProductStatusProfile  WHERE sporttype = 170

--DELETE FROM ProductSettingDetail WHERE sporttype = 170
--DELETE FROM ProductStatusProfile WHERE Sporttype = 170







