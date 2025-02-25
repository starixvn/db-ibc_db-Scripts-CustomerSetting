/*<info serverAlias="DBGLOB-GlobCustDB" executers="" viewers="" isFunction="0"></info>*/
/*
	Created: DaveTruong
	Date: 20250120
	Task: Grant on GlobCustDB [RedmineID:#216870]
	DB: DBGLOB/GlobCustDB
*/
USE GlobCustDB;
GO
/*Site*/
GRANT SELECT ON dbo.Site TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*SiteDBConfig*/
GRANT SELECT ON dbo.SiteDBConfig TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*Dep_Initial_BetSetting*/
GRANT SELECT ON dbo.Dep_Initial_BetSetting TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*Dep_Initial_ProductConfig*/
GRANT SELECT ON dbo.Dep_Initial_ProductConfig TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*Dep_Initial_ProductConfig_Detail*/
GRANT SELECT ON dbo.Dep_Initial_ProductConfig_Detail TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*Dep_Initial_StepByConfig*/
GRANT SELECT ON dbo.Dep_Initial_StepByConfig TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*Dep_ProductBetSetting*/
GRANT SELECT ON dbo.Dep_ProductBetSetting TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*Dep_ProductSetting*/
GRANT SELECT ON dbo.Dep_ProductSetting TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*Dep_ProductSettingDetail*/
GRANT SELECT ON dbo.Dep_ProductSettingDetail TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*Dep_ProductSettingType*/
GRANT SELECT ON dbo.Dep_ProductSettingType TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*Dep_ProductStakeLevelGroup*/
GRANT SELECT ON dbo.Dep_ProductStakeLevelGroup TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*Dep_ProductStatusProfile*/
GRANT SELECT ON dbo.Dep_ProductStatusProfile TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*Dep_StakeLevel*/
GRANT SELECT ON dbo.Dep_StakeLevel TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*Dep_StakeLevel_History*/
GRANT SELECT ON dbo.Dep_StakeLevel_History TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*Dep_StakeLevelGroupDetail*/
GRANT SELECT ON dbo.Dep_StakeLevelGroupDetail TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*Dep_StakeLevelGroupDetail_History*/
GRANT SELECT ON dbo.Dep_StakeLevelGroupDetail_History TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*Dep_UMConfig*/
GRANT SELECT ON dbo.Dep_UMConfig TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*DomainManagement*/
GRANT SELECT ON dbo.DomainManagement TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*GameGroup*/
GRANT SELECT ON dbo.GameGroup TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*GameLaunchPerCurrency*/
GRANT SELECT ON dbo.GameLaunchPerCurrency TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*GameLaunchPerSite*/
GRANT SELECT ON dbo.GameLaunchPerSite TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*LossLimit_GlobalSetting*/
GRANT SELECT ON dbo.LossLimit_GlobalSetting TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*MaxPayoutGlobalSetting*/
GRANT SELECT ON dbo.MaxPayoutGlobalSetting TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*PlayCurrencySetting*/
GRANT SELECT ON dbo.PlayCurrencySetting TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*ProductBetSetting*/
GRANT SELECT ON dbo.ProductBetSetting TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*ProductStakeLevelGroup*/
GRANT SELECT ON dbo.ProductStakeLevelGroup TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*SettingSystem*/
GRANT SELECT ON dbo.SettingSystem TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*SportBettypeSettingMatrix*/
GRANT SELECT ON dbo.SportBettypeSettingMatrix TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*StakeLevel*/
GRANT SELECT ON dbo.StakeLevel TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
/*StakeLevel_History*/
GRANT SELECT ON dbo.StakeLevel_History TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;