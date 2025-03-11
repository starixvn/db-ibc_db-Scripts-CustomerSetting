/*<info serverAlias="IRS_DBTP-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250212@Johnson	
	Task: Enable inhouse on DBTP
	DB: IRS_DBTP-bodb02
	
	Revisions:
		- 20250212@Johnson: Update repinfo for DBTP to new group [RedmineID: #216870]
*/	

UPDATE RepInfo
SET active = 1,
	[group] = 130 --local
	--[group] = 11 --PRO GlobCustDB to DBTP
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
	'ProblemAccountReason'	
)
AND [group] = 13 --local
GO

UPDATE RepInfo
SET active = 1,
	[group] = 130 --local
	--[group] = 11 --PRO GlobCustDB to DBTP
WHERE [name] IN ('Winlimit_ActionSetting',
	'Winlimit_GameGroupSetting',
	'Winlimit_LevelSetting',
	'Winlimit_ProductSetting',
	'WinLimit_ProductSettingDetail'
)
AND [group] = 13 --local
GO

--enable inhouse for 2 new tables Winlimit_Group/Winlimit_ProductGlobalSetting
UPDATE RepInfo
SET active = 1
WHERE [group] = 130
	--[group] = 11
	AND [name] =  'Winlimit_Group'
GO

UPDATE RepInfo
SET active = 1
WHERE [group] = 130
	--[group] = 11
	AND [name] =  'Winlimit_ProductGlobalSetting'	