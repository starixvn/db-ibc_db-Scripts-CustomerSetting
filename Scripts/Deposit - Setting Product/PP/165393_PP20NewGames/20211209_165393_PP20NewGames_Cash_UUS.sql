/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20211210
	Created: Winfred 
	Task: #165393 - Pragmatic - Integrate 20 new games for Deposit UUS [Redmine:165393]
	DB: DBCUST/CUSTDB
*/

CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
									,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
									,ExchangeId int)
									
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--UUS
SELECT 4186 ,'0.2'         ,'200'            ,0.2         ,200            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4203 ,'0.2'         ,'200'            ,0.2         ,200            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4208 ,'0.2'         ,'300'            ,0.2         ,300            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4215 ,'0.2'         ,'400'            ,0.2         ,400            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4220 ,'0.1'         ,'400'            ,0.1         ,400            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4221 ,'0.2'         ,'800'            ,0.2         ,800            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4236 ,'0.2'         ,'300'            ,0.2         ,300            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4239 ,'0.1'         ,'100'            ,0.1         ,100            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4242 ,'0.2'         ,'200'            ,0.2         ,200            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4244 ,'0.2'         ,'200'            ,0.2         ,200            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4248 ,'0.2'         ,'400'            ,0.2         ,400            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4253 ,'0.2'         ,'300'            ,0.2         ,300            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4255 ,'0.2'         ,'200'            ,0.2         ,200            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4267 ,'0.2'         ,'800'            ,0.2         ,800            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4268 ,'0.2'         ,'800'            ,0.2         ,800            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4276 ,'0.25'        ,'250'            ,0.25        ,250            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4278 ,'0.2'         ,'800'            ,0.2         ,800            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4280 ,'0.2'         ,'800'            ,0.2         ,800            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4282 ,'0.2'         ,'800'            ,0.2         ,800            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4283 ,'0.1'         ,'400'            ,0.1         ,400            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4286 ,'0.2'         ,'800'            ,0.2         ,800            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4289 ,'0.2'         ,'800'            ,0.2         ,800            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4292 ,'0.2'         ,'800'            ,0.2         ,800            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4293 ,'0.2'         ,'200'            ,0.2         ,200            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4294 ,'0.4'         ,'600'            ,0.4         ,600            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4295 ,'0.2'         ,'200'            ,0.2         ,200            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4296 ,'0.2'         ,'800'            ,0.2         ,800            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6701 ,'0.2'         ,'200'            ,0.2         ,200            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6702 ,'0.2'         ,'800'            ,0.2         ,800            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6703 ,'0.2'         ,'300'            ,0.2         ,300            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6704 ,'0.2'         ,'800'            ,0.2         ,800            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6705 ,'0.25'        ,'1000'           ,0.25        ,1000           ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6706 ,'0.2'         ,'800'            ,0.2         ,800            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6707 ,'0.25'        ,'1000'           ,0.25        ,1000           ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6708 ,'0.2'         ,'800'            ,0.2         ,800            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6709 ,'0.1'         ,'400'            ,0.1         ,400            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6710 ,'0.2'         ,'200'            ,0.2         ,200            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6711 ,'0.2'         ,'800'            ,0.2         ,800            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6712 ,'0.2'         ,'800'            ,0.2         ,800            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6713 ,'0.38'        ,'380'            ,0.38        ,380            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6714 ,'0.2'         ,'800'            ,0.2         ,800            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6715 ,'0.2'         ,'800'            ,0.2         ,800            ,20   UNION ALL	--UUS	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4186 ,'0.2'         ,'200'            ,0.2         ,200            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4203 ,'0.2'         ,'200'            ,0.2         ,200            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4208 ,'0.2'         ,'300'            ,0.2         ,300            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4215 ,'0.2'         ,'400'            ,0.2         ,400            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4220 ,'0.1'         ,'400'            ,0.1         ,400            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4221 ,'0.2'         ,'800'            ,0.2         ,800            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4236 ,'0.2'         ,'300'            ,0.2         ,300            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4239 ,'0.1'         ,'100'            ,0.1         ,100            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4242 ,'0.2'         ,'200'            ,0.2         ,200            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4244 ,'0.2'         ,'200'            ,0.2         ,200            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4248 ,'0.2'         ,'400'            ,0.2         ,400            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4253 ,'0.2'         ,'300'            ,0.2         ,300            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4255 ,'0.2'         ,'200'            ,0.2         ,200            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4267 ,'0.2'         ,'800'            ,0.2         ,800            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4268 ,'0.2'         ,'800'            ,0.2         ,800            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4276 ,'0.25'        ,'250'            ,0.25        ,250            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4278 ,'0.2'         ,'800'            ,0.2         ,800            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4280 ,'0.2'         ,'800'            ,0.2         ,800            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4282 ,'0.2'         ,'800'            ,0.2         ,800            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4283 ,'0.1'         ,'400'            ,0.1         ,400            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4286 ,'0.2'         ,'800'            ,0.2         ,800            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4289 ,'0.2'         ,'800'            ,0.2         ,800            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4292 ,'0.2'         ,'800'            ,0.2         ,800            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4293 ,'0.2'         ,'200'            ,0.2         ,200            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4294 ,'0.4'         ,'600'            ,0.4         ,600            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4295 ,'0.2'         ,'200'            ,0.2         ,200            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4296 ,'0.2'         ,'800'            ,0.2         ,800            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6701 ,'0.2'         ,'200'            ,0.2         ,200            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6702 ,'0.2'         ,'800'            ,0.2         ,800            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6703 ,'0.2'         ,'300'            ,0.2         ,300            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6704 ,'0.2'         ,'800'            ,0.2         ,800            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6705 ,'0.25'        ,'1000'           ,0.25        ,1000           ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6706 ,'0.2'         ,'800'            ,0.2         ,800            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6707 ,'0.25'        ,'1000'           ,0.25        ,1000           ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6708 ,'0.2'         ,'800'            ,0.2         ,800            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6709 ,'0.1'         ,'400'            ,0.1         ,400            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6710 ,'0.2'         ,'200'            ,0.2         ,200            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6711 ,'0.2'         ,'800'            ,0.2         ,800            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6712 ,'0.2'         ,'800'            ,0.2         ,800            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6713 ,'0.38'        ,'380'            ,0.38        ,380            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6714 ,'0.2'         ,'800'            ,0.2         ,800            ,72   UNION ALL	--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 6715 ,'0.2'         ,'800'            ,0.2         ,800            ,72				--YNG	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999


;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  WHERE t.ExchangeId = s.ExchangeId) t
WHERE s.GameTypeID = 4101)

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

DROP TABLE #StakeLevel_Temp