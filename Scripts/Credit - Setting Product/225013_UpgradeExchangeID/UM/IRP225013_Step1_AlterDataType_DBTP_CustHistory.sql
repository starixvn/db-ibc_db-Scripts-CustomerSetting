/*<info serverAlias="DBTP-bodb_CustHistory" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250428@Johnson	
	Task: Upgrade ExchangeID data type for tables setting [redmine:#225013]
	DB: DBTP-bodb_CustHistory
*/

ALTER TABLE Customer_History ALTER COLUMN Currency SMALLINT WITH(ONLINE = ON)
GO
