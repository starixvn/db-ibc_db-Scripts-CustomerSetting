/*
	Created: Winfred
	Date: 20200828
	Task: Insert Stake level for WM UUS [Redmine: 131589]
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
--YNG 
SELECT 3401 , 72, '50', '5,000', 50, 5000 UNION ALL 
SELECT 3401 , 72, '20', '30,000', 20, 30000 UNION ALL 
SELECT 3401 , 72, '100', '10,000', 100, 10000 UNION ALL 
SELECT 3401 , 72, '500', '50,000', 500, 50000 UNION ALL 
--UUS
SELECT 3401 , 20, '1', '100', 1, 100  


MERGE StakeLevel as s
USING #temp t
	ON s.GameTypeID = t.GameTypeID 
	AND s.ExchangeId = t.ExchangeId AND s.MinLabel = t.MinLabel and s.MaxLabel = t.MaxLabel
WHEN NOT MATCHED THEN INSERT (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake,ExchangeId)
					VALUES( T.GameTypeID, T.MinLabel,T.MaxLabel, T.MinStake , T.MaxStake, T.ExchangeId)
WHEN MATCHED THEN UPDATE SET s.MinLabel = t.MinLabel,
							s.MaxLabel = t.MaxLabel,
							s.MinStake = t.MinStake,
							s.MaxStake = t.MaxStake;

DROP TABLE #temp