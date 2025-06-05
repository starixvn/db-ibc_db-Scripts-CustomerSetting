/*<info serverAlias="IRS_DBTP-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250423@Johnson	
	Task: Upgrade ExchangeID data type for tables setting [redmine:#225013]
	DB: IRS_DBTP-bodb02
*/

--select * from RepInfo (NOLOCK) where  [name] in ('MaxPayoutGlobalSetting','ProductBetSetting','LimitPTDailySetting')

UPDATE RepInfo
SET active = 0
WHERE [name] =  'MaxPayoutGlobalSetting'
    --AND [group] = 130 --local

    
UPDATE RepInfo
SET active = 0
WHERE [name] =  'ProductBetSetting'
    --AND [group] = 130 --local

UPDATE RepInfo
SET active = 0
WHERE [name] =  'LimitPTDailySetting'
    --AND [group] = 13 --local

