/*
	Created: 20200623@Eden
	Task: Insert StakeLevel for SA Gaming Redmine - HK$,HKK : #128128
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
)
GO

INSERT #temp (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake,ExchangeId)
SELECT 3001,'30','3000',30,3000,67 UNION ALL
SELECT 3001,'100','5000',100,5000,67 UNION ALL
SELECT 3001,'500','10000',500,10000,67 UNION ALL
SELECT 3001,'30','3000',30,3000,5 UNION ALL
SELECT 3001,'100','10000',100,10000,5 UNION ALL
SELECT 3001,'500','20000',500,20000,5 

UPDATE t
SET MinLabel = REVERSE(STUFF (REVERSE(t.MinLabel),4,0,','))
FROM #temp t
WHERE MinStake > 999

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #temp t
WHERE MaxStake > 999

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),8,0,','))
FROM #temp t
WHERE MaxStake > 999999

DELETE S
FROM StakeLevel S WITH(ROWLOCK) 
WHERE S.GameTypeID BETWEEN 3001 AND 3007
	AND S.ExchangeId IN (SELECT ExchangeId FROM #temp)

INSERT INTO StakeLevel (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake,ExchangeId)
SELECT T.GameTypeID, T.MinLabel,T.MaxLabel,	T.MinStake , T.MaxStake, T.ExchangeId
FROM #temp T WITH(NOLOCK)
WHERE T.GameTypeID = 3001

DROP TABLE #temp