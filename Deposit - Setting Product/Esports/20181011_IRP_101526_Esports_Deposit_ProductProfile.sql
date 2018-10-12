/*
	Created: 20181011@Winnie
	Task: Insert product profile for Esports Deposit
	DB: DBCUST/CustDB
*/

-- BEGIN STEP 1: DEPLOY THIS SCRIPT ON DBCUST/CustDB	 --
-----------------------------------------------------------
USE CustDB
GO

DECLARE @SettingStatus TINYINT, 
		@ProductID INT,	
		@IsSync BIT, 
		@IsHidden BIT, 
		@IsDisabled BIT 
	
SELECT @SettingStatus = 1 --0: Production, 1: UAT, 2: Hide
SELECT @ProductID = 16
SELECT @IsSync = 1
SELECT @IsHidden = 0
SELECT @IsDisabled = 0

--PT Setting
INSERT INTO	dbo.Dep_ProductSettingDetail
		(	SettingType, SportType	, BetType	, IsLive, ProductID		, MaxPT	, MaxDiscount	, IsSync	, IsHidden	, IsDisabled	, SettingLevel, DisplayOrder, SettingStatus, IntervalValue)
VALUES	
--Status Setting																																				
		(	13         , 43		, 1		, 0     , @ProductID	, NULL	, NULL			, @IsSync	, @IsHidden	, @IsDisabled	, 2           , 1           , @SettingStatus, NULL)
-- PT Setting
	,	(	1         , 43		, 1		, 0     , @ProductID	, 90	, NULL			, NULL		, NULL		, NULL			, 4           , 3           , @SettingStatus, NULL)
	,	(	1         , 43		, 2		, 0     , @ProductID	, 90	, NULL			, NULL		, NULL		, NULL			, 4           , 3           , @SettingStatus, NULL)
	,	(	1         , 43		, 3		, 0     , @ProductID	, 90	, NULL			, NULL		, NULL		, NULL			, 4           , 3           , @SettingStatus, NULL)
	,	(	1         , 43		, 10	, 0     , @ProductID	, 90	, NULL			, NULL		, NULL		, NULL			, 4           , 3           , @SettingStatus, NULL)
	,	(	1         , 43		, 20	, 0     , @ProductID	, 90	, NULL			, NULL		, NULL		, NULL			, 4           , 3           , @SettingStatus, NULL)
	,	(	1         , 43		, 9999	, 0     , @ProductID	, 90	, NULL			, NULL		, NULL		, NULL			, 4           , 3           , @SettingStatus, NULL)
--Bet limit																																				
	,	(	2		  , 43		, 1		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 2            , 2           , @SettingStatus, NULL)
	

-- BEGIN STEP 2: DEPLOY THIS SCRIPT ON DBCUST/CustDB	 --
-----------------------------------------------------------

INSERT INTO	dbo.ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
SELECT 43,1,18


INSERT INTO [dbo].[ProductBetSetting]
           ([Sporttype]
           ,[Bettype]
           ,[Currency]
           ,[MinBet]
           ,[IsDep]  )
SELECT 
			43
           ,1
           ,exchangeid
           ,0
           ,0        
FROM exchange WITH(NOLOCK)
WHERE exchangeid=20
   
