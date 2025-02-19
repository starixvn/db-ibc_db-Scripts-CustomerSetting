/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Dave
	Date: 20250120
	Task: Create view in CustDB [RedmineID:#216870]
	DB: DBCust/CustDB
*/
USE [CustDB]; 
GO
GRANT SELECT ON dbo.Acc_SuperPrefix TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.BetLimitControlTypeDetails TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.CategoryConfig TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.DangerLevelPolicy TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.Dep_Initial_BetSetting TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.Dep_Initial_ProductConfig TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.Dep_Initial_ProductConfig_Detail TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.Dep_Initial_StepByConfig TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.Dep_ProductBetSetting TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.Dep_ProductSetting TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.Dep_ProductSettingDetail TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.Dep_ProductSettingType TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.Dep_ProductStakeLevelGroup TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.Dep_ProductStatusProfile TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.Dep_StakeLevel TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.Dep_StakeLevelGroupDetail TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.Dep_UMConfig TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.DomainManagement TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.GameGroup TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.GameLaunchPerCurrency TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.GameLaunchPerSite TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.GameRoundBetLimitSettings TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.Initial_ProductConfig TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.Initial_ProductConfig_Detail TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.Initial_StepByConfig TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.LossLimit_GlobalSetting TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.MaxPayoutGlobalSetting TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.MsgError TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.MsgErrorGroup TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.PlayCurrencySetting TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.ProblemAccountReason TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.ProductBetSetting TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.ProductGlobalSetting TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.ProductLaunchedSiteCurrency TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.ProductProfileSiteCurrency TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.ProductProfileSiteCurrency_UAT TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.ProductSettingProfile TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.ProductSettingProfile_UAT TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.ProductSettingSystemDisplay TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.ProductSettingSystemDisplay_UAT TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.ProductSettingType TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.ProductSettingUpdateRestriction TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.ProductStakeLevelGroup TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.ProductStatusProfile TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.ProductStatusSiteCurrency TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.ProfilePicture TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.SettingSystem TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.Site TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.SiteDBConfig TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.SportBettypeSettingMatrix TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.SportNonOfferedSiteCurrency TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.StakeLevel TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.UMConfig TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.Winlimit_ActionSetting TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.Winlimit_GameGroupSetting TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.Winlimit_Group TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.Winlimit_LevelSetting TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.Winlimit_ProductGlobalSetting TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.Winlimit_ProductSetting TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;
GRANT SELECT ON dbo.WinLimit_ProductSettingDetail TO wsv_nap, wsv_alp, wsv_alpv, wsv_xnap, wsv_lap, svc_tig, asv_cust;