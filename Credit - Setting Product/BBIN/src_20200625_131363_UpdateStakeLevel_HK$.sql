/*
	Created: 20200625@Eden
	Task: Update Stake Bet Limit for BBIN - HK$ [Redmine: #131363]
	DB: DBCUST/CustDB
*/
USE CUSTDB
GO

UPDATE s 
SET  MinLabel = '15'
	,MaxLabel = '5,000'
	,MinStake = 15
	,MaxStake = 5000
FROM StakeLevel S WITH(ROWLOCK) 
WHERE S.GameTypeID = 3300 AND s.ExchangeId = 5
