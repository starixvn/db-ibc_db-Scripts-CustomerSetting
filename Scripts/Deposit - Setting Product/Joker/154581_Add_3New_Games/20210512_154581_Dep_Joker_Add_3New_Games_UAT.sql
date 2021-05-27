/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210512
	Task:  Add 3 New Games for Joker - deposit  UUS RedmineID:#154581
	DB: DBCust/CustDB
*/
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(18))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--UUS
SELECT 6413 ,'0.25' ,'50'      ,0.25 ,50      ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6414 ,'0.1'  ,'20'      ,0.1  ,20      ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6415 ,'0.2'  ,'20'      ,0.2  ,20      ,20				--UUS	--IN,IND,IDD,IDR,DDD,UUS

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
