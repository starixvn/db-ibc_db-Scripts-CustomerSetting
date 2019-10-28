/*
	Created: 20191028@Winnie
	Task: Insert product profile for SG
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
SELECT @ProductID = 22
SELECT @IsSync = 1
SELECT @IsHidden = 0
SELECT @IsDisabled = 0

--PT Setting
INSERT INTO	dbo.ProductSettingDetail
		(	SettingType, SportType	, BetType	, IsLive, ProductID		, MaxPT	, MaxDiscount	, IsSync	, IsHidden	, IsDisabled	, SettingLevel, DisplayOrder, SettingStatus, IntervalValue)
VALUES	

--Bet limit																																				
		(	8		  , 247		, 4301 		, 0     , @ProductID	, NULL	, NULL			, NULL		, NULL		, NULL			, 2            , 5           , @SettingStatus, NULL)

-- BEGIN STEP 2: DEPLOY THIS SCRIPT ON DBCUST/CustDB	 --
-----------------------------------------------------------
INSERT INTO GameGroup(GameGroupID,	RefSportType,	RefBetType,	GroupName,	IsDeposit)
VALUES(12,	247,	4301,	'Level 1',	0)

INSERT INTO StakeLevel(GameTypeID	,GameGroupID,	MinLabel,	MaxLabel,	MinStake,	MaxStake,	ExchangeID,	ResourceID)
SELECT 4301,	12,	NULL,	NULL,	NULL,	NULL,	exchangeid	,NULL
FROM exchange WITH(NOLOCK)
WHERE exchangeid=20

INSERT INTO StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT StakeLevelID,	GameTypeID,	'0.25',	' 125.00',	 0.25 , 125.00 
FROM StakeLevel WITH(NOLOCK) WHERE GameTypeID=4301 AND GameGroupID=12 AND ExchangeId=20


