/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Dave
	Date: 20250120
	Task: Create view in CustDB [RedmineID:#216870]
	DB: DBCust/CustDB
*/
USE CustDB
GO

/*Site*/
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

/*SiteDBConfig*/
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


/*Dep_Initial_BetSetting*/
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

/*Dep_Initial_ProductConfig*/
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


/*Dep_Initial_ProductConfig_Detail*/
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


/*Dep_Initial_StepByConfig*/
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


/*Dep_ProductBetSetting*/
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


/*Dep_ProductSetting*/
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


/*Dep_ProductSettingDetail*/
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


/*Dep_ProductSettingType*/
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


/*Dep_ProductStakeLevelGroup*/
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


/*Dep_ProductStatusProfile*/
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


/*Dep_StakeLevel*/
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


/*Dep_StakeLevel_History*/
/*Dep_StakeLevelGroupDetail*/
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

/*Dep_StakeLevelGroupDetail_History*/
/*Dep_UMConfig*/
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


/*DomainManagement*/
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


/*GameGroup*/
CREATE VIEW [dbo].[GameGroup]AS/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/	SELECT   GameGroupID 		, RefSportType 		, RefBetType 		, GroupName 		, IsDeposit 		, RepUpdateTime 	FROM GlobCustDB.dbo.GameGroup WITH(NOLOCK);
GO


/*GameLaunchPerCurrency*/
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


/*GameLaunchPerSite*/
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


/*LossLimit_GlobalSetting*/
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


/*MaxPayoutGlobalSetting*/
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


/*PlayCurrencySetting*/
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


/*ProductBetSetting*/
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


/*ProductStakeLevelGroup*/
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

/*SettingSystem*/
CREATE VIEW [dbo].[SettingSystem]AS/*
	Created: Dave
	Date: 2025-01-20
	Task: Scale out dbcust
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250120@Dave:Scale out dbcust - [Redmine: #216870]

*/	SELECT   SystemID 		, SystemName 		, Description 		, SystemPrefix 	FROM GlobCustDB.dbo.SettingSystem WITH(NOLOCK);
GO


/*SportBettypeSettingMatrix*/
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


/*StakeLevel*/
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

/*StakeLevel_History*/