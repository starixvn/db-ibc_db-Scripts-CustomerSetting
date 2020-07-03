/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200222
	Task:  Insert Product [SabaGameSetting] RedmineID:#136210
	DB: DBCust/CustDB
*/
DECLARE @productID SMALLINT ,@settingType SMALLINT,@betType SMALLINT,@sportType SMALLINT
SET @settingType =  4 -- Product Status
SET @productID = 54 -- Sapa Virtual Sport
-- Saba Virtual Sports : 9854
SET @sportType = 98
SET @betType = 1 -- Handicap

IF NOT EXISTS(	SELECT TOP 1 1 
				FROM dbo.ProductSettingDetail psd WITH(NOLOCK)
				WHERE 	psd.ProductID = @productID 
					AND SettingType = @settingType 
					AND SportType  = @sportType 
					AND BetType = @betType			
			)
	BEGIN
		INSERT INTO [CustDB].[dbo].[ProductSettingDetail]
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
		-- Saba Virtual Sports
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
			1,--  IsHidden
            1,--  IsDisabled
            1,--  SettingLevel
            1,--  DisplayOrder
            1,--  SettingStatus (only UAT)
            NULL,--  IntervalValue
            @productID,--  RealProductId
            NULL--  MaxChoice
		)
	END		

