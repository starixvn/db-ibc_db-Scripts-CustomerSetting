/*<info serverAlias="IRS_DBTP-bodb02,DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250212@Johnson	
	Task: Enable inhouse on DBDIST & DBTP
	DB: IRS_DBTP-bodb02,DBCustRepl-ReplCustDB
	
	Revisions:
		- 20250212@Johnson: Update repinfo for DBDIST & DBTP to new group [RedmineID: #216870]
*/	

UPDATE RepInfo
SET active = 1,
	--[group] = 2 --PRO GlobCustDB to RepCustDB
	[group] = 130 --local GlobCustDB to RepCustDB
WHERE [name] IN (	
	'ProductProfileSiteCurrency',
	'ProductProfileSiteCurrency_UAT',
	'ProductSettingProfile',
	'ProductSettingProfile_UAT',	
	'ProductStatusProfile',
	'ProductStatusSiteCurrency',
	'SportNonOfferedSiteCurrency',
	'CategoryConfig',
	'MsgError',
	'MsgErrorGroup',
	'ProblemAccountReason'	
)
and [Group] = 13 --local