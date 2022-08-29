/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220829@Tacy
	Task: Insert new Product profile for Microgaming [redmine:#175853]
	DB: DBCust/CustDB
*/

DECLARE @productID SMALLINT ,@betType SMALLINT,
		@sportType SMALLINT,@RealProductID SMALLINT,
		@SettingStatus TINYINT, @ProductSettingID INT
		
SELECT @SettingStatus = 1 --0: Production, 1: UAT, 2: Hide	
	 , @productID = 22
	 , @sportType = 155
	 , @betType = 8400 
	 , @RealProductID = 22 
	 , @ProductSettingID = 227

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
    ,[RealProductId]
	,[ProductSettingID])
VALUES	
	--GroupStakeLevel																																				
	(8, @Sporttype, @Bettype, 0, @ProductID, NULL, NULL, NULL, NULL, NULL, 2, 5, @SettingStatus, NULL, @RealProductId, @ProductSettingID)

--GameGroup
INSERT INTO GameGroup ([GameGroupID], [RefSportType], [RefBetType], [GroupName], [IsDeposit])
VALUES (40,155,8400,'Level 1',0)