/*<info serverAlias="DBAGE-bodb_AGE" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250502@Johnson	
	Task: Upgrade ExchangeID data type for cdc_bettrans  [redmine:#225013]
	DB: DBAGE-bodb_AGE
*/

ALTER TABLE cdc_bettrans ALTER COLUMN currency SMALLINT WITH(ONLINE = ON)
