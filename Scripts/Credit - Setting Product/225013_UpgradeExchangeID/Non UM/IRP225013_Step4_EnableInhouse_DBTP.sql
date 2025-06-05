/*<info serverAlias="IRS_DBTP-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250423@Johnson	
	Task: Upgrade ExchangeID data type for tables setting [redmine:#225013]
	DB: IRS_DBTP-bodb02
*/
--select * from RepInfo (NOLOCK) where  [name] IN ('ProductBetSetting','MaxPayoutGlobalSetting','LimitPTDailySetting')

UPDATE RepInfo
SET active = 1
WHERE [name] =  'MaxPayoutGlobalSetting'
    --AND [group] = 130 --local

    
UPDATE RepInfo
SET active = 1
WHERE [name] =  'ProductBetSetting'
   -- AND [group] = 130 --local

UPDATE RepInfo
SET active = 1
WHERE [name] =  'LimitPTDailySetting'
    --AND [group] = 13 --local

