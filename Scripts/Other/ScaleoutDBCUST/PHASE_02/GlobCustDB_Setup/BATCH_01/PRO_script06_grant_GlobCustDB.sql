/*<info serverAlias="DBGLOB-GlobCustDB" executers="" viewers="" isFunction="0"></info>*/
/*
	Created: DaveTruong
	Date: 20250120
	Task: Grant on GlobCustDB [RedmineID:#216870]
	DB: DBGLOB/GlobCustDB
*/
USE GlobCustDB;
GO

IF database_principal_id('API_Vender') IS NULL
	CREATE USER API_Vender FOR LOGIN API_Vender;
GO
IF database_principal_id('asv_cust') IS NULL
	CREATE USER asv_cust FOR LOGIN asv_cust;
GO
IF database_principal_id('CNS_Sales') IS NULL
	CREATE USER CNS_Sales FOR LOGIN CNS_Sales;
GO
IF database_principal_id('Dot_12Bet') IS NULL
	CREATE USER Dot_12Bet FOR LOGIN Dot_12Bet;
GO
IF database_principal_id('Dot_Admin') IS NULL
	CREATE USER Dot_Admin FOR LOGIN Dot_Admin;
GO
IF database_principal_id('Dot_Casino') IS NULL
	CREATE USER Dot_Casino FOR LOGIN Dot_Casino;
GO
IF database_principal_id('Dot_Evolution') IS NULL
	CREATE USER Dot_Evolution FOR LOGIN Dot_Evolution;
GO
IF database_principal_id('Dot_Intg') IS NULL
	CREATE USER Dot_Intg FOR LOGIN Dot_Intg;
GO
IF database_principal_id('Dot_Member') IS NULL
	CREATE USER Dot_Member FOR LOGIN Dot_Member;
GO
IF database_principal_id('LicBIUser') IS NULL
	CREATE USER LicBIUser FOR LOGIN LicBIUser;
GO
IF database_principal_id('ow_12bet') IS NULL
	CREATE USER ow_12bet FOR LOGIN ow_12bet;
GO
IF database_principal_id('ow_lic_12bet') IS NULL
	CREATE USER ow_lic_12bet FOR LOGIN ow_lic_12bet;
GO
IF database_principal_id('sportsbook_refdata') IS NULL
	CREATE USER sportsbook_refdata FOR LOGIN sportsbook_refdata;
GO
IF database_principal_id('svc_tig') IS NULL
	CREATE USER svc_tig FOR LOGIN svc_tig;
GO
IF database_principal_id('wsv_afinet') IS NULL
	CREATE USER wsv_afinet FOR LOGIN wsv_afinet;
GO
IF database_principal_id('wsv_alp') IS NULL
	CREATE USER wsv_alp FOR LOGIN wsv_alp;
GO
IF database_principal_id('wsv_alpv') IS NULL
	CREATE USER wsv_alpv FOR LOGIN wsv_alpv;
GO
IF database_principal_id('wsv_lap') IS NULL
	CREATE USER wsv_lap FOR LOGIN wsv_lap;
GO
IF database_principal_id('wsv_nap') IS NULL
	CREATE USER wsv_nap FOR LOGIN wsv_nap;
GO
IF database_principal_id('wsv_xnap') IS NULL
	CREATE USER wsv_xnap FOR LOGIN wsv_xnap;
GO

/*API_Vender*/
GRANT SELECT ON Dep_Initial_BetSetting TO API_Vender;
GO
GRANT SELECT ON Dep_Initial_ProductConfig TO API_Vender;
GO
GRANT SELECT ON Dep_Initial_ProductConfig_Detail TO API_Vender;
GO
GRANT SELECT ON Dep_Initial_StepByConfig TO API_Vender;
GO
GRANT SELECT ON Dep_ProductBetSetting TO API_Vender;
GO
GRANT SELECT ON Dep_ProductSetting TO API_Vender;
GO
GRANT SELECT ON Dep_ProductSettingDetail TO API_Vender;
GO
GRANT SELECT ON Dep_ProductSettingType TO API_Vender;
GO
GRANT SELECT ON Dep_ProductStakeLevelGroup TO API_Vender;
GO
GRANT SELECT ON Dep_ProductStatusProfile TO API_Vender;
GO
GRANT SELECT ON Dep_StakeLevel TO API_Vender;
GO
GRANT SELECT ON Dep_StakeLevel_History TO API_Vender;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail TO API_Vender;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail_History TO API_Vender;
GO
GRANT SELECT ON Dep_UMConfig TO API_Vender;
GO
GRANT SELECT ON DomainManagement TO API_Vender;
GO
GRANT SELECT ON GameGroup TO API_Vender;
GO
GRANT SELECT ON GameLaunchPerCurrency TO API_Vender;
GO
GRANT SELECT ON GameLaunchPerSite TO API_Vender;
GO
GRANT SELECT ON LossLimit_GlobalSetting TO API_Vender;
GO
GRANT SELECT ON MaxPayoutGlobalSetting TO API_Vender;
GO
GRANT SELECT ON PlayCurrencySetting TO API_Vender;
GO
GRANT SELECT ON ProductBetSetting TO API_Vender;
GO
GRANT SELECT ON ProductStakeLevelGroup TO API_Vender;
GO
GRANT SELECT ON SettingSystem TO API_Vender;
GO
GRANT SELECT ON Site TO API_Vender;
GO
GRANT SELECT ON SiteDBConfig TO API_Vender;
GO
GRANT SELECT ON SportBettypeSettingMatrix TO API_Vender;
GO
GRANT SELECT ON StakeLevel TO API_Vender;
GO
GRANT SELECT ON StakeLevel_History TO API_Vender;
GO
/*asv_cust*/
GRANT SELECT ON Dep_Initial_BetSetting TO asv_cust;
GO
GRANT SELECT ON Dep_Initial_ProductConfig TO asv_cust;
GO
GRANT SELECT ON Dep_Initial_ProductConfig_Detail TO asv_cust;
GO
GRANT SELECT ON Dep_Initial_StepByConfig TO asv_cust;
GO
GRANT SELECT ON Dep_ProductBetSetting TO asv_cust;
GO
GRANT SELECT ON Dep_ProductSetting TO asv_cust;
GO
GRANT SELECT ON Dep_ProductSettingDetail TO asv_cust;
GO
GRANT SELECT ON Dep_ProductSettingType TO asv_cust;
GO
GRANT SELECT ON Dep_ProductStakeLevelGroup TO asv_cust;
GO
GRANT SELECT ON Dep_ProductStatusProfile TO asv_cust;
GO
GRANT SELECT ON Dep_StakeLevel TO asv_cust;
GO
GRANT SELECT ON Dep_StakeLevel_History TO asv_cust;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail TO asv_cust;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail_History TO asv_cust;
GO
GRANT SELECT ON Dep_UMConfig TO asv_cust;
GO
GRANT SELECT ON DomainManagement TO asv_cust;
GO
GRANT SELECT ON GameGroup TO asv_cust;
GO
GRANT SELECT ON GameLaunchPerCurrency TO asv_cust;
GO
GRANT SELECT ON GameLaunchPerSite TO asv_cust;
GO
GRANT SELECT ON LossLimit_GlobalSetting TO asv_cust;
GO
GRANT SELECT ON MaxPayoutGlobalSetting TO asv_cust;
GO
GRANT SELECT ON PlayCurrencySetting TO asv_cust;
GO
GRANT SELECT ON ProductBetSetting TO asv_cust;
GO
GRANT SELECT ON ProductStakeLevelGroup TO asv_cust;
GO
GRANT SELECT ON SettingSystem TO asv_cust;
GO
GRANT SELECT ON Site TO asv_cust;
GO
GRANT SELECT ON SiteDBConfig TO asv_cust;
GO
GRANT SELECT ON SportBettypeSettingMatrix TO asv_cust;
GO
GRANT SELECT ON StakeLevel TO asv_cust;
GO
GRANT SELECT ON StakeLevel_History TO asv_cust;
GO
/*CNS_Sales*/
GRANT SELECT ON Dep_Initial_BetSetting TO CNS_Sales;
GO
GRANT SELECT ON Dep_Initial_ProductConfig TO CNS_Sales;
GO
GRANT SELECT ON Dep_Initial_ProductConfig_Detail TO CNS_Sales;
GO
GRANT SELECT ON Dep_Initial_StepByConfig TO CNS_Sales;
GO
GRANT SELECT ON Dep_ProductBetSetting TO CNS_Sales;
GO
GRANT SELECT ON Dep_ProductSetting TO CNS_Sales;
GO
GRANT SELECT ON Dep_ProductSettingDetail TO CNS_Sales;
GO
GRANT SELECT ON Dep_ProductSettingType TO CNS_Sales;
GO
GRANT SELECT ON Dep_ProductStakeLevelGroup TO CNS_Sales;
GO
GRANT SELECT ON Dep_ProductStatusProfile TO CNS_Sales;
GO
GRANT SELECT ON Dep_StakeLevel TO CNS_Sales;
GO
GRANT SELECT ON Dep_StakeLevel_History TO CNS_Sales;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail TO CNS_Sales;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail_History TO CNS_Sales;
GO
GRANT SELECT ON Dep_UMConfig TO CNS_Sales;
GO
GRANT SELECT ON DomainManagement TO CNS_Sales;
GO
GRANT SELECT ON GameGroup TO CNS_Sales;
GO
GRANT SELECT ON GameLaunchPerCurrency TO CNS_Sales;
GO
GRANT SELECT ON GameLaunchPerSite TO CNS_Sales;
GO
GRANT SELECT ON LossLimit_GlobalSetting TO CNS_Sales;
GO
GRANT SELECT ON MaxPayoutGlobalSetting TO CNS_Sales;
GO
GRANT SELECT ON PlayCurrencySetting TO CNS_Sales;
GO
GRANT SELECT ON ProductBetSetting TO CNS_Sales;
GO
GRANT SELECT ON ProductStakeLevelGroup TO CNS_Sales;
GO
GRANT SELECT ON SettingSystem TO CNS_Sales;
GO
GRANT SELECT ON Site TO CNS_Sales;
GO
GRANT SELECT ON SiteDBConfig TO CNS_Sales;
GO
GRANT SELECT ON SportBettypeSettingMatrix TO CNS_Sales;
GO
GRANT SELECT ON StakeLevel TO CNS_Sales;
GO
GRANT SELECT ON StakeLevel_History TO CNS_Sales;
GO
/*Dot_12Bet*/
GRANT SELECT ON Dep_Initial_BetSetting TO Dot_12Bet;
GO
GRANT SELECT ON Dep_Initial_ProductConfig TO Dot_12Bet;
GO
GRANT SELECT ON Dep_Initial_ProductConfig_Detail TO Dot_12Bet;
GO
GRANT SELECT ON Dep_Initial_StepByConfig TO Dot_12Bet;
GO
GRANT SELECT ON Dep_ProductBetSetting TO Dot_12Bet;
GO
GRANT SELECT ON Dep_ProductSetting TO Dot_12Bet;
GO
GRANT SELECT ON Dep_ProductSettingDetail TO Dot_12Bet;
GO
GRANT SELECT ON Dep_ProductSettingType TO Dot_12Bet;
GO
GRANT SELECT ON Dep_ProductStakeLevelGroup TO Dot_12Bet;
GO
GRANT SELECT ON Dep_ProductStatusProfile TO Dot_12Bet;
GO
GRANT SELECT ON Dep_StakeLevel TO Dot_12Bet;
GO
GRANT SELECT ON Dep_StakeLevel_History TO Dot_12Bet;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail TO Dot_12Bet;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail_History TO Dot_12Bet;
GO
GRANT SELECT ON Dep_UMConfig TO Dot_12Bet;
GO
GRANT SELECT ON DomainManagement TO Dot_12Bet;
GO
GRANT SELECT ON GameGroup TO Dot_12Bet;
GO
GRANT SELECT ON GameLaunchPerCurrency TO Dot_12Bet;
GO
GRANT SELECT ON GameLaunchPerSite TO Dot_12Bet;
GO
GRANT SELECT ON LossLimit_GlobalSetting TO Dot_12Bet;
GO
GRANT SELECT ON MaxPayoutGlobalSetting TO Dot_12Bet;
GO
GRANT SELECT ON PlayCurrencySetting TO Dot_12Bet;
GO
GRANT SELECT ON ProductBetSetting TO Dot_12Bet;
GO
GRANT SELECT ON ProductStakeLevelGroup TO Dot_12Bet;
GO
GRANT SELECT ON SettingSystem TO Dot_12Bet;
GO
GRANT SELECT ON Site TO Dot_12Bet;
GO
GRANT SELECT ON SiteDBConfig TO Dot_12Bet;
GO
GRANT SELECT ON SportBettypeSettingMatrix TO Dot_12Bet;
GO
GRANT SELECT ON StakeLevel TO Dot_12Bet;
GO
GRANT SELECT ON StakeLevel_History TO Dot_12Bet;
GO
/*Dot_Admin*/
GRANT SELECT ON Dep_Initial_BetSetting TO Dot_Admin;
GO
GRANT SELECT ON Dep_Initial_ProductConfig TO Dot_Admin;
GO
GRANT SELECT ON Dep_Initial_ProductConfig_Detail TO Dot_Admin;
GO
GRANT SELECT ON Dep_Initial_StepByConfig TO Dot_Admin;
GO
GRANT SELECT ON Dep_ProductBetSetting TO Dot_Admin;
GO
GRANT SELECT ON Dep_ProductSetting TO Dot_Admin;
GO
GRANT SELECT ON Dep_ProductSettingDetail TO Dot_Admin;
GO
GRANT SELECT ON Dep_ProductSettingType TO Dot_Admin;
GO
GRANT SELECT ON Dep_ProductStakeLevelGroup TO Dot_Admin;
GO
GRANT SELECT ON Dep_ProductStatusProfile TO Dot_Admin;
GO
GRANT SELECT ON Dep_StakeLevel TO Dot_Admin;
GO
GRANT SELECT ON Dep_StakeLevel_History TO Dot_Admin;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail TO Dot_Admin;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail_History TO Dot_Admin;
GO
GRANT SELECT ON Dep_UMConfig TO Dot_Admin;
GO
GRANT SELECT ON DomainManagement TO Dot_Admin;
GO
GRANT SELECT ON GameGroup TO Dot_Admin;
GO
GRANT SELECT ON GameLaunchPerCurrency TO Dot_Admin;
GO
GRANT SELECT ON GameLaunchPerSite TO Dot_Admin;
GO
GRANT SELECT ON LossLimit_GlobalSetting TO Dot_Admin;
GO
GRANT SELECT ON MaxPayoutGlobalSetting TO Dot_Admin;
GO
GRANT SELECT ON PlayCurrencySetting TO Dot_Admin;
GO
GRANT SELECT ON ProductBetSetting TO Dot_Admin;
GO
GRANT SELECT ON ProductStakeLevelGroup TO Dot_Admin;
GO
GRANT SELECT ON SettingSystem TO Dot_Admin;
GO
GRANT SELECT ON Site TO Dot_Admin;
GO
GRANT SELECT ON SiteDBConfig TO Dot_Admin;
GO
GRANT SELECT ON SportBettypeSettingMatrix TO Dot_Admin;
GO
GRANT SELECT ON StakeLevel TO Dot_Admin;
GO
GRANT SELECT ON StakeLevel_History TO Dot_Admin;
GO
/*Dot_Casino*/
GRANT SELECT ON Dep_Initial_BetSetting TO Dot_Casino;
GO
GRANT SELECT ON Dep_Initial_ProductConfig TO Dot_Casino;
GO
GRANT SELECT ON Dep_Initial_ProductConfig_Detail TO Dot_Casino;
GO
GRANT SELECT ON Dep_Initial_StepByConfig TO Dot_Casino;
GO
GRANT SELECT ON Dep_ProductBetSetting TO Dot_Casino;
GO
GRANT SELECT ON Dep_ProductSetting TO Dot_Casino;
GO
GRANT SELECT ON Dep_ProductSettingDetail TO Dot_Casino;
GO
GRANT SELECT ON Dep_ProductSettingType TO Dot_Casino;
GO
GRANT SELECT ON Dep_ProductStakeLevelGroup TO Dot_Casino;
GO
GRANT SELECT ON Dep_ProductStatusProfile TO Dot_Casino;
GO
GRANT SELECT ON Dep_StakeLevel TO Dot_Casino;
GO
GRANT SELECT ON Dep_StakeLevel_History TO Dot_Casino;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail TO Dot_Casino;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail_History TO Dot_Casino;
GO
GRANT SELECT ON Dep_UMConfig TO Dot_Casino;
GO
GRANT SELECT ON DomainManagement TO Dot_Casino;
GO
GRANT SELECT ON GameGroup TO Dot_Casino;
GO
GRANT SELECT ON GameLaunchPerCurrency TO Dot_Casino;
GO
GRANT SELECT ON GameLaunchPerSite TO Dot_Casino;
GO
GRANT SELECT ON LossLimit_GlobalSetting TO Dot_Casino;
GO
GRANT SELECT ON MaxPayoutGlobalSetting TO Dot_Casino;
GO
GRANT SELECT ON PlayCurrencySetting TO Dot_Casino;
GO
GRANT SELECT ON ProductBetSetting TO Dot_Casino;
GO
GRANT SELECT ON ProductStakeLevelGroup TO Dot_Casino;
GO
GRANT SELECT ON SettingSystem TO Dot_Casino;
GO
GRANT SELECT ON Site TO Dot_Casino;
GO
GRANT SELECT ON SiteDBConfig TO Dot_Casino;
GO
GRANT SELECT ON SportBettypeSettingMatrix TO Dot_Casino;
GO
GRANT SELECT ON StakeLevel TO Dot_Casino;
GO
GRANT SELECT ON StakeLevel_History TO Dot_Casino;
GO
/*Dot_Evolution*/
GRANT SELECT ON Dep_Initial_BetSetting TO Dot_Evolution;
GO
GRANT SELECT ON Dep_Initial_ProductConfig TO Dot_Evolution;
GO
GRANT SELECT ON Dep_Initial_ProductConfig_Detail TO Dot_Evolution;
GO
GRANT SELECT ON Dep_Initial_StepByConfig TO Dot_Evolution;
GO
GRANT SELECT ON Dep_ProductBetSetting TO Dot_Evolution;
GO
GRANT SELECT ON Dep_ProductSetting TO Dot_Evolution;
GO
GRANT SELECT ON Dep_ProductSettingDetail TO Dot_Evolution;
GO
GRANT SELECT ON Dep_ProductSettingType TO Dot_Evolution;
GO
GRANT SELECT ON Dep_ProductStakeLevelGroup TO Dot_Evolution;
GO
GRANT SELECT ON Dep_ProductStatusProfile TO Dot_Evolution;
GO
GRANT SELECT ON Dep_StakeLevel TO Dot_Evolution;
GO
GRANT SELECT ON Dep_StakeLevel_History TO Dot_Evolution;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail TO Dot_Evolution;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail_History TO Dot_Evolution;
GO
GRANT SELECT ON Dep_UMConfig TO Dot_Evolution;
GO
GRANT SELECT ON DomainManagement TO Dot_Evolution;
GO
GRANT SELECT ON GameGroup TO Dot_Evolution;
GO
GRANT SELECT ON GameLaunchPerCurrency TO Dot_Evolution;
GO
GRANT SELECT ON GameLaunchPerSite TO Dot_Evolution;
GO
GRANT SELECT ON LossLimit_GlobalSetting TO Dot_Evolution;
GO
GRANT SELECT ON MaxPayoutGlobalSetting TO Dot_Evolution;
GO
GRANT SELECT ON PlayCurrencySetting TO Dot_Evolution;
GO
GRANT SELECT ON ProductBetSetting TO Dot_Evolution;
GO
GRANT SELECT ON ProductStakeLevelGroup TO Dot_Evolution;
GO
GRANT SELECT ON SettingSystem TO Dot_Evolution;
GO
GRANT SELECT ON Site TO Dot_Evolution;
GO
GRANT SELECT ON SiteDBConfig TO Dot_Evolution;
GO
GRANT SELECT ON SportBettypeSettingMatrix TO Dot_Evolution;
GO
GRANT SELECT ON StakeLevel TO Dot_Evolution;
GO
GRANT SELECT ON StakeLevel_History TO Dot_Evolution;
GO
/*Dot_Intg*/
GRANT SELECT ON Dep_Initial_BetSetting TO Dot_Intg;
GO
GRANT SELECT ON Dep_Initial_ProductConfig TO Dot_Intg;
GO
GRANT SELECT ON Dep_Initial_ProductConfig_Detail TO Dot_Intg;
GO
GRANT SELECT ON Dep_Initial_StepByConfig TO Dot_Intg;
GO
GRANT SELECT ON Dep_ProductBetSetting TO Dot_Intg;
GO
GRANT SELECT ON Dep_ProductSetting TO Dot_Intg;
GO
GRANT SELECT ON Dep_ProductSettingDetail TO Dot_Intg;
GO
GRANT SELECT ON Dep_ProductSettingType TO Dot_Intg;
GO
GRANT SELECT ON Dep_ProductStakeLevelGroup TO Dot_Intg;
GO
GRANT SELECT ON Dep_ProductStatusProfile TO Dot_Intg;
GO
GRANT SELECT ON Dep_StakeLevel TO Dot_Intg;
GO
GRANT SELECT ON Dep_StakeLevel_History TO Dot_Intg;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail TO Dot_Intg;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail_History TO Dot_Intg;
GO
GRANT SELECT ON Dep_UMConfig TO Dot_Intg;
GO
GRANT SELECT ON DomainManagement TO Dot_Intg;
GO
GRANT SELECT ON GameGroup TO Dot_Intg;
GO
GRANT SELECT ON GameLaunchPerCurrency TO Dot_Intg;
GO
GRANT SELECT ON GameLaunchPerSite TO Dot_Intg;
GO
GRANT SELECT ON LossLimit_GlobalSetting TO Dot_Intg;
GO
GRANT SELECT ON MaxPayoutGlobalSetting TO Dot_Intg;
GO
GRANT SELECT ON PlayCurrencySetting TO Dot_Intg;
GO
GRANT SELECT ON ProductBetSetting TO Dot_Intg;
GO
GRANT SELECT ON ProductStakeLevelGroup TO Dot_Intg;
GO
GRANT SELECT ON SettingSystem TO Dot_Intg;
GO
GRANT SELECT ON Site TO Dot_Intg;
GO
GRANT SELECT ON SiteDBConfig TO Dot_Intg;
GO
GRANT SELECT ON SportBettypeSettingMatrix TO Dot_Intg;
GO
GRANT SELECT ON StakeLevel TO Dot_Intg;
GO
GRANT SELECT ON StakeLevel_History TO Dot_Intg;
GO
/*Dot_Member*/
GRANT SELECT ON Dep_Initial_BetSetting TO Dot_Member;
GO
GRANT SELECT ON Dep_Initial_ProductConfig TO Dot_Member;
GO
GRANT SELECT ON Dep_Initial_ProductConfig_Detail TO Dot_Member;
GO
GRANT SELECT ON Dep_Initial_StepByConfig TO Dot_Member;
GO
GRANT SELECT ON Dep_ProductBetSetting TO Dot_Member;
GO
GRANT SELECT ON Dep_ProductSetting TO Dot_Member;
GO
GRANT SELECT ON Dep_ProductSettingDetail TO Dot_Member;
GO
GRANT SELECT ON Dep_ProductSettingType TO Dot_Member;
GO
GRANT SELECT ON Dep_ProductStakeLevelGroup TO Dot_Member;
GO
GRANT SELECT ON Dep_ProductStatusProfile TO Dot_Member;
GO
GRANT SELECT ON Dep_StakeLevel TO Dot_Member;
GO
GRANT SELECT ON Dep_StakeLevel_History TO Dot_Member;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail TO Dot_Member;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail_History TO Dot_Member;
GO
GRANT SELECT ON Dep_UMConfig TO Dot_Member;
GO
GRANT SELECT ON DomainManagement TO Dot_Member;
GO
GRANT SELECT ON GameGroup TO Dot_Member;
GO
GRANT SELECT ON GameLaunchPerCurrency TO Dot_Member;
GO
GRANT SELECT ON GameLaunchPerSite TO Dot_Member;
GO
GRANT SELECT ON LossLimit_GlobalSetting TO Dot_Member;
GO
GRANT SELECT ON MaxPayoutGlobalSetting TO Dot_Member;
GO
GRANT SELECT ON PlayCurrencySetting TO Dot_Member;
GO
GRANT SELECT ON ProductBetSetting TO Dot_Member;
GO
GRANT SELECT ON ProductStakeLevelGroup TO Dot_Member;
GO
GRANT SELECT ON SettingSystem TO Dot_Member;
GO
GRANT SELECT ON Site TO Dot_Member;
GO
GRANT SELECT ON SiteDBConfig TO Dot_Member;
GO
GRANT SELECT ON SportBettypeSettingMatrix TO Dot_Member;
GO
GRANT SELECT ON StakeLevel TO Dot_Member;
GO
GRANT SELECT ON StakeLevel_History TO Dot_Member;
GO
/*LicBIUser*/
GRANT SELECT ON Dep_Initial_BetSetting TO LicBIUser;
GO
GRANT SELECT ON Dep_Initial_ProductConfig TO LicBIUser;
GO
GRANT SELECT ON Dep_Initial_ProductConfig_Detail TO LicBIUser;
GO
GRANT SELECT ON Dep_Initial_StepByConfig TO LicBIUser;
GO
GRANT SELECT ON Dep_ProductBetSetting TO LicBIUser;
GO
GRANT SELECT ON Dep_ProductSetting TO LicBIUser;
GO
GRANT SELECT ON Dep_ProductSettingDetail TO LicBIUser;
GO
GRANT SELECT ON Dep_ProductSettingType TO LicBIUser;
GO
GRANT SELECT ON Dep_ProductStakeLevelGroup TO LicBIUser;
GO
GRANT SELECT ON Dep_ProductStatusProfile TO LicBIUser;
GO
GRANT SELECT ON Dep_StakeLevel TO LicBIUser;
GO
GRANT SELECT ON Dep_StakeLevel_History TO LicBIUser;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail TO LicBIUser;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail_History TO LicBIUser;
GO
GRANT SELECT ON Dep_UMConfig TO LicBIUser;
GO
GRANT SELECT ON DomainManagement TO LicBIUser;
GO
GRANT SELECT ON GameGroup TO LicBIUser;
GO
GRANT SELECT ON GameLaunchPerCurrency TO LicBIUser;
GO
GRANT SELECT ON GameLaunchPerSite TO LicBIUser;
GO
GRANT SELECT ON LossLimit_GlobalSetting TO LicBIUser;
GO
GRANT SELECT ON MaxPayoutGlobalSetting TO LicBIUser;
GO
GRANT SELECT ON PlayCurrencySetting TO LicBIUser;
GO
GRANT SELECT ON ProductBetSetting TO LicBIUser;
GO
GRANT SELECT ON ProductStakeLevelGroup TO LicBIUser;
GO
GRANT SELECT ON SettingSystem TO LicBIUser;
GO
GRANT SELECT ON Site TO LicBIUser;
GO
GRANT SELECT ON SiteDBConfig TO LicBIUser;
GO
GRANT SELECT ON SportBettypeSettingMatrix TO LicBIUser;
GO
GRANT SELECT ON StakeLevel TO LicBIUser;
GO
GRANT SELECT ON StakeLevel_History TO LicBIUser;
GO
/*ow_12bet*/
GRANT SELECT ON Dep_Initial_BetSetting TO ow_12bet;
GO
GRANT SELECT ON Dep_Initial_ProductConfig TO ow_12bet;
GO
GRANT SELECT ON Dep_Initial_ProductConfig_Detail TO ow_12bet;
GO
GRANT SELECT ON Dep_Initial_StepByConfig TO ow_12bet;
GO
GRANT SELECT ON Dep_ProductBetSetting TO ow_12bet;
GO
GRANT SELECT ON Dep_ProductSetting TO ow_12bet;
GO
GRANT SELECT ON Dep_ProductSettingDetail TO ow_12bet;
GO
GRANT SELECT ON Dep_ProductSettingType TO ow_12bet;
GO
GRANT SELECT ON Dep_ProductStakeLevelGroup TO ow_12bet;
GO
GRANT SELECT ON Dep_ProductStatusProfile TO ow_12bet;
GO
GRANT SELECT ON Dep_StakeLevel TO ow_12bet;
GO
GRANT SELECT ON Dep_StakeLevel_History TO ow_12bet;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail TO ow_12bet;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail_History TO ow_12bet;
GO
GRANT SELECT ON Dep_UMConfig TO ow_12bet;
GO
GRANT SELECT ON DomainManagement TO ow_12bet;
GO
GRANT SELECT ON GameGroup TO ow_12bet;
GO
GRANT SELECT ON GameLaunchPerCurrency TO ow_12bet;
GO
GRANT SELECT ON GameLaunchPerSite TO ow_12bet;
GO
GRANT SELECT ON LossLimit_GlobalSetting TO ow_12bet;
GO
GRANT SELECT ON MaxPayoutGlobalSetting TO ow_12bet;
GO
GRANT SELECT ON PlayCurrencySetting TO ow_12bet;
GO
GRANT SELECT ON ProductBetSetting TO ow_12bet;
GO
GRANT SELECT ON ProductStakeLevelGroup TO ow_12bet;
GO
GRANT SELECT ON SettingSystem TO ow_12bet;
GO
GRANT SELECT ON Site TO ow_12bet;
GO
GRANT SELECT ON SiteDBConfig TO ow_12bet;
GO
GRANT SELECT ON SportBettypeSettingMatrix TO ow_12bet;
GO
GRANT SELECT ON StakeLevel TO ow_12bet;
GO
GRANT SELECT ON StakeLevel_History TO ow_12bet;
GO
/*ow_lic_12bet*/
GRANT SELECT ON Dep_Initial_BetSetting TO ow_lic_12bet;
GO
GRANT SELECT ON Dep_Initial_ProductConfig TO ow_lic_12bet;
GO
GRANT SELECT ON Dep_Initial_ProductConfig_Detail TO ow_lic_12bet;
GO
GRANT SELECT ON Dep_Initial_StepByConfig TO ow_lic_12bet;
GO
GRANT SELECT ON Dep_ProductBetSetting TO ow_lic_12bet;
GO
GRANT SELECT ON Dep_ProductSetting TO ow_lic_12bet;
GO
GRANT SELECT ON Dep_ProductSettingDetail TO ow_lic_12bet;
GO
GRANT SELECT ON Dep_ProductSettingType TO ow_lic_12bet;
GO
GRANT SELECT ON Dep_ProductStakeLevelGroup TO ow_lic_12bet;
GO
GRANT SELECT ON Dep_ProductStatusProfile TO ow_lic_12bet;
GO
GRANT SELECT ON Dep_StakeLevel TO ow_lic_12bet;
GO
GRANT SELECT ON Dep_StakeLevel_History TO ow_lic_12bet;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail TO ow_lic_12bet;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail_History TO ow_lic_12bet;
GO
GRANT SELECT ON Dep_UMConfig TO ow_lic_12bet;
GO
GRANT SELECT ON DomainManagement TO ow_lic_12bet;
GO
GRANT SELECT ON GameGroup TO ow_lic_12bet;
GO
GRANT SELECT ON GameLaunchPerCurrency TO ow_lic_12bet;
GO
GRANT SELECT ON GameLaunchPerSite TO ow_lic_12bet;
GO
GRANT SELECT ON LossLimit_GlobalSetting TO ow_lic_12bet;
GO
GRANT SELECT ON MaxPayoutGlobalSetting TO ow_lic_12bet;
GO
GRANT SELECT ON PlayCurrencySetting TO ow_lic_12bet;
GO
GRANT SELECT ON ProductBetSetting TO ow_lic_12bet;
GO
GRANT SELECT ON ProductStakeLevelGroup TO ow_lic_12bet;
GO
GRANT SELECT ON SettingSystem TO ow_lic_12bet;
GO
GRANT SELECT ON Site TO ow_lic_12bet;
GO
GRANT SELECT ON SiteDBConfig TO ow_lic_12bet;
GO
GRANT SELECT ON SportBettypeSettingMatrix TO ow_lic_12bet;
GO
GRANT SELECT ON StakeLevel TO ow_lic_12bet;
GO
GRANT SELECT ON StakeLevel_History TO ow_lic_12bet;
GO
/*sportsbook_refdata*/
GRANT SELECT ON Dep_Initial_BetSetting TO sportsbook_refdata;
GO
GRANT SELECT ON Dep_Initial_ProductConfig TO sportsbook_refdata;
GO
GRANT SELECT ON Dep_Initial_ProductConfig_Detail TO sportsbook_refdata;
GO
GRANT SELECT ON Dep_Initial_StepByConfig TO sportsbook_refdata;
GO
GRANT SELECT ON Dep_ProductBetSetting TO sportsbook_refdata;
GO
GRANT SELECT ON Dep_ProductSetting TO sportsbook_refdata;
GO
GRANT SELECT ON Dep_ProductSettingDetail TO sportsbook_refdata;
GO
GRANT SELECT ON Dep_ProductSettingType TO sportsbook_refdata;
GO
GRANT SELECT ON Dep_ProductStakeLevelGroup TO sportsbook_refdata;
GO
GRANT SELECT ON Dep_ProductStatusProfile TO sportsbook_refdata;
GO
GRANT SELECT ON Dep_StakeLevel TO sportsbook_refdata;
GO
GRANT SELECT ON Dep_StakeLevel_History TO sportsbook_refdata;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail TO sportsbook_refdata;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail_History TO sportsbook_refdata;
GO
GRANT SELECT ON Dep_UMConfig TO sportsbook_refdata;
GO
GRANT SELECT ON DomainManagement TO sportsbook_refdata;
GO
GRANT SELECT ON GameGroup TO sportsbook_refdata;
GO
GRANT SELECT ON GameLaunchPerCurrency TO sportsbook_refdata;
GO
GRANT SELECT ON GameLaunchPerSite TO sportsbook_refdata;
GO
GRANT SELECT ON LossLimit_GlobalSetting TO sportsbook_refdata;
GO
GRANT SELECT ON MaxPayoutGlobalSetting TO sportsbook_refdata;
GO
GRANT SELECT ON PlayCurrencySetting TO sportsbook_refdata;
GO
GRANT SELECT ON ProductBetSetting TO sportsbook_refdata;
GO
GRANT SELECT ON ProductStakeLevelGroup TO sportsbook_refdata;
GO
GRANT SELECT ON SettingSystem TO sportsbook_refdata;
GO
GRANT SELECT ON Site TO sportsbook_refdata;
GO
GRANT SELECT ON SiteDBConfig TO sportsbook_refdata;
GO
GRANT SELECT ON SportBettypeSettingMatrix TO sportsbook_refdata;
GO
GRANT SELECT ON StakeLevel TO sportsbook_refdata;
GO
GRANT SELECT ON StakeLevel_History TO sportsbook_refdata;
GO
/*svc_tig*/
GRANT SELECT ON Dep_Initial_BetSetting TO svc_tig;
GO
GRANT SELECT ON Dep_Initial_ProductConfig TO svc_tig;
GO
GRANT SELECT ON Dep_Initial_ProductConfig_Detail TO svc_tig;
GO
GRANT SELECT ON Dep_Initial_StepByConfig TO svc_tig;
GO
GRANT SELECT ON Dep_ProductBetSetting TO svc_tig;
GO
GRANT SELECT ON Dep_ProductSetting TO svc_tig;
GO
GRANT SELECT ON Dep_ProductSettingDetail TO svc_tig;
GO
GRANT SELECT ON Dep_ProductSettingType TO svc_tig;
GO
GRANT SELECT ON Dep_ProductStakeLevelGroup TO svc_tig;
GO
GRANT SELECT ON Dep_ProductStatusProfile TO svc_tig;
GO
GRANT SELECT ON Dep_StakeLevel TO svc_tig;
GO
GRANT SELECT ON Dep_StakeLevel_History TO svc_tig;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail TO svc_tig;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail_History TO svc_tig;
GO
GRANT SELECT ON Dep_UMConfig TO svc_tig;
GO
GRANT SELECT ON DomainManagement TO svc_tig;
GO
GRANT SELECT ON GameGroup TO svc_tig;
GO
GRANT SELECT ON GameLaunchPerCurrency TO svc_tig;
GO
GRANT SELECT ON GameLaunchPerSite TO svc_tig;
GO
GRANT SELECT ON LossLimit_GlobalSetting TO svc_tig;
GO
GRANT SELECT ON MaxPayoutGlobalSetting TO svc_tig;
GO
GRANT SELECT ON PlayCurrencySetting TO svc_tig;
GO
GRANT SELECT ON ProductBetSetting TO svc_tig;
GO
GRANT SELECT ON ProductStakeLevelGroup TO svc_tig;
GO
GRANT SELECT ON SettingSystem TO svc_tig;
GO
GRANT SELECT ON Site TO svc_tig;
GO
GRANT SELECT ON SiteDBConfig TO svc_tig;
GO
GRANT SELECT ON SportBettypeSettingMatrix TO svc_tig;
GO
GRANT SELECT ON StakeLevel TO svc_tig;
GO
GRANT SELECT ON StakeLevel_History TO svc_tig;
GO
/*wsv_afinet*/
GRANT SELECT ON Dep_Initial_BetSetting TO wsv_afinet;
GO
GRANT SELECT ON Dep_Initial_ProductConfig TO wsv_afinet;
GO
GRANT SELECT ON Dep_Initial_ProductConfig_Detail TO wsv_afinet;
GO
GRANT SELECT ON Dep_Initial_StepByConfig TO wsv_afinet;
GO
GRANT SELECT ON Dep_ProductBetSetting TO wsv_afinet;
GO
GRANT SELECT ON Dep_ProductSetting TO wsv_afinet;
GO
GRANT SELECT ON Dep_ProductSettingDetail TO wsv_afinet;
GO
GRANT SELECT ON Dep_ProductSettingType TO wsv_afinet;
GO
GRANT SELECT ON Dep_ProductStakeLevelGroup TO wsv_afinet;
GO
GRANT SELECT ON Dep_ProductStatusProfile TO wsv_afinet;
GO
GRANT SELECT ON Dep_StakeLevel TO wsv_afinet;
GO
GRANT SELECT ON Dep_StakeLevel_History TO wsv_afinet;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail TO wsv_afinet;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail_History TO wsv_afinet;
GO
GRANT SELECT ON Dep_UMConfig TO wsv_afinet;
GO
GRANT SELECT ON DomainManagement TO wsv_afinet;
GO
GRANT SELECT ON GameGroup TO wsv_afinet;
GO
GRANT SELECT ON GameLaunchPerCurrency TO wsv_afinet;
GO
GRANT SELECT ON GameLaunchPerSite TO wsv_afinet;
GO
GRANT SELECT ON LossLimit_GlobalSetting TO wsv_afinet;
GO
GRANT SELECT ON MaxPayoutGlobalSetting TO wsv_afinet;
GO
GRANT SELECT ON PlayCurrencySetting TO wsv_afinet;
GO
GRANT SELECT ON ProductBetSetting TO wsv_afinet;
GO
GRANT SELECT ON ProductStakeLevelGroup TO wsv_afinet;
GO
GRANT SELECT ON SettingSystem TO wsv_afinet;
GO
GRANT SELECT ON Site TO wsv_afinet;
GO
GRANT SELECT ON SiteDBConfig TO wsv_afinet;
GO
GRANT SELECT ON SportBettypeSettingMatrix TO wsv_afinet;
GO
GRANT SELECT ON StakeLevel TO wsv_afinet;
GO
GRANT SELECT ON StakeLevel_History TO wsv_afinet;
GO
/*wsv_alp*/
GRANT SELECT ON Dep_Initial_BetSetting TO wsv_alp;
GO
GRANT SELECT ON Dep_Initial_ProductConfig TO wsv_alp;
GO
GRANT SELECT ON Dep_Initial_ProductConfig_Detail TO wsv_alp;
GO
GRANT SELECT ON Dep_Initial_StepByConfig TO wsv_alp;
GO
GRANT SELECT ON Dep_ProductBetSetting TO wsv_alp;
GO
GRANT SELECT ON Dep_ProductSetting TO wsv_alp;
GO
GRANT SELECT ON Dep_ProductSettingDetail TO wsv_alp;
GO
GRANT SELECT ON Dep_ProductSettingType TO wsv_alp;
GO
GRANT SELECT ON Dep_ProductStakeLevelGroup TO wsv_alp;
GO
GRANT SELECT ON Dep_ProductStatusProfile TO wsv_alp;
GO
GRANT SELECT ON Dep_StakeLevel TO wsv_alp;
GO
GRANT SELECT ON Dep_StakeLevel_History TO wsv_alp;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail TO wsv_alp;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail_History TO wsv_alp;
GO
GRANT SELECT ON Dep_UMConfig TO wsv_alp;
GO
GRANT SELECT ON DomainManagement TO wsv_alp;
GO
GRANT SELECT ON GameGroup TO wsv_alp;
GO
GRANT SELECT ON GameLaunchPerCurrency TO wsv_alp;
GO
GRANT SELECT ON GameLaunchPerSite TO wsv_alp;
GO
GRANT SELECT ON LossLimit_GlobalSetting TO wsv_alp;
GO
GRANT SELECT ON MaxPayoutGlobalSetting TO wsv_alp;
GO
GRANT SELECT ON PlayCurrencySetting TO wsv_alp;
GO
GRANT SELECT ON ProductBetSetting TO wsv_alp;
GO
GRANT SELECT ON ProductStakeLevelGroup TO wsv_alp;
GO
GRANT SELECT ON SettingSystem TO wsv_alp;
GO
GRANT SELECT ON Site TO wsv_alp;
GO
GRANT SELECT ON SiteDBConfig TO wsv_alp;
GO
GRANT SELECT ON SportBettypeSettingMatrix TO wsv_alp;
GO
GRANT SELECT ON StakeLevel TO wsv_alp;
GO
GRANT SELECT ON StakeLevel_History TO wsv_alp;
GO
/*wsv_alpv*/
GRANT SELECT ON Dep_Initial_BetSetting TO wsv_alpv;
GO
GRANT SELECT ON Dep_Initial_ProductConfig TO wsv_alpv;
GO
GRANT SELECT ON Dep_Initial_ProductConfig_Detail TO wsv_alpv;
GO
GRANT SELECT ON Dep_Initial_StepByConfig TO wsv_alpv;
GO
GRANT SELECT ON Dep_ProductBetSetting TO wsv_alpv;
GO
GRANT SELECT ON Dep_ProductSetting TO wsv_alpv;
GO
GRANT SELECT ON Dep_ProductSettingDetail TO wsv_alpv;
GO
GRANT SELECT ON Dep_ProductSettingType TO wsv_alpv;
GO
GRANT SELECT ON Dep_ProductStakeLevelGroup TO wsv_alpv;
GO
GRANT SELECT ON Dep_ProductStatusProfile TO wsv_alpv;
GO
GRANT SELECT ON Dep_StakeLevel TO wsv_alpv;
GO
GRANT SELECT ON Dep_StakeLevel_History TO wsv_alpv;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail TO wsv_alpv;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail_History TO wsv_alpv;
GO
GRANT SELECT ON Dep_UMConfig TO wsv_alpv;
GO
GRANT SELECT ON DomainManagement TO wsv_alpv;
GO
GRANT SELECT ON GameGroup TO wsv_alpv;
GO
GRANT SELECT ON GameLaunchPerCurrency TO wsv_alpv;
GO
GRANT SELECT ON GameLaunchPerSite TO wsv_alpv;
GO
GRANT SELECT ON LossLimit_GlobalSetting TO wsv_alpv;
GO
GRANT SELECT ON MaxPayoutGlobalSetting TO wsv_alpv;
GO
GRANT SELECT ON PlayCurrencySetting TO wsv_alpv;
GO
GRANT SELECT ON ProductBetSetting TO wsv_alpv;
GO
GRANT SELECT ON ProductStakeLevelGroup TO wsv_alpv;
GO
GRANT SELECT ON SettingSystem TO wsv_alpv;
GO
GRANT SELECT ON Site TO wsv_alpv;
GO
GRANT SELECT ON SiteDBConfig TO wsv_alpv;
GO
GRANT SELECT ON SportBettypeSettingMatrix TO wsv_alpv;
GO
GRANT SELECT ON StakeLevel TO wsv_alpv;
GO
GRANT SELECT ON StakeLevel_History TO wsv_alpv;
GO
/*wsv_lap*/
GRANT SELECT ON Dep_Initial_BetSetting TO wsv_lap;
GO
GRANT SELECT ON Dep_Initial_ProductConfig TO wsv_lap;
GO
GRANT SELECT ON Dep_Initial_ProductConfig_Detail TO wsv_lap;
GO
GRANT SELECT ON Dep_Initial_StepByConfig TO wsv_lap;
GO
GRANT SELECT ON Dep_ProductBetSetting TO wsv_lap;
GO
GRANT SELECT ON Dep_ProductSetting TO wsv_lap;
GO
GRANT SELECT ON Dep_ProductSettingDetail TO wsv_lap;
GO
GRANT SELECT ON Dep_ProductSettingType TO wsv_lap;
GO
GRANT SELECT ON Dep_ProductStakeLevelGroup TO wsv_lap;
GO
GRANT SELECT ON Dep_ProductStatusProfile TO wsv_lap;
GO
GRANT SELECT ON Dep_StakeLevel TO wsv_lap;
GO
GRANT SELECT ON Dep_StakeLevel_History TO wsv_lap;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail TO wsv_lap;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail_History TO wsv_lap;
GO
GRANT SELECT ON Dep_UMConfig TO wsv_lap;
GO
GRANT SELECT ON DomainManagement TO wsv_lap;
GO
GRANT SELECT ON GameGroup TO wsv_lap;
GO
GRANT SELECT ON GameLaunchPerCurrency TO wsv_lap;
GO
GRANT SELECT ON GameLaunchPerSite TO wsv_lap;
GO
GRANT SELECT ON LossLimit_GlobalSetting TO wsv_lap;
GO
GRANT SELECT ON MaxPayoutGlobalSetting TO wsv_lap;
GO
GRANT SELECT ON PlayCurrencySetting TO wsv_lap;
GO
GRANT SELECT ON ProductBetSetting TO wsv_lap;
GO
GRANT SELECT ON ProductStakeLevelGroup TO wsv_lap;
GO
GRANT SELECT ON SettingSystem TO wsv_lap;
GO
GRANT SELECT ON Site TO wsv_lap;
GO
GRANT SELECT ON SiteDBConfig TO wsv_lap;
GO
GRANT SELECT ON SportBettypeSettingMatrix TO wsv_lap;
GO
GRANT SELECT ON StakeLevel TO wsv_lap;
GO
GRANT SELECT ON StakeLevel_History TO wsv_lap;
GO
/*wsv_nap*/
GRANT SELECT ON Dep_Initial_BetSetting TO wsv_nap;
GO
GRANT SELECT ON Dep_Initial_ProductConfig TO wsv_nap;
GO
GRANT SELECT ON Dep_Initial_ProductConfig_Detail TO wsv_nap;
GO
GRANT SELECT ON Dep_Initial_StepByConfig TO wsv_nap;
GO
GRANT SELECT ON Dep_ProductBetSetting TO wsv_nap;
GO
GRANT SELECT ON Dep_ProductSetting TO wsv_nap;
GO
GRANT SELECT ON Dep_ProductSettingDetail TO wsv_nap;
GO
GRANT SELECT ON Dep_ProductSettingType TO wsv_nap;
GO
GRANT SELECT ON Dep_ProductStakeLevelGroup TO wsv_nap;
GO
GRANT SELECT ON Dep_ProductStatusProfile TO wsv_nap;
GO
GRANT SELECT ON Dep_StakeLevel TO wsv_nap;
GO
GRANT SELECT ON Dep_StakeLevel_History TO wsv_nap;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail TO wsv_nap;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail_History TO wsv_nap;
GO
GRANT SELECT ON Dep_UMConfig TO wsv_nap;
GO
GRANT SELECT ON DomainManagement TO wsv_nap;
GO
GRANT SELECT ON GameGroup TO wsv_nap;
GO
GRANT SELECT ON GameLaunchPerCurrency TO wsv_nap;
GO
GRANT SELECT ON GameLaunchPerSite TO wsv_nap;
GO
GRANT SELECT ON LossLimit_GlobalSetting TO wsv_nap;
GO
GRANT SELECT ON MaxPayoutGlobalSetting TO wsv_nap;
GO
GRANT SELECT ON PlayCurrencySetting TO wsv_nap;
GO
GRANT SELECT ON ProductBetSetting TO wsv_nap;
GO
GRANT SELECT ON ProductStakeLevelGroup TO wsv_nap;
GO
GRANT SELECT ON SettingSystem TO wsv_nap;
GO
GRANT SELECT ON Site TO wsv_nap;
GO
GRANT SELECT ON SiteDBConfig TO wsv_nap;
GO
GRANT SELECT ON SportBettypeSettingMatrix TO wsv_nap;
GO
GRANT SELECT ON StakeLevel TO wsv_nap;
GO
GRANT SELECT ON StakeLevel_History TO wsv_nap;
GO
/*wsv_xnap*/
GRANT SELECT ON Dep_Initial_BetSetting TO wsv_xnap;
GO
GRANT SELECT ON Dep_Initial_ProductConfig TO wsv_xnap;
GO
GRANT SELECT ON Dep_Initial_ProductConfig_Detail TO wsv_xnap;
GO
GRANT SELECT ON Dep_Initial_StepByConfig TO wsv_xnap;
GO
GRANT SELECT ON Dep_ProductBetSetting TO wsv_xnap;
GO
GRANT SELECT ON Dep_ProductSetting TO wsv_xnap;
GO
GRANT SELECT ON Dep_ProductSettingDetail TO wsv_xnap;
GO
GRANT SELECT ON Dep_ProductSettingType TO wsv_xnap;
GO
GRANT SELECT ON Dep_ProductStakeLevelGroup TO wsv_xnap;
GO
GRANT SELECT ON Dep_ProductStatusProfile TO wsv_xnap;
GO
GRANT SELECT ON Dep_StakeLevel TO wsv_xnap;
GO
GRANT SELECT ON Dep_StakeLevel_History TO wsv_xnap;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail TO wsv_xnap;
GO
GRANT SELECT ON Dep_StakeLevelGroupDetail_History TO wsv_xnap;
GO
GRANT SELECT ON Dep_UMConfig TO wsv_xnap;
GO
GRANT SELECT ON DomainManagement TO wsv_xnap;
GO
GRANT SELECT ON GameGroup TO wsv_xnap;
GO
GRANT SELECT ON GameLaunchPerCurrency TO wsv_xnap;
GO
GRANT SELECT ON GameLaunchPerSite TO wsv_xnap;
GO
GRANT SELECT ON LossLimit_GlobalSetting TO wsv_xnap;
GO
GRANT SELECT ON MaxPayoutGlobalSetting TO wsv_xnap;
GO
GRANT SELECT ON PlayCurrencySetting TO wsv_xnap;
GO
GRANT SELECT ON ProductBetSetting TO wsv_xnap;
GO
GRANT SELECT ON ProductStakeLevelGroup TO wsv_xnap;
GO
GRANT SELECT ON SettingSystem TO wsv_xnap;
GO
GRANT SELECT ON Site TO wsv_xnap;
GO
GRANT SELECT ON SiteDBConfig TO wsv_xnap;
GO
GRANT SELECT ON SportBettypeSettingMatrix TO wsv_xnap;
GO
GRANT SELECT ON StakeLevel TO wsv_xnap;
GO
GRANT SELECT ON StakeLevel_History TO wsv_xnap;
GO