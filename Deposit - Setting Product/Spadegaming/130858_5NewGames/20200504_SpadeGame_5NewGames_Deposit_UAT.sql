/*
	Created: 20200504@Tiara
	Task: Insert Stake Level for Spade Gaming --UAT - Deposit
	DB: DBCUST/CustDB
*/

USE CustDB
GO

CREATE TABLE #temp(
	GameTypeID		INT,
	[exchangeid]	[int] ,
	[MinLabel]		VARCHAR(30),
	[MaxLabel]		VARCHAR(30),
	[Min]			[decimal](19, 8) NULL,
	[Max]			[decimal](19, 8) NULL,	
) ON [PRIMARY]

GO
INSERT #temp (GameTypeID,[exchangeid],[MinLabel],[MaxLabel], [Min], [Max]) 

SELECT 4337,20,'0.5','90',0.5,90 UNION ALL	--UUS, YNG
SELECT 4338,20,'0.4','80',0.4,80 UNION ALL	
SELECT 4339,20,'0.5','150',0.5,150 UNION ALL	
SELECT 4337,72,'1','2000',1,2000 UNION ALL	
SELECT 4338,72,'0.8','2000',0.8,2000 UNION ALL	
SELECT 4339,72,'1','2000',1,2000 

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #temp t
WHERE Max > 999

;WITH T AS(
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.Min,t.Max
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY (SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.Min,t.Max FROM #temp t WHERE s.ExchangeId = t.ExchangeID AND s.GameGroupID = 12) t
WHERE s.GameTypeID = 4301
)
MERGE Dep_StakeLevelGroupDetail as g 
USING t ON g.GameTypeID = t.GameTypeID AND g.StakeLevelID = t.StakeLevelID 
WHEN MATCHED THEN UPDATE SET g.MinLabel = t.MinLabel,
							g.MaxLabel = t.MaxLabel,
							g.MinStake = t.Min,
							g.MaxStake = t.Max
WHEN NOT MATCHED THEN INSERT ([StakeLevelID]
							   ,[GameTypeID]
							   ,[MinLabel]
							   ,[MaxLabel]
							   ,[MinStake]
							   ,[MaxStake]
							   )
				VALUES(t.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.Min,t.Max);

DROP TABLE #temp
