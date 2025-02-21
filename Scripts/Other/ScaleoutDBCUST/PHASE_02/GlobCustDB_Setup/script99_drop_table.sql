/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Dave
	Date: 20250120
	Task: Drop table in CustDB [RedmineID:#216870]
	DB: DBCust/CustDB
*/
USE [CustDB]
GO
DROP TABLE IF EXISTS dbo.Acc_SuperPrefix;
DROP TABLE IF EXISTS dbo.CategoryConfig;
DROP TABLE IF EXISTS dbo.DangerLevelPolicy;
DROP TABLE IF EXISTS dbo.Dep_Initial_BetSetting;
DROP TABLE IF EXISTS dbo.Dep_Initial_ProductConfig;
DROP TABLE IF EXISTS dbo.Dep_Initial_ProductConfig_Detail;
DROP TABLE IF EXISTS dbo.Dep_Initial_StepByConfig;
DROP TABLE IF EXISTS dbo.Dep_ProductBetSetting;
DROP TABLE IF EXISTS dbo.Dep_ProductSetting;
DROP TABLE IF EXISTS dbo.Dep_ProductSettingDetail;
DROP TABLE IF EXISTS dbo.Dep_ProductSettingType;
DROP TABLE IF EXISTS dbo.Dep_ProductStakeLevelGroup;
DROP TABLE IF EXISTS dbo.Dep_ProductStatusProfile;
DROP TABLE IF EXISTS dbo.Dep_StakeLevel;
DROP TABLE IF EXISTS dbo.Dep_StakeLevel_History;
DROP TABLE IF EXISTS dbo.Dep_StakeLevelGroupDetail;
DROP TABLE IF EXISTS dbo.Dep_StakeLevelGroupDetail_History;
DROP TABLE IF EXISTS dbo.Dep_UMConfig;
DROP TABLE IF EXISTS dbo.DomainManagement;
DROP TABLE IF EXISTS dbo.GameGroup;
DROP TABLE IF EXISTS dbo.GameLaunchPerCurrency;
DROP TABLE IF EXISTS dbo.GameLaunchPerSite;
DROP TABLE IF EXISTS dbo.GameRoundBetLimitSettings;
DROP TABLE IF EXISTS dbo.Initial_ProductConfig;
DROP TABLE IF EXISTS dbo.Initial_ProductConfig_Detail;
DROP TABLE IF EXISTS dbo.Initial_StepByConfig;
DROP TABLE IF EXISTS dbo.LossLimit_GlobalSetting;
DROP TABLE IF EXISTS dbo.MaxPayoutGlobalSetting;
DROP TABLE IF EXISTS dbo.MsgError;
DROP TABLE IF EXISTS dbo.MsgErrorGroup;
DROP TABLE IF EXISTS dbo.PlayCurrencySetting;
DROP TABLE IF EXISTS dbo.ProblemAccountReason;
DROP TABLE IF EXISTS dbo.ProductBetSetting;
DROP TABLE IF EXISTS dbo.ProductGlobalSetting;
DROP TABLE IF EXISTS dbo.ProductLaunchedSiteCurrency;
DROP TABLE IF EXISTS dbo.ProductProfileSiteCurrency;
DROP TABLE IF EXISTS dbo.ProductProfileSiteCurrency_UAT;
DROP TABLE IF EXISTS dbo.ProductSettingProfile;
DROP TABLE IF EXISTS dbo.ProductSettingProfile_UAT;
DROP TABLE IF EXISTS dbo.ProductSettingSystemDisplay;
DROP TABLE IF EXISTS dbo.ProductSettingSystemDisplay_UAT;
DROP TABLE IF EXISTS dbo.ProductSettingType;
DROP TABLE IF EXISTS dbo.ProductSettingUpdateRestriction;
DROP TABLE IF EXISTS dbo.ProductStakeLevelGroup;
DROP TABLE IF EXISTS dbo.ProductStatusProfile;
DROP TABLE IF EXISTS dbo.ProductStatusSiteCurrency;
DROP TABLE IF EXISTS dbo.ProfilePicture;
DROP TABLE IF EXISTS dbo.SettingSystem;
DROP TABLE IF EXISTS dbo.Site;
DROP TABLE IF EXISTS dbo.SiteDBConfig;
DROP TABLE IF EXISTS dbo.SportBettypeSettingMatrix;
DROP TABLE IF EXISTS dbo.SportNonOfferedSiteCurrency;
DROP TABLE IF EXISTS dbo.StakeLevel;
DROP TABLE IF EXISTS dbo.StakeLevel_History;
DROP TABLE IF EXISTS dbo.UMConfig;
DROP TABLE IF EXISTS dbo.Winlimit_ActionSetting;
DROP TABLE IF EXISTS dbo.Winlimit_GameGroupSetting;
DROP TABLE IF EXISTS dbo.Winlimit_Group;
DROP TABLE IF EXISTS dbo.Winlimit_LevelSetting;
DROP TABLE IF EXISTS dbo.Winlimit_ProductGlobalSetting;
DROP TABLE IF EXISTS dbo.Winlimit_ProductSetting;
DROP TABLE IF EXISTS dbo.WinLimit_ProductSettingDetail;