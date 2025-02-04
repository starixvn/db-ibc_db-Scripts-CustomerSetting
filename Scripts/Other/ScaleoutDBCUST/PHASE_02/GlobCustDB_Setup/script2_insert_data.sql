/*<info serverAlias="DBGLOB-GlobCustDB" executers="" viewers="" isFunction="0"></info>*/
/*
	Created: DaveTruong
	Date: 20250120
	Task: Create table ScaleOut Custsetting on  GlobCustDB [RedmineID:#216870]
	DB: DBGLOB/GlobCustDB
*/
USE GlobCustDB
GO


INSERT INTO GlobCustDB.[dbo].[Acc_SuperPrefix]( GroupName, Prefix, AllowNewSuper, RepUpdateTime)
SELECT  GroupName , Prefix , AllowNewSuper , RepUpdateTime 
FROM CustDB.[dbo].[Acc_SuperPrefix] WITH(NOLOCK);


SET IDENTITY_INSERT [dbo].[BetLimitControlTypeDetails] ON; 
INSERT INTO GlobCustDB.[dbo].[BetLimitControlTypeDetails]( ID, BetLimitTypeID, ProductID, Sporttype, Bettype, LeagueGroupID, LeagueID, RepUpdateTime)
SELECT  ID , BetLimitTypeID , ProductID , Sporttype , Bettype , LeagueGroupID , LeagueID , RepUpdateTime 
FROM CustDB.[dbo].[BetLimitControlTypeDetails] WITH(NOLOCK);
SET IDENTITY_INSERT [dbo].[BetLimitControlTypeDetails] OFF; 


INSERT INTO GlobCustDB.[dbo].[CategoryConfig]( CategoryID, CategoryName, OfferDeposit, CategoryNameCS, CustomerClass, HiddenSite, RepUpdateTime)
SELECT  CategoryID , CategoryName , OfferDeposit , CategoryNameCS , CustomerClass , HiddenSite , RepUpdateTime 
FROM CustDB.[dbo].[CategoryConfig] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[DangerLevelPolicy]( SportType, DangerLevel, ActionType, Value, LeagueGroupID)
SELECT  SportType , DangerLevel , ActionType , Value , LeagueGroupID 
FROM CustDB.[dbo].[DangerLevelPolicy] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[Dep_Initial_BetSetting]( ConfigID, Currency, SportType, BetType, MinBet, MaxBet, MaxPerMatch, MaxPerNumber, MaxPayoutPerMatch)
SELECT  ConfigID , Currency , SportType , BetType , MinBet , MaxBet , MaxPerMatch , MaxPerNumber , MaxPayoutPerMatch 
FROM CustDB.[dbo].[Dep_Initial_BetSetting] WITH(NOLOCK);


SET IDENTITY_INSERT [dbo].[Dep_Initial_ProductConfig] ON; 
INSERT INTO GlobCustDB.[dbo].[Dep_Initial_ProductConfig]( ConfigID, ProductID, SportTypeList, BetTypeList, Site, Currency, StartTime, EndTime, IsTest, Status, CurrentStep, ProcessedStep, Remark)
SELECT  ConfigID , ProductID , SportTypeList , BetTypeList , Site , Currency , StartTime , EndTime , IsTest , Status , CurrentStep , ProcessedStep , Remark 
FROM CustDB.[dbo].[Dep_Initial_ProductConfig] WITH(NOLOCK);
SET IDENTITY_INSERT [dbo].[Dep_Initial_ProductConfig] OFF; 


INSERT INTO GlobCustDB.[dbo].[Dep_Initial_ProductConfig_Detail]( ConfigID, SportType, BetType, IsLive, SettingType, IsDefault, DefaultValueSuper, DefaultValueMaster, DefaultValueAgent, DefaultValueMember, SpecialRequirement)
SELECT  ConfigID , SportType , BetType , IsLive , SettingType , IsDefault , DefaultValueSuper , DefaultValueMaster , DefaultValueAgent , DefaultValueMember , SpecialRequirement 
FROM CustDB.[dbo].[Dep_Initial_ProductConfig_Detail] WITH(NOLOCK);


SET IDENTITY_INSERT [dbo].[Dep_Initial_StepByConfig] ON; 
INSERT INTO GlobCustDB.[dbo].[Dep_Initial_StepByConfig]( StepID, IsScanCustomer, SortOrder)
SELECT  StepID , IsScanCustomer , SortOrder 
FROM CustDB.[dbo].[Dep_Initial_StepByConfig] WITH(NOLOCK);
SET IDENTITY_INSERT [dbo].[Dep_Initial_StepByConfig] OFF; 


INSERT INTO GlobCustDB.[dbo].[Dep_ProductBetSetting]( Sporttype, Bettype, Currency, MinBet, MaxBet, MaxPerMatch, DefaultMinBet, DefaultMaxBet, DefaultMaxPerMatch, MaxPerBall, RepUpdateTime)
SELECT  Sporttype , Bettype , Currency , MinBet , MaxBet , MaxPerMatch , DefaultMinBet , DefaultMaxBet , DefaultMaxPerMatch , MaxPerBall , RepUpdateTime 
FROM CustDB.[dbo].[Dep_ProductBetSetting] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[Dep_ProductSetting]( ProductSettingID, ProductID, SettingType, TemplateID, DisplayOrder, SettingLevel, RepUpdateTime)
SELECT  ProductSettingID , ProductID , SettingType , TemplateID , DisplayOrder , SettingLevel , RepUpdateTime 
FROM CustDB.[dbo].[Dep_ProductSetting] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[Dep_ProductSettingDetail]( ProductSettingID, SportType, BetType, IsLive, MaxDefaultValue, SettingStatus, MinDefaultValue, IsApplyBA, RepUpdateTime)
SELECT  ProductSettingID , SportType , BetType , IsLive , MaxDefaultValue , SettingStatus , MinDefaultValue , IsApplyBA , RepUpdateTime 
FROM CustDB.[dbo].[Dep_ProductSettingDetail] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[Dep_ProductSettingType]( SettingType, SettingName, SettingNameDetail)
SELECT  SettingType , SettingName , SettingNameDetail 
FROM CustDB.[dbo].[Dep_ProductSettingType] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[Dep_ProductStakeLevelGroup]( Sporttype, GameGroupID, MinBet, MaxBet, LicenseeGroupID, Remark, RepUpdateTime, SiteID, isDeleted)
SELECT  Sporttype , GameGroupID , MinBet , MaxBet , LicenseeGroupID , Remark , RepUpdateTime , SiteID , isDeleted 
FROM CustDB.[dbo].[Dep_ProductStakeLevelGroup] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[Dep_ProductStatusProfile]( Sporttype, Bettype, bitmapOrder, RepUpdateTime)
SELECT  Sporttype , Bettype , bitmapOrder , RepUpdateTime 
FROM CustDB.[dbo].[Dep_ProductStatusProfile] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[Dep_StakeLevel]( StakeLevelID, GameTypeID, GameGroupID, MinLabel, MaxLabel, MinStake, MaxStake, ExchangeID, ResourceId, SiteID, RepUpdateTime)
SELECT  StakeLevelID , GameTypeID , GameGroupID , MinLabel , MaxLabel , MinStake , MaxStake , ExchangeID , ResourceId , SiteID , RepUpdateTime 
FROM CustDB.[dbo].[Dep_StakeLevel] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[Dep_StakeLevel_History]( StakeLevelID, GameTypeID, MaxLabel, MaxStake, SiteID, UpdateTime)
SELECT  StakeLevelID , GameTypeID , MaxLabel , MaxStake , SiteID , UpdateTime 
FROM CustDB.[dbo].[Dep_StakeLevel_History] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[Dep_StakeLevelGroupDetail]( StakeLevelID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ParentTypeID, MaxGameStake, RepUpdateTime)
SELECT  StakeLevelID , GameTypeID , MinLabel , MaxLabel , MinStake , MaxStake , ParentTypeID , MaxGameStake , RepUpdateTime 
FROM CustDB.[dbo].[Dep_StakeLevelGroupDetail] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[Dep_StakeLevelGroupDetail_History]( StakeLevelID, GameTypeID, MaxLabel, MaxStake, MaxGameStake, UpdateTime)
SELECT  StakeLevelID , GameTypeID , MaxLabel , MaxStake , MaxGameStake , UpdateTime 
FROM CustDB.[dbo].[Dep_StakeLevelGroupDetail_History] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[Dep_UMConfig]( FunctionType, ProductID, SettingType, LicenseeID, BeginTime, EndTime/*, Time_Stamp*/)
SELECT  FunctionType , ProductID , SettingType , LicenseeID , BeginTime , EndTime /*, Time_Stamp */
FROM CustDB.[dbo].[Dep_UMConfig] WITH(NOLOCK);


SET IDENTITY_INSERT [dbo].[DomainManagement] ON; 
INSERT INTO GlobCustDB.[dbo].[DomainManagement]( DomainID, Domain, System, Site, BrandName, Status, ExpiredDate, LastUpdateTime, RestrictedCountries, Remark, isDeleted, RepUpdateTime)
SELECT  DomainID , Domain , System , Site , BrandName , Status , ExpiredDate , LastUpdateTime , RestrictedCountries , Remark , isDeleted , RepUpdateTime 
FROM CustDB.[dbo].[DomainManagement] WITH(NOLOCK);
SET IDENTITY_INSERT [dbo].[DomainManagement] OFF; 


INSERT INTO GlobCustDB.[dbo].[GameLaunchPerCurrency]( SportType, BetType, Currency, IsLaunched, IsTest, RepUpdateTime)
SELECT  SportType , BetType , Currency , IsLaunched , IsTest , RepUpdateTime 
FROM CustDB.[dbo].[GameLaunchPerCurrency] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[GameLaunchPerSite]( SportType, BetType, SiteID, IsLaunched, IsTest, RepUpdateTime)
SELECT  SportType , BetType , SiteID , IsLaunched , IsTest , RepUpdateTime 
FROM CustDB.[dbo].[GameLaunchPerSite] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[GameRoundBetLimitSettings]( SportType, BetType, ProductID, GameRoundBetLimit, RepUpdateTime)
SELECT  SportType , BetType , ProductID , GameRoundBetLimit , RepUpdateTime 
FROM CustDB.[dbo].[GameRoundBetLimitSettings] WITH(NOLOCK);


SET IDENTITY_INSERT [dbo].[Initial_ProductConfig] ON; 
INSERT INTO GlobCustDB.[dbo].[Initial_ProductConfig]( ConfigID, ProductID, SportTypeList, BetTypeList, Site, Currency, StartTime, EndTime, IsTest, Status, CurrentStep, ProcessedStep, Remark)
SELECT  ConfigID , ProductID , SportTypeList , BetTypeList , Site , Currency , StartTime , EndTime , IsTest , Status , CurrentStep , ProcessedStep , Remark 
FROM CustDB.[dbo].[Initial_ProductConfig] WITH(NOLOCK);
SET IDENTITY_INSERT [dbo].[Initial_ProductConfig] OFF; 


INSERT INTO GlobCustDB.[dbo].[Initial_ProductConfig_Detail]( ConfigID, SportType, BetType, IsLive, SettingType, IsDefault, CopyFromSportType, CopyFromBetType, DefaultValueSuper, DefaultValueMaster, DefaultValueAgent, DefaultValueMember, SpecialRequirement)
SELECT  ConfigID , SportType , BetType , IsLive , SettingType , IsDefault , CopyFromSportType , CopyFromBetType , DefaultValueSuper , DefaultValueMaster , DefaultValueAgent , DefaultValueMember , SpecialRequirement 
FROM CustDB.[dbo].[Initial_ProductConfig_Detail] WITH(NOLOCK);


SET IDENTITY_INSERT [dbo].[Initial_StepByConfig] ON; 
INSERT INTO GlobCustDB.[dbo].[Initial_StepByConfig]( StepID, IsScanCustomer, SortOrder)
SELECT  StepID , IsScanCustomer , SortOrder 
FROM CustDB.[dbo].[Initial_StepByConfig] WITH(NOLOCK);
SET IDENTITY_INSERT [dbo].[Initial_StepByConfig] OFF; 


INSERT INTO GlobCustDB.[dbo].[LossLimit_GlobalSetting]( ProductId, ExchangeId, MinLossLimit, DefaultLossLimit, RepUpdateTime)
SELECT  ProductId , ExchangeId , MinLossLimit , DefaultLossLimit , RepUpdateTime 
FROM CustDB.[dbo].[LossLimit_GlobalSetting] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[MaxPayoutGlobalSetting]( SportType, BetType, Currency, SingleMatchParlay, Combo2, Combo35, ComboOver6, SettingStatus, RepUpdateTime)
SELECT  SportType , BetType , Currency , SingleMatchParlay , Combo2 , Combo35 , ComboOver6 , SettingStatus , RepUpdateTime 
FROM CustDB.[dbo].[MaxPayoutGlobalSetting] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[MsgError]( MsgID, MsgGroupID, MsgNameEN, MsgNameCT, MsgNameCS, MsgNameJP, MsgNameTH, MsgNameKO, MsgNameES, MsgNameVI, IsActive, MsgNameCN, MsgNameIN, RepUpdateTime)
SELECT  MsgID , MsgGroupID , MsgNameEN , MsgNameCT , MsgNameCS , MsgNameJP , MsgNameTH , MsgNameKO , MsgNameES , MsgNameVI , IsActive , MsgNameCN , MsgNameIN , RepUpdateTime 
FROM CustDB.[dbo].[MsgError] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[MsgErrorGroup]( MsgGroupID, MsgGroupName, RepUpdateTime)
SELECT  MsgGroupID , MsgGroupName , RepUpdateTime 
FROM CustDB.[dbo].[MsgErrorGroup] WITH(NOLOCK);


SET IDENTITY_INSERT [dbo].[PlayCurrencySetting] ON; 
INSERT INTO GlobCustDB.[dbo].[PlayCurrencySetting]( ID, SiteId, SiteName, SportType, MemberCurrency, PlayCurrency, FromDate, ToDate, RepUpdateTime)
SELECT  ID , SiteId , SiteName , SportType , MemberCurrency , PlayCurrency , FromDate , ToDate , RepUpdateTime 
FROM CustDB.[dbo].[PlayCurrencySetting] WITH(NOLOCK);
SET IDENTITY_INSERT [dbo].[PlayCurrencySetting] OFF; 


INSERT INTO GlobCustDB.[dbo].[ProblemAccountReason]( ReasonID, ReasonName, IsCN88, IsCredit, IsLicensee, ReasonNameCS, ReasonGroupID, RepUpdateTime)
SELECT  ReasonID , ReasonName , IsCN88 , IsCredit , IsLicensee , ReasonNameCS , ReasonGroupID , RepUpdateTime 
FROM CustDB.[dbo].[ProblemAccountReason] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[ProductBetSetting]( Sporttype, Bettype, Currency, MinBet, IsDep, MaxBet, MaxPerMatch, DefaultMinBet, DefaultMaxBet, DefaultMaxPerMatch, RepUpdateTime)
SELECT  Sporttype , Bettype , Currency , MinBet , IsDep , MaxBet , MaxPerMatch , DefaultMinBet , DefaultMaxBet , DefaultMaxPerMatch , RepUpdateTime 
FROM CustDB.[dbo].[ProductBetSetting] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[ProductGlobalSetting]( Sporttype, Bettype, MaxPositiontaking, Maxsdiscount, IsDep, RepUpdateTime)
SELECT  Sporttype , Bettype , MaxPositiontaking , Maxsdiscount , IsDep , RepUpdateTime 
FROM CustDB.[dbo].[ProductGlobalSetting] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[ProductLaunchedSiteCurrency]( SiteID, Currency, SportType, IsLaunched, IsTest, BetType, LaunchedLevel, RepUpdateTime)
SELECT  SiteID , Currency , SportType , IsLaunched , IsTest , BetType , LaunchedLevel , RepUpdateTime 
FROM CustDB.[dbo].[ProductLaunchedSiteCurrency] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[ProductProfileSiteCurrency]( SiteID, Currency, ProductSettingID, RepUpdateTime)
SELECT  SiteID , Currency , ProductSettingID , RepUpdateTime 
FROM CustDB.[dbo].[ProductProfileSiteCurrency] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[ProductProfileSiteCurrency_UAT]( SiteID, Currency, ProductSettingID, RepUpdateTime)
SELECT  SiteID , Currency , ProductSettingID , RepUpdateTime 
FROM CustDB.[dbo].[ProductProfileSiteCurrency_UAT] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[ProductSettingDetail]( SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, ProductSettingID, Parent_ProductSettingID, Child_DisplayOrder, SubType, RepUpdateTime)
SELECT  SettingType , SportType , BetType , IsLive , ProductID , MaxPT , MaxDiscount , IsSync , IsHidden , IsDisabled , SettingLevel , DisplayOrder , SettingStatus , IntervalValue , RealProductId , MaxChoice , ProductSettingID , Parent_ProductSettingID , Child_DisplayOrder , SubType , RepUpdateTime 
FROM CustDB.[dbo].[ProductSettingDetail] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[ProductSettingDetail_UAT]( SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, ProductSettingID, Parent_ProductSettingID, Child_DisplayOrder, SubType, RepUpdateTime)
SELECT  SettingType , SportType , BetType , IsLive , ProductID , MaxPT , MaxDiscount , IsSync , IsHidden , IsDisabled , SettingLevel , DisplayOrder , SettingStatus , IntervalValue , RealProductId , MaxChoice , ProductSettingID , Parent_ProductSettingID , Child_DisplayOrder , SubType , RepUpdateTime 
FROM CustDB.[dbo].[ProductSettingDetail_UAT] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[ProductSettingProfile]( ProductSettingID, SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, Parent_ProductSettingID, Child_DisplayOrder, SubType, GroupID, GroupType, GroupTypeOrder, SubGroupID, SubGroupOrder, CreationStatus, DisplayType, MarketType, RepUpdateTime)
SELECT  ProductSettingID , SettingType , SportType , BetType , IsLive , ProductID , MaxPT , MaxDiscount , IsSync , IsHidden , IsDisabled , SettingLevel , DisplayOrder , SettingStatus , IntervalValue , RealProductId , MaxChoice , Parent_ProductSettingID , Child_DisplayOrder , SubType , GroupID , GroupType , GroupTypeOrder , SubGroupID , SubGroupOrder , CreationStatus , DisplayType , MarketType , RepUpdateTime 
FROM CustDB.[dbo].[ProductSettingProfile] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[ProductSettingProfile_UAT]( ProductSettingID, SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue, RealProductId, MaxChoice, Parent_ProductSettingID, Child_DisplayOrder, SubType, GroupID, GroupType, GroupTypeOrder, SubGroupID, SubGroupOrder, CreationStatus, DisplayType, MarketType, RepUpdateTime)
SELECT  ProductSettingID , SettingType , SportType , BetType , IsLive , ProductID , MaxPT , MaxDiscount , IsSync , IsHidden , IsDisabled , SettingLevel , DisplayOrder , SettingStatus , IntervalValue , RealProductId , MaxChoice , Parent_ProductSettingID , Child_DisplayOrder , SubType , GroupID , GroupType , GroupTypeOrder , SubGroupID , SubGroupOrder , CreationStatus , DisplayType , MarketType , RepUpdateTime 
FROM CustDB.[dbo].[ProductSettingProfile_UAT] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[ProductSettingSystemDisplay]( SystemID, ProductID, SettingType, DisplayMode, RepUpdateTime)
SELECT  SystemID , ProductID , SettingType , DisplayMode , RepUpdateTime 
FROM CustDB.[dbo].[ProductSettingSystemDisplay] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[ProductSettingSystemDisplay_UAT]( SystemID, ProductID, SettingType, DisplayMode)
SELECT  SystemID , ProductID , SettingType , DisplayMode 
FROM CustDB.[dbo].[ProductSettingSystemDisplay_UAT] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[ProductSettingType]( SettingType, SettingName, SettingNameDetail)
SELECT  SettingType , SettingName , SettingNameDetail 
FROM CustDB.[dbo].[ProductSettingType] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[ProductSettingUpdateRestriction]( SystemID, ProductID, SettingType, ActorRoleID, TargetRoleID, ErrCode, RestrictionMode, RepUpdateTime)
SELECT  SystemID , ProductID , SettingType , ActorRoleID , TargetRoleID , ErrCode , RestrictionMode , RepUpdateTime 
FROM CustDB.[dbo].[ProductSettingUpdateRestriction] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[ProductStakeLevelGroup]( Sporttype, GameGroupID, MinBet, MaxBet, CreditGroupID, Remark, RepUpdateTime, isDeleted)
SELECT  Sporttype , GameGroupID , MinBet , MaxBet , CreditGroupID , Remark , RepUpdateTime , isDeleted 
FROM CustDB.[dbo].[ProductStakeLevelGroup] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[ProductStatusProfile]( Sporttype, Bettype, bitmapOrder, RepUpdateTime)
SELECT  Sporttype , Bettype , bitmapOrder , RepUpdateTime 
FROM CustDB.[dbo].[ProductStatusProfile] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[ProductStatusSiteCurrency]( SportType, BetType, Currency, SiteID, IsHidden, IsDisabled, HasSynced, RepUpdateTime)
SELECT  SportType , BetType , Currency , SiteID , IsHidden , IsDisabled , HasSynced , RepUpdateTime 
FROM CustDB.[dbo].[ProductStatusSiteCurrency] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[ProfilePicture]( ImageId, Image, RepUpdateTime, IsDeleted)
SELECT  ImageId , Image , RepUpdateTime , IsDeleted 
FROM CustDB.[dbo].[ProfilePicture] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[SettingSystem]( SystemID, SystemName, Description, SystemPrefix)
SELECT  SystemID , SystemName , Description , SystemPrefix 
FROM CustDB.[dbo].[SettingSystem] WITH(NOLOCK);


SET IDENTITY_INSERT [dbo].[Site] ON; 
INSERT INTO GlobCustDB.[dbo].[Site]( siteid, site, type, spreada, spreadb, spreadc, spreadd, spreade, spreadf, ServerID, isLicensee, isActive, isDeposit, SpecialGroup, BlockNewCust, UnblockTime, IsChinaView, RepUpdateTime, SiteDBGroupID, SiteLabel, SpecialPlatfrom, CustDBGroupID, SiteType)
SELECT  siteid , site , type , spreada , spreadb , spreadc , spreadd , spreade , spreadf , ServerID , isLicensee , isActive , isDeposit , SpecialGroup , BlockNewCust , UnblockTime , IsChinaView , RepUpdateTime , SiteDBGroupID , SiteLabel , SpecialPlatfrom , CustDBGroupID , SiteType 
FROM CustDB.[dbo].[Site] WITH(NOLOCK);
SET IDENTITY_INSERT [dbo].[Site] OFF; 


INSERT INTO GlobCustDB.[dbo].[SiteDBConfig]( SiteDBGroupID, LinkedServerName, ClientAccessName, AGIP, AWSProxyDomain, AWSProxyPort, RepUpdateTime, FQDN)
SELECT  SiteDBGroupID , LinkedServerName , ClientAccessName , AGIP , AWSProxyDomain , AWSProxyPort , RepUpdateTime , FQDN 
FROM CustDB.[dbo].[SiteDBConfig] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[SportBettypeSettingMatrix]( SportType, BetType, isLicensee, isLive, Site, isActive, SportTypeRefPT, BetTypeRefPT, isLivePT, TablePT, SportTypeRefComm, BetTypeRefComm, TableComm, SportTypeRefBetSetting, BetTypeRefBetSetting, TableBetSetting, IsLiveComm, IsLiveBetSetting, TableBettrans, SporttypeRefWinlossLimit, BettypeRefWinlossLimit, RealProductId, isDeleted, RepUpdateTime, ProductID)
SELECT  SportType , BetType , isLicensee , isLive , Site , isActive , SportTypeRefPT , BetTypeRefPT , isLivePT , TablePT , SportTypeRefComm , BetTypeRefComm , TableComm , SportTypeRefBetSetting , BetTypeRefBetSetting , TableBetSetting , IsLiveComm , IsLiveBetSetting , TableBettrans , SporttypeRefWinlossLimit , BettypeRefWinlossLimit , RealProductId , isDeleted , RepUpdateTime , ProductID 
FROM CustDB.[dbo].[SportBettypeSettingMatrix] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[SportNonOfferedSiteCurrency]( SportType, BetType, Currency, SiteID, RealProductID, RepUpdateTime)
SELECT  SportType , BetType , Currency , SiteID , RealProductID , RepUpdateTime 
FROM CustDB.[dbo].[SportNonOfferedSiteCurrency] WITH(NOLOCK);


SET IDENTITY_INSERT [dbo].[StakeLevel] ON; 
INSERT INTO GlobCustDB.[dbo].[StakeLevel]( StakeLevelID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ExchangeId, ResourceId, GameGroupID, RepUpdateTime)
SELECT  StakeLevelID , GameTypeID , MinLabel , MaxLabel , MinStake , MaxStake , ExchangeId , ResourceId , GameGroupID , RepUpdateTime 
FROM CustDB.[dbo].[StakeLevel] WITH(NOLOCK);
SET IDENTITY_INSERT [dbo].[StakeLevel] OFF; 


INSERT INTO GlobCustDB.[dbo].[StakeLevel_History]( StakeLevelID, GameTypeID, MaxLabel, MaxStake, UpdateTime)
SELECT  StakeLevelID , GameTypeID , MaxLabel , MaxStake , UpdateTime 
FROM CustDB.[dbo].[StakeLevel_History] WITH(NOLOCK);


SET IDENTITY_INSERT [dbo].[SystemSettings] ON; 
INSERT INTO GlobCustDB.[dbo].[SystemSettings]( VID, VName, VValue)
SELECT  VID , VName , VValue 
FROM CustDB.[dbo].[SystemSettings] WITH(NOLOCK);
SET IDENTITY_INSERT [dbo].[SystemSettings] OFF; 


SET IDENTITY_INSERT [dbo].[UMConfig] ON; 
INSERT INTO GlobCustDB.[dbo].[UMConfig]( ProductID, SportType, BetType, IsLive, SettingType, FunctionType, SiteID, Currency, SuperID, BeginTime, EndTime/*, Time_Stamp*/, ShowTime, LockAddingNew, ConfigID)
SELECT  ProductID , SportType , BetType , IsLive , SettingType , FunctionType , SiteID , Currency , SuperID , BeginTime , EndTime /*, Time_Stamp*/ , ShowTime , LockAddingNew , ConfigID 
FROM CustDB.[dbo].[UMConfig] WITH(NOLOCK);
SET IDENTITY_INSERT [dbo].[UMConfig] OFF; 


INSERT INTO GlobCustDB.[dbo].[Winlimit_ActionSetting]( ActionID, ActionName, RepUpdateTime)
SELECT  ActionID , ActionName , RepUpdateTime 
FROM CustDB.[dbo].[Winlimit_ActionSetting] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[Winlimit_GameGroupSetting]( ProductID, BetTypeID, GroupID, RepUpdateTime)
SELECT  ProductID , BetTypeID , GroupID , RepUpdateTime 
FROM CustDB.[dbo].[Winlimit_GameGroupSetting] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[Winlimit_Group]( GroupID, GroupName)
SELECT  GroupID , GroupName 
FROM CustDB.[dbo].[Winlimit_Group] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[Winlimit_LevelSetting]( LevelID, LevelName, LevelOrder, RepUpdateTime)
SELECT  LevelID , LevelName , LevelOrder , RepUpdateTime 
FROM CustDB.[dbo].[Winlimit_LevelSetting] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[Winlimit_ProductGlobalSetting]( ProductID, BetTypeID, GroupID, GroupName, Level1, Level2, Level3, Level101, Level102, blockedTransferLvl3, Currency, IsDeposit)
SELECT  ProductID , BetTypeID , GroupID , GroupName , Level1 , Level2 , Level3 , Level101 , Level102 , blockedTransferLvl3 , Currency , IsDeposit 
FROM CustDB.[dbo].[Winlimit_ProductGlobalSetting] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[Winlimit_ProductSetting]( ProductID, BettypeID, LevelID, SettingStatus, RepUpdateTime)
SELECT  ProductID , BettypeID , LevelID , SettingStatus , RepUpdateTime 
FROM CustDB.[dbo].[Winlimit_ProductSetting] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[WinLimit_ProductSettingDetail]( ProductID, GroupID, ExchangeID, SiteID, LevelID, MaxWinLimit, IsBlockedPlaceBet, IsBlockedTransfer, MaxWinLimit_RM, IsSuspendedAccount, RepUpdateTime)
SELECT  ProductID , GroupID , ExchangeID , SiteID , LevelID , MaxWinLimit , IsBlockedPlaceBet , IsBlockedTransfer , MaxWinLimit_RM , IsSuspendedAccount , RepUpdateTime 
FROM CustDB.[dbo].[WinLimit_ProductSettingDetail] WITH(NOLOCK);



