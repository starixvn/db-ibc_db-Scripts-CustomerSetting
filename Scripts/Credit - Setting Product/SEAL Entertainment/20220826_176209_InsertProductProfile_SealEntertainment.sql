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
		
SELECT @SettingStatus = 0 --0: Production, 1: UAT, 2: Hide	
	 , @productID = 22 -- SEAL Entertainment
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
	--GroupStakeLevel																																				
	(8, @Sporttype, @Bettype, 0, @ProductID, NULL, NULL, NULL, NULL, NULL, 2, 5, @SettingStatus, NULL, @RealProductId)

--GameGroup
INSERT INTO GameGroup ([GameGroupID], [RefSportType], [RefBetType], [GroupName], [IsDeposit])
VALUES (39,156,8900,'Level 1',0)