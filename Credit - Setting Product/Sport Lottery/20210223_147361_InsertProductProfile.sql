/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210223
	Task:  Insert new Product profile for Sports Lottery [RedmineID:#147361]
	DB: DBCust/CustDB
*/
USE CustDB
GO
 /*
DECLARE @Sporttype INT = 169
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
	 , @productID = 44 -- Sports Lottery
	 , @sportType = 169
	 , @betType = 3611 
	 , @RealProductID = 63 
	 , @IsSync = 1
	 , @IsHidden = 0
	 , @IsDisabled = 0
	 , @BitmapOrder = 32
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
		--BetLimit																																				
			(		2         , @Sporttype		, @Bettype		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 4           , 2           , @SettingStatus, NULL, @RealProductId , 0)
		--WinLossLimit Setting																																				
			,	(	6		   , @Sporttype		, @Bettype		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 2           , 4           , @SettingStatus, NULL, @RealProductId, NULL)
		--Status Setting																																				
			,	(	13         , @Sporttype		, @Bettype		, 0     , @ProductID	, NULL	, NULL			, @IsSync	, @IsHidden	, @IsDisabled	, 2           , 1           , @SettingStatus, NULL, @RealProductId, NULL)			
		--PT	
			,	(	18         , @Sporttype		, @Bettype		, 0     , @ProductID	, @MaxPT, NULL			, NULL		, NULL		, NULL			, 4           , 3           , @SettingStatus, NULL, @RealProductId, NULL)




	END		

DELETE P
FROM ProductStatusProfile P WITH (ROWLOCK)
WHERE P.Sporttype = @Sporttype

INSERT INTO	dbo.ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
VALUES	(@Sporttype, @Bettype, @BitmapOrder)


DELETE P
FROM ProductBetSetting P WITH (ROWLOCK)
WHERE P.Sporttype = @Sporttype AND p.Bettype = @betType

INSERT INTO dbo.ProductBetSetting
        ( Sporttype ,
          Bettype ,
          Currency ,
          MinBet ,
          IsDep ,
          MaxBet ,
          MaxPerMatch ,
          DefaultMinBet ,
          DefaultMaxBet ,
          DefaultMaxPerMatch
        )
SELECT @sportType ,
	   @betType ,
	   Currency ,
	   MinBet ,
	   IsDep ,
	   MaxBet ,
	   MaxPerMatch ,
	   DefaultMinBet ,
	   DefaultMaxBet ,
	   DefaultMaxPerMatch
FROM ProductBetSetting WITH (NOLOCK)
WHERE Sporttype = 220 AND Bettype = 1024


/*
DELETE FROM ProductStatusSiteCurrency WHERE SportType=@Sporttype and Bettype = @betType

INSERT INTO ProductStatusSiteCurrency (SportType, BetType, SiteID, Currency, IsHidden, IsDisabled, HasSynced)
SELECT @Sporttype, @Bettype, SiteID, Currency, IsHidden, IsDisabled, HasSynced  
FROM ProductStatusSiteCurrency WITH (NOLOCK)
WHERE Sporttype = 220 AND Bettype = 1024
*/