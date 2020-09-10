/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200909
	Task:  Insert new Product [Joker] RedmineID:#131603
	DB: DBCust/CustDB
*/
DECLARE @productID SMALLINT ,@settingType SMALLINT,@betType SMALLINT,@sportType SMALLINT
SET @settingType =  8 -- GroupStakeLevel	
SET @productID = 22 -- Macau Games
SET @sportType = 234
SET @betType = 6401 

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
			NULL,--  IsSync
			NULL,--  IsHidden
            NULL,--  IsDisabled
            2,--  SettingLevel
            5,--  DisplayOrder
            1,--  SettingStatus (only UAT)
            NULL,--  IntervalValue
            @productID,--  RealProductId
            NULL--  MaxChoice
		)
	END		

