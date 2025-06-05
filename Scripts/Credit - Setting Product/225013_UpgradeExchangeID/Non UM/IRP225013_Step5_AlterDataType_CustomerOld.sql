/*<info serverAlias="DBARCCUST-bodb_customer" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250424@Johnson	
	Task: Upgrade ExchangeID data type for tables setting  [redmine:#225013]
	DB: DBARCCUST-bodb_customer
*/

ALTER TABLE Customer_old ALTER COLUMN currency SMALLINT WITH(ONLINE = ON)
