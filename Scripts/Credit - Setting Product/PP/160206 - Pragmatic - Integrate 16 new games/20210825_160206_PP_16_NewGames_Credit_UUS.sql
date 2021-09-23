/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20210825
	Created: Winfred 
	Task: #160206 - Pragmatic - Integrate 16 new games for Credit UUS [Redmine:160206]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(6))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
SELECT 4266 ,'0.4'  ,'100'     ,0.4  ,100     ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK
SELECT 4267 ,'0.4'  ,'50'      ,0.4  ,50      ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK
SELECT 4268 ,'0.4'  ,'50'      ,0.4  ,50      ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK
SELECT 4269 ,'0.4'  ,'50'      ,0.4  ,50      ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK
SELECT 4270 ,'0.5'  ,'50'      ,0.5  ,50      ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK
SELECT 4271 ,'0.4'  ,'40'      ,0.4  ,40      ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK
SELECT 4272 ,'0.5'  ,'25'      ,0.5  ,25      ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK
SELECT 4273 ,'0.4'  ,'50'      ,0.4  ,50      ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK
SELECT 4274 ,'0.4'  ,'12'      ,0.4  ,12      ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK
SELECT 4275 ,'0.5'  ,'10'      ,0.5  ,10      ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK
SELECT 4276 ,'0.5'  ,'25'      ,0.5  ,25      ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK
SELECT 4277 ,'0.5'  ,'25'      ,0.5  ,25      ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK
SELECT 4278 ,'0.4'  ,'50'      ,0.4  ,50      ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK
SELECT 4279 ,'0.4'  ,'50'      ,0.4  ,50      ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK
SELECT 4280 ,'0.4'  ,'50'      ,0.4  ,50      ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK
SELECT 4281 ,'0.4'  ,'20'      ,0.4  ,20      ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK
--YNG
SELECT 4266 ,'0.4'  ,'100'     ,0.4  ,100     ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK
SELECT 4267 ,'0.4'  ,'50'      ,0.4  ,50      ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK
SELECT 4268 ,'0.4'  ,'50'      ,0.4  ,50      ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK
SELECT 4269 ,'0.4'  ,'50'      ,0.4  ,50      ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK
SELECT 4270 ,'0.5'  ,'50'      ,0.5  ,50      ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK
SELECT 4271 ,'0.4'  ,'40'      ,0.4  ,40      ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK
SELECT 4272 ,'0.5'  ,'25'      ,0.5  ,25      ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK
SELECT 4273 ,'0.4'  ,'50'      ,0.4  ,50      ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK
SELECT 4274 ,'0.4'  ,'12'      ,0.4  ,12      ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK
SELECT 4275 ,'0.5'  ,'10'      ,0.5  ,10      ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK
SELECT 4276 ,'0.5'  ,'25'      ,0.5  ,25      ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK
SELECT 4277 ,'0.5'  ,'25'      ,0.5  ,25      ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK
SELECT 4278 ,'0.4'  ,'50'      ,0.4  ,50      ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK
SELECT 4279 ,'0.4'  ,'50'      ,0.4  ,50      ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK
SELECT 4280 ,'0.4'  ,'50'      ,0.4  ,50      ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK
SELECT 4281 ,'0.4'  ,'20'      ,0.4  ,20      ,72				--YNG	--USD , YEN , UT , $US , YNG , MMK

	
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