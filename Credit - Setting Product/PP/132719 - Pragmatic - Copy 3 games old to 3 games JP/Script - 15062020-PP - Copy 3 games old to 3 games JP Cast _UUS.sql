/*
	Date: 20200615
	Created: Winfred 
	Task: #135906 - PP  - Copy bet limit setting from 3 games old to 3 games JP June 2020
	DB: DBCUST/CUSTDB
*/

CREATE TABLE #StakeLevel_Temp (StakeLevelID int, GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8))

INSERT INTO #StakeLevel_Temp(StakeLevelID,GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake)
SELECT s.StakeLevelID, 4187 as GameTypeID,s.MinLabel,s.MaxLabel,s.MinStake,s.MaxStake
FROM Dep_StakeLevelGroupDetail s
inner join Dep_StakeLevel t on s.StakeLevelID = t.StakeLevelID  and t.GameTypeID = 4101 and t.GameGroupID = 8
WHERE s.GameTypeID = 4107 and t.ExchangeID in (20,72)
union All
SELECT s.StakeLevelID, 4188 as GameTypeID,s.MinLabel,s.MaxLabel,s.MinStake,s.MaxStake
FROM Dep_StakeLevelGroupDetail s
inner join Dep_StakeLevel t on s.StakeLevelID = t.StakeLevelID  and t.GameTypeID = 4101 and t.GameGroupID = 8
WHERE s.GameTypeID = 4116 and t.ExchangeID in (20,72)
union All
SELECT s.StakeLevelID, 4189 as GameTypeID,s.MinLabel,s.MaxLabel,s.MinStake,s.MaxStake
FROM Dep_StakeLevelGroupDetail s
inner join Dep_StakeLevel t on s.StakeLevelID = t.StakeLevelID  and t.GameTypeID = 4101 and t.GameGroupID = 8
WHERE s.GameTypeID = 4139 and t.ExchangeID in (20,72)

MERGE StakeLevelGroupDetail as g 
USING #StakeLevel_Temp s on g.StakeLevelID = s.StakeLevelID AND g.GameTypeID = s.GameTypeID
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