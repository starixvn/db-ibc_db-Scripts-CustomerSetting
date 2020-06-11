/*
	Date: 20200610
	Created: Winfred 
	Task: #135162 - Pragmatic - Integrate 10 new games for Credit UUS
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(6))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--UUS
SELECT 4218 ,'0.05' ,'75',0.05,75,20		UNION ALL
SELECT 4219 ,'0.1' ,'100',0.1,100,20		UNION ALL
SELECT 4220 ,'0.1' ,'10',0.1,10,20			UNION ALL
SELECT 4221 ,'0.2' ,'12',0.2,12,20			UNION ALL
SELECT 4222 ,'0.2' ,'8',0.2,8,20			UNION ALL
SELECT 4223 ,'0.05' ,'25',0.05,25,20		UNION ALL
SELECT 4224 ,'0.25' ,'50',0.25,50,20		UNION ALL
SELECT 4225 ,'0.1' ,'100',0.1,100,20		UNION ALL
SELECT 4226 ,'0.25' ,'37.5',0.25,37.5,20	UNION ALL
SELECT 4227 ,'0.1' ,'100',0.1,100,20		UNION ALL							
-- YNG
SELECT 4218 ,'0.05' ,'75',0.05,75,72		UNION ALL
SELECT 4219 ,'0.1' ,'100',0.1,100,72		UNION ALL
SELECT 4220 ,'0.1' ,'10',0.1,10,72			UNION ALL
SELECT 4221 ,'0.2' ,'12',0.2,12,72			UNION ALL
SELECT 4222 ,'0.2' ,'8',0.2,8,72			UNION ALL
SELECT 4223 ,'0.05' ,'25',0.05,25,72		UNION ALL
SELECT 4224 ,'0.25' ,'50',0.25,50,72		UNION ALL
SELECT 4225 ,'0.1' ,'100',0.1,100,72		UNION ALL
SELECT 4226 ,'0.25' ,'37.5',0.25,37.5,72	UNION ALL
SELECT 4227 ,'0.1' ,'100',0.1,100,72			



;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 4101)

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