/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20220203
	Created: Winfred 
	Task: #168832 - Spadegaming - 10 new games 2022 - UUS SIT deposit RedmineID:#168832
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId INT, GameGroupID INT DEFAULT(11))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--UUS
SELECT 4363 ,'1'        ,'100'         ,1        ,100         ,20   UNION ALL	--UUS	--INH,YNG,UUS,DON
SELECT 4368 ,'0.8'      ,'100'         ,0.8      ,100         ,20   UNION ALL	--UUS	--INH,YNG,UUS,DON
SELECT 4372 ,'1'        ,'100'         ,1        ,100         ,20   UNION ALL	--UUS	--INH,YNG,UUS,DON
SELECT 4375 ,'1'        ,'1200'        ,1        ,1200        ,20   UNION ALL	--UUS	--INH,YNG,UUS,DON
SELECT 4376 ,'1'        ,'100'         ,1        ,100         ,20   UNION ALL	--UUS	--INH,YNG,UUS,DON
SELECT 4377 ,'1'        ,'100'         ,1        ,100         ,20   UNION ALL	--UUS	--INH,YNG,UUS,DON
SELECT 4378 ,'0.9'      ,'150'         ,0.9      ,150         ,20   UNION ALL	--UUS	--INH,YNG,UUS,DON
SELECT 4379 ,'1'        ,'1000'        ,1        ,1000        ,20   UNION ALL	--UUS	--INH,YNG,UUS,DON
SELECT 4380 ,'1'        ,'1000'        ,1        ,1000        ,20   UNION ALL	--UUS	--INH,YNG,UUS,DON
SELECT 4381 ,'1'        ,'1000'        ,1        ,1000        ,20   UNION ALL	--UUS	--INH,YNG,UUS,DON
SELECT 4382 ,'1'        ,'100'         ,1        ,100         ,20   UNION ALL	--UUS	--INH,YNG,UUS,DON
SELECT 4383 ,'1'        ,'100'         ,1        ,100         ,20   UNION ALL	--UUS	--INH,YNG,UUS,DON
SELECT 4384 ,'0.8'      ,'125'         ,0.8      ,125         ,20   UNION ALL	--UUS	--INH,YNG,UUS,DON
--YNG
SELECT 4363 ,'1'        ,'100'         ,1        ,100         ,72   UNION ALL	--YNG	--INH,YNG,UUS,DON
SELECT 4368 ,'0.8'      ,'100'         ,0.8      ,100         ,72   UNION ALL	--YNG	--INH,YNG,UUS,DON
SELECT 4372 ,'1'        ,'100'         ,1        ,100         ,72   UNION ALL	--YNG	--INH,YNG,UUS,DON
SELECT 4375 ,'1'        ,'1200'        ,1        ,1200        ,72   UNION ALL	--YNG	--INH,YNG,UUS,DON
SELECT 4376 ,'1'        ,'100'         ,1        ,100         ,72   UNION ALL	--YNG	--INH,YNG,UUS,DON
SELECT 4377 ,'1'        ,'100'         ,1        ,100         ,72   UNION ALL	--YNG	--INH,YNG,UUS,DON
SELECT 4378 ,'0.9'      ,'150'         ,0.9      ,150         ,72   UNION ALL	--YNG	--INH,YNG,UUS,DON
SELECT 4379 ,'1'        ,'1000'        ,1        ,1000        ,72   UNION ALL	--YNG	--INH,YNG,UUS,DON
SELECT 4380 ,'1'        ,'1000'        ,1        ,1000        ,72   UNION ALL	--YNG	--INH,YNG,UUS,DON
SELECT 4381 ,'1'        ,'1000'        ,1        ,1000        ,72   UNION ALL	--YNG	--INH,YNG,UUS,DON
SELECT 4382 ,'1'        ,'100'         ,1        ,100         ,72   UNION ALL	--YNG	--INH,YNG,UUS,DON
SELECT 4383 ,'1'        ,'100'         ,1        ,100         ,72   UNION ALL	--YNG	--INH,YNG,UUS,DON
SELECT 4384 ,'0.8'      ,'125'         ,0.8      ,125         ,72				--YNG	--INH,YNG,UUS,DON


UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 4301)

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