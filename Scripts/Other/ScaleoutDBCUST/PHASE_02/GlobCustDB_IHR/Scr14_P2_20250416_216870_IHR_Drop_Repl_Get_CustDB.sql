/*<info serverAlias="DBCUST-CustDB"></info>*/
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
DROP PROCEDURE IF EXISTS Repl_GetDep_ProductBetSetting
GO

DROP PROCEDURE IF EXISTS Repl_GetDep_ProductStakeLevelGroup
GO

DROP PROCEDURE IF EXISTS Repl_GetDep_StakeLevel
GO

DROP PROCEDURE IF EXISTS Repl_GetDep_StakeLevelGroupDetail
GO

DROP PROCEDURE IF EXISTS Repl_GetGameGroup
GO

DROP PROCEDURE IF EXISTS Repl_GetProductBetSetting
GO

DROP PROCEDURE IF EXISTS Repl_GetProductStakeLevelGroup
GO

DROP PROCEDURE IF EXISTS Repl_GetStakeLevel
GO

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Deposit Setting
DROP PROCEDURE IF EXISTS Repl_GetDep_ProductSetting
GO

DROP PROCEDURE IF EXISTS Repl_GetDep_ProductSettingDetail
GO

DROP PROCEDURE IF EXISTS Repl_GetDep_ProductStatusProfile
GO

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others
DROP PROCEDURE IF EXISTS Repl_GetDomainManagement
GO

DROP PROCEDURE IF EXISTS Repl_GetGameLaunchPerCurrency
GO

DROP PROCEDURE IF EXISTS Repl_GetGameLaunchPerSite
GO

DROP PROCEDURE IF EXISTS Repl_GetLossLimit_GlobalSetting
GO

DROP PROCEDURE IF EXISTS Repl_GetMaxPayoutGlobalSetting
GO

DROP PROCEDURE IF EXISTS Repl_GetPlayCurrencySetting
GO

DROP PROCEDURE IF EXISTS Repl_GettblSite
GO

DROP PROCEDURE IF EXISTS Repl_GetSiteDBConfig
GO

DROP PROCEDURE IF EXISTS Repl_GetSportBettypeSettingMatrix
GO