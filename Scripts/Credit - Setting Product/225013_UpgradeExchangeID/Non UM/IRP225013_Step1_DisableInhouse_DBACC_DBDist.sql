/*<info serverAlias="IRS_DBACC-bodb02,DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250423@Johnson	
	Task: Upgrade ExchangeID data type for tables setting [redmine:#225013]
	DB: IRS_DBACC-bodb02,DBCustRepl-ReplCustDB
*/

--select * from RepInfo (NOLOCK) where  [name] =  'ProductBetSetting'

UPDATE RepInfo
SET active = 0
WHERE [name] =  'ProductBetSetting'
    --AND [group] = 13 --local


