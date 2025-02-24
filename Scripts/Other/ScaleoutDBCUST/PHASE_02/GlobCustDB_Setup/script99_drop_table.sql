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
DROP TABLE IF EXISTS dbo.GameRoundBetLimitSettings;
DROP TABLE IF EXISTS dbo.Initial_ProductConfig;
DROP TABLE IF EXISTS dbo.Initial_ProductConfig_Detail;
DROP TABLE IF EXISTS dbo.Initial_StepByConfig;
DROP TABLE IF EXISTS dbo.MsgError;
DROP TABLE IF EXISTS dbo.MsgErrorGroup;
DROP TABLE IF EXISTS dbo.ProblemAccountReason;
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
DROP TABLE IF EXISTS dbo.ProductStatusProfile;
DROP TABLE IF EXISTS dbo.ProductStatusSiteCurrency;
DROP TABLE IF EXISTS dbo.ProfilePicture;
DROP TABLE IF EXISTS dbo.SportNonOfferedSiteCurrency;
DROP TABLE IF EXISTS dbo.UMConfig;
DROP TABLE IF EXISTS dbo.Winlimit_ActionSetting;
DROP TABLE IF EXISTS dbo.Winlimit_GameGroupSetting;
DROP TABLE IF EXISTS dbo.Winlimit_Group;
DROP TABLE IF EXISTS dbo.Winlimit_LevelSetting;
DROP TABLE IF EXISTS dbo.Winlimit_ProductGlobalSetting;
DROP TABLE IF EXISTS dbo.Winlimit_ProductSetting;
DROP TABLE IF EXISTS dbo.WinLimit_ProductSettingDetail;