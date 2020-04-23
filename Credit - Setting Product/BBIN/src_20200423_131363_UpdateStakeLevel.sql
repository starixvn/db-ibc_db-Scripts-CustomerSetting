/*
	Created: 20200423@Eden
	Task: Update Min Stake Bet Limit for BBIN - Real Currency [Redmine: #131363]
		- MYR: 10
		- HKD: 15
		- THB: 50
		- USD: 2
		- VND: 33,000
	DB: DBCUST/CustDB
*/
USE CUSTDB
GO

DECLARE @NewStake TABLE (
	CurrencyCode	VARCHAR(3),
	[MinLabel]		VARCHAR(30),
	[MinStake]		[decimal](19, 8) NULL
)
INSERT INTO @NewStake(CurrencyCode,MinLabel,MinStake)
SELECT 'MYR', '10', 10 UNION ALL
SELECT 'HKD', '15', 15 UNION ALL
SELECT 'THB', '50', 50 UNION ALL
--SELECT 'USD', '2', 2 UNION ALL
SELECT 'VND', '33', 33

--SELECT s.StakeLevelID,S.MinLabel,s.MinStake,e.Code,e.currency,tmp.MinLabel,tmp.MinStake
--FROM StakeLevel S WITH(ROWLOCK) 
--	INNER JOIN exchange e WITH(NOLOCK) ON e.exchangeid = s.ExchangeId
--	INNER JOIN @NewStake tmp ON tmp.CurrencyCode = e.Code
--WHERE S.GameTypeID = 3300
--ORDER BY e.code,e.currency,s.StakeLevelID

UPDATE s 
SET  MinLabel = tmp.MinLabel
	,MinStake = tmp.MinStake
FROM StakeLevel S WITH(ROWLOCK) 
	INNER JOIN exchange e WITH(NOLOCK) ON e.exchangeid = s.ExchangeId
	INNER JOIN @NewStake tmp ON tmp.CurrencyCode = e.Code
WHERE S.GameTypeID = 3300
