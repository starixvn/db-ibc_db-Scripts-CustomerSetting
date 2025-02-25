/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Dave
	Date: 20250120
	Task: Rename table in CustDB [RedmineID:#216870]
	DB: DBCust/CustDB
*/
USE CustDB
GO
/*Site*/
exec sp_rename 'dbo.Site','Del_Site';
/*SiteDBConfig*/
exec sp_rename 'dbo.SiteDBConfig','Del_SiteDBConfig';
/*Dep_Initial_BetSetting*/
exec sp_rename 'dbo.Dep_Initial_BetSetting','Del_Dep_Initial_BetSetting';
/*Dep_Initial_ProductConfig*/
exec sp_rename 'dbo.Dep_Initial_ProductConfig','Del_Dep_Initial_ProductConfig';
/*Dep_Initial_ProductConfig_Detail*/
exec sp_rename 'dbo.Dep_Initial_ProductConfig_Detail','Del_Dep_Initial_ProductConfig_Detail';
/*Dep_Initial_StepByConfig*/
exec sp_rename 'dbo.Dep_Initial_StepByConfig','Del_Dep_Initial_StepByConfig';
/*Dep_ProductBetSetting*/
exec sp_rename 'dbo.Dep_ProductBetSetting','Del_Dep_ProductBetSetting';
/*Dep_ProductSetting*/
exec sp_rename 'dbo.Dep_ProductSetting','Del_Dep_ProductSetting';
/*Dep_ProductSettingDetail*/
exec sp_rename 'dbo.Dep_ProductSettingDetail','Del_Dep_ProductSettingDetail';
/*Dep_ProductSettingType*/
exec sp_rename 'dbo.Dep_ProductSettingType','Del_Dep_ProductSettingType';
/*Dep_ProductStakeLevelGroup*/
exec sp_rename 'dbo.Dep_ProductStakeLevelGroup','Del_Dep_ProductStakeLevelGroup';
/*Dep_ProductStatusProfile*/
exec sp_rename 'dbo.Dep_ProductStatusProfile','Del_Dep_ProductStatusProfile';
/*Dep_StakeLevel*/
exec sp_rename 'dbo.Dep_StakeLevel','Del_Dep_StakeLevel';
/*Dep_StakeLevel_History*/
exec sp_rename 'dbo.Dep_StakeLevel_History','Del_Dep_StakeLevel_History';
/*Dep_StakeLevelGroupDetail*/
exec sp_rename 'dbo.Dep_StakeLevelGroupDetail','Del_Dep_StakeLevelGroupDetail';
/*Dep_StakeLevelGroupDetail_History*/
exec sp_rename 'dbo.Dep_StakeLevelGroupDetail_History','Del_Dep_StakeLevelGroupDetail_History';
/*Dep_UMConfig*/
exec sp_rename 'dbo.Dep_UMConfig','Del_Dep_UMConfig';
/*DomainManagement*/
exec sp_rename 'dbo.DomainManagement','Del_DomainManagement';
/*GameGroup*/
exec sp_rename 'dbo.GameGroup','Del_GameGroup';
/*GameLaunchPerCurrency*/
exec sp_rename 'dbo.GameLaunchPerCurrency','Del_GameLaunchPerCurrency';
/*GameLaunchPerSite*/
exec sp_rename 'dbo.GameLaunchPerSite','Del_GameLaunchPerSite';
/*LossLimit_GlobalSetting*/
exec sp_rename 'dbo.LossLimit_GlobalSetting','Del_LossLimit_GlobalSetting';
/*MaxPayoutGlobalSetting*/
exec sp_rename 'dbo.MaxPayoutGlobalSetting','Del_MaxPayoutGlobalSetting';
/*PlayCurrencySetting*/
exec sp_rename 'dbo.PlayCurrencySetting','Del_PlayCurrencySetting';
/*ProductBetSetting*/
exec sp_rename 'dbo.ProductBetSetting','Del_ProductBetSetting';
/*ProductStakeLevelGroup*/
exec sp_rename 'dbo.ProductStakeLevelGroup','Del_ProductStakeLevelGroup';
/*SettingSystem*/
exec sp_rename 'dbo.SettingSystem','Del_SettingSystem';
/*SportBettypeSettingMatrix*/
exec sp_rename 'dbo.SportBettypeSettingMatrix','Del_SportBettypeSettingMatrix';
/*StakeLevel*/
exec sp_rename 'dbo.StakeLevel','Del_StakeLevel';
/*StakeLevel_History*/
exec sp_rename 'dbo.StakeLevel_History','Del_StakeLevel_History';