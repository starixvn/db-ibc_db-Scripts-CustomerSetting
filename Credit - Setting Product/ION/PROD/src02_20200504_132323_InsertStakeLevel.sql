/*
	Created: 20200504@Eden
	Task: Insert Stake level of ION [Redmine: 132323]
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
SELECT 5601, 13, '1', '50,000', 1, 50000 UNION ALL -- RMB
SELECT 5601, 81, '1', '50,000', 1, 50000 UNION ALL -- CY
SELECT 5601, 6, '1', '5,000', 1, 5000 UNION ALL -- EURO
SELECT 5601, 12, '1', '2,500', 1, 2500 UNION ALL -- GBP
SELECT 5601, 5, '1', '50,000', 1, 50000 UNION ALL -- HK$
SELECT 5601, 67, '1', '50,000', 1, 50000 UNION ALL -- HKK
SELECT 5601, 15, '1', '50,000', 1, 50000 UNION ALL -- IN
SELECT 5601, 22, '1', '50,000', 1, 50000 UNION ALL -- IND
SELECT 5601, 33, '1', '50,000', 1, 50000 UNION ALL -- IDD
SELECT 5601, 34, '1', '50,000', 1, 50000 UNION ALL -- IDR
SELECT 5601, 47, '1', '50,000', 1, 50000 UNION ALL -- DDD
SELECT 5601, 45, '100', '5,000,000', 100, 5000000 UNION ALL -- Won
SELECT 5601, 2, '1', '20,000', 1, 20000 UNION ALL -- RM
SELECT 5601, 43, '5', '150,000', 5, 150000 UNION ALL -- THB
SELECT 5601, 3, '1', '5,000', 1, 5000 UNION ALL -- US$
SELECT 5601, 16, '1', '5,000', 1, 5000 UNION ALL -- Yen
SELECT 5601, 35, '1', '5,000', 1, 5000 UNION ALL -- $US
SELECT 5601, 64, '1', '5,000', 1, 5000 -- UT

--DELETE S
--FROM StakeLevel S WITH(ROWLOCK) 
--WHERE S.GameTypeID = 5601
--	AND S.ExchangeId IN (SELECT ExchangeId FROM #temp) -- IDR

--INSERT INTO StakeLevel (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake,ExchangeId,ResourceId)
--SELECT T.GameTypeID, T.MinLabel,T.MaxLabel,	T.MinStake , T.MaxStake, T.ExchangeId, 2
--FROM #temp T WITH(NOLOCK)
--WHERE T.GameTypeID = 5601
--ORDER BY GameTypeID,ExchangeId,MaxStake,MinStake

MERGE StakeLevel s
USING #temp t
	ON s.GameTypeID = t.GameTypeID 
	AND s.ExchangeId = t.ExchangeId
WHEN NOT MATCHED THEN INSERT (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake,ExchangeId,ResourceId)
					VALUES( T.GameTypeID, T.MinLabel,T.MaxLabel, T.MinStake , T.MaxStake, T.ExchangeId, 2)
WHEN MATCHED THEN UPDATE SET s.MinLabel = t.MinLabel,
							s.MaxLabel = t.MaxLabel,
							s.MinStake = t.MinStake,
							s.MaxStake = t.MaxStake, 
							s.ResourceId = 2;

DROP TABLE #temp

