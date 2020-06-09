/*
	Created: 20200504@Eden
	Task: Insert StakeLevel for ION [Redmine: 132323]
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
SELECT 5601, 20, '2', '100,000', 2, 100000 UNION ALL -- UUS
SELECT 5601, 72, '2', '100,000', 2, 100000 -- YNG

--DELETE S
--FROM StakeLevel S WITH(ROWLOCK) 
--WHERE S.GameTypeID = 5601
--	AND S.ExchangeId IN (SELECT ExchangeId FROM #temp) -- IDR

--INSERT INTO StakeLevel (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake,ExchangeId,ResourceId)
--SELECT T.GameTypeID, T.MinLabel,T.MaxLabel,	T.MinStake , T.MaxStake, T.ExchangeId, 2
--FROM #temp T WITH(NOLOCK)
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