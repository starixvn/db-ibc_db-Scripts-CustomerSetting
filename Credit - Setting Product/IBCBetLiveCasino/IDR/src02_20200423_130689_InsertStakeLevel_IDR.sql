/*
	Created: 20200423@Tiara
	Task: Delete existing data of GTCasino -IDR [Redmine: #130689]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

CREATE TABLE #temp(
	GameTypeID		INT,
	[MinLabel]		VARCHAR(30),
	[MaxLabel]		VARCHAR(30),
	[MinStake]			[decimal](19, 8) NULL,
	[MaxStake]			[decimal](19, 8) NULL,
	[ExchangeId]	[int] 
) ON [PRIMARY]

GO
INSERT #temp (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake,ExchangeId)
SELECT 3201,'6','50,000',6,50000,15 UNION ALL
SELECT 3201,'6','50,000',6,50000,22 UNION ALL
SELECT 3201,'6','50,000',6,50000,33 UNION ALL
SELECT 3201,'6','50,000',6,50000,34 UNION ALL
SELECT 3201,'6','50,000',6,50000,47 

DELETE S
FROM StakeLevel S WITH(ROWLOCK) 
WHERE S.GameTypeID = 3201
	AND S.ExchangeId IN (15,22,33,34,47) -- IDR

INSERT INTO StakeLevel (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake,ExchangeId)
SELECT T.GameTypeID, T.MinLabel,T.MaxLabel,	T.MinStake , T.MaxStake, T.ExchangeId
FROM #temp T WITH(NOLOCK)
WHERE T.GameTypeID = 3201

DROP TABLE #temp

