/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200805
	Task:  Insert Setting StakeLevelGroupDetail [PG Game] - Deposit - UUS RedmineID:#137763
	DB: DBCust/CustDB
*/
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(16))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--YNG
SELECT 6001 ,'2'      ,'200'       ,2      ,200       ,72   UNION ALL
SELECT 6002 ,'2'      ,'200'       ,2      ,200       ,72   UNION ALL
SELECT 6003 ,'2'      ,'200'       ,2      ,200       ,72   UNION ALL
SELECT 6004 ,'2'      ,'200'       ,2      ,200       ,72   UNION ALL
SELECT 6005 ,'5'      ,'5000'      ,5      ,5000      ,72   UNION ALL
SELECT 6006 ,'2'      ,'200'       ,2      ,200       ,72   UNION ALL
SELECT 6007 ,'2'      ,'500'       ,2      ,500       ,72   UNION ALL
SELECT 6008 ,'2'      ,'1000'      ,2      ,1000      ,72   UNION ALL
SELECT 6009 ,'2'      ,'2000'      ,2      ,2000      ,72   UNION ALL
SELECT 6010 ,'2.5'    ,'750'       ,2.5    ,750       ,72   UNION ALL
SELECT 6011 ,'2'      ,'500'       ,2      ,500       ,72   UNION ALL
SELECT 6012 ,'2'      ,'500'       ,2      ,500       ,72   UNION ALL
SELECT 6013 ,'5'      ,'1000'      ,5      ,1000      ,72   UNION ALL
SELECT 6014 ,'3'      ,'300'       ,3      ,300       ,72   UNION ALL
SELECT 6015 ,'2'      ,'500'       ,2      ,500       ,72   UNION ALL
SELECT 6016 ,'2'      ,'200'       ,2      ,200       ,72   UNION ALL
SELECT 6017 ,'3'      ,'600'       ,3      ,600       ,72   UNION ALL
SELECT 6018 ,'2'      ,'1000'      ,2      ,1000      ,72   UNION ALL
SELECT 6019 ,'5'      ,'10000'     ,5      ,10000     ,72   UNION ALL
SELECT 6020 ,'2'      ,'2000'      ,2      ,2000      ,72   UNION ALL
--UUS
SELECT 6001 ,'2'      ,'200'       ,2      ,200       ,20   UNION ALL
SELECT 6002 ,'2'      ,'200'       ,2      ,200       ,20   UNION ALL
SELECT 6003 ,'2'      ,'200'       ,2      ,200       ,20   UNION ALL
SELECT 6004 ,'2'      ,'200'       ,2      ,200       ,20   UNION ALL
SELECT 6005 ,'5'      ,'5000'      ,5      ,5000      ,20   UNION ALL
SELECT 6006 ,'2'      ,'200'       ,2      ,200       ,20   UNION ALL
SELECT 6007 ,'2'      ,'500'       ,2      ,500       ,20   UNION ALL
SELECT 6008 ,'2'      ,'1000'      ,2      ,1000      ,20   UNION ALL
SELECT 6009 ,'2'      ,'2000'      ,2      ,2000      ,20   UNION ALL
SELECT 6010 ,'2.5'    ,'750'       ,2.5    ,750       ,20   UNION ALL
SELECT 6011 ,'2'      ,'500'       ,2      ,500       ,20   UNION ALL
SELECT 6012 ,'2'      ,'500'       ,2      ,500       ,20   UNION ALL
SELECT 6013 ,'5'      ,'1000'      ,5      ,1000      ,20   UNION ALL
SELECT 6014 ,'3'      ,'300'       ,3      ,300       ,20   UNION ALL
SELECT 6015 ,'2'      ,'500'       ,2      ,500       ,20   UNION ALL
SELECT 6016 ,'2'      ,'200'       ,2      ,200       ,20   UNION ALL
SELECT 6017 ,'3'      ,'600'       ,3      ,600       ,20   UNION ALL
SELECT 6018 ,'2'      ,'1000'      ,2      ,1000      ,20   UNION ALL
SELECT 6019 ,'5'      ,'10000'     ,5      ,10000     ,20   UNION ALL
SELECT 6020 ,'2'      ,'2000'      ,2      ,2000      ,20   
UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #Dep_StakeLevel_Temp t
WHERE MaxStake > 999

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #Dep_StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 6001)

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