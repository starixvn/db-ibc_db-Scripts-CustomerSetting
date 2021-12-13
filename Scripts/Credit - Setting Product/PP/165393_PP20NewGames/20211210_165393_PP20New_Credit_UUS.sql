/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20211210
	Created: Winfred 
	Task: #165393 - Pragmatic - Integrate 20 new games for Credit UUS [Redmine:165393]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(6))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================

--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4186 ,'0.2'     ,'1000'        ,0.2     ,1000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4203 ,'0.2'     ,'1000'        ,0.2     ,1000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4208 ,'0.2'     ,'2000'        ,0.2     ,2000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4215 ,'0.2'     ,'2000'        ,0.2     ,2000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4220 ,'0.1'     ,'1000'        ,0.1     ,1000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4221 ,'0.2'     ,'2000'        ,0.2     ,2000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4236 ,'0.2'     ,'2000'        ,0.2     ,2000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4239 ,'0.1'     ,'500'         ,0.1     ,500         ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4242 ,'0.2'     ,'500'         ,0.2     ,500         ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4244 ,'0.2'     ,'800'         ,0.2     ,800         ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4248 ,'0.2'     ,'2000'        ,0.2     ,2000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4253 ,'0.2'     ,'1000'        ,0.2     ,1000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4255 ,'0.2'     ,'1000'        ,0.2     ,1000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4267 ,'0.2'     ,'2000'        ,0.2     ,2000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4268 ,'0.2'     ,'2000'        ,0.2     ,2000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4276 ,'0.25'    ,'2000'        ,0.25    ,2000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4278 ,'0.2'     ,'2000'        ,0.2     ,2000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4280 ,'0.2'     ,'2000'        ,0.2     ,2000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4282 ,'0.2'     ,'2000'        ,0.2     ,2000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4283 ,'0.1'     ,'1000'        ,0.1     ,1000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4286 ,'0.2'     ,'2000'        ,0.2     ,2000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4289 ,'0.2'     ,'2000'        ,0.2     ,2000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4292 ,'0.2'     ,'2000'        ,0.2     ,2000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4293 ,'0.2'     ,'1200'        ,0.2     ,1200        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4294 ,'0.4'     ,'2000'        ,0.4     ,2000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4295 ,'0.2'     ,'1000'        ,0.2     ,1000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4296 ,'0.2'     ,'2000'        ,0.2     ,2000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6701 ,'0.2'     ,'1000'        ,0.2     ,1000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6702 ,'0.2'     ,'2000'        ,0.2     ,2000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6703 ,'0.2'     ,'2000'        ,0.2     ,2000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6704 ,'0.2'     ,'2000'        ,0.2     ,2000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6705 ,'0.25'    ,'2000'        ,0.25    ,2000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6706 ,'0.2'     ,'2000'        ,0.2     ,2000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6707 ,'0.25'    ,'2000'        ,0.25    ,2000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6708 ,'0.2'     ,'2000'        ,0.2     ,2000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6709 ,'0.1'     ,'1000'        ,0.1     ,1000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6710 ,'0.2'     ,'1000'        ,0.2     ,1000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6711 ,'0.2'     ,'2000'        ,0.2     ,2000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6712 ,'0.2'     ,'2000'        ,0.2     ,2000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6713 ,'0.38'    ,'1900'        ,0.38    ,1900        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6714 ,'0.2'     ,'2000'        ,0.2     ,2000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6715 ,'0.2'     ,'2000'        ,0.2     ,2000        ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
--YNG
SELECT 4186 ,'0.2'     ,'1000'        ,0.2     ,1000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4203 ,'0.2'     ,'1000'        ,0.2     ,1000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4208 ,'0.2'     ,'2000'        ,0.2     ,2000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4215 ,'0.2'     ,'2000'        ,0.2     ,2000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4220 ,'0.1'     ,'1000'        ,0.1     ,1000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4221 ,'0.2'     ,'2000'        ,0.2     ,2000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4236 ,'0.2'     ,'2000'        ,0.2     ,2000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4239 ,'0.1'     ,'500'         ,0.1     ,500         ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4242 ,'0.2'     ,'500'         ,0.2     ,500         ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4244 ,'0.2'     ,'800'         ,0.2     ,800         ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4248 ,'0.2'     ,'2000'        ,0.2     ,2000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4253 ,'0.2'     ,'1000'        ,0.2     ,1000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4255 ,'0.2'     ,'1000'        ,0.2     ,1000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4267 ,'0.2'     ,'2000'        ,0.2     ,2000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4268 ,'0.2'     ,'2000'        ,0.2     ,2000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4276 ,'0.25'    ,'2000'        ,0.25    ,2000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4278 ,'0.2'     ,'2000'        ,0.2     ,2000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4280 ,'0.2'     ,'2000'        ,0.2     ,2000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4282 ,'0.2'     ,'2000'        ,0.2     ,2000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4283 ,'0.1'     ,'1000'        ,0.1     ,1000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4286 ,'0.2'     ,'2000'        ,0.2     ,2000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4289 ,'0.2'     ,'2000'        ,0.2     ,2000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4292 ,'0.2'     ,'2000'        ,0.2     ,2000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4293 ,'0.2'     ,'1200'        ,0.2     ,1200        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4294 ,'0.4'     ,'2000'        ,0.4     ,2000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4295 ,'0.2'     ,'1000'        ,0.2     ,1000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4296 ,'0.2'     ,'2000'        ,0.2     ,2000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6701 ,'0.2'     ,'1000'        ,0.2     ,1000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6702 ,'0.2'     ,'2000'        ,0.2     ,2000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6703 ,'0.2'     ,'2000'        ,0.2     ,2000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6704 ,'0.2'     ,'2000'        ,0.2     ,2000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6705 ,'0.25'    ,'2000'        ,0.25    ,2000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6706 ,'0.2'     ,'2000'        ,0.2     ,2000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6707 ,'0.25'    ,'2000'        ,0.25    ,2000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6708 ,'0.2'     ,'2000'        ,0.2     ,2000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6709 ,'0.1'     ,'1000'        ,0.1     ,1000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6710 ,'0.2'     ,'1000'        ,0.2     ,1000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6711 ,'0.2'     ,'2000'        ,0.2     ,2000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6712 ,'0.2'     ,'2000'        ,0.2     ,2000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6713 ,'0.38'    ,'1900'        ,0.38    ,1900        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6714 ,'0.2'     ,'2000'        ,0.2     ,2000        ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6715 ,'0.2'     ,'2000'        ,0.2     ,2000        ,72				--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO

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