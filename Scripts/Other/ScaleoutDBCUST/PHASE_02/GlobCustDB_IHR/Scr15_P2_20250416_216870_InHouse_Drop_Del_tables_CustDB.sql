/*<info serverAlias="DBCUST-CustDB"></info>*/
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
DROP TABLE IF EXISTS Dep_ProductBetSetting_Del_Inhouse
GO

DROP TABLE IF EXISTS Dep_StakeLevel_Del_Inhouse
GO

DROP TABLE IF EXISTS Dep_StakeLevelGroupDetail_Del_Inhouse
GO

DROP TABLE IF EXISTS GameGroup_Del_Inhouse
GO

DROP TABLE IF EXISTS ProductBetSetting_Del_Inhouse
GO

DROP TABLE IF EXISTS StakeLevel_Del_Inhouse
GO

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Deposit Setting
DROP TABLE IF EXISTS Dep_ProductSetting_Del_Inhouse
GO

DROP TABLE IF EXISTS Dep_ProductSettingDetail_Del_Inhouse
GO

DROP TABLE IF EXISTS Dep_ProductStatusProfile_Del_Inhouse
GO

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Others
DROP TABLE IF EXISTS GameLaunchPerCurrency_Del_Inhouse
GO

DROP TABLE IF EXISTS GameLaunchPerSite_Del_Inhouse
GO

DROP TABLE IF EXISTS LossLimit_GlobalSetting_Del_Inhouse
GO

DROP TABLE IF EXISTS MaxPayoutGlobalSetting_Del_Inhouse
GO

DROP TABLE IF EXISTS PlayCurrencySetting_Del_Inhouse
GO

DROP TABLE IF EXISTS Site_Del_Inhouse
GO

DROP TABLE IF EXISTS SiteDBConfig_Del_Inhouse
GO