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
GRANT SELECT ON dbo.Site TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*SiteDBConfig*/
GRANT SELECT ON dbo.SiteDBConfig TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*Dep_Initial_BetSetting*/
GRANT SELECT ON dbo.Dep_Initial_BetSetting TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*Dep_Initial_ProductConfig*/
GRANT SELECT ON dbo.Dep_Initial_ProductConfig TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*Dep_Initial_ProductConfig_Detail*/
GRANT SELECT ON dbo.Dep_Initial_ProductConfig_Detail TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*Dep_Initial_StepByConfig*/
GRANT SELECT ON dbo.Dep_Initial_StepByConfig TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*Dep_ProductBetSetting*/
GRANT SELECT ON dbo.Dep_ProductBetSetting TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*Dep_ProductSetting*/
GRANT SELECT ON dbo.Dep_ProductSetting TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*Dep_ProductSettingDetail*/
GRANT SELECT ON dbo.Dep_ProductSettingDetail TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*Dep_ProductSettingType*/
GRANT SELECT ON dbo.Dep_ProductSettingType TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*Dep_ProductStakeLevelGroup*/
GRANT SELECT ON dbo.Dep_ProductStakeLevelGroup TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*Dep_ProductStatusProfile*/
GRANT SELECT ON dbo.Dep_ProductStatusProfile TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*Dep_StakeLevel*/
GRANT SELECT ON dbo.Dep_StakeLevel TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*Dep_StakeLevel_History*/
GRANT SELECT ON dbo.Dep_StakeLevel_History TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*Dep_StakeLevelGroupDetail*/
GRANT SELECT ON dbo.Dep_StakeLevelGroupDetail TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*Dep_StakeLevelGroupDetail_History*/
GRANT SELECT ON dbo.Dep_StakeLevelGroupDetail_History TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*Dep_UMConfig*/
GRANT SELECT ON dbo.Dep_UMConfig TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*DomainManagement*/
GRANT SELECT ON dbo.DomainManagement TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*GameGroup*/
GRANT SELECT ON dbo.GameGroup TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*GameLaunchPerCurrency*/
GRANT SELECT ON dbo.GameLaunchPerCurrency TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*GameLaunchPerSite*/
GRANT SELECT ON dbo.GameLaunchPerSite TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*LossLimit_GlobalSetting*/
GRANT SELECT ON dbo.LossLimit_GlobalSetting TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*MaxPayoutGlobalSetting*/
GRANT SELECT ON dbo.MaxPayoutGlobalSetting TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*PlayCurrencySetting*/
GRANT SELECT ON dbo.PlayCurrencySetting TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*ProductBetSetting*/
GRANT SELECT ON dbo.ProductBetSetting TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*ProductStakeLevelGroup*/
GRANT SELECT ON dbo.ProductStakeLevelGroup TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*SettingSystem*/
GRANT SELECT ON dbo.SettingSystem TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*SportBettypeSettingMatrix*/
GRANT SELECT ON dbo.SportBettypeSettingMatrix TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*StakeLevel*/
GRANT SELECT ON dbo.StakeLevel TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;
/*StakeLevel_History*/
GRANT SELECT ON dbo.StakeLevel_History TO API_Vender, asv_cust, CNS_Sales, Dot_12Bet, Dot_Admin, Dot_Casino, Dot_Evolution, Dot_Intg, Dot_Member, LicBIUser, ow_12bet, ow_lic_12bet, sportsbook_refdata, svc_tig, wsv_afinet, wsv_alp, wsv_alpv, wsv_lap, wsv_nap, wsv_xnap;