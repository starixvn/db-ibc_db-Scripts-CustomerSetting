/*
	Date: 20201209
	Created: Winfred 
	Task: #146800 - Pragmatic - Integrate 14 new games Dec 2020 for Credit UUS [Redmine:146800]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(6))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG	$US

SELECT 4244 ,'0.2'  ,'4'       ,0.2  ,4       ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4245 ,'0.2'  ,'40'      ,0.2  ,40      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4246 ,'0.25' ,'50'      ,0.25 ,50      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4247 ,'0.25' ,'25'      ,0.25 ,25      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4248 ,'0.2'  ,'12'      ,0.2  ,12      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4249 ,'0.1'  ,'10'      ,0.1  ,10      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4250 ,'0.25' ,'10'      ,0.25 ,10      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4251 ,'0.2'  ,'10'      ,0.2  ,10      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4252 ,'0.2'  ,'10'      ,0.2  ,10      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4253 ,'0.2'  ,'12'      ,0.2  ,12      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4254 ,'0.1'  ,'32'      ,0.1  ,32      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4256 ,'0.2'  ,'26'      ,0.2  ,26      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4257 ,'0.1'  ,'200'     ,0.1  ,200     ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG

SELECT 4244 ,'0.2'  ,'4'       ,0.2  ,4       ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4245 ,'0.2'  ,'40'      ,0.2  ,40      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4246 ,'0.25' ,'50'      ,0.25 ,50      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4247 ,'0.25' ,'25'      ,0.25 ,25      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4248 ,'0.2'  ,'12'      ,0.2  ,12      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4249 ,'0.1'  ,'10'      ,0.1  ,10      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4250 ,'0.25' ,'10'      ,0.25 ,10      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4251 ,'0.2'  ,'10'      ,0.2  ,10      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4252 ,'0.2'  ,'10'      ,0.2  ,10      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4253 ,'0.2'  ,'12'      ,0.2  ,12      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4254 ,'0.1'  ,'32'      ,0.1  ,32      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4256 ,'0.2'  ,'26'      ,0.2  ,26      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4257 ,'0.1'  ,'200'     ,0.1  ,200     ,72				--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG

	
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