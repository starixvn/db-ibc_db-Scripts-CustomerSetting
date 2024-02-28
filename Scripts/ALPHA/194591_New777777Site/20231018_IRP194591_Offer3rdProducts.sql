/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231018@Johnson
	Task: Offer 3rd products for new site 777777, currency PC
	DB: DBCUST/CustDB
*/
DECLARE @siteID INT, @FollowedSite INT, @Currency INT, @FollowedCurrency INT
DECLARE @new_CreditGroupID tinyint

SELECT @new_CreditGroupID=Max(CreditGroupID) + 1
FROM exchange with (nolock)

UPDATE Site WITH(ROWLOCK)
SET SpecialPlatfrom = 4, 
	SpecialGroup = 2
WHERE site = '777777'

SELECT @siteID = SiteID 
FROM Site WITH(NOLOCK)
WHERE site = '777777'

SELECT @Currency = ExchangeId--PC
FROM exchange WITH(NOLOCK)
WHERE currency = 'PC'

SELECT @new_CreditGroupID

UPDATE exchange with (ROWLOCK)
SET CreditGroupID=@new_CreditGroupID
	,RepUpdateTime=SYSDATETIME()
WHERE currency= 'PC'

--Add data for StakeLevel
INSERT INTO dbo.StakeLevel (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ExchangeId, ResourceId, GameGroupID)
SELECT 2401, '1', '100,000', 1, 100000, @currency, NULL, 0 -- Allbet
UNION SELECT 3001, '200', '20,000', 200, 20000, @currency, NULL, 0--SA Gaming
UNION SELECT 3001, '300', '30,000', 300, 30000, @currency, NULL, 0
UNION SELECT 3001, '1,000', '100,000', 1000, 100000, @currency, NULL, 0
--PRO
UNION SELECT 3101, '200', '10,000', 200, 10000, @currency, NULL, 0--AE Sexy
UNION SELECT 3101, '300', '25,000', 300, 25000, @currency, NULL, 0
UNION SELECT 3101, '500', '50,000', 500, 50000, @currency, NULL, 0
UNION SELECT 3101, '1,000', '100,000', 1000, 100000, @currency, NULL, 0
/*
--SIT
UNION SELECT 3101, '50', '15,000', 50, 15000, @currency, NULL, 0--AE Sexy
UNION SELECT 3101, '100', '25,000', 100, 25000, @currency, NULL, 0
UNION SELECT 3101, '1,000', '50,000', 1000, 50000, @currency, NULL, 0
*/
UNION SELECT 3401, '1', '50,000', 1, 50000, @currency, NULL, 0--WM
UNION SELECT 3151, '1', '100,000', 1, 100000, @currency, NULL, 0--Yeebet
UNION SELECT 8201, '1', '50,000', 1, 50000, @currency, NULL, 0--FGG
UNION SELECT 3801, NULL, NULL, 0, 0, @currency, NULL, 25--VGaming
UNION SELECT 4601, '0.1', '20,000',0.1, 20000, @currency, NULL, 0--Virtual Games
UNION SELECT 4602, '0.1', '20,000',0.1, 20000, @currency, NULL, 0--Virtual Games
UNION SELECT 4605, '0.1', '20,000',0.1, 20000, @currency, NULL, 0--Virtual Games
UNION SELECT 5500, NULL, NULL, 0, 0, @currency, NULL, 32--Funky Games

--Add StakeLevelGroupDetail for VGaming
DECLARE @StakeLevelID INT

SELECT @StakeLevelID = StakeLevelID
FROM StakeLevel (NOLOCK)
WHERE GameTypeID = 3801 AND ExchangeId = @currency

INSERT INTO [dbo].[StakeLevelGroupDetail]
           ([StakeLevelID]
           ,[GameTypeID]
           ,[MinLabel]
           ,[MaxLabel]
           ,[MinStake]
           ,[MaxStake]
           ,[ParentTypeID]
           ,[MaxGameStake])
SELECT @StakeLevelID, 3801,'0.1', '50,000',0.1, 50000,NULL,NULL		   

--Add StakeLevelGroupDetail for Funky Games
SELECT @StakeLevelID = StakeLevelID
FROM StakeLevel (NOLOCK)
WHERE GameTypeID = 5500 AND ExchangeId = @currency

INSERT INTO [dbo].[StakeLevelGroupDetail]
           ([StakeLevelID]
           ,[GameTypeID]
           ,[MinLabel]
           ,[MaxLabel]
           ,[MinStake]
           ,[MaxStake]
           ,[ParentTypeID]
           ,[MaxGameStake])
SELECT DISTINCT @StakeLevelID, GameTypeID,'1', '25,000',1, 25000,NULL,NULL	
FROM  StakeLevelGroupDetail (NOLOCK) 
WHERE GameTypeID BETWEEN 5500 and 5528
	
INSERT INTO [dbo].[ProductStakeLevelGroup]
           ([Sporttype]
           ,[GameGroupID]
           ,[MinBet]
           ,[MaxBet]
           ,[CreditGroupID]
           ,[Remark]
           ,[RepUpdateTime]
           ,[isDeleted])
SELECT 165, 2, 0.1, 10000, @new_CreditGroupID, NULL, SYSDATETIME(), 0	--Arcadia Gaming
UNION SELECT 247, 1, 0.1, 100000, @new_CreditGroupID, NULL, SYSDATETIME(), 0 --SG Slot		   
UNION SELECT 247, 2, 0.1, 25000, @new_CreditGroupID, NULL, SYSDATETIME(), 0 --SG Others		   
UNION SELECT 234, 1, 0.1, 50000, @new_CreditGroupID, NULL, SYSDATETIME(), 0 --Joker Slot		   
UNION SELECT 167, 1, 0.1, 50000, @new_CreditGroupID, NULL, SYSDATETIME(), 0 --CG Slot	
UNION SELECT 172, 1, 0.1, 100000, @new_CreditGroupID, NULL, SYSDATETIME(), 0 --AdvantPlay Slot	
UNION SELECT 174, 2, 0.1, 5000, @new_CreditGroupID, NULL, SYSDATETIME(), 0 --AdvantPlay Mini Others	
UNION SELECT 237, 2, 0.1, 50000, @new_CreditGroupID, NULL, SYSDATETIME(), 0 --MaxGame Others	
UNION SELECT 156, 1, 0.1, 50000, @new_CreditGroupID, NULL, SYSDATETIME(), 0 --SEAL Entertainment Slot	
UNION SELECT 155, 1, 0.1, 100000, @new_CreditGroupID, NULL, SYSDATETIME(), 0 --MG-RNG Slot	
UNION SELECT 155, 2, 0.1, 25000, @new_CreditGroupID, NULL, SYSDATETIME(), 0 --MG-RNG Others	
UNION SELECT 158, 1, 0.1, 50000, @new_CreditGroupID, NULL, SYSDATETIME(), 0 --Jili Slot	
UNION SELECT 158, 2, 0.1, 25000, @new_CreditGroupID, NULL, SYSDATETIME(), 0 --Jili Others	

INSERT INTO [dbo].[ProductStatusSiteCurrency]
           ([SportType]
           ,[BetType]
           ,[Currency]
           ,[SiteID]
           ,[IsHidden]
           ,[IsDisabled]
           ,[HasSynced])
SELECT DISTINCT [SportType]
	   ,[BetType]
	   ,0 Currency
	   ,@siteID
	   ,CASE WHEN SportType IN (171,9911,9906,9904,169,220,222,224,202,176,245,9908,175,159,211,233,243,244,155,156,158,165,167,172,174,234,237,247) THEN 0 ELSE 1 END [IsHidden]
	   ,CASE WHEN SportType IN (171,9911,9906,9904,169,220,222,224,202,176,245,9908,175,159,211,233,243,244,155,156,158,165,167,172,174,234,237,247) THEN 0 ELSE 1 END [IsDisabled]
	   ,1 [HasSynced]
FROM ProductStatusSiteCurrency WITH(NOLOCK)

--Dont offer these sports
INSERT INTO [dbo].[SportNonOfferedSiteCurrency]
           ([SportType]
           ,[BetType]
           ,[Currency]
           ,[SiteID])
SELECT 242, 3201, 0, @siteID--IBCBet LCS
UNION SELECT 170, 3701, 0, @siteID--PP Live Casino
UNION SELECT 225, 5601, 0, @siteID--ION
UNION SELECT 241, 3300, 0, @siteID--BBIN
UNION SELECT 232, 6001, 0, @siteID--PG Soft
UNION SELECT 238, 7001, 0, @siteID--Habanero
UNION SELECT 248, 7000, 0, @siteID--PP
UNION SELECT 239, 3501, 0, @siteID--BG

INSERT INTO [dbo].[ProductLaunchedSiteCurrency]
           ([SiteID]
           ,[Currency]
           ,[SportType]
           ,[IsLaunched]
           ,[IsTest]
           ,[BetType]
           ,[LaunchedLevel])
SELECT DISTINCT @SiteID,
	0 Currency,
	SportType,
	CASE WHEN SportType IN (171,9911,9906,9904,169,220,222,224,202,176,245,9908,175,159,211,233,243,244,155,156,158,165,167,172,174,234,237,247) THEN 1 ELSE 0 END IsLaunched,
	0 IsTest,
	BetType,
	LaunchedLevel
FROM ProductLaunchedSiteCurrency WITH(NOLOCK)
UNION ALL 
--VS3
SELECT @SiteID, 0 Currency, 178 SportType,0 IsLaunched,0 IsTest,5302 BetType,0 LaunchedLevel
UNION ALL 
SELECT @SiteID, 0 Currency, 179 SportType,0 IsLaunched,0 IsTest,5302 BetType,0 LaunchedLevel


INSERT INTO ProductProfileSiteCurrency(SiteID,Currency,ProductSettingID)
SELECT @SiteID,0,9 --VGaming 
UNION SELECT @SiteID,0,250 --Comm GroupB 
UNION SELECT @SiteID,0,251 --Comm GroupC 
UNION SELECT @SiteID,0,252 --Comm GroupD 

--Add data for LossLimit_GlobalSetting
INSERT INTO [dbo].[LossLimit_GlobalSetting]
           ([ProductId]
           ,[ExchangeId]
           ,[MinLossLimit]
           ,[DefaultLossLimit])
SELECT 5, @Currency, 5000, 5000000--Virtual Sports
UNION SELECT 41, @Currency, 5000, 5000000--Live Casino
UNION SELECT 18, @Currency, 5000, 1000000--RNG Slot
UNION SELECT 44, @Currency, 5000, 1000000--RNG Lottery
UNION SELECT 64, @Currency, 5000, 1000000--Virtual Games
UNION SELECT 66, @Currency, 5000, 1000000--Vgaming
UNION SELECT 69, @Currency, 5000, 1000000--Bitcoin

--Add data for ProductBetSetting
INSERT INTO [dbo].[ProductBetSetting]
           ([Sporttype]
           ,[Bettype]
           ,[Currency]
           ,[MinBet]
           ,[IsDep]
           ,[MaxBet]
           ,[MaxPerMatch]
           ,[DefaultMinBet]
           ,[DefaultMaxBet]
           ,[DefaultMaxPerMatch])
SELECT [Sporttype]
	   ,[Bettype]
	   ,@Currency
	   ,CASE WHEN Sporttype = 175 THEN 1 ELSE [MinBet] END
	   ,[IsDep]
	   ,CASE WHEN Sporttype = 175 THEN 5000 ELSE [MaxBet] END
	   ,CASE WHEN Sporttype = 175 THEN 5000 ELSE [MaxPerMatch] END
	   ,CASE WHEN Sporttype = 175 THEN 1 ELSE [DefaultMinBet] END
	   ,CASE WHEN Sporttype = 175 THEN 5000 ELSE [DefaultMaxBet] END
	   ,CASE WHEN Sporttype = 175 THEN 5000 ELSE [DefaultMaxPerMatch] END
FROM ProductBetSetting WITH(NOLOCK)
WHERE currency = 20

