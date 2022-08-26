/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220826@Tacy
	Task: Insert new Product profile for SEAL Entertainment [redmine:#176209]
	DB: DBCust/CustDB
*/

DECLARE @productID SMALLINT ,@betType SMALLINT,
		@sportType SMALLINT,@RealProductID SMALLINT,@SettingStatus TINYINT,
		@MaxDiscount DECIMAL(9,8), @IsSync BIT, @IsHidden BIT,@MaxPT TINYINT,		
		@IsDisabled BIT, @BitmapOrder TINYINT
		
SELECT @SettingStatus = 1 --0: Production, 1: UAT, 2: Hide	
	 , @productID = 72 -- SEAL Entertainment
	 , @sportType = 156
	 , @betType = 8900 
	 , @RealProductID = 22 
	 , @IsSync = 1
	 , @IsHidden = 0
	 , @IsDisabled = 0
	 , @BitmapOrder = 40
	 , @MaxPT = 90
	 , @MaxDiscount = 0

-- [ProductSettingDetail]
DELETE FROM dbo.ProductSettingDetail WITH(ROWLOCK)
WHERE 	ProductID=@productID 
	AND SportType=@sportType 
	AND BetType=@betType			
		
INSERT INTO [ProductSettingDetail]
    ([SettingType]
    ,[SportType]
    ,[BetType]
    ,[IsLive]
    ,[ProductID]
    ,[MaxPT]
    ,[MaxDiscount]
    ,[IsSync] 
    ,[IsHidden]
    ,[IsDisabled]
    ,[SettingLevel]
    ,[DisplayOrder]
    ,[SettingStatus]
    ,[IntervalValue]
    ,[RealProductId])
VALUES	
	--PT	
		(	18         , @Sporttype		, @Bettype		, 0     , @ProductID	, @MaxPT, NULL			, NULL		, NULL		, NULL			, 1           , 3           , @SettingStatus, NULL, @RealProductId)
	--Comm	
	,	(	3         , @Sporttype		, @Bettype		, 0     , @ProductID	, NULL	, @MaxDiscount	, NULL		, NULL		, NULL			, 1           , 2           , @SettingStatus, NULL, @RealProductId)
	--DependencyProductStatus																																				
	,	(	21         , @Sporttype		, @Bettype		, 0     , @ProductID	, NULL	, NULL			, @IsSync	, @IsHidden	, @IsDisabled	, 1           , 1           , @SettingStatus, NULL, @RealProductId)
	--GroupStakeLevel																																				
	,	(	8         , @Sporttype		, @Bettype		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 2           , 5           , @SettingStatus, NULL, @RealProductId)
	--WinLossLimit Setting																																				
	,	(	6		   , @Sporttype		, @Bettype		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 1           , 4           , @SettingStatus, NULL, @RealProductId)


-- [ProductStatusProfile]
DELETE P
FROM ProductStatusProfile P WITH (ROWLOCK)
WHERE P.Sporttype = @Sporttype

INSERT INTO	dbo.ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
VALUES	(@Sporttype, @Bettype, @BitmapOrder)


-- [ProductSettingSystemDisplay]
DELETE P
FROM ProductSettingSystemDisplay P WITH (ROWLOCK)
WHERE P.ProductID = @ProductID

INSERT INTO dbo.ProductSettingSystemDisplay
        (SystemID, ProductID, SettingType, DisplayMode)
SELECT 5,@ProductID,18,3
UNION ALL 
SELECT 5,@ProductID,3,3
UNION ALL 
SELECT 5,@ProductID,6,3
UNION ALL 
SELECT 5,@ProductID,21,3
UNION ALL
SELECT 9,@ProductID,21,3
UNION ALL 
SELECT 9,@ProductID,18,3
UNION ALL 
SELECT 9,@ProductID,3,3
UNION ALL 
SELECT 9,@ProductID,6,3
UNION ALL
SELECT 6,@ProductID,21,3
UNION ALL
SELECT 7,@ProductID,21,3
UNION ALL
SELECT 8,@ProductID,21,3


--GameGroup
INSERT INTO GameGroup ([GameGroupID], [RefSportType], [RefBetType], [GroupName], [IsDeposit])
VALUES (39,156,8900,'Level 1',0)