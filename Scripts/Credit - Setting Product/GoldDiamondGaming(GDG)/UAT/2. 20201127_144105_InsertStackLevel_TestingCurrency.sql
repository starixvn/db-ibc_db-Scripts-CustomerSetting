/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20201127@Tina
	Task: Insert StakeLevel for Gold Diamond Gaming (GDG) - Real Currency [Redmine: #144105]
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
SELECT 5701, 72, '5', '2,500', 5, 2500 UNION ALL -- YNG(YNG)

SELECT 5701, 20, '5', '2,500', 5, 2500  -- UUS(UUS)

DELETE S
FROM StakeLevel S WITH(ROWLOCK) 
WHERE S.GameTypeID = 5701
	AND S.ExchangeId IN (20,72)

INSERT INTO StakeLevel (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake,ExchangeId)
SELECT T.GameTypeID, T.MinLabel,T.MaxLabel,	T.MinStake , T.MaxStake, T.ExchangeId
FROM #temp T WITH(NOLOCK)
ORDER BY GameTypeID,ExchangeId,MaxStake

DROP TABLE #temp