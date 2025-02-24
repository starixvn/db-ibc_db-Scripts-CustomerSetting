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



INSERT INTO GlobCustDB.[dbo].[CategoryConfig]( CategoryID, CategoryName, OfferDeposit, CategoryNameCS, CustomerClass, HiddenSite, RepUpdateTime)
SELECT  CategoryID , CategoryName , OfferDeposit , CategoryNameCS , CustomerClass , HiddenSite , RepUpdateTime 
FROM CustDB.[dbo].[CategoryConfig] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[DangerLevelPolicy]( SportType, DangerLevel, ActionType, Value, LeagueGroupID)
SELECT  SportType , DangerLevel , ActionType , Value , LeagueGroupID 
FROM CustDB.[dbo].[DangerLevelPolicy] WITH(NOLOCK);


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



INSERT INTO GlobCustDB.[dbo].[MsgError]( MsgID, MsgGroupID, MsgNameEN, MsgNameCT, MsgNameCS, MsgNameJP, MsgNameTH, MsgNameKO, MsgNameES, MsgNameVI, IsActive, MsgNameCN, MsgNameIN, RepUpdateTime)
SELECT  MsgID , MsgGroupID , MsgNameEN , MsgNameCT , MsgNameCS , MsgNameJP , MsgNameTH , MsgNameKO , MsgNameES , MsgNameVI , IsActive , MsgNameCN , MsgNameIN , RepUpdateTime 
FROM CustDB.[dbo].[MsgError] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[MsgErrorGroup]( MsgGroupID, MsgGroupName, RepUpdateTime)
SELECT  MsgGroupID , MsgGroupName , RepUpdateTime 
FROM CustDB.[dbo].[MsgErrorGroup] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[ProblemAccountReason]( ReasonID, ReasonName, IsCN88, IsCredit, IsLicensee, ReasonNameCS, ReasonGroupID, RepUpdateTime)
SELECT  ReasonID , ReasonName , IsCN88 , IsCredit , IsLicensee , ReasonNameCS , ReasonGroupID , RepUpdateTime 
FROM CustDB.[dbo].[ProblemAccountReason] WITH(NOLOCK);


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


INSERT INTO GlobCustDB.[dbo].[ProductStatusProfile]( Sporttype, Bettype, bitmapOrder, RepUpdateTime)
SELECT  Sporttype , Bettype , bitmapOrder , RepUpdateTime 
FROM CustDB.[dbo].[ProductStatusProfile] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[ProductStatusSiteCurrency]( SportType, BetType, Currency, SiteID, IsHidden, IsDisabled, HasSynced, RepUpdateTime)
SELECT  SportType , BetType , Currency , SiteID , IsHidden , IsDisabled , HasSynced , RepUpdateTime 
FROM CustDB.[dbo].[ProductStatusSiteCurrency] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[ProfilePicture]( ImageId, Image, RepUpdateTime, IsDeleted)
SELECT  ImageId , Image , RepUpdateTime , IsDeleted 
FROM CustDB.[dbo].[ProfilePicture] WITH(NOLOCK);


INSERT INTO GlobCustDB.[dbo].[SportNonOfferedSiteCurrency]( SportType, BetType, Currency, SiteID, RealProductID, RepUpdateTime)
SELECT  SportType , BetType , Currency , SiteID , RealProductID , RepUpdateTime 
FROM CustDB.[dbo].[SportNonOfferedSiteCurrency] WITH(NOLOCK);



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



