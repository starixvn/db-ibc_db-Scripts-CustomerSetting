/*<info serverAlias="DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250312@Johnson	
	Task: Rollback inhouse on DBDIST to CustDB
	DB: DBCustRepl-ReplCustDB
	
	Revisions:
		- 20250212@Johnson: Update repinfo for DBDIST to CustDB [RedmineID: #216870]
*/	

UPDATE RepInfo
SET [group] = 14 --CustDB to RepCustDB	
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