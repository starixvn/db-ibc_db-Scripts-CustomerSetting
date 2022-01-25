/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created:	Winfred
	Date:		20220121
	Task:		Update setting 238	Habanero (Habanero) for currency INR1 RedmineID:#166295
	DB:			DBCust/CustDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(21))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
SELECT 7001 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7002 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7003 ,'1.5'     ,'3000'        ,1.5     ,3000        ,10   UNION ALL	--INR1
SELECT 7004 ,'1.5'     ,'3000'        ,1.5     ,3000        ,10   UNION ALL	--INR1
SELECT 7005 ,'1.5'     ,'3000'        ,1.5     ,3000        ,10   UNION ALL	--INR1
SELECT 7006 ,'0.8'     ,'1600'        ,0.8     ,1600        ,10   UNION ALL	--INR1
SELECT 7007 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7008 ,'1.5'     ,'3000'        ,1.5     ,3000        ,10   UNION ALL	--INR1
SELECT 7009 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7010 ,'2.8'     ,'5600'        ,2.8     ,5600        ,10   UNION ALL	--INR1
SELECT 7011 ,'1'       ,'2000'        ,1       ,2000        ,10   UNION ALL	--INR1
SELECT 7012 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7013 ,'2.8'     ,'5600'        ,2.8     ,5600        ,10   UNION ALL	--INR1
SELECT 7014 ,'3'       ,'6000'        ,3       ,6000        ,10   UNION ALL	--INR1
SELECT 7015 ,'2'       ,'4000'        ,2       ,4000        ,10   UNION ALL	--INR1
SELECT 7016 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7017 ,'3'       ,'6000'        ,3       ,6000        ,10   UNION ALL	--INR1
SELECT 7018 ,'2.8'     ,'5600'        ,2.8     ,5600        ,10   UNION ALL	--INR1
SELECT 7019 ,'1.5'     ,'3000'        ,1.5     ,3000        ,10   UNION ALL	--INR1
SELECT 7020 ,'2'       ,'1000'        ,2       ,1000        ,10   UNION ALL	--INR1
SELECT 7021 ,'2'       ,'4000'        ,2       ,4000        ,10   UNION ALL	--INR1
SELECT 7022 ,'2'       ,'4000'        ,2       ,4000        ,10   UNION ALL	--INR1
SELECT 7023 ,'8.8'     ,'4400'        ,8.8     ,4400        ,10   UNION ALL	--INR1
SELECT 7024 ,'1.5'     ,'3000'        ,1.5     ,3000        ,10   UNION ALL	--INR1
SELECT 7025 ,'4'       ,'4000'        ,4       ,4000        ,10   UNION ALL	--INR1
SELECT 7026 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7027 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7028 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7029 ,'2.8'     ,'5600'        ,2.8     ,5600        ,10   UNION ALL	--INR1
SELECT 7030 ,'2'       ,'4000'        ,2       ,4000        ,10   UNION ALL	--INR1
SELECT 7031 ,'1.8'     ,'3600'        ,1.8     ,3600        ,10   UNION ALL	--INR1
SELECT 7032 ,'3'       ,'6000'        ,3       ,6000        ,10   UNION ALL	--INR1
SELECT 7033 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7034 ,'3'       ,'6000'        ,3       ,6000        ,10   UNION ALL	--INR1
SELECT 7035 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7036 ,'1.5'     ,'3000'        ,1.5     ,3000        ,10   UNION ALL	--INR1
SELECT 7037 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7038 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7039 ,'3'       ,'6000'        ,3       ,6000        ,10   UNION ALL	--INR1
SELECT 7040 ,'3'       ,'6000'        ,3       ,6000        ,10   UNION ALL	--INR1
SELECT 7041 ,'3'       ,'6000'        ,3       ,6000        ,10   UNION ALL	--INR1
SELECT 7042 ,'3'       ,'6000'        ,3       ,6000        ,10   UNION ALL	--INR1
SELECT 7043 ,'1.8'     ,'3600'        ,1.8     ,3600        ,10   UNION ALL	--INR1
SELECT 7044 ,'3'       ,'6000'        ,3       ,6000        ,10   UNION ALL	--INR1
SELECT 7045 ,'2'       ,'4000'        ,2       ,4000        ,10   UNION ALL	--INR1
SELECT 7046 ,'5'       ,'5000'        ,5       ,5000        ,10   UNION ALL	--INR1
SELECT 7047 ,'2'       ,'4000'        ,2       ,4000        ,10   UNION ALL	--INR1
SELECT 7048 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7049 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7050 ,'5'       ,'5000'        ,5       ,5000        ,10   UNION ALL	--INR1
SELECT 7051 ,'1.8'     ,'3600'        ,1.8     ,3600        ,10   UNION ALL	--INR1
SELECT 7052 ,'5'       ,'5000'        ,5       ,5000        ,10   UNION ALL	--INR1
SELECT 7053 ,'5'       ,'5000'        ,5       ,5000        ,10   UNION ALL	--INR1
SELECT 7054 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7055 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7056 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7057 ,'2.8'     ,'5600'        ,2.8     ,5600        ,10   UNION ALL	--INR1
SELECT 7058 ,'5'       ,'5000'        ,5       ,5000        ,10   UNION ALL	--INR1
SELECT 7059 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7060 ,'2'       ,'4000'        ,2       ,4000        ,10   UNION ALL	--INR1
SELECT 7061 ,'5'       ,'5000'        ,5       ,5000        ,10   UNION ALL	--INR1
SELECT 7062 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7063 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7064 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7065 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7066 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7067 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7068 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7069 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7070 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7071 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7072 ,'3'       ,'6000'        ,3       ,6000        ,10   UNION ALL	--INR1
SELECT 7073 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7074 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7075 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7076 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7077 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7078 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7079 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7080 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7081 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7082 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7083 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7084 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7085 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7086 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7087 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7088 ,'5'       ,'5000'        ,5       ,5000        ,10   UNION ALL	--INR1
SELECT 7089 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7090 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7091 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7092 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7093 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7094 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7095 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7096 ,'5'       ,'5000'        ,5       ,5000        ,10   UNION ALL	--INR1
SELECT 7097 ,'3'       ,'6000'        ,3       ,6000        ,10   UNION ALL	--INR1
SELECT 7098 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7099 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7101 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7102 ,'2'       ,'4000'        ,2       ,4000        ,10   UNION ALL	--INR1
SELECT 7103 ,'5'       ,'5000'        ,5       ,5000        ,10   UNION ALL	--INR1
SELECT 7104 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7105 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7106 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7107 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7108 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7109 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7110 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7111 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7112 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7113 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7114 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7115 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 7116 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10				--INR1
	
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
WHERE s.GameTypeID = 7001)

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