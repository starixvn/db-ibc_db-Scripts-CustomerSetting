/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20210427
	Created: Winfred 
	Task: #153850 - Macau Game - Add 5 new VoidBridge games May 2021 - Deposit - UUS [redmine : 153850]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(3))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--UUS
SELECT 4081 ,'0.3'  ,'60'      ,0.3  ,60      ,20   UNION ALL	--UUS	--US$, USDT,UUS
SELECT 4082 ,'0.5'  ,'50'      ,0.5  ,50      ,20   UNION ALL	--UUS	--US$, USDT,UUS
SELECT 4083 ,'0.5'  ,'50'      ,0.5  ,50      ,20   UNION ALL	--UUS	--US$, USDT,UUS
SELECT 4084 ,'0.4'  ,'40'      ,0.4  ,40      ,20   UNION ALL	--UUS	--US$, USDT,UUS
SELECT 4085 ,'0.25' ,'50'      ,0.25 ,50      ,20				--UUS	--US$, USDT,UUS



;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 4001)

MERGE Dep_StakeLevelGroupDetail as g 
USING STAKE_TEMP s on g.StakeLevelID = s.StakeLevelID AND g.GameTypeID = s.GameTypeID
WHEN MATCHED THEN UPDATE SET 
					g.MinLabel = s.MinLabel,
					g.MaxLabel = s.MaxLabel,
					g.MinStake =  s.MinStake,
					g.MaxStake =  s.MaxStake
WHEN NOT MATCHED THEN 
					INSERT (StakeLevelID,GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake)
					VALUES (s.StakeLevelID,s.GameTypeID,s.MinLabel,s.MaxLabel,s.MinStake,s.MaxStake)					
					 ;

DROP TABLE #StakeLevel_Temp