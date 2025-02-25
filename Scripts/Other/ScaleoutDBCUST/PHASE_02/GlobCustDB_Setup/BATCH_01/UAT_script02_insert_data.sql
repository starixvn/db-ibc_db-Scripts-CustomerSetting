/*<info serverAlias="DBGLOB-GlobCustDB" executers="" viewers="" isFunction="0"></info>*/
/*
	Created: DaveTruong
	Date: 20250120
	Task: Create table ScaleOut Custsetting on  GlobCustDB (NOT for SiteDBConfig, site) [RedmineID:#216870]
	DB: DBGLOB/GlobCustDB
*/
USE GlobCustDB
GO
/*Dep_Initial_BetSetting*/
INSERT INTO GlobCustDB.[dbo].[Dep_Initial_BetSetting]( ConfigID, Currency, SportType, BetType, MinBet, MaxBet, MaxPerMatch, MaxPerNumber, MaxPayoutPerMatch)
SELECT  ConfigID , Currency , SportType , BetType , MinBet , MaxBet , MaxPerMatch , MaxPerNumber , MaxPayoutPerMatch 
FROM CustDB.[dbo].[Dep_Initial_BetSetting] WITH(NOLOCK);

/*Dep_Initial_ProductConfig*/
SET IDENTITY_INSERT [dbo].[Dep_Initial_ProductConfig] ON; 
INSERT INTO GlobCustDB.[dbo].[Dep_Initial_ProductConfig]( ConfigID, ProductID, SportTypeList, BetTypeList, Site, Currency, StartTime, EndTime, IsTest, Status, CurrentStep, ProcessedStep, Remark)
SELECT  ConfigID , ProductID , SportTypeList , BetTypeList , Site , Currency , StartTime , EndTime , IsTest , Status , CurrentStep , ProcessedStep , Remark 
FROM CustDB.[dbo].[Dep_Initial_ProductConfig] WITH(NOLOCK);
SET IDENTITY_INSERT [dbo].[Dep_Initial_ProductConfig] OFF; 

/*Dep_Initial_ProductConfig_Detail*/
INSERT INTO GlobCustDB.[dbo].[Dep_Initial_ProductConfig_Detail]( ConfigID, SportType, BetType, IsLive, SettingType, IsDefault, DefaultValueSuper, DefaultValueMaster, DefaultValueAgent, DefaultValueMember, SpecialRequirement)
SELECT  ConfigID , SportType , BetType , IsLive , SettingType , IsDefault , DefaultValueSuper , DefaultValueMaster , DefaultValueAgent , DefaultValueMember , SpecialRequirement 
FROM CustDB.[dbo].[Dep_Initial_ProductConfig_Detail] WITH(NOLOCK);

/*Dep_Initial_StepByConfig*/
SET IDENTITY_INSERT [dbo].[Dep_Initial_StepByConfig] ON; 
INSERT INTO GlobCustDB.[dbo].[Dep_Initial_StepByConfig]( StepID, IsScanCustomer, SortOrder)
SELECT  StepID , IsScanCustomer , SortOrder 
FROM CustDB.[dbo].[Dep_Initial_StepByConfig] WITH(NOLOCK);
SET IDENTITY_INSERT [dbo].[Dep_Initial_StepByConfig] OFF; 

/*Dep_ProductBetSetting*/
INSERT INTO GlobCustDB.[dbo].[Dep_ProductBetSetting]( Sporttype, Bettype, Currency, MinBet, MaxBet, MaxPerMatch, DefaultMinBet, DefaultMaxBet, DefaultMaxPerMatch, MaxPerBall, RepUpdateTime)
SELECT  Sporttype , Bettype , Currency , MinBet , MaxBet , MaxPerMatch , DefaultMinBet , DefaultMaxBet , DefaultMaxPerMatch , MaxPerBall , RepUpdateTime 
FROM CustDB.[dbo].[Dep_ProductBetSetting] WITH(NOLOCK);

/*Dep_ProductSetting*/
INSERT INTO GlobCustDB.[dbo].[Dep_ProductSetting]( ProductSettingID, ProductID, SettingType, TemplateID, DisplayOrder, SettingLevel, RepUpdateTime)
SELECT  ProductSettingID , ProductID , SettingType , TemplateID , DisplayOrder , SettingLevel , RepUpdateTime 
FROM CustDB.[dbo].[Dep_ProductSetting] WITH(NOLOCK);

/*Dep_ProductSettingDetail*/
INSERT INTO GlobCustDB.[dbo].[Dep_ProductSettingDetail]( ProductSettingID, SportType, BetType, IsLive, MaxDefaultValue, SettingStatus, MinDefaultValue, IsApplyBA, RepUpdateTime)
SELECT  ProductSettingID , SportType , BetType , IsLive , MaxDefaultValue , SettingStatus , MinDefaultValue , IsApplyBA , RepUpdateTime 
FROM CustDB.[dbo].[Dep_ProductSettingDetail] WITH(NOLOCK);

/*Dep_ProductSettingType*/
INSERT INTO GlobCustDB.[dbo].[Dep_ProductSettingType]( SettingType, SettingName, SettingNameDetail)
SELECT  SettingType , SettingName , SettingNameDetail 
FROM CustDB.[dbo].[Dep_ProductSettingType] WITH(NOLOCK);

/*Dep_ProductStakeLevelGroup*/
INSERT INTO GlobCustDB.[dbo].[Dep_ProductStakeLevelGroup]( Sporttype, GameGroupID, MinBet, MaxBet, LicenseeGroupID, Remark, RepUpdateTime, SiteID, isDeleted)
SELECT  Sporttype , GameGroupID , MinBet , MaxBet , LicenseeGroupID , Remark , RepUpdateTime , SiteID , isDeleted 
FROM CustDB.[dbo].[Dep_ProductStakeLevelGroup] WITH(NOLOCK);

/*Dep_ProductStatusProfile*/
INSERT INTO GlobCustDB.[dbo].[Dep_ProductStatusProfile]( Sporttype, Bettype, bitmapOrder, RepUpdateTime)
SELECT  Sporttype , Bettype , bitmapOrder , RepUpdateTime 
FROM CustDB.[dbo].[Dep_ProductStatusProfile] WITH(NOLOCK);

/*Dep_StakeLevel*/
INSERT INTO GlobCustDB.[dbo].[Dep_StakeLevel]( StakeLevelID, GameTypeID, GameGroupID, MinLabel, MaxLabel, MinStake, MaxStake, ExchangeID, ResourceId, SiteID, RepUpdateTime)
SELECT  StakeLevelID , GameTypeID , GameGroupID , MinLabel , MaxLabel , MinStake , MaxStake , ExchangeID , ResourceId , SiteID , RepUpdateTime 
FROM CustDB.[dbo].[Dep_StakeLevel] WITH(NOLOCK);

/*Dep_StakeLevel_History*/
INSERT INTO GlobCustDB.[dbo].[Dep_StakeLevel_History]( StakeLevelID, GameTypeID, MaxLabel, MaxStake, SiteID, UpdateTime)
SELECT  StakeLevelID , GameTypeID , MaxLabel , MaxStake , SiteID , UpdateTime 
FROM CustDB.[dbo].[Dep_StakeLevel_History] WITH(NOLOCK);

/*Dep_StakeLevelGroupDetail*/
INSERT INTO GlobCustDB.[dbo].[Dep_StakeLevelGroupDetail]( StakeLevelID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ParentTypeID, MaxGameStake, RepUpdateTime)
SELECT  StakeLevelID , GameTypeID , MinLabel , MaxLabel , MinStake , MaxStake , ParentTypeID , MaxGameStake , RepUpdateTime 
FROM CustDB.[dbo].[Dep_StakeLevelGroupDetail] WITH(NOLOCK);

/*Dep_StakeLevelGroupDetail_History*/
INSERT INTO GlobCustDB.[dbo].[Dep_StakeLevelGroupDetail_History]( StakeLevelID, GameTypeID, MaxLabel, MaxStake, MaxGameStake, UpdateTime)
SELECT  StakeLevelID , GameTypeID , MaxLabel , MaxStake , MaxGameStake , UpdateTime 
FROM CustDB.[dbo].[Dep_StakeLevelGroupDetail_History] WITH(NOLOCK);

/*Dep_UMConfig*/
INSERT INTO GlobCustDB.[dbo].[Dep_UMConfig]( FunctionType, ProductID, SettingType, LicenseeID, BeginTime, EndTime/*, Time_Stamp*/)
SELECT  FunctionType , ProductID , SettingType , LicenseeID , BeginTime , EndTime /*, Time_Stamp */
FROM CustDB.[dbo].[Dep_UMConfig] WITH(NOLOCK);

/*DomainManagement*/
SET IDENTITY_INSERT [dbo].[DomainManagement] ON; 
INSERT INTO GlobCustDB.[dbo].[DomainManagement]( DomainID, Domain, System, Site, BrandName, Status, ExpiredDate, LastUpdateTime, RestrictedCountries, Remark, isDeleted, RepUpdateTime)
SELECT  DomainID , Domain , System , Site , BrandName , Status , ExpiredDate , LastUpdateTime , RestrictedCountries , Remark , isDeleted , RepUpdateTime 
FROM CustDB.[dbo].[DomainManagement] WITH(NOLOCK);
SET IDENTITY_INSERT [dbo].[DomainManagement] OFF; 

/*GameGroup*/
INSERT INTO GlobCustDB.[dbo].[GameGroup](	 GameGroupID, RefSportType, RefBetType, GroupName, IsDeposit, RepUpdateTime)SELECT 	 GameGroupID , RefSportType , RefBetType , GroupName , IsDeposit , RepUpdateTime FROM CustDB.[dbo].[GameGroup] WITH(NOLOCK);

/*GameLaunchPerCurrency*/
INSERT INTO GlobCustDB.[dbo].[GameLaunchPerCurrency]( SportType, BetType, Currency, IsLaunched, IsTest, RepUpdateTime)
SELECT  SportType , BetType , Currency , IsLaunched , IsTest , RepUpdateTime 
FROM CustDB.[dbo].[GameLaunchPerCurrency] WITH(NOLOCK);

/*GameLaunchPerSite*/
INSERT INTO GlobCustDB.[dbo].[GameLaunchPerSite]( SportType, BetType, SiteID, IsLaunched, IsTest, RepUpdateTime)
SELECT  SportType , BetType , SiteID , IsLaunched , IsTest , RepUpdateTime 
FROM CustDB.[dbo].[GameLaunchPerSite] WITH(NOLOCK);

/*LossLimit_GlobalSetting*/
INSERT INTO GlobCustDB.[dbo].[LossLimit_GlobalSetting]( ProductId, ExchangeId, MinLossLimit, DefaultLossLimit, RepUpdateTime)
SELECT  ProductId , ExchangeId , MinLossLimit , DefaultLossLimit , RepUpdateTime 
FROM CustDB.[dbo].[LossLimit_GlobalSetting] WITH(NOLOCK);

/*MaxPayoutGlobalSetting*/
INSERT INTO GlobCustDB.[dbo].[MaxPayoutGlobalSetting]( SportType, BetType, Currency, SingleMatchParlay, Combo2, Combo35, ComboOver6, SettingStatus, RepUpdateTime)
SELECT  SportType , BetType , Currency , SingleMatchParlay , Combo2 , Combo35 , ComboOver6 , SettingStatus , RepUpdateTime 
FROM CustDB.[dbo].[MaxPayoutGlobalSetting] WITH(NOLOCK);

/*PlayCurrencySetting*/
SET IDENTITY_INSERT [dbo].[PlayCurrencySetting] ON; 
INSERT INTO GlobCustDB.[dbo].[PlayCurrencySetting]( ID, SiteId, SiteName, SportType, MemberCurrency, PlayCurrency, FromDate, ToDate, RepUpdateTime)
SELECT  ID , SiteId , SiteName , SportType , MemberCurrency , PlayCurrency , FromDate , ToDate , RepUpdateTime 
FROM CustDB.[dbo].[PlayCurrencySetting] WITH(NOLOCK);
SET IDENTITY_INSERT [dbo].[PlayCurrencySetting] OFF; 

/*ProductBetSetting*/
INSERT INTO GlobCustDB.[dbo].[ProductBetSetting]( Sporttype, Bettype, Currency, MinBet, IsDep, MaxBet, MaxPerMatch, DefaultMinBet, DefaultMaxBet, DefaultMaxPerMatch, RepUpdateTime)
SELECT  Sporttype , Bettype , Currency , MinBet , IsDep , MaxBet , MaxPerMatch , DefaultMinBet , DefaultMaxBet , DefaultMaxPerMatch , RepUpdateTime 
FROM CustDB.[dbo].[ProductBetSetting] WITH(NOLOCK);

/*ProductStakeLevelGroup*/
INSERT INTO GlobCustDB.[dbo].[ProductStakeLevelGroup]( Sporttype, GameGroupID, MinBet, MaxBet, CreditGroupID, Remark, RepUpdateTime, isDeleted)
SELECT  Sporttype , GameGroupID , MinBet , MaxBet , CreditGroupID , Remark , RepUpdateTime , isDeleted 
FROM CustDB.[dbo].[ProductStakeLevelGroup] WITH(NOLOCK);

/*SettingSystem*/
INSERT INTO GlobCustDB.[dbo].[SettingSystem]( SystemID, SystemName, Description, SystemPrefix)
SELECT  SystemID , SystemName , Description , SystemPrefix 
FROM CustDB.[dbo].[SettingSystem] WITH(NOLOCK);


/*SportBettypeSettingMatrix*/
INSERT INTO GlobCustDB.[dbo].[SportBettypeSettingMatrix]( SportType, BetType, isLicensee, isLive, Site, isActive, SportTypeRefPT, BetTypeRefPT, isLivePT, TablePT, SportTypeRefComm, BetTypeRefComm, TableComm, SportTypeRefBetSetting, BetTypeRefBetSetting, TableBetSetting, IsLiveComm, IsLiveBetSetting, TableBettrans, SporttypeRefWinlossLimit, BettypeRefWinlossLimit, RealProductId, isDeleted, RepUpdateTime, ProductID)
SELECT  SportType , BetType , isLicensee , isLive , Site , isActive , SportTypeRefPT , BetTypeRefPT , isLivePT , TablePT , SportTypeRefComm , BetTypeRefComm , TableComm , SportTypeRefBetSetting , BetTypeRefBetSetting , TableBetSetting , IsLiveComm , IsLiveBetSetting , TableBettrans , SporttypeRefWinlossLimit , BettypeRefWinlossLimit , RealProductId , isDeleted , RepUpdateTime , ProductID 
FROM CustDB.[dbo].[SportBettypeSettingMatrix] WITH(NOLOCK);

/*StakeLevel*/
SET IDENTITY_INSERT [dbo].[StakeLevel] ON; 
INSERT INTO GlobCustDB.[dbo].[StakeLevel]( StakeLevelID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ExchangeId, ResourceId, GameGroupID, RepUpdateTime)
SELECT  StakeLevelID , GameTypeID , MinLabel , MaxLabel , MinStake , MaxStake , ExchangeId , ResourceId , GameGroupID , RepUpdateTime 
FROM CustDB.[dbo].[StakeLevel] WITH(NOLOCK);
SET IDENTITY_INSERT [dbo].[StakeLevel] OFF; 

/*StakeLevel_History*/
INSERT INTO GlobCustDB.[dbo].[StakeLevel_History]( StakeLevelID, GameTypeID, MaxLabel, MaxStake, UpdateTime)
SELECT  StakeLevelID , GameTypeID , MaxLabel , MaxStake , UpdateTime 
FROM CustDB.[dbo].[StakeLevel_History] WITH(NOLOCK);
