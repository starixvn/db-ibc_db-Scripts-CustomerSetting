/*
	Created: 20200406@Elodie
	Task: Insert StakeLevel for BBIN_UUS [Redmine: #131363]
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
SELECT 3300,'5000','500000',5000,500000,20 UNION ALL
SELECT 3300,'10000','1000000',10000,1000000,20 


UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #temp t
WHERE MaxStake > 999

UPDATE t
SET MinLabel = REVERSE(STUFF (REVERSE(t.MinLabel),4,0,','))
FROM #temp t
WHERE MinStake > 999

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),8,0,','))
FROM #temp t
WHERE MaxStake > 999999

DELETE S
FROM StakeLevel S WITH(ROWLOCK) 
WHERE S.GameTypeID = 3300
	AND S.ExchangeId IN (20)


INSERT INTO StakeLevel (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake,ExchangeId)
SELECT T.GameTypeID, T.MinLabel,T.MaxLabel,	T.MinStake , T.MaxStake, T.ExchangeId
FROM #temp T WITH(NOLOCK)

DROP TABLE #temp