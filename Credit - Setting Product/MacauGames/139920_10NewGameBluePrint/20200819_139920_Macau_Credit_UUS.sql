/*
	Date: 20200819
	Created: Winfred 
	Task: #139920 - Macau Game - 10 game Blue Print - Credit  -UUS	[redmine : 139850]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(1))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--UUS
SELECT 4057 ,'0.1'  ,'15'      ,0.1  ,15      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4058 ,'0.1'  ,'4'       ,0.1  ,4       ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4059 ,'0.1'  ,'10'      ,0.1  ,10      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4061 ,'0.2'  ,'10'      ,0.2  ,10      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4063 ,'0.1'  ,'10'      ,0.1  ,10      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4073 ,'0.2'  ,'4'       ,0.2  ,4       ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4077 ,'0.2'  ,'10'      ,0.2  ,10      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4078 ,'0.1'  ,'4'       ,0.1  ,4       ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4079 ,'0.5'  ,'10'      ,0.5  ,10      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4080 ,'0.2'  ,'10'      ,0.2  ,10      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD, UUS, YNG					
-- YNG
SELECT 4057 ,'0.1'  ,'15'      ,0.1  ,15      ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4058 ,'0.1'  ,'4'       ,0.1  ,4       ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4059 ,'0.1'  ,'10'      ,0.1  ,10      ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4061 ,'0.2'  ,'10'      ,0.2  ,10      ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4063 ,'0.1'  ,'10'      ,0.1  ,10      ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4073 ,'0.2'  ,'4'       ,0.2  ,4       ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4077 ,'0.2'  ,'10'      ,0.2  ,10      ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4078 ,'0.1'  ,'4'       ,0.1  ,4       ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4079 ,'0.5'  ,'10'      ,0.5  ,10      ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4080 ,'0.2'  ,'10'      ,0.2  ,10      ,72				--YNG	--Yen, UT, $US, US$, USD, UUS, YNG		

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