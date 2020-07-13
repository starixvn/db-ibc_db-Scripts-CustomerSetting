/*
	Date: 20200709
	Created: Winfred 
	Task: #137367 - Pragmatic - Initialize setting for 7 New Jackpot Games for Cash [Redmine:135875]
	DB: DBCUST/CUSTDB
*/

CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
									,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
									,ExchangeId int)
									
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--UUS
SELECT 4187 ,'1.4' ,'14' ,1.4,14,20		UNION ALL
SELECT 4188 ,'1.25' ,'15' ,1.25,15,20	UNION ALL
SELECT 4189 ,'1.5' ,'15' ,1.5,15,20		UNION ALL
SELECT 4228 ,'1.8' ,'54' ,1.8,54,20		UNION ALL
SELECT 4229 ,'1.5' ,'50' ,1.5,50,20		UNION ALL
SELECT 4230 ,'1.5' ,'50' ,1.5,50,20		UNION ALL
SELECT 4231 ,'1.25' ,'30' ,1.25,30,20	UNION ALL
-- YNG
SELECT 4187 ,'1.4' ,'14' ,1.4,14,72		UNION ALL
SELECT 4188 ,'1.25' ,'15' ,1.25,15,72	UNION ALL
SELECT 4189 ,'1.5' ,'15' ,1.5,15,72		UNION ALL
SELECT 4228 ,'1.8' ,'54' ,1.8,54,72		UNION ALL
SELECT 4229 ,'1.5' ,'50' ,1.5,50,72		UNION ALL
SELECT 4230 ,'1.5' ,'50' ,1.5,50,72		UNION ALL
SELECT 4231 ,'1.25' ,'30' ,1.25,30,72		

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