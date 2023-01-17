/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230116@Helios
	Task: Insert new Product profile for Jili [redmine:#182869]
	DB: DBCust/CustDB
*/
DECLARE @productID SMALLINT , @BetType SMALLINT,
		@sportType SMALLINT,@RealProductID SMALLINT,	
		@SettingStatus TINYINT, @ProductSettingID INT
		
SELECT @SettingStatus = 1 --0: Production, 1: UAT, 2: Hide	
	 , @productID = 18
	 , @sportType = 158
	 , @BetType = 5100
	 , @RealProductID = 18 
	 , @ProductSettingID = 243
-- Insert [ProductSettingDetail]

INSERT INTO   [ProductSettingDetail]
([SettingType], 
[SportType],
[BetType],
[IsLive],
[ProductID],
[MaxPT],
[MaxDiscount],
[IsSync],
[IsHidden],
[IsDisabled],
[SettingLevel],
[DisplayOrder],
[SettingStatus],
[IntervalValue],
[RealProductId],
[MaxChoice],
[ProductSettingID],
[Parent_ProductSettingID],
[Child_DisplayOrder],
[SubType] )
 VALUES
  --SettingType = 8 : BetLimit Level SportType/GameGroup
  ( 8, @sportType,5100,0,@productID,90.00,0.01000000,1,0,0,2,5,@settingstatus,NULL,@RealProductID,NULL,@ProductSettingID,NULL,NULL,NULL)

--GameGroup
INSERT INTO GameGroup ([GameGroupID], [RefSportType], [RefBetType], [GroupName], [IsDeposit])
VALUES 
(41,158,5100,'Level 1',0) ,
(42,158,5100,'Level 1',1)


--DECLARE @MaxGameGroupID INT 
--SELECT @MaxGameGroupID = MAX(GameGroupID) FROM GameGroup (NOLOCK)

--Create Table #Temp ([GameGroupID] INT, [RefSportType] SmallInt, [RefBetType] Int, [GroupName] nvarchar(100), [IsDeposit] bit)
--Insert into #Temp
--VALUES
--  ( 1 + @MaxGameGroupID , 158, 5100, 'Level 1', 0),
--  ( 2 + @MaxGameGroupID , 158, 5100, 'Level 1', 1)
----GameGroup
--INSERT INTO GameGroup ([GameGroupID], [RefSportType], [RefBetType], [GroupName], [IsDeposit])
--SELECT * FROM #Temp

--DROP TABLE #Temp