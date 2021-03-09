/*
	Created: 20210304@Tina
	Task: Insert StakeLevel for PP Live Casino - Test Currency
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
SELECT 3701, 72, '0.1', '2,500', 0.1, 2500 UNION ALL -- YNG(YNG)
SELECT 3701, 20, '0.1', '2,500', 0.1, 2500 --UUS(UUS)

DELETE S
FROM StakeLevel S WITH(ROWLOCK) 
WHERE S.GameTypeID = 3701
	AND S.ExchangeId IN (20,72)

INSERT INTO StakeLevel (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake,ExchangeId)
SELECT T.GameTypeID, T.MinLabel,T.MaxLabel,	T.MinStake , T.MaxStake, T.ExchangeId
FROM #temp T WITH(NOLOCK)
ORDER BY GameTypeID,ExchangeId,MaxStake

DROP TABLE #temp

/*
SELECT *
FROM StakeLevel SL WITH (NOLOCK)
WHERE SL.GameTypeID = 3701
*/