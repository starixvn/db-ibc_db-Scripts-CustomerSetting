/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created:	Winfred
	Date:		20220121
	Task:		Update setting 232	PG Soft (PG Soft) for currency INR1 RedmineID:#166295
	DB:			DBCust/CustDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId INT, GameGroupID INT DEFAULT(15))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
SELECT 6001 ,'6'       ,'600'         ,6       ,600         ,10   UNION ALL	--INR1
SELECT 6002 ,'6'       ,'600'         ,6       ,600         ,10   UNION ALL	--INR1
SELECT 6003 ,'6'       ,'600'         ,6       ,600         ,10   UNION ALL	--INR1
SELECT 6004 ,'6'       ,'600'         ,6       ,600         ,10   UNION ALL	--INR1
SELECT 6005 ,'10'      ,'10000'       ,10      ,10000       ,10   UNION ALL	--INR1
SELECT 6006 ,'6'       ,'600'         ,6       ,600         ,10   UNION ALL	--INR1
SELECT 6007 ,'6'       ,'1500'        ,6       ,1500        ,10   UNION ALL	--INR1
SELECT 6008 ,'6'       ,'3000'        ,6       ,3000        ,10   UNION ALL	--INR1
SELECT 6009 ,'5'       ,'5000'        ,5       ,5000        ,10   UNION ALL	--INR1
SELECT 6010 ,'10'      ,'3000'        ,10      ,3000        ,10   UNION ALL	--INR1
SELECT 6011 ,'6'       ,'1500'        ,6       ,1500        ,10   UNION ALL	--INR1
SELECT 6012 ,'6'       ,'1500'        ,6       ,1500        ,10   UNION ALL	--INR1
SELECT 6013 ,'10'      ,'2000'        ,10      ,2000        ,10   UNION ALL	--INR1
SELECT 6014 ,'9'       ,'900'         ,9       ,900         ,10   UNION ALL	--INR1
SELECT 6015 ,'6'       ,'1500'        ,6       ,1500        ,10   UNION ALL	--INR1
SELECT 6016 ,'6'       ,'600'         ,6       ,600         ,10   UNION ALL	--INR1
SELECT 6017 ,'9'       ,'1800'        ,9       ,1800        ,10   UNION ALL	--INR1
SELECT 6018 ,'6'       ,'3000'        ,6       ,3000        ,10   UNION ALL	--INR1
SELECT 6019 ,'10'      ,'20000'       ,10      ,20000       ,10   UNION ALL	--INR1
SELECT 6020 ,'6'       ,'6000'        ,6       ,6000        ,10   UNION ALL	--INR1
SELECT 6021 ,'5'       ,'900'         ,5       ,900         ,10   UNION ALL	--INR1
SELECT 6022 ,'1'       ,'30000'       ,1       ,30000       ,10   UNION ALL	--INR1
SELECT 6023 ,'7.5'     ,'750'         ,7.5     ,750         ,10   UNION ALL	--INR1
SELECT 6024 ,'9'       ,'900'         ,9       ,900         ,10   UNION ALL	--INR1
SELECT 6025 ,'1.5'     ,'60000'       ,1.5     ,60000       ,10   UNION ALL	--INR1
SELECT 6026 ,'9'       ,'9000'        ,9       ,9000        ,10   UNION ALL	--INR1
SELECT 6027 ,'1.5'     ,'30000'       ,1.5     ,30000       ,10   UNION ALL	--INR1
SELECT 6028 ,'9'       ,'4500'        ,9       ,4500        ,10   UNION ALL	--INR1
SELECT 6029 ,'9'       ,'270'         ,9       ,270         ,10   UNION ALL	--INR1
SELECT 6030 ,'9'       ,'900'         ,9       ,900         ,10   UNION ALL	--INR1
SELECT 6031 ,'9'       ,'9000'        ,9       ,9000        ,10   UNION ALL	--INR1
SELECT 6032 ,'1.5'     ,'30000'       ,1.5     ,30000       ,10   UNION ALL	--INR1
SELECT 6033 ,'9'       ,'9000'        ,9       ,9000        ,10   UNION ALL	--INR1
SELECT 6034 ,'6'       ,'3000'        ,6       ,3000        ,10   UNION ALL	--INR1
SELECT 6035 ,'10'      ,'1000'        ,10      ,1000        ,10   UNION ALL	--INR1
SELECT 6036 ,'9'       ,'9000'        ,9       ,9000        ,10   UNION ALL	--INR1
SELECT 6037 ,'1.5'     ,'30000'       ,1.5     ,30000       ,10   UNION ALL	--INR1
SELECT 6038 ,'1.5'     ,'10000'       ,1.5     ,10000       ,10   UNION ALL	--INR1
SELECT 6039 ,'9'       ,'9000'        ,9       ,9000        ,10   UNION ALL	--INR1
SELECT 6040 ,'9'       ,'9000'        ,9       ,9000        ,10   UNION ALL	--INR1
SELECT 6041 ,'9'       ,'4500'        ,9       ,4500        ,10   UNION ALL	--INR1
SELECT 6042 ,'9'       ,'9000'        ,9       ,9000        ,10   UNION ALL	--INR1
SELECT 6043 ,'9'       ,'4500'        ,9       ,4500        ,10   UNION ALL	--INR1
SELECT 6044 ,'9'       ,'4500'        ,9       ,4500        ,10   UNION ALL	--INR1
SELECT 6045 ,'10'      ,'5000'        ,10      ,5000        ,10   UNION ALL	--INR1
SELECT 6046 ,'9'       ,'1800'        ,9       ,1800        ,10   UNION ALL	--INR1
SELECT 6047 ,'9'       ,'900'         ,9       ,900         ,10   UNION ALL	--INR1
SELECT 6048 ,'9'       ,'900'         ,9       ,900         ,10   UNION ALL	--INR1
SELECT 6049 ,'3'       ,'300'         ,3       ,300         ,10   UNION ALL	--INR1
SELECT 6050 ,'9'       ,'2700'        ,9       ,2700        ,10   UNION ALL	--INR1
SELECT 6051 ,'6'       ,'3000'        ,6       ,3000        ,10   UNION ALL	--INR1
SELECT 6052 ,'6'       ,'6000'        ,6       ,6000        ,10   UNION ALL	--INR1
SELECT 6053 ,'10'      ,'10000'       ,10      ,10000       ,10   UNION ALL	--INR1
SELECT 6054 ,'10'      ,'1000'        ,10      ,1000        ,10   UNION ALL	--INR1
SELECT 6055 ,'10'      ,'4000'        ,10      ,4000        ,10   UNION ALL	--INR1
SELECT 6056 ,'6'       ,'600'         ,6       ,600         ,10   UNION ALL	--INR1
SELECT 6057 ,'10'      ,'4000'        ,10      ,4000        ,10   UNION ALL	--INR1
SELECT 6058 ,'6'       ,'600'         ,6       ,600         ,10   UNION ALL	--INR1
SELECT 6059 ,'10'      ,'4000'        ,10      ,4000        ,10   UNION ALL	--INR1
SELECT 6060 ,'6'       ,'600'         ,6       ,600         ,10   UNION ALL	--INR1
SELECT 6061 ,'3'       ,'300'         ,3       ,300         ,10   UNION ALL	--INR1
SELECT 6063 ,'6'       ,'3000'        ,6       ,3000        ,10   UNION ALL	--INR1
SELECT 6064 ,'6'       ,'600'         ,6       ,600         ,10   UNION ALL	--INR1
SELECT 6065 ,'6'       ,'600'         ,6       ,600         ,10   UNION ALL	--INR1
SELECT 6066 ,'5'       ,'5000'        ,5       ,5000        ,10   UNION ALL	--INR1
SELECT 6067 ,'10'      ,'4000'        ,10      ,4000        ,10   UNION ALL	--INR1
SELECT 6069 ,'6'       ,'600'         ,6       ,600         ,10   UNION ALL	--INR1
SELECT 6070 ,'5'       ,'5000'        ,5       ,5000        ,10   UNION ALL	--INR1
SELECT 6071 ,'5'       ,'5000'        ,5       ,5000        ,10   UNION ALL	--INR1
SELECT 6072 ,'6'       ,'600'         ,6       ,600         ,10   UNION ALL	--INR1
SELECT 6073 ,'5'       ,'5000'        ,5       ,5000        ,10   UNION ALL	--INR1
SELECT 6074 ,'5'       ,'5000'        ,5       ,5000        ,10   UNION ALL	--INR1
SELECT 6075 ,'6'       ,'600'         ,6       ,600         ,10   UNION ALL	--INR1
SELECT 6076 ,'6'       ,'600'         ,6       ,600         ,10   UNION ALL	--INR1
SELECT 6077 ,'6'       ,'600'         ,6       ,600         ,10   UNION ALL	--INR1
SELECT 6078 ,'6'       ,'600'         ,6       ,600         ,10   UNION ALL	--INR1
SELECT 6079 ,'10'      ,'4000'        ,10      ,4000        ,10   UNION ALL	--INR1
SELECT 6080 ,'6'       ,'600'         ,6       ,600         ,10   UNION ALL	--INR1
SELECT 6081 ,'6'       ,'600'         ,6       ,600         ,10   UNION ALL	--INR1
SELECT 6082 ,'5'       ,'5000'        ,5       ,5000        ,10   UNION ALL	--INR1
SELECT 6083 ,'6'       ,'600'         ,6       ,600         ,10   UNION ALL	--INR1
SELECT 6084 ,'6'       ,'3000'        ,6       ,3000        ,10   UNION ALL	--INR1
SELECT 6085 ,'5'       ,'5000'        ,5       ,5000        ,10   UNION ALL	--INR1
SELECT 6086 ,'6'       ,'600'         ,6       ,600         ,10				--INR1
	
UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999	
	
;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 6001)

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