/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200909
	Task:  Insert Setting StakeLevelGroupDetail [Joker] - UUS deposit RedmineID:#131603
	DB: DBCust/CustDB
*/
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(18))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--UUS
SELECT 6401 ,'0.09' ,'54'      ,0.09 ,54      ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6402 ,'0.1'  ,'60'      ,0.1  ,60      ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6403 ,'0.1'  ,'60'      ,0.1  ,60      ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6404 ,'0.2'  ,'120'     ,0.2  ,120     ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6405 ,'0.1'  ,'60'      ,0.1  ,60      ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6406 ,'0.5'  ,'300'     ,0.5  ,300     ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6407 ,'0.5'  ,'300'     ,0.5  ,300     ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6408 ,'0.2'  ,'20'      ,0.2  ,20      ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6409 ,'0.1'  ,'60'      ,0.1  ,60      ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6410 ,'0.1'  ,'60'      ,0.1  ,60      ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6411 ,'0.1'  ,'60'      ,0.1  ,60      ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6412 ,'0.05' ,'30'      ,0.05 ,30      ,20				--UUS	--IN,IND,IDD,IDR,DDD,UUS

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #Dep_StakeLevel_Temp t
WHERE MaxStake > 999

DELETE  a
FROM Dep_StakeLevelGroupDetail a
INNER JOIN Dep_StakeLevel b WITH(NOLOCK) ON a.StakeLevelID = b.StakeLevelID	
WHERE b.GameTypeID = 6401 AND b.ExchangeId IN (SELECT DISTINCT ExchangeId FROM #Dep_StakeLevel_Temp)

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #Dep_StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 6401)

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
DROP TABLE #Dep_StakeLevel_Temp
PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 