/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Johnson
	Date: 20210909
	Task: SBO ION Live Casino - Change bet limit for RM, HKD, HKK currencies
	DB: DBCust/CustDB
*/

UPDATE StakeLevel WITH(ROWLOCK)
SET MinStake = 1,
	MaxStake = 10000,
	MinLabel = '1',
	MaxLabel = '10,000'
WHERE GameTypeID = 5601
	AND ExchangeId IN (2,5,67)