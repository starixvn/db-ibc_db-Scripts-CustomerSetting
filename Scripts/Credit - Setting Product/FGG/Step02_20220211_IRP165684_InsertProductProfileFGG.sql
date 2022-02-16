/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Elodie
	Date: 20220211
	Task:  Insert new Product profile for FGG [RedmineID:#165684]
	DB: DBCust/CustDB
*/
USE CustDB
GO
 /*
DECLARE @Sporttype INT = 176
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
	 , @productID = 64
	 , @sportType = 176
	 , @betType = 8201 
	 , @RealProductID = 70 
	 , @IsSync = 1
	 , @IsHidden = 0
	 , @IsDisabled = 0
	 , @BitmapOrder = 38
	 , @MaxPT = 90
	 --, @MaxDiscount = 0.01
	 --, @IntervalValue = 0.0005 
	 
	UPDATE ps 
	SET ps.ProductID = 64
	FROM ProductSettingDetail ps WITH (ROWLOCK)
	WHERE productid = 38

	UPDATE ps 
	SET ps.SettingLevel = 2
	FROM ProductSettingDetail ps WITH (ROWLOCK)
	WHERE productid = 64 AND ps.SettingType IN (1,6,13)

	UPDATE ps 
	SET ps.SettingType = 18
	FROM ProductSettingDetail ps WITH (ROWLOCK)
	WHERE productid = 64 AND ps.SettingType = 1

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
				(	18         , @Sporttype		, @Bettype		, 0     , @ProductID	, @MaxPT, NULL			, NULL		, NULL		, NULL			, 2           , 2           , @SettingStatus, NULL, @RealProductId, NULL)
		--Status Setting																																				
			,	(	13         , @Sporttype		, @Bettype		, 0     , @ProductID	, NULL	, NULL			, @IsSync	, @IsHidden	, @IsDisabled	, 2           , 1           , @SettingStatus, NULL, @RealProductId, NULL)
		--BetSetting																																				
			,	(	7         , @Sporttype		, @Bettype		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 4           , 4           , @SettingStatus, NULL, @RealProductId , NULL)
		--WinLossLimit Setting																																				
			,	(	6		   , @Sporttype		, @Bettype		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 2           , 3           , @SettingStatus, NULL, @RealProductId, NULL)

	END		

UPDATE p 
SET p.ProductID = @ProductID
FROM ProductSettingSystemDisplay P WITH (ROWLOCK)
WHERE P.ProductID = 38

DELETE P
FROM ProductStatusProfile P WITH (ROWLOCK)
WHERE P.Sporttype = @Sporttype

INSERT INTO	dbo.ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
VALUES	(@Sporttype, @Bettype, @BitmapOrder)

UPDATE p 
SET p.ProductID = @ProductID
FROM LossLimit_GlobalSetting P WITH (ROWLOCK)
WHERE P.ProductID = 38

DELETE ProductStatusSiteCurrency WHERE sportType = 176

INSERT INTO ProductStatusSiteCurrency(SportType,BetType,Currency,SiteID,IsHidden,IsDisabled,HasSynced)
SELECT 176,8201,exchangeid,0,1,1,1
FROM Exchange e WITH(NOLOCK)
WHERE exchangeid NOT IN (2,3,6,13,15,16,22,33,34,35,43,45,47,64,69,95,10,20,72,67,5,51)			