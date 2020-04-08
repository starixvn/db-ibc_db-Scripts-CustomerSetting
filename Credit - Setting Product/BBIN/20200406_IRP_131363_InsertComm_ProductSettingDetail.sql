/*
	Created: 20200406@Eden
	Task: Insert comm - ProductSettingDetail for BBIN
	DB: DBCUST/CustDB
*/

USE CustDB
GO
/*
SELECT * FROM ProductSettingDetail WITH(ROWLOCK) WHERE Sporttype = 241 
*/


DECLARE @SettingStatus TINYINT, @ProductID INT, @MaxPT TINYINT, @MaxDiscount DECIMAL(9,8), @IsSync BIT, @IsHidden BIT, @IsDisabled BIT, @BitmapOrder TINYINT, @IntervalValue DECIMAL(19,8)
SELECT @SettingStatus = 1 --0: Production, 1: UAT, 2: Hide
SELECT @ProductID = 41
SELECT @MaxDiscount = 0.005
SELECT @IntervalValue = 0.0005

--PT Setting
INSERT INTO	dbo.ProductSettingDetail
		(	SettingType, SportType	, BetType	, IsLive, ProductID		, MaxPT	, MaxDiscount	, IsSync	, IsHidden	, IsDisabled	, SettingLevel, DisplayOrder, SettingStatus, IntervalValue)
VALUES	
--Comm	
		(	3          , 241		, 3300		, 0     , @ProductID	, NULL, @MaxDiscount	, NULL		, NULL		, NULL			, 2           , 2           , @SettingStatus, @IntervalValue)
