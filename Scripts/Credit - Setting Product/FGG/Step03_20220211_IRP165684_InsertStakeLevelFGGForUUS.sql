/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220211@Elodie
	Task: Insert StakeLevel for FGG - Test Currency [Redmine: #165684]
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
SELECT 8201, 72, '35', '3,500', 35, 3500 UNION ALL -- YNG(YNG)
SELECT 8201, 72, '350', '17,500', 350, 17500 UNION ALL -- YNG(YNG)
SELECT 8201, 72, '700', '35,000', 700, 35000 UNION ALL -- YNG(YNG)

SELECT 8201, 20, '35', '3,500', 35, 3500 UNION ALL -- UUS(UUS)
SELECT 8201, 20, '350', '17,500', 350, 17500 UNION ALL -- UUS(UUS)
SELECT 8201, 20, '700', '35,000', 700, 35000 -- UUS(UUS)


DELETE S
FROM StakeLevel S WITH(ROWLOCK) 
WHERE S.GameTypeID = 8201
	AND S.ExchangeId IN (20,72)

INSERT INTO StakeLevel (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake,ExchangeId)
SELECT T.GameTypeID, T.MinLabel,T.MaxLabel,	T.MinStake , T.MaxStake, T.ExchangeId
FROM #temp T WITH(NOLOCK)
ORDER BY GameTypeID,ExchangeId,MaxStake

DROP TABLE #temp