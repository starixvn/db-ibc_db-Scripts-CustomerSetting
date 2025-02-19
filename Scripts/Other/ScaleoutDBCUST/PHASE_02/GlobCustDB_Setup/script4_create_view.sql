/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Dave
	Date: 20250120
	Task: Create view in CustDB [RedmineID:#216870]
	DB: DBCust/CustDB
*/
USE CustDB
GO

CREATE VIEW [dbo].[Acc_SuperPrefix]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   GroupName 
		, Prefix 
		, AllowNewSuper 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.Acc_SuperPrefix WITH(NOLOCK);
GO


CREATE VIEW [dbo].[BetLimitControlTypeDetails]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   ID 
		, BetLimitTypeID 
		, ProductID 
		, Sporttype 
		, Bettype 
		, LeagueGroupID 
		, LeagueID 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.BetLimitControlTypeDetails WITH(NOLOCK);
GO


CREATE VIEW [dbo].[CategoryConfig]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   CategoryID 
		, CategoryName 
		, OfferDeposit 
		, CategoryNameCS 
		, CustomerClass 
		, HiddenSite 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.CategoryConfig WITH(NOLOCK);
GO


CREATE VIEW [dbo].[DangerLevelPolicy]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   SportType 
		, DangerLevel 
		, ActionType 
		, Value 
		, LeagueGroupID 
	FROM GlobCustDB.dbo.DangerLevelPolicy WITH(NOLOCK);
GO


CREATE VIEW [dbo].[Dep_Initial_BetSetting]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   ConfigID 
		, Currency 
		, SportType 
		, BetType 
		, MinBet 
		, MaxBet 
		, MaxPerMatch 
		, MaxPerNumber 
		, MaxPayoutPerMatch 
	FROM GlobCustDB.dbo.Dep_Initial_BetSetting WITH(NOLOCK);
GO


CREATE VIEW [dbo].[Dep_Initial_ProductConfig]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   ConfigID 
		, ProductID 
		, SportTypeList 
		, BetTypeList 
		, Site 
		, Currency 
		, StartTime 
		, EndTime 
		, IsTest 
		, Status 
		, CurrentStep 
		, ProcessedStep 
		, Remark 
	FROM GlobCustDB.dbo.Dep_Initial_ProductConfig WITH(NOLOCK);
GO


CREATE VIEW [dbo].[Dep_Initial_ProductConfig_Detail]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   ConfigID 
		, SportType 
		, BetType 
		, IsLive 
		, SettingType 
		, IsDefault 
		, DefaultValueSuper 
		, DefaultValueMaster 
		, DefaultValueAgent 
		, DefaultValueMember 
		, SpecialRequirement 
	FROM GlobCustDB.dbo.Dep_Initial_ProductConfig_Detail WITH(NOLOCK);
GO


CREATE VIEW [dbo].[Dep_Initial_StepByConfig]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   StepID 
		, IsScanCustomer 
		, SortOrder 
	FROM GlobCustDB.dbo.Dep_Initial_StepByConfig WITH(NOLOCK);
GO


CREATE VIEW [dbo].[Dep_ProductBetSetting]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   Sporttype 
		, Bettype 
		, Currency 
		, MinBet 
		, MaxBet 
		, MaxPerMatch 
		, DefaultMinBet 
		, DefaultMaxBet 
		, DefaultMaxPerMatch 
		, MaxPerBall 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.Dep_ProductBetSetting WITH(NOLOCK);
GO


CREATE VIEW [dbo].[Dep_ProductSetting]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   ProductSettingID 
		, ProductID 
		, SettingType 
		, TemplateID 
		, DisplayOrder 
		, SettingLevel 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.Dep_ProductSetting WITH(NOLOCK);
GO


CREATE VIEW [dbo].[Dep_ProductSettingDetail]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   ProductSettingID 
		, SportType 
		, BetType 
		, IsLive 
		, MaxDefaultValue 
		, SettingStatus 
		, MinDefaultValue 
		, IsApplyBA 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.Dep_ProductSettingDetail WITH(NOLOCK);
GO


CREATE VIEW [dbo].[Dep_ProductSettingType]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   SettingType 
		, SettingName 
		, SettingNameDetail 
	FROM GlobCustDB.dbo.Dep_ProductSettingType WITH(NOLOCK);
GO


CREATE VIEW [dbo].[Dep_ProductStakeLevelGroup]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   Sporttype 
		, GameGroupID 
		, MinBet 
		, MaxBet 
		, LicenseeGroupID 
		, Remark 
		, RepUpdateTime 
		, SiteID 
		, isDeleted 
	FROM GlobCustDB.dbo.Dep_ProductStakeLevelGroup WITH(NOLOCK);
GO


CREATE VIEW [dbo].[Dep_ProductStatusProfile]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   Sporttype 
		, Bettype 
		, bitmapOrder 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.Dep_ProductStatusProfile WITH(NOLOCK);
GO


CREATE VIEW [dbo].[Dep_StakeLevel]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   StakeLevelID 
		, GameTypeID 
		, GameGroupID 
		, MinLabel 
		, MaxLabel 
		, MinStake 
		, MaxStake 
		, ExchangeID 
		, ResourceId 
		, SiteID 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.Dep_StakeLevel WITH(NOLOCK);
GO


CREATE VIEW [dbo].[Dep_StakeLevelGroupDetail]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   StakeLevelID 
		, GameTypeID 
		, MinLabel 
		, MaxLabel 
		, MinStake 
		, MaxStake 
		, ParentTypeID 
		, MaxGameStake 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.Dep_StakeLevelGroupDetail WITH(NOLOCK);
GO

CREATE VIEW [dbo].[Dep_UMConfig]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   FunctionType 
		, ProductID 
		, SettingType 
		, LicenseeID 
		, BeginTime 
		, EndTime 
		, Time_Stamp 
	FROM GlobCustDB.dbo.Dep_UMConfig WITH(NOLOCK);
GO


CREATE VIEW [dbo].[DomainManagement]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   DomainID 
		, Domain 
		, System 
		, Site 
		, BrandName 
		, Status 
		, ExpiredDate 
		, LastUpdateTime 
		, RestrictedCountries 
		, Remark 
		, isDeleted 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.DomainManagement WITH(NOLOCK);
GO


CREATE VIEW [dbo].[GameGroup]AS/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/	SELECT   GameGroupID 		, RefSportType 		, RefBetType 		, GroupName 		, IsDeposit 		, RepUpdateTime 	FROM GlobCustDB.dbo.GameGroup WITH(NOLOCK);
GO


CREATE VIEW [dbo].[GameLaunchPerCurrency]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   SportType 
		, BetType 
		, Currency 
		, IsLaunched 
		, IsTest 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.GameLaunchPerCurrency WITH(NOLOCK);
GO


CREATE VIEW [dbo].[GameLaunchPerSite]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   SportType 
		, BetType 
		, SiteID 
		, IsLaunched 
		, IsTest 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.GameLaunchPerSite WITH(NOLOCK);
GO


CREATE VIEW [dbo].[GameRoundBetLimitSettings]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   SportType 
		, BetType 
		, ProductID 
		, GameRoundBetLimit 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.GameRoundBetLimitSettings WITH(NOLOCK);
GO


CREATE VIEW [dbo].[Initial_ProductConfig]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   ConfigID 
		, ProductID 
		, SportTypeList 
		, BetTypeList 
		, Site 
		, Currency 
		, StartTime 
		, EndTime 
		, IsTest 
		, Status 
		, CurrentStep 
		, ProcessedStep 
		, Remark 
	FROM GlobCustDB.dbo.Initial_ProductConfig WITH(NOLOCK);
GO


CREATE VIEW [dbo].[Initial_ProductConfig_Detail]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   ConfigID 
		, SportType 
		, BetType 
		, IsLive 
		, SettingType 
		, IsDefault 
		, CopyFromSportType 
		, CopyFromBetType 
		, DefaultValueSuper 
		, DefaultValueMaster 
		, DefaultValueAgent 
		, DefaultValueMember 
		, SpecialRequirement 
	FROM GlobCustDB.dbo.Initial_ProductConfig_Detail WITH(NOLOCK);
GO


CREATE VIEW [dbo].[Initial_StepByConfig]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   StepID 
		, IsScanCustomer 
		, SortOrder 
	FROM GlobCustDB.dbo.Initial_StepByConfig WITH(NOLOCK);
GO


CREATE VIEW [dbo].[LossLimit_GlobalSetting]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   ProductId 
		, ExchangeId 
		, MinLossLimit 
		, DefaultLossLimit 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.LossLimit_GlobalSetting WITH(NOLOCK);
GO


CREATE VIEW [dbo].[MaxPayoutGlobalSetting]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   SportType 
		, BetType 
		, Currency 
		, SingleMatchParlay 
		, Combo2 
		, Combo35 
		, ComboOver6 
		, SettingStatus 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.MaxPayoutGlobalSetting WITH(NOLOCK);
GO


CREATE VIEW [dbo].[MsgError]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   MsgID 
		, MsgGroupID 
		, MsgNameEN 
		, MsgNameCT 
		, MsgNameCS 
		, MsgNameJP 
		, MsgNameTH 
		, MsgNameKO 
		, MsgNameES 
		, MsgNameVI 
		, IsActive 
		, MsgNameCN 
		, MsgNameIN 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.MsgError WITH(NOLOCK);
GO


CREATE VIEW [dbo].[MsgErrorGroup]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   MsgGroupID 
		, MsgGroupName 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.MsgErrorGroup WITH(NOLOCK);
GO


CREATE VIEW [dbo].[PlayCurrencySetting]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   ID 
		, SiteId 
		, SiteName 
		, SportType 
		, MemberCurrency 
		, PlayCurrency 
		, FromDate 
		, ToDate 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.PlayCurrencySetting WITH(NOLOCK);
GO


CREATE VIEW [dbo].[ProblemAccountReason]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   ReasonID 
		, ReasonName 
		, IsCN88 
		, IsCredit 
		, IsLicensee 
		, ReasonNameCS 
		, ReasonGroupID 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.ProblemAccountReason WITH(NOLOCK);
GO


CREATE VIEW [dbo].[ProductBetSetting]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   Sporttype 
		, Bettype 
		, Currency 
		, MinBet 
		, IsDep 
		, MaxBet 
		, MaxPerMatch 
		, DefaultMinBet 
		, DefaultMaxBet 
		, DefaultMaxPerMatch 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.ProductBetSetting WITH(NOLOCK);
GO


CREATE VIEW [dbo].[ProductGlobalSetting]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   Sporttype 
		, Bettype 
		, MaxPositiontaking 
		, Maxsdiscount 
		, IsDep 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.ProductGlobalSetting WITH(NOLOCK);
GO


CREATE VIEW [dbo].[ProductLaunchedSiteCurrency]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   SiteID 
		, Currency 
		, SportType 
		, IsLaunched 
		, IsTest 
		, BetType 
		, LaunchedLevel 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.ProductLaunchedSiteCurrency WITH(NOLOCK);
GO


CREATE VIEW [dbo].[ProductProfileSiteCurrency]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   SiteID 
		, Currency 
		, ProductSettingID 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.ProductProfileSiteCurrency WITH(NOLOCK);
GO


CREATE VIEW [dbo].[ProductProfileSiteCurrency_UAT]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   SiteID 
		, Currency 
		, ProductSettingID 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.ProductProfileSiteCurrency_UAT WITH(NOLOCK);
GO


CREATE VIEW [dbo].[ProductSettingProfile]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   ProductSettingID 
		, SettingType 
		, SportType 
		, BetType 
		, IsLive 
		, ProductID 
		, MaxPT 
		, MaxDiscount 
		, IsSync 
		, IsHidden 
		, IsDisabled 
		, SettingLevel 
		, DisplayOrder 
		, SettingStatus 
		, IntervalValue 
		, RealProductId 
		, MaxChoice 
		, Parent_ProductSettingID 
		, Child_DisplayOrder 
		, SubType 
		, GroupID 
		, GroupType 
		, GroupTypeOrder 
		, SubGroupID 
		, SubGroupOrder 
		, CreationStatus 
		, DisplayType 
		, MarketType 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.ProductSettingProfile WITH(NOLOCK);
GO


CREATE VIEW [dbo].[ProductSettingProfile_UAT]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   ProductSettingID 
		, SettingType 
		, SportType 
		, BetType 
		, IsLive 
		, ProductID 
		, MaxPT 
		, MaxDiscount 
		, IsSync 
		, IsHidden 
		, IsDisabled 
		, SettingLevel 
		, DisplayOrder 
		, SettingStatus 
		, IntervalValue 
		, RealProductId 
		, MaxChoice 
		, Parent_ProductSettingID 
		, Child_DisplayOrder 
		, SubType 
		, GroupID 
		, GroupType 
		, GroupTypeOrder 
		, SubGroupID 
		, SubGroupOrder 
		, CreationStatus 
		, DisplayType 
		, MarketType 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.ProductSettingProfile_UAT WITH(NOLOCK);
GO


CREATE VIEW [dbo].[ProductSettingSystemDisplay]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   SystemID 
		, ProductID 
		, SettingType 
		, DisplayMode 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.ProductSettingSystemDisplay WITH(NOLOCK);
GO


CREATE VIEW [dbo].[ProductSettingSystemDisplay_UAT]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   SystemID 
		, ProductID 
		, SettingType 
		, DisplayMode 
	FROM GlobCustDB.dbo.ProductSettingSystemDisplay_UAT WITH(NOLOCK);
GO


CREATE VIEW [dbo].[ProductSettingType]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   SettingType 
		, SettingName 
		, SettingNameDetail 
	FROM GlobCustDB.dbo.ProductSettingType WITH(NOLOCK);
GO


CREATE VIEW [dbo].[ProductSettingUpdateRestriction]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   SystemID 
		, ProductID 
		, SettingType 
		, ActorRoleID 
		, TargetRoleID 
		, ErrCode 
		, RestrictionMode 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.ProductSettingUpdateRestriction WITH(NOLOCK);
GO


CREATE VIEW [dbo].[ProductStakeLevelGroup]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   Sporttype 
		, GameGroupID 
		, MinBet 
		, MaxBet 
		, CreditGroupID 
		, Remark 
		, RepUpdateTime 
		, isDeleted 
	FROM GlobCustDB.dbo.ProductStakeLevelGroup WITH(NOLOCK);
GO


CREATE VIEW [dbo].[ProductStatusProfile]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   Sporttype 
		, Bettype 
		, bitmapOrder 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.ProductStatusProfile WITH(NOLOCK);
GO


CREATE VIEW [dbo].[ProductStatusSiteCurrency]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   SportType 
		, BetType 
		, Currency 
		, SiteID 
		, IsHidden 
		, IsDisabled 
		, HasSynced 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.ProductStatusSiteCurrency WITH(NOLOCK);
GO


CREATE VIEW [dbo].[ProfilePicture]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   ImageId 
		, Image 
		, RepUpdateTime 
		, IsDeleted 
	FROM GlobCustDB.dbo.ProfilePicture WITH(NOLOCK);
GO


CREATE VIEW [dbo].[SettingSystem]AS/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/	SELECT   SystemID 		, SystemName 		, Description 		, SystemPrefix 	FROM GlobCustDB.dbo.SettingSystem WITH(NOLOCK);
GO


CREATE VIEW [dbo].[Site]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   siteid 
		, site 
		, type 
		, spreada 
		, spreadb 
		, spreadc 
		, spreadd 
		, spreade 
		, spreadf 
		, ServerID 
		, isLicensee 
		, isActive 
		, isDeposit 
		, SpecialGroup 
		, BlockNewCust 
		, UnblockTime 
		, IsChinaView 
		, RepUpdateTime 
		, SiteDBGroupID 
		, SiteLabel 
		, SpecialPlatfrom 
		, CustDBGroupID 
		, SiteType 
	FROM GlobCustDB.dbo.Site WITH(NOLOCK);
GO


CREATE VIEW [dbo].[SiteDBConfig]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   SiteDBGroupID 
		, LinkedServerName 
		, ClientAccessName 
		, AGIP 
		, AWSProxyDomain 
		, AWSProxyPort 
		, RepUpdateTime 
		, FQDN 
	FROM GlobCustDB.dbo.SiteDBConfig WITH(NOLOCK);
GO


CREATE VIEW [dbo].[SportBettypeSettingMatrix]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   SportType 
		, BetType 
		, isLicensee 
		, isLive 
		, Site 
		, isActive 
		, SportTypeRefPT 
		, BetTypeRefPT 
		, isLivePT 
		, TablePT 
		, SportTypeRefComm 
		, BetTypeRefComm 
		, TableComm 
		, SportTypeRefBetSetting 
		, BetTypeRefBetSetting 
		, TableBetSetting 
		, IsLiveComm 
		, IsLiveBetSetting 
		, TableBettrans 
		, SporttypeRefWinlossLimit 
		, BettypeRefWinlossLimit 
		, RealProductId 
		, isDeleted 
		, RepUpdateTime 
		, ProductID 
	FROM GlobCustDB.dbo.SportBettypeSettingMatrix WITH(NOLOCK);
GO


CREATE VIEW [dbo].[SportNonOfferedSiteCurrency]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   SportType 
		, BetType 
		, Currency 
		, SiteID 
		, RealProductID 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.SportNonOfferedSiteCurrency WITH(NOLOCK);
GO


CREATE VIEW [dbo].[StakeLevel]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   StakeLevelID 
		, GameTypeID 
		, MinLabel 
		, MaxLabel 
		, MinStake 
		, MaxStake 
		, ExchangeId 
		, ResourceId 
		, GameGroupID 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.StakeLevel WITH(NOLOCK);
GO

CREATE VIEW [dbo].[UMConfig]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   ProductID 
		, SportType 
		, BetType 
		, IsLive 
		, SettingType 
		, FunctionType 
		, SiteID 
		, Currency 
		, SuperID 
		, BeginTime 
		, EndTime 
		, Time_Stamp 
		, ShowTime 
		, LockAddingNew 
		, ConfigID 
	FROM GlobCustDB.dbo.UMConfig WITH(NOLOCK);
GO


CREATE VIEW [dbo].[Winlimit_ActionSetting]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   ActionID 
		, ActionName 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.Winlimit_ActionSetting WITH(NOLOCK);
GO


CREATE VIEW [dbo].[Winlimit_GameGroupSetting]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   ProductID 
		, BetTypeID 
		, GroupID 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.Winlimit_GameGroupSetting WITH(NOLOCK);
GO


CREATE VIEW [dbo].[Winlimit_Group]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   GroupID 
		, GroupName 
	FROM GlobCustDB.dbo.Winlimit_Group WITH(NOLOCK);
GO


CREATE VIEW [dbo].[Winlimit_LevelSetting]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   LevelID 
		, LevelName 
		, LevelOrder 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.Winlimit_LevelSetting WITH(NOLOCK);
GO


CREATE VIEW [dbo].[Winlimit_ProductGlobalSetting]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   ProductID 
		, BetTypeID 
		, GroupID 
		, GroupName 
		, Level1 
		, Level2 
		, Level3 
		, Level101 
		, Level102 
		, blockedTransferLvl3 
		, Currency 
		, IsDeposit 
	FROM GlobCustDB.dbo.Winlimit_ProductGlobalSetting WITH(NOLOCK);
GO


CREATE VIEW [dbo].[Winlimit_ProductSetting]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   ProductID 
		, BettypeID 
		, LevelID 
		, SettingStatus 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.Winlimit_ProductSetting WITH(NOLOCK);
GO


CREATE VIEW [dbo].[WinLimit_ProductSettingDetail]
AS
/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/
	SELECT   ProductID 
		, GroupID 
		, ExchangeID 
		, SiteID 
		, LevelID 
		, MaxWinLimit 
		, IsBlockedPlaceBet 
		, IsBlockedTransfer 
		, MaxWinLimit_RM 
		, IsSuspendedAccount 
		, RepUpdateTime 
	FROM GlobCustDB.dbo.WinLimit_ProductSettingDetail WITH(NOLOCK);
GO

