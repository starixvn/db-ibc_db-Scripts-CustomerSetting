/*<info serverAlias="IRS_DBTP-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250312@Johnson	
	Task: Enable inhouse on DBDIST
	DB: IRS_DBTP-bodb02
	
	Revisions:
		- 20250312@Johnson: rollback for DBTP [RedmineID: #216870]
*/	

--change group to CustDB
UPDATE RepInfo
SET [group] = 16 --CustDB to DBTP	
WHERE [name] IN ('ProductGlobalSetting',
	'ProductLaunchedSiteCurrency',
	'ProductProfileSiteCurrency',
	'ProductProfileSiteCurrency_UAT',
	'ProductSettingProfile',
	'ProductSettingProfile_UAT',
	'ProductSettingSystemDisplay',
	'ProductSettingUpdateRestriction',
	'ProductStatusProfile',
	'ProductStatusSiteCurrency',
	'SportNonOfferedSiteCurrency',	
	'CategoryConfig',	
	'ProblemAccountReason',
	'Winlimit_ActionSetting',
	'Winlimit_GameGroupSetting',
	'Winlimit_LevelSetting',
	'Winlimit_ProductSetting',
	'WinLimit_ProductSettingDetail'
)
GO

--change group to CustDB
UPDATE RepInfo
SET [group] = 18 --CustDB to DBTP	
WHERE [name] IN (
	'MsgError',
	'MsgErrorGroup',
	'Acc_SuperPrefix'
)
GO


--disable inhouse for 2 new tables 
UPDATE RepInfo
SET active = 0
WHERE [name] IN (
	'Winlimit_Group',
	'Winlimit_ProductGlobalSetting'
)