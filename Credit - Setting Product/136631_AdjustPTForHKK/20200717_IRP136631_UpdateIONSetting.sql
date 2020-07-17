/*
	Created: 20200717@Johnson
	Task: update global stakelevel setting for ION for HKK
	DB: DBCUST/CUSTDB
*/

UPDATE StakeLevel WITH(UPDLOCK,ROWLOCK)
SET MaxLabel = '20,000',
	MaxStake = 20000
WHERE GameTypeID = 5601 
	AND ExchangeId = 67