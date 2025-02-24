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

