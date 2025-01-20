/*<info serverAlias=DBCUST-CustDB executers= isFunction=0 isNested=0></info>*/
/*
	Created: 20250116@Tacy	
	Task: DROP sp [Repl_Getxxx] on CustDB
	DB: DBCUST-CustDB
	
	Revisions:
		- 20250116@Tacy: Created [RedmineID: #216870]
*/
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Bet Setting
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Repl_GetDep_ProductBetSetting')
    DROP PROCEDURE Repl_GetDep_ProductBetSetting
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Repl_GetDep_ProductStakeLevelGroup')
    DROP PROCEDURE Repl_GetDep_ProductStakeLevelGroup
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Repl_GetDep_StakeLevel')
    DROP PROCEDURE Repl_GetDep_StakeLevel
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Repl_GetDep_StakeLevelGroupDetail')
    DROP PROCEDURE Repl_GetDep_StakeLevelGroupDetail
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Repl_GetGameGroup')
    DROP PROCEDURE Repl_GetGameGroup
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Repl_GetProductBetSetting')
    DROP PROCEDURE Repl_GetProductBetSetting
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Repl_GetProductStakeLevelGroup')
    DROP PROCEDURE Repl_GetProductStakeLevelGroup
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Repl_GetStakeLevel')
    DROP PROCEDURE Repl_GetStakeLevel
GO

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Deposit Setting
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Repl_GetDep_ProductSetting')
    DROP PROCEDURE Repl_GetDep_ProductSetting
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Repl_GetDep_ProductSettingDetail')
    DROP PROCEDURE Repl_GetDep_ProductSettingDetail
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Repl_GetDep_ProductStatusProfile')
    DROP PROCEDURE Repl_GetDep_ProductStatusProfile
GO

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Repl_GetDomainManagement')
    DROP PROCEDURE Repl_GetDomainManagement
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Repl_GetGameLaunchPerCurrency')
    DROP PROCEDURE Repl_GetGameLaunchPerCurrency
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Repl_GetGameLaunchPerSite')
    DROP PROCEDURE Repl_GetGameLaunchPerSite
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Repl_GetGameRoundBetLimitSettings')
    DROP PROCEDURE Repl_GetGameRoundBetLimitSettings
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Repl_GetLossLimit_GlobalSetting')
    DROP PROCEDURE Repl_GetLossLimit_GlobalSetting
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Repl_GetMaxPayoutGlobalSetting')
    DROP PROCEDURE Repl_GetMaxPayoutGlobalSetting
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Repl_GetPlayCurrencySetting')
    DROP PROCEDURE Repl_GetPlayCurrencySetting
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Repl_GetSite')
    DROP PROCEDURE Repl_GetSite
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Repl_GetSiteDBConfig')
    DROP PROCEDURE Repl_GetSiteDBConfig
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Repl_GetSportBettypeSettingMatrix')
    DROP PROCEDURE Repl_GetSportBettypeSettingMatrix
GO