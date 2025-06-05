/*<info serverAlias="DBCUST-CustDB,DBCustRepl-ReplCustDB,IRS_DBG-bodb02,IRS_DBSIG-CustDB,IRS_DBCTG-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250428@Johnson	
	Task: Upgrade ExchangeID data type for tables setting [redmine:#225013]
	DB: DBCUST-CustDB,DBCustRepl-ReplCustDB,IRS_DBG-bodb02,IRS_DBSIG-CustDB,IRS_DBCTG-CustDB
*/

ALTER TABLE Customer ALTER COLUMN Currency SMALLINT WITH(ONLINE = ON)
GO
