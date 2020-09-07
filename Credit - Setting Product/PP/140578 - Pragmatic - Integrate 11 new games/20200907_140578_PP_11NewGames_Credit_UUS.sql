/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200805
	Task:  Pragmatic - Integrate 11 new games for Credit - UUS RedmineID:#140578
	DB: DBCust/CustDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(6))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--UUS
SELECT 4232 ,'0.2'  ,'40'      ,0.2  ,40      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4233 ,'0.25' ,'50'      ,0.25 ,50      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4234 ,'0.2'  ,'20'      ,0.2  ,20      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4235 ,'0.25' ,'25'      ,0.25 ,25      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4236 ,'0.2'  ,'12'      ,0.2  ,12      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4237 ,'0.09' ,'9'       ,0.09 ,9       ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4238 ,'0.2'  ,'40'      ,0.2  ,40      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4239 ,'0.1'  ,'5'       ,0.1  ,5       ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4240 ,'0.05' ,'50'      ,0.05 ,50      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4241 ,'0.1'  ,'100'     ,0.1  ,100     ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4242 ,'0.2'  ,'4'       ,0.2  ,4       ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
--YNG
SELECT 4232 ,'0.2'  ,'40'      ,0.2  ,40      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4233 ,'0.25' ,'50'      ,0.25 ,50      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4234 ,'0.2'  ,'20'      ,0.2  ,20      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4235 ,'0.25' ,'25'      ,0.25 ,25      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4236 ,'0.2'  ,'12'      ,0.2  ,12      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4237 ,'0.09' ,'9'       ,0.09 ,9       ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4238 ,'0.2'  ,'40'      ,0.2  ,40      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4239 ,'0.1'  ,'5'       ,0.1  ,5       ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4240 ,'0.05' ,'50'      ,0.05 ,50      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4241 ,'0.1'  ,'100'     ,0.1  ,100     ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4242 ,'0.2'  ,'4'       ,0.2  ,4       ,72				--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG

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