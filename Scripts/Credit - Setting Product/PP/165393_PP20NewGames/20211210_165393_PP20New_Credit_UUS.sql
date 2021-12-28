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
SELECT 4186 ,'0.2'     ,'10'          ,0.2     ,10          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4203 ,'0.2'     ,'10'          ,0.2     ,10          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4208 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4215 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4220 ,'0.1'     ,'10'          ,0.1     ,10          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4221 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4236 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4239 ,'0.1'     ,'5'           ,0.1     ,5           ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4242 ,'0.2'     ,'5'           ,0.2     ,5           ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4244 ,'0.2'     ,'8'           ,0.2     ,8           ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4248 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4253 ,'0.2'     ,'10'          ,0.2     ,10          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4255 ,'0.2'     ,'10'          ,0.2     ,10          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4267 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4268 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4276 ,'0.25'    ,'20'          ,0.25    ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4278 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4280 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4282 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4283 ,'0.1'     ,'10'          ,0.1     ,10          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4286 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4289 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4292 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4293 ,'0.2'     ,'12'          ,0.2     ,12          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4294 ,'0.4'     ,'20'          ,0.4     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4295 ,'0.2'     ,'10'          ,0.2     ,10          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4296 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6701 ,'0.2'     ,'10'          ,0.2     ,10          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6702 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6703 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6704 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6705 ,'0.25'    ,'20'          ,0.25    ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6706 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6707 ,'0.25'    ,'20'          ,0.25    ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6708 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6709 ,'0.1'     ,'10'          ,0.1     ,10          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6710 ,'0.2'     ,'10'          ,0.2     ,10          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6711 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6712 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6713 ,'0.38'    ,'19'          ,0.38    ,19          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6714 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6715 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
--YNG                                                                              
SELECT 4186 ,'0.2'     ,'10'          ,0.2     ,10          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4203 ,'0.2'     ,'10'          ,0.2     ,10          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4208 ,'0.2'     ,'20'          ,0.2     ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4215 ,'0.2'     ,'20'          ,0.2     ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4220 ,'0.1'     ,'10'          ,0.1     ,10          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4221 ,'0.2'     ,'20'          ,0.2     ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4236 ,'0.2'     ,'20'          ,0.2     ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4239 ,'0.1'     ,'5'           ,0.1     ,5           ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4242 ,'0.2'     ,'5'           ,0.2     ,5           ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4244 ,'0.2'     ,'8'           ,0.2     ,8           ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4248 ,'0.2'     ,'20'          ,0.2     ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4253 ,'0.2'     ,'10'          ,0.2     ,10          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4255 ,'0.2'     ,'10'          ,0.2     ,10          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4267 ,'0.2'     ,'20'          ,0.2     ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4268 ,'0.2'     ,'20'          ,0.2     ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4276 ,'0.25'    ,'20'          ,0.25    ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4278 ,'0.2'     ,'20'          ,0.2     ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4280 ,'0.2'     ,'20'          ,0.2     ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4282 ,'0.2'     ,'20'          ,0.2     ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4283 ,'0.1'     ,'10'          ,0.1     ,10          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4286 ,'0.2'     ,'20'          ,0.2     ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4289 ,'0.2'     ,'20'          ,0.2     ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4292 ,'0.2'     ,'20'          ,0.2     ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4293 ,'0.2'     ,'12'          ,0.2     ,12          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4294 ,'0.4'     ,'20'          ,0.4     ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4295 ,'0.2'     ,'10'          ,0.2     ,10          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4296 ,'0.2'     ,'20'          ,0.2     ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6701 ,'0.2'     ,'10'          ,0.2     ,10          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6702 ,'0.2'     ,'20'          ,0.2     ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6703 ,'0.2'     ,'20'          ,0.2     ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6704 ,'0.2'     ,'20'          ,0.2     ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6705 ,'0.25'    ,'20'          ,0.25    ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6706 ,'0.2'     ,'20'          ,0.2     ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6707 ,'0.25'    ,'20'          ,0.25    ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6708 ,'0.2'     ,'20'          ,0.2     ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6709 ,'0.1'     ,'10'          ,0.1     ,10          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6710 ,'0.2'     ,'10'          ,0.2     ,10          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6711 ,'0.2'     ,'20'          ,0.2     ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6712 ,'0.2'     ,'20'          ,0.2     ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6713 ,'0.38'    ,'19'          ,0.38    ,19          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6714 ,'0.2'     ,'20'          ,0.2     ,20          ,72   UNION ALL	--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 6715 ,'0.2'     ,'20'          ,0.2     ,20          ,72				--YNG	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO

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