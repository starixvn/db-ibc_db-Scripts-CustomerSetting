/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Dave
	Date: 20250120
	Task: Rename table to original name if View not exists [RedmineID:#216870]
	DB: DBCust/CustDB
*/

USE CustDB
GO

IF OBJECT_ID('Dep_Initial_BetSetting', 'V') IS NULL AND OBJECT_ID('Dep_Initial_BetSetting') IS NULL
	exec sp_rename 'dbo.Del_Dep_Initial_BetSetting','Dep_Initial_BetSetting';
GO
IF OBJECT_ID('Dep_Initial_ProductConfig', 'V') IS NULL AND OBJECT_ID('Dep_Initial_ProductConfig') IS NULL
	exec sp_rename 'dbo.Del_Dep_Initial_ProductConfig','Dep_Initial_ProductConfig';
GO
IF OBJECT_ID('Dep_Initial_ProductConfig_Detail', 'V') IS NULL AND OBJECT_ID('Dep_Initial_ProductConfig_Detail') IS NULL
	exec sp_rename 'dbo.Del_Dep_Initial_ProductConfig_Detail','Dep_Initial_ProductConfig_Detail';
GO
IF OBJECT_ID('Dep_Initial_StepByConfig', 'V') IS NULL AND OBJECT_ID('Dep_Initial_StepByConfig') IS NULL
	exec sp_rename 'dbo.Del_Dep_Initial_StepByConfig','Dep_Initial_StepByConfig';
GO
IF OBJECT_ID('Dep_ProductBetSetting', 'V') IS NULL AND OBJECT_ID('Dep_ProductBetSetting') IS NULL
	exec sp_rename 'dbo.Del_Dep_ProductBetSetting','Dep_ProductBetSetting';
GO
IF OBJECT_ID('Dep_ProductSetting', 'V') IS NULL AND OBJECT_ID('Dep_ProductSetting') IS NULL
	exec sp_rename 'dbo.Del_Dep_ProductSetting','Dep_ProductSetting';
GO
IF OBJECT_ID('Dep_ProductSettingDetail', 'V') IS NULL AND OBJECT_ID('Dep_ProductSettingDetail') IS NULL
	exec sp_rename 'dbo.Del_Dep_ProductSettingDetail','Dep_ProductSettingDetail';
GO
IF OBJECT_ID('Dep_ProductSettingType', 'V') IS NULL AND OBJECT_ID('Dep_ProductSettingType') IS NULL
	exec sp_rename 'dbo.Del_Dep_ProductSettingType','Dep_ProductSettingType';
GO
IF OBJECT_ID('Dep_ProductStakeLevelGroup', 'V') IS NULL AND OBJECT_ID('Dep_ProductStakeLevelGroup') IS NULL
	exec sp_rename 'dbo.Del_Dep_ProductStakeLevelGroup','Dep_ProductStakeLevelGroup';
GO
IF OBJECT_ID('Dep_ProductStatusProfile', 'V') IS NULL AND OBJECT_ID('Dep_ProductStatusProfile') IS NULL
	exec sp_rename 'dbo.Del_Dep_ProductStatusProfile','Dep_ProductStatusProfile';
GO
IF OBJECT_ID('Dep_StakeLevel', 'V') IS NULL AND OBJECT_ID('Dep_StakeLevel') IS NULL
	exec sp_rename 'dbo.Del_Dep_StakeLevel','Dep_StakeLevel';
GO
IF OBJECT_ID('Dep_StakeLevel_History', 'V') IS NULL AND OBJECT_ID('Dep_StakeLevel_History') IS NULL
	exec sp_rename 'dbo.Del_Dep_StakeLevel_History','Dep_StakeLevel_History';
GO
IF OBJECT_ID('Dep_StakeLevelGroupDetail', 'V') IS NULL AND OBJECT_ID('Dep_StakeLevelGroupDetail') IS NULL
	exec sp_rename 'dbo.Del_Dep_StakeLevelGroupDetail','Dep_StakeLevelGroupDetail';
GO
IF OBJECT_ID('Dep_StakeLevelGroupDetail_History', 'V') IS NULL AND OBJECT_ID('Dep_StakeLevelGroupDetail_History') IS NULL
	exec sp_rename 'dbo.Del_Dep_StakeLevelGroupDetail_History','Dep_StakeLevelGroupDetail_History';
GO
IF OBJECT_ID('Dep_UMConfig', 'V') IS NULL AND OBJECT_ID('Dep_UMConfig') IS NULL
	exec sp_rename 'dbo.Del_Dep_UMConfig','Dep_UMConfig';
GO
IF OBJECT_ID('DomainManagement', 'V') IS NULL AND OBJECT_ID('DomainManagement') IS NULL
	exec sp_rename 'dbo.Del_DomainManagement','DomainManagement';
GO
IF OBJECT_ID('GameGroup', 'V') IS NULL AND OBJECT_ID('GameGroup') IS NULL
	exec sp_rename 'dbo.Del_GameGroup','GameGroup';
GO
IF OBJECT_ID('GameLaunchPerCurrency', 'V') IS NULL AND OBJECT_ID('GameLaunchPerCurrency') IS NULL
	exec sp_rename 'dbo.Del_GameLaunchPerCurrency','GameLaunchPerCurrency';
GO
IF OBJECT_ID('GameLaunchPerSite', 'V') IS NULL AND OBJECT_ID('GameLaunchPerSite') IS NULL
	exec sp_rename 'dbo.Del_GameLaunchPerSite','GameLaunchPerSite';
GO
IF OBJECT_ID('LossLimit_GlobalSetting', 'V') IS NULL AND OBJECT_ID('LossLimit_GlobalSetting') IS NULL
	exec sp_rename 'dbo.Del_LossLimit_GlobalSetting','LossLimit_GlobalSetting';
GO
IF OBJECT_ID('MaxPayoutGlobalSetting', 'V') IS NULL AND OBJECT_ID('MaxPayoutGlobalSetting') IS NULL
	exec sp_rename 'dbo.Del_MaxPayoutGlobalSetting','MaxPayoutGlobalSetting';
GO
IF OBJECT_ID('PlayCurrencySetting', 'V') IS NULL AND OBJECT_ID('PlayCurrencySetting') IS NULL
	exec sp_rename 'dbo.Del_PlayCurrencySetting','PlayCurrencySetting';
GO
IF OBJECT_ID('ProductBetSetting', 'V') IS NULL AND OBJECT_ID('ProductBetSetting') IS NULL
	exec sp_rename 'dbo.Del_ProductBetSetting','ProductBetSetting';
GO
IF OBJECT_ID('ProductStakeLevelGroup', 'V') IS NULL AND OBJECT_ID('ProductStakeLevelGroup') IS NULL
	exec sp_rename 'dbo.Del_ProductStakeLevelGroup','ProductStakeLevelGroup';
GO
IF OBJECT_ID('SettingSystem', 'V') IS NULL AND OBJECT_ID('SettingSystem') IS NULL
	exec sp_rename 'dbo.Del_SettingSystem','SettingSystem';
GO
IF OBJECT_ID('Site', 'V') IS NULL AND OBJECT_ID('Site') IS NULL
	exec sp_rename 'dbo.Del_Site','Site';
GO
IF OBJECT_ID('SiteDBConfig', 'V') IS NULL AND OBJECT_ID('SiteDBConfig') IS NULL
	exec sp_rename 'dbo.Del_SiteDBConfig','SiteDBConfig';
GO
IF OBJECT_ID('SportBettypeSettingMatrix', 'V') IS NULL AND OBJECT_ID('SportBettypeSettingMatrix') IS NULL
	exec sp_rename 'dbo.Del_SportBettypeSettingMatrix','SportBettypeSettingMatrix';
GO
IF OBJECT_ID('StakeLevel', 'V') IS NULL AND OBJECT_ID('StakeLevel') IS NULL
	exec sp_rename 'dbo.Del_StakeLevel','StakeLevel';
GO
IF OBJECT_ID('StakeLevel_History', 'V') IS NULL AND OBJECT_ID('StakeLevel_History') IS NULL
	exec sp_rename 'dbo.Del_StakeLevel_History','StakeLevel_History';
GO