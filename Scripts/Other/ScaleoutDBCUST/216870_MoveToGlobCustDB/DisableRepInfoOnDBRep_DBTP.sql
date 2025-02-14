/*<info serverAlias="IRS_DBTP-bodb02,DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250212@Johnson	
	Task: Disable inhouse on DBDIST & DBTP
	DB: IRS_DBTP-bodb02,DBCustRepl-ReplCustDB
	
	Revisions:
		- 20250212@Johnson: Update repinfo for DBCustRepl [RedmineID: #216870]
*/		

UPDATE RepInfo
SET active = 0
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
	'Acc_SuperPrefix',
	'CategoryConfig',
	'MsgError',
	'MsgErrorGroup',
	'ProblemAccountReason',
	'Winlimit_ActionSetting',
	'Winlimit_GameGroupSetting',
	'Winlimit_LevelSetting',
	'Winlimit_ProductSetting',
	'WinLimit_ProductSettingDetail'
)
AND [group] = 13--local

