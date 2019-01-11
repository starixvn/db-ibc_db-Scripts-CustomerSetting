/*
	Created: 20190109@Winnie
	Task: Insert product profile for Poker Video Game
	DB: DBCUST/CustDB
*/

-- BEGIN STEP 1: DEPLOY THIS SCRIPT ON DBCUST/CustDB	 --
-----------------------------------------------------------
USE CustDB
GO

DECLARE @SettingStatus TINYINT, 
		@ProductID INT,	
		@IsSync BIT, 
		@IsHidden BIT, 
		@IsDisabled BIT 
	
SELECT @SettingStatus = 1 --0: Production, 1: UAT, 2: Hide
SELECT @ProductID = 33
SELECT @IsSync = 1
SELECT @IsHidden = 0
SELECT @IsDisabled = 0


INSERT INTO	dbo.ProductSettingDetail
		(	SettingType, SportType	, BetType	, IsLive, ProductID		, MaxPT	, MaxDiscount	, IsSync	, IsHidden	, IsDisabled	, SettingLevel, DisplayOrder, SettingStatus, IntervalValue)
VALUES	
--Status Setting																																				
		(	13         , 165	, 1901		, 0     , @ProductID	, NULL	, NULL			, @IsSync	, @IsHidden	, @IsDisabled	, 3           , 1           , @SettingStatus, NULL)

--Bet limit																																				
	,	(	8		  , 165		, 1901		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 1            , 5           , @SettingStatus, NULL)


-- BEGIN STEP 2: DEPLOY THIS SCRIPT ON DBCUST/CustDB	 --
-----------------------------------------------------------

INSERT INTO	dbo.ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
SELECT 165,1901,19

INSERT INTO [dbo].[GameGroup]
           ([GameGroupID]
           ,[RefSportType]
           ,[RefBetType]
           ,[GroupName]
           ,[IsDeposit])
     VALUES
           (9
           ,165
           ,1901
           ,'Level 1'
           ,0)

INSERT INTO [dbo].[StakeLevel]
           ([GameTypeID]
           ,[MinLabel]
           ,[MaxLabel]
           ,[MinStake]
           ,[MaxStake]
           ,[ExchangeId]
           ,[ResourceId]
           ,[GameGroupID])
     VALUES
           (1901
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,20
           ,NULL
           ,9)

INSERT INTO [dbo].[StakeLevel]
           ([GameTypeID]
           ,[MinLabel]
           ,[MaxLabel]
           ,[MinStake]
           ,[MaxStake]
           ,[ExchangeId]
           ,[ResourceId]
           ,[GameGroupID])
     VALUES
           (1901
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,16
           ,NULL
           ,9)


INSERT INTO [dbo].[StakeLevel]
           ([GameTypeID]
           ,[MinLabel]
           ,[MaxLabel]
           ,[MinStake]
           ,[MaxStake]
           ,[ExchangeId]
           ,[ResourceId]
           ,[GameGroupID])
     VALUES
           (1901
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,64
           ,NULL
           ,9)

INSERT INTO [dbo].[StakeLevelGroupDetail]
           ([StakeLevelID]
           ,[GameTypeID]
           ,[MinLabel]
           ,[MaxLabel]
           ,[MinStake]
           ,[MaxStake]  )
SELECT
           StakeLevelID
           ,1901
           ,'0.1'
           ,'50'
           ,0.1
           ,50
FROM  StakeLevel (NOLOCK) WHERE GameGroupID=9 AND GameTypeID=1901 

GO
   
