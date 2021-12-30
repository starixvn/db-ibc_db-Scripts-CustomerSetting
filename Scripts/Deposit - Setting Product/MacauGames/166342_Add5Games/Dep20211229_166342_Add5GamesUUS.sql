/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20211229
	Created: Winfred 
	Task: #166342 - Macau Game - Add 5 new games and re-enable existing buy bonus games - Deposit - UUS [redmine : 166342]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(3))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--================= BP  ========================================
--UUS
SELECT 4056 ,'0.1'      ,'10'          ,0.1      ,10          ,20   UNION ALL	--UUS	--US$, USDT, UUS
SELECT 4062 ,'0.1'      ,'4'           ,0.1      ,4           ,20   UNION ALL	--UUS	--US$, USDT, UUS
SELECT 4066 ,'0.2'      ,'20'          ,0.2      ,20          ,20   UNION ALL	--UUS	--US$, USDT, UUS
SELECT 4076 ,'0.2'      ,'20'          ,0.2      ,20          ,20   UNION ALL	--UUS	--US$, USDT, UUS
--================= VP  ========================================
SELECT 4096 ,'0.25'     ,'25'          ,0.25     ,25          ,20				--UUS	--UUS

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