/*
	Created: 20210224@Tina
	Task: Insert product profile for Habanero - CREDIT
	Redmine: https://nexdev.net/issues/145459
	DB: DBCUST/CustDB
*/

USE CustDB
GO
/*
DELETE FROM ProductSettingDetail WITH(ROWLOCK) WHERE Sporttype = 238 
*/


DECLARE @SettingStatus TINYINT, @ProductID INT, @RealProductID INT, @betType SMALLINT,@sportType SMALLINT
SELECT @SettingStatus = 1 --0: Production, 1: UAT, 2: Hide
SELECT @ProductID = 61
SELECT @RealProductID = 22

SET @sportType = 238
SET @betType = 7001 

--PT Setting
INSERT INTO	dbo.ProductSettingDetail
		(SettingType, SportType	, BetType	, IsLive, ProductID		, MaxPT	, MaxDiscount	, IsSync	, IsHidden	, IsDisabled	, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId	, MaxChoice)
VALUES	
--BetSetting																																				
		(8          , @sportType, @betType	, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 2           , 6           , @SettingStatus, NULL		   , @RealProductID	, NULL)





