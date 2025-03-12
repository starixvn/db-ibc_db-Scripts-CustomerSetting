/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Dave
	Date: 20250311
	Task: Drop view in CustDB [RedmineID:#216870]
	DB: DBCust/CustDB
*/
USE CustDB
GO
DROP VIEW dbo.Dep_Initial_BetSetting;
DROP VIEW dbo.Dep_Initial_ProductConfig;
DROP VIEW dbo.Dep_Initial_ProductConfig_Detail;
DROP VIEW dbo.Dep_Initial_StepByConfig;
DROP VIEW dbo.Dep_ProductBetSetting;
DROP VIEW dbo.Dep_ProductSetting;
DROP VIEW dbo.Dep_ProductSettingDetail;
DROP VIEW dbo.Dep_ProductSettingType;
DROP VIEW dbo.Dep_ProductStakeLevelGroup;
DROP VIEW dbo.Dep_ProductStatusProfile;
DROP VIEW dbo.Dep_StakeLevel;
DROP VIEW dbo.Dep_StakeLevelGroupDetail;
DROP VIEW dbo.Dep_UMConfig;
DROP VIEW dbo.DomainManagement;
DROP VIEW dbo.GameGroup;
DROP VIEW dbo.GameLaunchPerCurrency;
DROP VIEW dbo.GameLaunchPerSite;
DROP VIEW dbo.LossLimit_GlobalSetting;
DROP VIEW dbo.MaxPayoutGlobalSetting;
DROP VIEW dbo.PlayCurrencySetting;
DROP VIEW dbo.ProductBetSetting;
DROP VIEW dbo.ProductStakeLevelGroup;
DROP VIEW dbo.SettingSystem;
DROP VIEW dbo.Site;
DROP VIEW dbo.SiteDBConfig;
DROP VIEW dbo.StakeLevel;
DROP VIEW dbo.SportBettypeSettingMatrix;
/*DROP VIEW dbo.StakeLevel_History;
DROP VIEW dbo.Dep_StakeLevelGroupDetail_History;
DROP VIEW dbo.Dep_StakeLevel_History;*/