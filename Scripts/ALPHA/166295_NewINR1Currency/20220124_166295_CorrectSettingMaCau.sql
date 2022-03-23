/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created:	Winfred
	Date:		20220121
	Task:		Update setting 212	Macau Games (Macau Games) for currency INR1 RedmineID:#166295
	DB:			DBCust/CustDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(1))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
SELECT 4002 ,'12.5'    ,'2500'        ,12.5    ,2500        ,10   UNION ALL	--INR1
SELECT 4003 ,'10'      ,'2000'        ,10      ,2000        ,10   UNION ALL	--INR1
SELECT 4004 ,'50'      ,'10000'       ,50      ,10000       ,10   UNION ALL	--INR1
SELECT 4005 ,'12.5'    ,'2500'        ,12.5    ,2500        ,10   UNION ALL	--INR1
SELECT 4008 ,'5'       ,'1000'        ,5       ,1000        ,10   UNION ALL	--INR1
SELECT 4009 ,'25'      ,'5000'        ,25      ,5000        ,10   UNION ALL	--INR1
SELECT 4010 ,'12.5'    ,'5000'        ,12.5    ,5000        ,10   UNION ALL	--INR1
SELECT 4012 ,'25'      ,'5000'        ,25      ,5000        ,10   UNION ALL	--INR1
SELECT 4013 ,'4.5'     ,'900'         ,4.5     ,900         ,10   UNION ALL	--INR1
SELECT 4014 ,'12.5'    ,'2500'        ,12.5    ,2500        ,10   UNION ALL	--INR1
SELECT 4015 ,'5'       ,'1000'        ,5       ,1000        ,10   UNION ALL	--INR1
SELECT 4018 ,'12.5'    ,'2000'        ,12.5    ,2000        ,10   UNION ALL	--INR1
SELECT 4019 ,'10'      ,'2000'        ,10      ,2000        ,10   UNION ALL	--INR1
SELECT 4020 ,'5'       ,'1000'        ,5       ,1000        ,10   UNION ALL	--INR1
SELECT 4021 ,'10'      ,'2000'        ,10      ,2000        ,10   UNION ALL	--INR1
SELECT 4022 ,'50'      ,'10000'       ,50      ,10000       ,10   UNION ALL	--INR1
SELECT 4023 ,'12.5'    ,'2500'        ,12.5    ,2500        ,10   UNION ALL	--INR1
SELECT 4024 ,'5'       ,'1000'        ,5       ,1000        ,10   UNION ALL	--INR1
SELECT 4025 ,'10'      ,'2000'        ,10      ,2000        ,10   UNION ALL	--INR1
SELECT 4026 ,'10'      ,'2000'        ,10      ,2000        ,10   UNION ALL	--INR1
SELECT 4028 ,'5'       ,'1000'        ,5       ,1000        ,10   UNION ALL	--INR1
SELECT 4029 ,'25'      ,'5000'        ,25      ,5000        ,10   UNION ALL	--INR1
SELECT 4031 ,'7.5'     ,'1500'        ,7.5     ,1500        ,10   UNION ALL	--INR1
SELECT 4032 ,'15'      ,'3000'        ,15      ,3000        ,10   UNION ALL	--INR1
SELECT 4033 ,'4.5'     ,'900'         ,4.5     ,900         ,10   UNION ALL	--INR1
SELECT 4034 ,'12.5'    ,'2500'        ,12.5    ,2500        ,10   UNION ALL	--INR1
SELECT 4035 ,'4.5'     ,'900'         ,4.5     ,900         ,10   UNION ALL	--INR1
SELECT 4036 ,'4.5'     ,'2700'        ,4.5     ,2700        ,10   UNION ALL	--INR1
SELECT 4037 ,'4.5'     ,'900'         ,4.5     ,900         ,10   UNION ALL	--INR1
SELECT 4038 ,'12.5'    ,'2500'        ,12.5    ,2500        ,10   UNION ALL	--INR1
SELECT 4039 ,'0.5'     ,'300'         ,0.5     ,300         ,10   UNION ALL	--INR1
SELECT 4040 ,'4.5'     ,'900'         ,4.5     ,900         ,10   UNION ALL	--INR1
SELECT 4041 ,'2.5'     ,'500'         ,2.5     ,500         ,10   UNION ALL	--INR1
SELECT 4042 ,'0.5'     ,'100'         ,0.5     ,100         ,10   UNION ALL	--INR1
SELECT 4043 ,'0.5'     ,'100'         ,0.5     ,100         ,10   UNION ALL	--INR1
SELECT 4044 ,'20'      ,'4000'        ,20      ,4000        ,10   UNION ALL	--INR1
SELECT 4045 ,'12.5'    ,'2500'        ,12.5    ,2500        ,10   UNION ALL	--INR1
SELECT 4046 ,'13.5'    ,'2700'        ,13.5    ,2700        ,10   UNION ALL	--INR1
SELECT 4047 ,'7.5'     ,'1500'        ,7.5     ,1500        ,10   UNION ALL	--INR1
SELECT 4048 ,'7.5'     ,'1500'        ,7.5     ,1500        ,10   UNION ALL	--INR1
SELECT 4049 ,'20'      ,'4000'        ,20      ,4000        ,10   UNION ALL	--INR1
SELECT 4050 ,'2.5'     ,'500'         ,2.5     ,500         ,10   UNION ALL	--INR1
SELECT 4051 ,'10'      ,'200'         ,10      ,200         ,10   UNION ALL	--INR1
SELECT 4052 ,'10'      ,'200'         ,10      ,200         ,10   UNION ALL	--INR1
SELECT 4053 ,'5'       ,'200'         ,5       ,200         ,10   UNION ALL	--INR1
SELECT 4054 ,'5'       ,'200'         ,5       ,200         ,10   UNION ALL	--INR1
SELECT 4055 ,'5'       ,'200'         ,5       ,200         ,10   UNION ALL	--INR1
SELECT 4056 ,'5'       ,'200'         ,5       ,200         ,10   UNION ALL	--INR1
SELECT 4057 ,'5'       ,'200'         ,5       ,200         ,10   UNION ALL	--INR1
SELECT 4058 ,'5'       ,'200'         ,5       ,200         ,10   UNION ALL	--INR1
SELECT 4061 ,'10'      ,'1000'        ,10      ,1000        ,10   UNION ALL	--INR1
SELECT 4062 ,'5'       ,'200'         ,5       ,200         ,10   UNION ALL	--INR1
SELECT 4063 ,'5'       ,'200'         ,5       ,200         ,10   UNION ALL	--INR1
SELECT 4066 ,'10'      ,'5000'        ,10      ,5000        ,10   UNION ALL	--INR1
SELECT 4073 ,'10'      ,'200'         ,10      ,200         ,10   UNION ALL	--INR1
SELECT 4076 ,'5'       ,'200'         ,5       ,200         ,10   UNION ALL	--INR1
SELECT 4077 ,'10'      ,'400'         ,10      ,400         ,10   UNION ALL	--INR1
SELECT 4078 ,'5'       ,'200'         ,5       ,200         ,10   UNION ALL	--INR1
SELECT 4079 ,'5'       ,'250'         ,5       ,250         ,10   UNION ALL	--INR1
SELECT 4080 ,'10'      ,'5000'        ,10      ,5000        ,10   UNION ALL	--INR1
SELECT 4081 ,'15'      ,'3000'        ,15      ,3000        ,10   UNION ALL	--INR1
SELECT 4082 ,'5'       ,'1000'        ,5       ,1000        ,10   UNION ALL	--INR1
SELECT 4083 ,'25'      ,'5000'        ,25      ,5000        ,10   UNION ALL	--INR1
SELECT 4084 ,'20'      ,'4000'        ,20      ,4000        ,10   UNION ALL	--INR1
SELECT 4085 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10   UNION ALL	--INR1
SELECT 4086 ,'12.5'    ,'2500'        ,12.5    ,2500        ,10   UNION ALL	--INR1
SELECT 4087 ,'25'      ,'5000'        ,25      ,5000        ,10   UNION ALL	--INR1
SELECT 4088 ,'5'       ,'200'         ,5       ,200         ,10   UNION ALL	--INR1
SELECT 4089 ,'5'       ,'200'         ,5       ,200         ,10   UNION ALL	--INR1
SELECT 4090 ,'5'       ,'2000'        ,5       ,2000        ,10   UNION ALL	--INR1
SELECT 4091 ,'10'      ,'200'         ,10      ,200         ,10   UNION ALL	--INR1
SELECT 4092 ,'5'       ,'500'         ,5       ,500         ,10   UNION ALL	--INR1
SELECT 4093 ,'10'      ,'500'         ,10      ,500         ,10   UNION ALL	--INR1
SELECT 4094 ,'2.5'     ,'500'         ,2.5     ,500         ,10   UNION ALL	--INR1
SELECT 4095 ,'25'      ,'5000'        ,25      ,5000        ,10   UNION ALL	--INR1
SELECT 4096 ,'2.5'     ,'5000'        ,2.5     ,5000        ,10				--INR1

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
WHERE s.GameTypeID = 4001)

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