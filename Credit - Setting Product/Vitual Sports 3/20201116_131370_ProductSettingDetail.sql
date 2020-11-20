/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20201116
	Task: Insert new Product [Leap Gaming Virtual Sports] RedmineID:#131370
	DB: DBCust/CustDB
*/

USE CustDB
GO

 /*
DECLARE @Sporttype INT = 231
DELETE FROM ProductSettingDetail WITH(ROWLOCK) WHERE Sporttype = @Sporttype
DELETE FROM ProductStatusProfile WITH(ROWLOCK) WHERE Sporttype = @Sporttype 
DELETE FROM ProductStatusSiteCurrency WITH(ROWLOCK) WHERE Sporttype = @Sporttype
GO
*/
DECLARE @productID SMALLINT ,@betType SMALLINT,
		@sportType SMALLINT,@RealProductID SMALLINT,@SettingStatus TINYINT
		,@IsSync BIT, @IsHidden BIT,@MaxPT TINYINT,@IsDisabled BIT
		,@MaxDiscount DECIMAL(9,8),@IntervalValue DECIMAL(19,8)
		
SELECT @SettingStatus = 1 --0: Production, 1: UAT, 2: Hide	
	 , @productID = 5  -- Leap Gaming
	 , @sportType = 231
	 , @betType = 5301 
	 , @RealProductID = 5 -- 49 
	 , @IsSync = 1
	 , @IsHidden = 0
	 , @IsDisabled = 0
	 , @MaxPT = 90
	 , @MaxDiscount = 0.005
	 --, @IntervalValue = 0.0005 
	 
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
				(	1	         , @Sporttype		, @Bettype		, 0     , @ProductID	, @MaxPT, NULL			, NULL		, NULL		, NULL			, 2           , 3           , @SettingStatus, NULL, @RealProductId, NULL)
		--Comm	
			,	(	20	         , @Sporttype		, @Bettype		, 0     , @ProductID	, NULL, @MaxDiscount	, NULL		, NULL		, NULL			, 2           , 2           , @SettingStatus, @IntervalValue, @RealProductId, NULL)

	END		
