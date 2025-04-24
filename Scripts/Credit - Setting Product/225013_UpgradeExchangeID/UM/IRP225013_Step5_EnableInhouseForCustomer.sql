/*<info serverAlias="DBCustRepl-ReplCustDB,IRS_DBTP-bodb02,IRS_DBG-bodb02,IRS_DBSIG-CustDB,IRS_DBCTG-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250428@Johnson	
	Task: Upgrade ExchangeID data type for tables setting [redmine:#225013]
	DB: DBCustRepl-ReplCustDB,IRS_DBTP-bodb02,IRS_DBG-bodb02,IRS_DBSIG-CustDB,IRS_DBCTG-CustDB
*/

--SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'Customer'

UPDATE RepInfo
SET active = 1
WHERE [name] =  'Customer'
	--AND [group] = 13--local
GO