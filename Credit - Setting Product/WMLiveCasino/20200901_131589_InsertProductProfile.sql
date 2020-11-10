/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200828
	Task:  Insert new Product profile for WM RedmineID:#131589
	DB: DBCust/CustDB
*/
USE CustDB
GO
 /*
DECLARE @Sporttype INT = 233
DELETE FROM ProductSettingDetail WITH(ROWLOCK) WHERE Sporttype = @Sporttype
DELETE FROM ProductStatusProfile WITH(ROWLOCK) WHERE Sporttype = @Sporttype 
DELETE FROM ProductStatusSiteCurrency WITH(ROWLOCK) WHERE Sporttype = @Sporttype
GO
*/
DECLARE @productID SMALLINT ,@betType SMALLINT,
		@sportType SMALLINT,@RealProductID SMALLINT,@SettingStatus TINYINT,
		@MaxDiscount DECIMAL(9,8), @IsSync BIT, @IsHidden BIT,@MaxPT TINYINT,		
		@IsDisabled BIT, @BitmapOrder TINYINT, @IntervalValue DECIMAL(19,8)
		
SELECT @SettingStatus = 1 --0: Production, 1: UAT, 2: Hide	
	 , @productID = 41 -- WM  Games
	 , @sportType = 233
	 , @betType = 3401 
	 , @RealProductID = 51 
	 , @IsSync = 1
	 , @IsHidden = 0
	 , @IsDisabled = 0
	 , @BitmapOrder = 29
	 , @MaxPT = 90
	 , @MaxDiscount = 0.005
	 , @IntervalValue = 0.0005 
	 
IF NOT EXISTS(	SELECT TOP 1 1 
				FROM dbo.ProductSettingDetail psd WITH(NOLOCK)
				WHERE 	psd.ProductID = @productID 
					AND SportType  = @sportType 
					AND BetType = @betType			
			)
	BEGIN
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
           ,[RealProductId]
           ,[MaxChoice])
		VALUES	
		--PT	
				(	18         , @Sporttype		, @Bettype		, 0     , @ProductID	, @MaxPT, NULL			, NULL		, NULL		, NULL			, 2           , 3           , @SettingStatus, NULL, @RealProductId, NULL)
		--Comm	
			,	(	19         , @Sporttype		, @Bettype		, 0     , @ProductID	, NULL, @MaxDiscount	, NULL		, NULL		, NULL			, 2           , 2           , @SettingStatus, @IntervalValue, @RealProductId, NULL)
		--Status Setting																																				
			,	(	13         , @Sporttype		, @Bettype		, 0     , @ProductID	, NULL	, NULL			, @IsSync	, @IsHidden	, @IsDisabled	, 2           , 1           , @SettingStatus, NULL, @RealProductId, NULL)
		--BetSetting																																				
			,	(	17         , @Sporttype		, @Bettype		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 2           , 6           , @SettingStatus, NULL, @RealProductId , 0)
		--WinLossLimit Setting																																				
			,	(	6		   , @Sporttype		, @Bettype		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 2           , 4           , @SettingStatus, NULL, @RealProductId, NULL)

	END		

DELETE P
FROM ProductStatusProfile P WITH (ROWLOCK)
WHERE P.Sporttype = @Sporttype

INSERT INTO	dbo.ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
VALUES	(@Sporttype, @Bettype, @BitmapOrder)