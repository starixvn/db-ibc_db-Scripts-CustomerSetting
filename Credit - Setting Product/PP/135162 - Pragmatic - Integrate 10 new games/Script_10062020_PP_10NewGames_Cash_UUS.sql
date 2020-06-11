/*
	Date: 20200610
	Created: Winfred 
	Task: #135162 - Pragmatic - Integrate 10 new games for Cash UUS
	DB: DBCUST/CUSTDB
*/

CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
									,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
									,ExchangeId int)
									
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--UUS
SELECT 4218 ,'0.05' ,'50' ,0.05,50,20	UNION ALL
SELECT 4219 ,'0.1' ,'20' ,0.1,20,20		UNION ALL
SELECT 4220 ,'0.1' ,'5' ,0.1,5,20		UNION ALL
SELECT 4221 ,'0.2' ,'4' ,0.2,4,20		UNION ALL
SELECT 4222 ,'0.2' ,'4' ,0.2,4,20		UNION ALL
SELECT 4223 ,'0.05' ,'15' ,0.05,15,20	UNION ALL
SELECT 4224 ,'0.25' ,'15' ,0.25,15,20	UNION ALL
SELECT 4225 ,'0.1' ,'40' ,0.1,40,20		UNION ALL
SELECT 4226 ,'0.25' ,'15' ,0.25,15,20	UNION ALL
SELECT 4227 ,'0.1' ,'40' ,0.1,40,20		UNION ALL
-- YNG
SELECT 4218 ,'0.05' ,'50' ,0.05,50,72	UNION ALL
SELECT 4219 ,'0.1' ,'20' ,0.1,20,72		UNION ALL
SELECT 4220 ,'0.1' ,'5' ,0.1,5,72		UNION ALL
SELECT 4221 ,'0.2' ,'4' ,0.2,4,72		UNION ALL
SELECT 4222 ,'0.2' ,'4' ,0.2,4,72		UNION ALL
SELECT 4223 ,'0.05' ,'15' ,0.05,15,72	UNION ALL
SELECT 4224 ,'0.25' ,'15' ,0.25,15,72	UNION ALL
SELECT 4225 ,'0.1' ,'40' ,0.1,40,72		UNION ALL
SELECT 4226 ,'0.25' ,'15' ,0.25,15,72	UNION ALL
SELECT 4227 ,'0.1' ,'40' ,0.1,40,72		

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  WHERE t.ExchangeId = s.ExchangeId) t
WHERE s.GameTypeID = 4101)

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