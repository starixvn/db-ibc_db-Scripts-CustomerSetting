/*
	Created: 20201109@Tina
	Task: Insert StakeLevel for Big Gaming - Real Currency [Redmine: #142458]
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
SELECT 3501, 72, '50', '5,000', 50, 5000 UNION ALL -- YNG(YNG)
SELECT 3501, 72, '100', '20,000', 100, 20000 UNION ALL -- YNG(YNG)
SELECT 3501, 72, '1,000', '50,000', 1000, 50000 UNION ALL -- YNG(YNG)

SELECT 3501, 20, '50', '5,000', 50, 5000 UNION ALL -- UUS(UUS)
SELECT 3501, 20, '100', '20,000', 100, 20000 UNION ALL -- UUS(UUS)
SELECT 3501, 20, '1,000', '50,000', 1000, 50000 --UUS(UUS)

DELETE S
FROM StakeLevel S WITH(ROWLOCK) 
WHERE S.GameTypeID = 3501
	AND S.ExchangeId IN (20,72)

INSERT INTO StakeLevel (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake,ExchangeId)
SELECT T.GameTypeID, T.MinLabel,T.MaxLabel,	T.MinStake , T.MaxStake, T.ExchangeId
FROM #temp T WITH(NOLOCK)
ORDER BY GameTypeID,ExchangeId,MaxStake

DROP TABLE #temp