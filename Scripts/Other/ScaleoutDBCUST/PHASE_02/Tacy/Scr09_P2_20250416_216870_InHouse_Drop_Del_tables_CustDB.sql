/*<info serverAlias=DBCUST-CustDB executers= isFunction=0 isNested=0></info>*/
/*
	Created: 20250116@Tacy	
	Task: DROP TABLE [xxx_Del_Inhouse] on CustDB
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250116@Tacy: Created [RedmineID: #216870]
*/
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Bet Setting
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'U' AND name = 'Dep_ProductBetSetting_Del_Inhouse')
          DROP TABLE Dep_ProductBetSetting_Del_Inhouse
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'U' AND name = 'Dep_StakeLevel_Del_Inhouse')
          DROP TABLE Dep_StakeLevel_Del_Inhouse
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'U' AND name = 'Dep_StakeLevelGroupDetail_Del_Inhouse')
          DROP TABLE Dep_StakeLevelGroupDetail_Del_Inhouse
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'U' AND name = 'GameGroup_Del_Inhouse')
          DROP TABLE GameGroup_Del_Inhouse
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'U' AND name = 'ProductBetSetting_Del_Inhouse')
          DROP TABLE ProductBetSetting_Del_Inhouse
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'U' AND name = 'StakeLevel_Del_Inhouse')
          DROP TABLE StakeLevel_Del_Inhouse
GO

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Deposit Setting
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'U' AND name = 'Dep_ProductSetting_Del_Inhouse')
          DROP TABLE Dep_ProductSetting_Del_Inhouse
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'U' AND name = 'Dep_ProductSettingDetail_Del_Inhouse')
          DROP TABLE Dep_ProductSettingDetail_Del_Inhouse
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'U' AND name = 'Dep_ProductStatusProfile_Del_Inhouse')
          DROP TABLE Dep_ProductStatusProfile_Del_Inhouse
GO

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'U' AND name = 'GameLaunchPerCurrency_Del_Inhouse')
          DROP TABLE GameLaunchPerCurrency_Del_Inhouse
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'U' AND name = 'GameLaunchPerSite_Del_Inhouse')
          DROP TABLE GameLaunchPerSite_Del_Inhouse
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'U' AND name = 'GameRoundBetLimitSettings_Del_Inhouse')
          DROP TABLE GameRoundBetLimitSettings_Del_Inhouse
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'U' AND name = 'LossLimit_GlobalSetting_Del_Inhouse')
          DROP TABLE LossLimit_GlobalSetting_Del_Inhouse
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'U' AND name = 'MaxPayoutGlobalSetting_Del_Inhouse')
          DROP TABLE MaxPayoutGlobalSetting_Del_Inhouse
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'U' AND name = 'PlayCurrencySetting_Del_Inhouse')
          DROP TABLE PlayCurrencySetting_Del_Inhouse
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'U' AND name = 'Site_Del_Inhouse')
          DROP TABLE Site_Del_Inhouse
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'U' AND name = 'SiteDBConfig_Del_Inhouse')
          DROP TABLE SiteDBConfig_Del_Inhouse
GO