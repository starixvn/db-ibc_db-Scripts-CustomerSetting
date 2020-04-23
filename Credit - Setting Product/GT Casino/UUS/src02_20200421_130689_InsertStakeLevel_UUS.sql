/*
	Created: 20200421@Elodie
	Task: Insert StakeLevel for GTCasino [Redmine: #130689]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

CREATE TABLE #temp(
	GameTypeID		INT,
	[MinLabel]		VARCHAR(30),
	[MaxLabel]		VARCHAR(30),
	[MinStake]		[decimal](19, 8) NULL,
	[MaxStake]		[decimal](19, 8) NULL,
	[ExchangeId]	[int] 
) ON [PRIMARY]

GO
INSERT #temp (GameTypeID, ExchangeId, MinLabel, MaxLabel, MinStake, MaxStake)
SELECT 3201, 20, '6', '50,000', 6, 50000  UNION ALL -- UUS
SELECT 3201, 15, '6', '50,000', 6, 50000  UNION ALL -- IDR
SELECT 3201, 22, '6', '50,000', 6, 50000  UNION ALL -- IDR
SELECT 3201, 33, '6', '50,000', 6, 50000  UNION ALL -- IDR
SELECT 3201, 34, '6', '50,000', 6, 50000  UNION ALL -- IDR
SELECT 3201, 47, '6', '50,000', 6, 50000 -- IDR

DELETE S
FROM StakeLevel S WITH(ROWLOCK) 
WHERE S.GameTypeID = 3201
	AND S.ExchangeId IN (20,15,22,33,34,47)

INSERT INTO StakeLevel (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake,ExchangeId)
SELECT T.GameTypeID, T.MinLabel,T.MaxLabel,	T.MinStake , T.MaxStake, T.ExchangeId
FROM #temp T WITH(NOLOCK)
ORDER BY GameTypeID,ExchangeId,MaxStake

DROP TABLE #temp