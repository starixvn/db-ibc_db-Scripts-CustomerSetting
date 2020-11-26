/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tina
	Date: 20201125
	Task: PG Soft - Add 41 new games - Test currencies - Deposit RedmineID:#145664
	DB: DBCust/CustDB
*/
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(16))

--#region insert data to temp table	
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
-----------------------------Test Currencies-----------------------------
SELECT 6021 ,'2.5'  ,'450'     ,2.5  ,450     ,20   UNION ALL	--(UUS)
SELECT 6022 ,'0.6'  ,'10500'   ,0.6  ,10500   ,20   UNION ALL	--(UUS)
SELECT 6023 ,'2.5'  ,'250'     ,2.5  ,250     ,20   UNION ALL	--(UUS)
SELECT 6024 ,'3'    ,'300'     ,3    ,300     ,20   UNION ALL	--(UUS)
SELECT 6025 ,'0.9'  ,'21000'   ,0.9  ,21000   ,20   UNION ALL	--(UUS)
SELECT 6026 ,'3'    ,'3000'    ,3    ,3000    ,20   UNION ALL	--(UUS)
SELECT 6027 ,'0.9'  ,'10500'   ,0.9  ,10500   ,20   UNION ALL	--(UUS)
SELECT 6028 ,'3'    ,'1500'    ,3    ,1500    ,20   UNION ALL	--(UUS)
SELECT 6029 ,'3'    ,'90'      ,3    ,90      ,20   UNION ALL	--(UUS)
SELECT 6030 ,'3'    ,'300'     ,3    ,300     ,20   UNION ALL	--(UUS)
SELECT 6031 ,'3'    ,'3000'    ,3    ,3000    ,20   UNION ALL	--(UUS)
SELECT 6032 ,'0.9'  ,'10500'   ,0.9  ,10500   ,20   UNION ALL	--(UUS)
SELECT 6033 ,'3'    ,'3000'    ,3    ,3000    ,20   UNION ALL	--(UUS)
SELECT 6034 ,'2'    ,'1000'    ,2    ,1000    ,20   UNION ALL	--(UUS)
SELECT 6035 ,'2'    ,'200'     ,2    ,200     ,20   UNION ALL	--(UUS)
SELECT 6036 ,'3'    ,'3000'    ,3    ,3000    ,20   UNION ALL	--(UUS)
SELECT 6037 ,'0.9'  ,'10500'   ,0.9  ,10500   ,20   UNION ALL	--(UUS)
SELECT 6038 ,'1'    ,'3500'    ,1    ,3500    ,20   UNION ALL	--(UUS)
SELECT 6039 ,'2.7'  ,'2700'    ,2.7  ,2700    ,20   UNION ALL	--(UUS)
SELECT 6040 ,'3'    ,'3000'    ,3    ,3000    ,20   UNION ALL	--(UUS)
SELECT 6041 ,'3'    ,'1500'    ,3    ,1500    ,20   UNION ALL	--(UUS)
SELECT 6042 ,'3'    ,'3000'    ,3    ,3000    ,20   UNION ALL	--(UUS)
SELECT 6043 ,'2.7'  ,'1350'    ,2.7  ,1350    ,20   UNION ALL	--(UUS)
SELECT 6044 ,'3'    ,'1500'    ,3    ,1500    ,20   UNION ALL	--(UUS)
SELECT 6045 ,'3'    ,'1500'    ,3    ,1500    ,20   UNION ALL	--(UUS)
SELECT 6046 ,'2.7'  ,'540'     ,2.7  ,540     ,20   UNION ALL	--(UUS)
SELECT 6047 ,'2.7'  ,'270'     ,2.7  ,270     ,20   UNION ALL	--(UUS)
SELECT 6048 ,'3'    ,'300'     ,3    ,300     ,20   UNION ALL	--(UUS)
SELECT 6049 ,'1'    ,'100'     ,1    ,100     ,20   UNION ALL	--(UUS)
SELECT 6050 ,'3'    ,'900'     ,3    ,900     ,20   UNION ALL	--(UUS)
SELECT 6051 ,'2'    ,'1000'    ,2    ,1000    ,20   UNION ALL	--(UUS)
SELECT 6052 ,'2'    ,'2000'    ,2    ,2000    ,20   UNION ALL	--(UUS)
SELECT 6053 ,'5'    ,'5000'    ,5    ,5000    ,20   UNION ALL	--(UUS)
SELECT 6054 ,'2.5'  ,'250'     ,2.5  ,250     ,20   UNION ALL	--(UUS)
SELECT 6055 ,'2.5'  ,'1000'    ,2.5  ,1000    ,20   UNION ALL	--(UUS)
SELECT 6056 ,'2'    ,'200'     ,2    ,200     ,20   UNION ALL	--(UUS)
SELECT 6057 ,'2.5'  ,'1000'    ,2.5  ,1000    ,20   UNION ALL	--(UUS)
SELECT 6058 ,'2'    ,'200'     ,2    ,200     ,20   UNION ALL	--(UUS)
SELECT 6059 ,'2.5'  ,'1000'    ,2.5  ,1000    ,20   UNION ALL	--(UUS)
SELECT 6060 ,'2'    ,'200'     ,2    ,200     ,20   UNION ALL	--(UUS)
SELECT 6061 ,'1'    ,'100'     ,1    ,100     ,20   UNION ALL	--(UUS)
SELECT 6021 ,'2.5'  ,'450'     ,2.5  ,450     ,72   UNION ALL	--YNG(YNG)
SELECT 6022 ,'0.6'  ,'10500'   ,0.6  ,10500   ,72   UNION ALL	--YNG(YNG)
SELECT 6023 ,'2.5'  ,'250'     ,2.5  ,250     ,72   UNION ALL	--YNG(YNG)
SELECT 6024 ,'3'    ,'300'     ,3    ,300     ,72   UNION ALL	--YNG(YNG)
SELECT 6025 ,'0.9'  ,'21000'   ,0.9  ,21000   ,72   UNION ALL	--YNG(YNG)
SELECT 6026 ,'3'    ,'3000'    ,3    ,3000    ,72   UNION ALL	--YNG(YNG)
SELECT 6027 ,'0.9'  ,'10500'   ,0.9  ,10500   ,72   UNION ALL	--YNG(YNG)
SELECT 6028 ,'3'    ,'1500'    ,3    ,1500    ,72   UNION ALL	--YNG(YNG)
SELECT 6029 ,'3'    ,'90'      ,3    ,90      ,72   UNION ALL	--YNG(YNG)
SELECT 6030 ,'3'    ,'300'     ,3    ,300     ,72   UNION ALL	--YNG(YNG)
SELECT 6031 ,'3'    ,'3000'    ,3    ,3000    ,72   UNION ALL	--YNG(YNG)
SELECT 6032 ,'0.9'  ,'10500'   ,0.9  ,10500   ,72   UNION ALL	--YNG(YNG)
SELECT 6033 ,'3'    ,'3000'    ,3    ,3000    ,72   UNION ALL	--YNG(YNG)
SELECT 6034 ,'2'    ,'1000'    ,2    ,1000    ,72   UNION ALL	--YNG(YNG)
SELECT 6035 ,'2'    ,'200'     ,2    ,200     ,72   UNION ALL	--YNG(YNG)
SELECT 6036 ,'3'    ,'3000'    ,3    ,3000    ,72   UNION ALL	--YNG(YNG)
SELECT 6037 ,'0.9'  ,'10500'   ,0.9  ,10500   ,72   UNION ALL	--YNG(YNG)
SELECT 6038 ,'1'    ,'3500'    ,1    ,3500    ,72   UNION ALL	--YNG(YNG)
SELECT 6039 ,'2.7'  ,'2700'    ,2.7  ,2700    ,72   UNION ALL	--YNG(YNG)
SELECT 6040 ,'3'    ,'3000'    ,3    ,3000    ,72   UNION ALL	--YNG(YNG)
SELECT 6041 ,'3'    ,'1500'    ,3    ,1500    ,72   UNION ALL	--YNG(YNG)
SELECT 6042 ,'3'    ,'3000'    ,3    ,3000    ,72   UNION ALL	--YNG(YNG)
SELECT 6043 ,'2.7'  ,'1350'    ,2.7  ,1350    ,72   UNION ALL	--YNG(YNG)
SELECT 6044 ,'3'    ,'1500'    ,3    ,1500    ,72   UNION ALL	--YNG(YNG)
SELECT 6045 ,'3'    ,'1500'    ,3    ,1500    ,72   UNION ALL	--YNG(YNG)
SELECT 6046 ,'2.7'  ,'540'     ,2.7  ,540     ,72   UNION ALL	--YNG(YNG)
SELECT 6047 ,'2.7'  ,'270'     ,2.7  ,270     ,72   UNION ALL	--YNG(YNG)
SELECT 6048 ,'3'    ,'300'     ,3    ,300     ,72   UNION ALL	--YNG(YNG)
SELECT 6049 ,'1'    ,'100'     ,1    ,100     ,72   UNION ALL	--YNG(YNG)
SELECT 6050 ,'3'    ,'900'     ,3    ,900     ,72   UNION ALL	--YNG(YNG)
SELECT 6051 ,'2'    ,'1000'    ,2    ,1000    ,72   UNION ALL	--YNG(YNG)
SELECT 6052 ,'2'    ,'2000'    ,2    ,2000    ,72   UNION ALL	--YNG(YNG)
SELECT 6053 ,'5'    ,'5000'    ,5    ,5000    ,72   UNION ALL	--YNG(YNG)
SELECT 6054 ,'2.5'  ,'250'     ,2.5  ,250     ,72   UNION ALL	--YNG(YNG)
SELECT 6055 ,'2.5'  ,'1000'    ,2.5  ,1000    ,72   UNION ALL	--YNG(YNG)
SELECT 6056 ,'2'    ,'200'     ,2    ,200     ,72   UNION ALL	--YNG(YNG)
SELECT 6057 ,'2.5'  ,'1000'    ,2.5  ,1000    ,72   UNION ALL	--YNG(YNG)
SELECT 6058 ,'2'    ,'200'     ,2    ,200     ,72   UNION ALL	--YNG(YNG)
SELECT 6059 ,'2.5'  ,'1000'    ,2.5  ,1000    ,72   UNION ALL	--YNG(YNG)
SELECT 6060 ,'2'    ,'200'     ,2    ,200     ,72   UNION ALL	--YNG(YNG)
SELECT 6061 ,'1'    ,'100'     ,1    ,100     ,72				--YNG(YNG)

--#endregion insert data to temp table

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #Dep_StakeLevel_Temp t
WHERE MaxStake > 999

;WITH STAKE_TEMP AS 
(
	SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
	FROM Dep_StakeLevel s WITH(NOLOCK)
	CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
				  FROM #Dep_StakeLevel_Temp t 
				  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
	WHERE s.GameTypeID = 6001
)

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