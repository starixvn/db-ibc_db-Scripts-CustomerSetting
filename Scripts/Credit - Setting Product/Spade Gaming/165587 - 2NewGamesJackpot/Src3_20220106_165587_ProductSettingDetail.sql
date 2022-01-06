/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220106
	Task:  Insert new status Jackpot RedmineID:#165587
	DB: DBCust/CustDB
*/
DECLARE @productID SMALLINT ,@settingType SMALLINT,@betType SMALLINT,@sportType SMALLINT, @BitmapOrder   TINYINT
SET @settingType =  13 -- Status	
SET @productID = 22 -- Macau Games
SET @sportType = 9904
SET @betType = 4001 
SET @BitmapOrder = 39

IF NOT EXISTS(	SELECT TOP 1 1 
				FROM dbo.ProductSettingDetail psd WITH(NOLOCK)
				WHERE 	psd.ProductID = @productID 
					AND SettingType = @settingType 
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
		(
			@settingType,
			@sportType,
			@betType,
			0,-- IsLive
			@productID,
			NULL,-- MaxPT
			NULL,-- MaxDiscount
			1,--  IsSync
			0,--  IsHidden
            0,--  IsDisabled
            2,--  SettingLevel
            5,--  DisplayOrder
            1,--  SettingStatus (only UAT)
            NULL,--  IntervalValue
            @productID,--  RealProductId
            NULL--  MaxChoice
		)
	END		

INSERT INTO	dbo.ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
SELECT @sporttype, @Bettype, @BitmapOrder	
	

