/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20211019
	Created: Winfred 
	Task: #163201 - Macau Game - Add 5 new games - Credit - UUS [redmine : 163201]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(1))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--================  BP    ================
--UUS
SELECT 4091 ,'0.1'  ,'4'       ,0.1  ,4       ,20   UNION ALL	--UUS	--US$, Yen, $US, UT, USD,UUS
SELECT 4092 ,'0.2'  ,'4'       ,0.2  ,4       ,20   UNION ALL	--UUS	--US$, Yen, $US, UT, USD,UUS
SELECT 4093 ,'0.1'  ,'10'      ,0.1  ,10      ,20   UNION ALL	--UUS	--US$, Yen, $US, UT, USD,UUS
--================  VP    ================
SELECT 4094 ,'0.25' ,'25'      ,0.25 ,25      ,20   UNION ALL	--UUS	--UUS
SELECT 4095 ,'0.1'  ,'4'       ,0.1  ,4       ,20				--UUS	--UUS

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 4001)

MERGE StakeLevelGroupDetail as g 
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