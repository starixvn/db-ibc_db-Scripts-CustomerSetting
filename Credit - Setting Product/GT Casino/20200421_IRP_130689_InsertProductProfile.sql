/*
	Created: 20200421@Elodie
	Task: Insert product profile for GTCasino
	DB: DBCUST/CustDB
*/

USE CustDB
GO
/*
DELETE FROM ProductSettingDetail WITH(ROWLOCK) WHERE Sporttype = 242
DELETE FROM ProductStatusProfile WITH(ROWLOCK) WHERE Sporttype = 242 
DELETE FROM ProductStatusSiteCurrency WITH(ROWLOCK) WHERE Sporttype = 242
*/


DECLARE @SettingStatus TINYINT, @ProductID TINYINT, @RealProductID TINYINT, @MaxPT TINYINT, @MaxDiscount DECIMAL(9,8), @IsSync BIT, @IsHidden BIT, @IsDisabled BIT, @BitmapOrder TINYINT, @IntervalValue DECIMAL(19,8)
SELECT @SettingStatus = 1 --0: Production, 1: UAT, 2: Hide
SELECT @ProductID = 41
SELECT @RealProductID = 46
SELECT @IsSync = 1
SELECT @IsHidden = 0
SELECT @IsDisabled = 0
SELECT @BitmapOrder = 25
SELECT @MaxPT = 90
SELECT @MaxDiscount = 0.005
SELECT @IntervalValue = 0.0005

DELETE P
FROM ProductSettingDetail P WITH (ROWLOCK)
WHERE P.SportType = 242
--PT Setting
INSERT INTO	dbo.ProductSettingDetail
		(	SettingType, SportType	, BetType	, IsLive, ProductID		, MaxPT	, MaxDiscount	, IsSync	, IsHidden	, IsDisabled	, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId)
VALUES	
--PT	
		(	1          , 242		, 3201		, 0     , @ProductID	, @MaxPT, NULL			, NULL		, NULL		, NULL			, 2           , 3           , @SettingStatus, NULL, @RealProductId)
--Comm	
	,	(	3          , 242		, 3201		, 0     , @ProductID	, NULL, @MaxDiscount	, NULL		, NULL		, NULL			, 2           , 2           , @SettingStatus, @IntervalValue, @RealProductId)
--Status Setting																																				
	,	(	13         , 242		, 3201		, 0     , @ProductID	, NULL	, NULL			, @IsSync	, @IsHidden	, @IsDisabled	, 2           , 1           , @SettingStatus, NULL, @RealProductId)
--BetSetting																																				
	,	(	7          , 242		, 3201		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 2           , 6           , @SettingStatus, NULL, @RealProductId)
--WinLossLimit Setting																																				
	,	(	6		   , 242		, 3201		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 2           , 4           , @SettingStatus, NULL, @RealProductId)

DELETE P
FROM ProductStatusProfile P WITH (ROWLOCK)
WHERE P.Sporttype = 242

INSERT INTO	dbo.ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
VALUES	(242, 3201, @BitmapOrder)






