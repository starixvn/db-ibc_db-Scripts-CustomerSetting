/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 202111101
	Created: Winfred 
	Task: #163502 - Pragmatic - Integrate 10 new games for Credit UUS [Redmine:163502]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(6))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
SELECT 4282 ,'0.4'  ,'20'      ,0.4  ,20      ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4283 ,'0.4'  ,'20'      ,0.4  ,20      ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4284 ,'1.8'  ,'27'      ,1.8  ,27      ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4285 ,'1.2'  ,'60'      ,1.2  ,60      ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4286 ,'0.4'  ,'100'     ,0.4  ,100     ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4287 ,'0.4'  ,'30'      ,0.4  ,30      ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4288 ,'0.9'  ,'45'      ,0.9  ,45      ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4289 ,'0.4'  ,'50'      ,0.4  ,50      ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4290 ,'0.4'  ,'50'      ,0.4  ,50      ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4291 ,'0.4'  ,'30'      ,0.4  ,30      ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
--YNG
SELECT 4282 ,'0.4'  ,'20'      ,0.4  ,20      ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4283 ,'0.4'  ,'20'      ,0.4  ,20      ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4284 ,'1.8'  ,'27'      ,1.8  ,27      ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4285 ,'1.2'  ,'60'      ,1.2  ,60      ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4286 ,'0.4'  ,'100'     ,0.4  ,100     ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4287 ,'0.4'  ,'30'      ,0.4  ,30      ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4288 ,'0.9'  ,'45'      ,0.9  ,45      ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4289 ,'0.4'  ,'50'      ,0.4  ,50      ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4290 ,'0.4'  ,'50'      ,0.4  ,50      ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4291 ,'0.4'  ,'30'      ,0.4  ,30      ,72   			--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO

	
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