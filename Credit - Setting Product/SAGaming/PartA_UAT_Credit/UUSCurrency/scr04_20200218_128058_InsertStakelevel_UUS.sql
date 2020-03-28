;/*
	Created: 20200218@Tiara
	Task: Insert StakeLevel for SA Gaming - UUS [Redmine: #128128]
	DB: DBCUST/CustDB
*/

-- BEGIN STEP 1: DEPLOY THIS SCRIPT ON DBCUST/CustDB	 --
-----------------------------------------------------------
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
SELECT 3001,'1','500',1,500,20 UNION ALL
SELECT 3001,'50','1000',50,1000,20 UNION ALL
SELECT 3001,'100','2000',100,2000,20

UPDATE t
SET MinLabel = REVERSE(STUFF (REVERSE(t.MinLabel),4,0,','))
FROM #temp t
WHERE MinStake > 999

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #temp t
WHERE MaxStake > 999

DELETE S
FROM StakeLevel S WITH (ROWLOCK)
WHERE S.GameTypeID BETWEEN 3001 AND 3007 AND S.ExchangeId IN (20)

INSERT INTO StakeLevel(GameTypeID, MinLabel, MaxLabel, MinStake,MaxStake, ExchangeID)
SELECT T.GameTypeID, T.MinLabel,T.MaxLabel,	T.MinStake , T.MaxStake, T.ExchangeId
FROM #temp T WITH(NOLOCK) 
WHERE T.GameTypeID = 3001 AND T.ExchangeId IN (20)

DROP TABLE #temp