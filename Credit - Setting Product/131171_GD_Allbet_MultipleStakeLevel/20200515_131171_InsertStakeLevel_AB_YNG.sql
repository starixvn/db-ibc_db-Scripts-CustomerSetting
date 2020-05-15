/*
	Created: 20200515@Tiara
	Date: 20200515
	Task: Insert stakelevel for Allbet - YNG [Redmine: #131171]
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
SELECT 2401,'2','200',2,200,72 UNION ALL
SELECT 2401,'5','500',5,500,72

INSERT INTO StakeLevel(GameTypeID, MinLabel, MaxLabel, MinStake,MaxStake, ExchangeID)
SELECT T.GameTypeID, T.MinLabel,T.MaxLabel,	T.MinStake , T.MaxStake, T.ExchangeId
FROM #temp T WITH(NOLOCK) 
WHERE T.GameTypeID = 2401 AND T.ExchangeId IN (72)

DROP TABLE #temp
