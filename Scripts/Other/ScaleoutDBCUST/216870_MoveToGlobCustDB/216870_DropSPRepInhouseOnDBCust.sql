/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250310@Johnson
	Task: DROP Repl SPs on CustDB
	DB: DBCUST-CustDB
	
	Revisions:
		- 2025010@Johnson: Created [RedmineID: #216870]
*/
DROP PROCEDURE IF EXISTS Repl_GetWinlimit_ActionSetting 
GO

DROP PROCEDURE IF EXISTS Repl_GetWinlimit_GameGroupSetting
GO

DROP PROCEDURE IF EXISTS Repl_GetWinlimit_LevelSetting
GO

DROP PROCEDURE IF EXISTS Repl_GetWinlimit_ProductSetting
GO

DROP PROCEDURE IF EXISTS Repl_GetWinLimit_ProductSettingDetail
GO

DROP PROCEDURE IF EXISTS Repl_GetProblemAccountReason
GO

DROP PROCEDURE IF EXISTS Repl_GetCategoryConfig
GO

DROP PROCEDURE IF EXISTS Repl_GetProductProfileSiteCurrency_UAT
GO

DROP PROCEDURE IF EXISTS Repl_GetProductProfileSiteCurrency
GO

DROP PROCEDURE IF EXISTS Repl_GetProductSettingProfile_UAT
GO

DROP PROCEDURE IF EXISTS Repl_GetProductSettingProfile
GO

DROP PROCEDURE IF EXISTS Repl_GetProductStatusProfile
GO

DROP PROCEDURE IF EXISTS Repl_GetProductStatusSiteCurrency
GO

DROP PROCEDURE IF EXISTS Repl_GetSportNonOfferedSiteCurrency
GO

DROP PROCEDURE IF EXISTS Repl_GetProductGlobalSetting
GO

DROP PROCEDURE IF EXISTS Repl_GetProductLaunchedSiteCurrency
GO

DROP PROCEDURE IF EXISTS Repl_GetProductSettingSystemDisplay
GO

DROP PROCEDURE IF EXISTS Repl_GetProductSettingUpdateRestriction
GO

DROP PROCEDURE IF EXISTS Repl_GetMsgError
GO

DROP PROCEDURE IF EXISTS Repl_GetMsgErrorGroup
GO