/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Dave
	Date: 20250120
	Task: Drop table in CustDB [RedmineID:#216870]
	DB: DBCust/CustDB
*/
USE [CustDB]
GO
/*Dep_Initial_BetSetting*/
DROP TABLE IF EXISTS dbo.Dep_Initial_BetSetting;
/*Dep_Initial_ProductConfig*/
DROP TABLE IF EXISTS dbo.Dep_Initial_ProductConfig;
/*Dep_Initial_ProductConfig_Detail*/
DROP TABLE IF EXISTS dbo.Dep_Initial_ProductConfig_Detail;
/*Dep_Initial_StepByConfig*/
DROP TABLE IF EXISTS dbo.Dep_Initial_StepByConfig;
/*Dep_ProductBetSetting*/
DROP TABLE IF EXISTS dbo.Dep_ProductBetSetting;
/*Dep_ProductSetting*/
DROP TABLE IF EXISTS dbo.Dep_ProductSetting;
/*Dep_ProductSettingDetail*/
DROP TABLE IF EXISTS dbo.Dep_ProductSettingDetail;
/*Dep_ProductSettingType*/
DROP TABLE IF EXISTS dbo.Dep_ProductSettingType;
/*Dep_ProductStakeLevelGroup*/
DROP TABLE IF EXISTS dbo.Dep_ProductStakeLevelGroup;
/*Dep_ProductStatusProfile*/
DROP TABLE IF EXISTS dbo.Dep_ProductStatusProfile;
/*Dep_StakeLevel*/
DROP TABLE IF EXISTS dbo.Dep_StakeLevel;
/*Dep_StakeLevel_History*/
DROP TABLE IF EXISTS dbo.Dep_StakeLevel_History;
/*Dep_StakeLevelGroupDetail*/
DROP TABLE IF EXISTS dbo.Dep_StakeLevelGroupDetail;
/*Dep_StakeLevelGroupDetail_History*/
DROP TABLE IF EXISTS dbo.Dep_StakeLevelGroupDetail_History;
/*Dep_UMConfig*/
DROP TABLE IF EXISTS dbo.Dep_UMConfig;
/*DomainManagement*/
DROP TABLE IF EXISTS dbo.DomainManagement;
/*GameGroup*/
DROP TABLE IF EXISTS dbo.GameGroup;
/*GameLaunchPerCurrency*/
DROP TABLE IF EXISTS dbo.GameLaunchPerCurrency;
/*GameLaunchPerSite*/
DROP TABLE IF EXISTS dbo.GameLaunchPerSite;
/*LossLimit_GlobalSetting*/
DROP TABLE IF EXISTS dbo.LossLimit_GlobalSetting;
/*MaxPayoutGlobalSetting*/
DROP TABLE IF EXISTS dbo.MaxPayoutGlobalSetting;
/*PlayCurrencySetting*/
DROP TABLE IF EXISTS dbo.PlayCurrencySetting;
/*ProductBetSetting*/
DROP TABLE IF EXISTS dbo.ProductBetSetting;
/*ProductStakeLevelGroup*/
DROP TABLE IF EXISTS dbo.ProductStakeLevelGroup;
/*SettingSystem*/
DROP TABLE IF EXISTS dbo.SettingSystem;
/*Site*/
DROP TABLE IF EXISTS dbo.Site;
/*SiteDBConfig*/
DROP TABLE IF EXISTS dbo.SiteDBConfig;
/*SportBettypeSettingMatrix*/
DROP TABLE IF EXISTS dbo.SportBettypeSettingMatrix;
/*StakeLevel*/
DROP TABLE IF EXISTS dbo.StakeLevel;
/*StakeLevel_History*/
DROP TABLE IF EXISTS dbo.StakeLevel_History;