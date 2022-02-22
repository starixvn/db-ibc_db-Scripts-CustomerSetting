/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220106
	Task:  Insert new status Jackpot RedmineID:#165587
	DB: DBCust/CustDB
	P/s :  Step 1 Add config status jackpot
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
            1,--  DisplayOrder
            1,--  SettingStatus (only UAT)
            NULL,--  IntervalValue
            @productID,--  RealProductId
            NULL--  MaxChoice
		)
	END		

DELETE FROM ProductStatusProfile WHERE Sporttype = @sporttype AND Bettype = @Bettype

INSERT INTO	dbo.ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
SELECT @sporttype, @Bettype, @BitmapOrder	
	

INSERT INTO [dbo].[ProductStatusSiteCurrency]
           ([SportType]
           ,[BetType]
           ,[Currency]
           ,[SiteID]
           ,[IsHidden]
           ,[IsDisabled]
		   ,[HasSynced])
SELECT @sporttype,@bettype, 0 AS exchangeid, s.siteid, 0 AS IsHidden, 1 AS IsDisabled, 1 AS HasSynced
FROM dbo.[Site] s WITH(NOLOCK)
WHERE s.isActive = 1 AND s.isLicensee = 0
	AND s.site IN ('789y')
	
-- Update Macau 	

UPDATE ProductSettingDetail WITH(UPDLOCK,ROWLOCK)
SET SettingLevel = 2
WHERE ProductID = @productID 
		AND SettingType = @settingType 
		AND SportType  = 212 
		AND BetType = 4001
