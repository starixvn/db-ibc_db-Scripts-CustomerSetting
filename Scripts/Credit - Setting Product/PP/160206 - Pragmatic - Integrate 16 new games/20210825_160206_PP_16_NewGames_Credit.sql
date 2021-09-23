/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20210825
	Created: Winfred 
	Task: #160206 - Pragmatic - Integrate 16 new games for Credit [Redmine:160206]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(6))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--GBP
SELECT 4266 ,'0.4'  ,'50'      ,0.4  ,50      ,12   UNION ALL	--GBP	--GBP
SELECT 4267 ,'0.4'  ,'20'      ,0.4  ,20      ,12   UNION ALL	--GBP	--GBP
SELECT 4268 ,'0.4'  ,'20'      ,0.4  ,20      ,12   UNION ALL	--GBP	--GBP
SELECT 4269 ,'0.4'  ,'20'      ,0.4  ,20      ,12   UNION ALL	--GBP	--GBP
SELECT 4270 ,'0.5'  ,'25'      ,0.5  ,25      ,12   UNION ALL	--GBP	--GBP
SELECT 4271 ,'0.4'  ,'20'      ,0.4  ,20      ,12   UNION ALL	--GBP	--GBP
SELECT 4272 ,'0.5'  ,'12.5'    ,0.5  ,12.5    ,12   UNION ALL	--GBP	--GBP
SELECT 4273 ,'0.4'  ,'20'      ,0.4  ,20      ,12   UNION ALL	--GBP	--GBP
SELECT 4274 ,'0.4'  ,'4'       ,0.4  ,4       ,12   UNION ALL	--GBP	--GBP
SELECT 4275 ,'0.5'  ,'5'       ,0.5  ,5       ,12   UNION ALL	--GBP	--GBP
SELECT 4276 ,'0.5'  ,'12.5'    ,0.5  ,12.5    ,12   UNION ALL	--GBP	--GBP
SELECT 4277 ,'0.5'  ,'12.5'    ,0.5  ,12.5    ,12   UNION ALL	--GBP	--GBP
SELECT 4278 ,'0.4'  ,'20'      ,0.4  ,20      ,12   UNION ALL	--GBP	--GBP
SELECT 4279 ,'0.4'  ,'20'      ,0.4  ,20      ,12   UNION ALL	--GBP	--GBP
SELECT 4280 ,'0.4'  ,'20'      ,0.4  ,20      ,12   UNION ALL	--GBP	--GBP
SELECT 4281 ,'0.4'  ,'10'      ,0.4  ,10      ,12   UNION ALL	--GBP	--GBP
--IDR,DDD,IDD,IN,IND
SELECT 4266 ,'4'    ,'1200'    ,4    ,1200    ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4267 ,'4'    ,'400'     ,4    ,400     ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4268 ,'4'    ,'400'     ,4    ,400     ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4269 ,'4'    ,'400'     ,4    ,400     ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4270 ,'5'    ,'500'     ,5    ,500     ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4271 ,'4'    ,'400'     ,4    ,400     ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4272 ,'5'    ,'250'     ,5    ,250     ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4273 ,'4'    ,'400'     ,4    ,400     ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4274 ,'4'    ,'120'     ,4    ,120     ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4275 ,'5'    ,'125'     ,5    ,125     ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4276 ,'5'    ,'250'     ,5    ,250     ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4277 ,'5'    ,'250'     ,5    ,250     ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4278 ,'4'    ,'400'     ,4    ,400     ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4279 ,'4'    ,'400'     ,4    ,400     ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4280 ,'4'    ,'400'     ,4    ,400     ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4281 ,'4'    ,'200'     ,4    ,200     ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4266 ,'4'    ,'1200'    ,4    ,1200    ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4267 ,'4'    ,'400'     ,4    ,400     ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4268 ,'4'    ,'400'     ,4    ,400     ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4269 ,'4'    ,'400'     ,4    ,400     ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4270 ,'5'    ,'500'     ,5    ,500     ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4271 ,'4'    ,'400'     ,4    ,400     ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4272 ,'5'    ,'250'     ,5    ,250     ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4273 ,'4'    ,'400'     ,4    ,400     ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4274 ,'4'    ,'120'     ,4    ,120     ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4275 ,'5'    ,'125'     ,5    ,125     ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4276 ,'5'    ,'250'     ,5    ,250     ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4277 ,'5'    ,'250'     ,5    ,250     ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4278 ,'4'    ,'400'     ,4    ,400     ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4279 ,'4'    ,'400'     ,4    ,400     ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4280 ,'4'    ,'400'     ,4    ,400     ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4281 ,'4'    ,'200'     ,4    ,200     ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4266 ,'4'    ,'1200'    ,4    ,1200    ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4267 ,'4'    ,'400'     ,4    ,400     ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4268 ,'4'    ,'400'     ,4    ,400     ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4269 ,'4'    ,'400'     ,4    ,400     ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4270 ,'5'    ,'500'     ,5    ,500     ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4271 ,'4'    ,'400'     ,4    ,400     ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4272 ,'5'    ,'250'     ,5    ,250     ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4273 ,'4'    ,'400'     ,4    ,400     ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4274 ,'4'    ,'120'     ,4    ,120     ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4275 ,'5'    ,'125'     ,5    ,125     ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4276 ,'5'    ,'250'     ,5    ,250     ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4277 ,'5'    ,'250'     ,5    ,250     ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4278 ,'4'    ,'400'     ,4    ,400     ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4279 ,'4'    ,'400'     ,4    ,400     ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4280 ,'4'    ,'400'     ,4    ,400     ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4281 ,'4'    ,'200'     ,4    ,200     ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4266 ,'4'    ,'1200'    ,4    ,1200    ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4267 ,'4'    ,'400'     ,4    ,400     ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4268 ,'4'    ,'400'     ,4    ,400     ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4269 ,'4'    ,'400'     ,4    ,400     ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4270 ,'5'    ,'500'     ,5    ,500     ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4271 ,'4'    ,'400'     ,4    ,400     ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4272 ,'5'    ,'250'     ,5    ,250     ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4273 ,'4'    ,'400'     ,4    ,400     ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4274 ,'4'    ,'120'     ,4    ,120     ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4275 ,'5'    ,'125'     ,5    ,125     ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4276 ,'5'    ,'250'     ,5    ,250     ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4277 ,'5'    ,'250'     ,5    ,250     ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4278 ,'4'    ,'400'     ,4    ,400     ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4279 ,'4'    ,'400'     ,4    ,400     ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4280 ,'4'    ,'400'     ,4    ,400     ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4281 ,'4'    ,'200'     ,4    ,200     ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4266 ,'4'    ,'1200'    ,4    ,1200    ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4267 ,'4'    ,'400'     ,4    ,400     ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4268 ,'4'    ,'400'     ,4    ,400     ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4269 ,'4'    ,'400'     ,4    ,400     ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4270 ,'5'    ,'500'     ,5    ,500     ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4271 ,'4'    ,'400'     ,4    ,400     ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4272 ,'5'    ,'250'     ,5    ,250     ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4273 ,'4'    ,'400'     ,4    ,400     ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4274 ,'4'    ,'120'     ,4    ,120     ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4275 ,'5'    ,'125'     ,5    ,125     ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4276 ,'5'    ,'250'     ,5    ,250     ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4277 ,'5'    ,'250'     ,5    ,250     ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4278 ,'4'    ,'400'     ,4    ,400     ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4279 ,'4'    ,'400'     ,4    ,400     ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4280 ,'4'    ,'400'     ,4    ,400     ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4281 ,'4'    ,'200'     ,4    ,200     ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
--INH
SELECT 4266 ,'10'   ,'2000'    ,10   ,2000    ,51   UNION ALL	--INH	--INH
SELECT 4267 ,'10'   ,'800'     ,10   ,800     ,51   UNION ALL	--INH	--INH
SELECT 4268 ,'10'   ,'800'     ,10   ,800     ,51   UNION ALL	--INH	--INH
SELECT 4269 ,'10'   ,'800'     ,10   ,800     ,51   UNION ALL	--INH	--INH
SELECT 4270 ,'12.5' ,'875'     ,12.5 ,875     ,51   UNION ALL	--INH	--INH
SELECT 4271 ,'10'   ,'800'     ,10   ,800     ,51   UNION ALL	--INH	--INH
SELECT 4272 ,'12.5' ,'375'     ,12.5 ,375     ,51   UNION ALL	--INH	--INH
SELECT 4273 ,'10'   ,'800'     ,10   ,800     ,51   UNION ALL	--INH	--INH
SELECT 4274 ,'10'   ,'200'     ,10   ,200     ,51   UNION ALL	--INH	--INH
SELECT 4275 ,'12.5' ,'200'     ,12.5 ,200     ,51   UNION ALL	--INH	--INH
SELECT 4276 ,'12.5' ,'375'     ,12.5 ,375     ,51   UNION ALL	--INH	--INH
SELECT 4277 ,'12.5' ,'375'     ,12.5 ,375     ,51   UNION ALL	--INH	--INH
SELECT 4278 ,'10'   ,'800'     ,10   ,800     ,51   UNION ALL	--INH	--INH
SELECT 4279 ,'10'   ,'800'     ,10   ,800     ,51   UNION ALL	--INH	--INH
SELECT 4280 ,'10'   ,'800'     ,10   ,800     ,51   UNION ALL	--INH	--INH
SELECT 4281 ,'10'   ,'400'     ,10   ,400     ,51   UNION ALL	--INH	--INH
--RM , HKK
SELECT 4266 ,'1'    ,'400'     ,1    ,400     ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4267 ,'1'    ,'200'     ,1    ,200     ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4268 ,'1'    ,'200'     ,1    ,200     ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4269 ,'1'    ,'200'     ,1    ,200     ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4270 ,'1.25' ,'200'     ,1.25 ,200     ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4271 ,'1'    ,'160'     ,1    ,160     ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4272 ,'1.25' ,'100'     ,1.25 ,100     ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4273 ,'1'    ,'200'     ,1    ,200     ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4274 ,'1'    ,'40'      ,1    ,40      ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4275 ,'1.25' ,'50'      ,1.25 ,50      ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4276 ,'1.25' ,'100'     ,1.25 ,100     ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4277 ,'1.25' ,'100'     ,1.25 ,100     ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4278 ,'1'    ,'200'     ,1    ,200     ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4279 ,'1'    ,'200'     ,1    ,200     ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4280 ,'1'    ,'200'     ,1    ,200     ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4281 ,'1'    ,'80'      ,1    ,80      ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4266 ,'1'    ,'400'     ,1    ,400     ,2    UNION ALL	--RM	--RM , HKK
SELECT 4267 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM , HKK
SELECT 4268 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM , HKK
SELECT 4269 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM , HKK
SELECT 4270 ,'1.25' ,'200'     ,1.25 ,200     ,2    UNION ALL	--RM	--RM , HKK
SELECT 4271 ,'1'    ,'160'     ,1    ,160     ,2    UNION ALL	--RM	--RM , HKK
SELECT 4272 ,'1.25' ,'100'     ,1.25 ,100     ,2    UNION ALL	--RM	--RM , HKK
SELECT 4273 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM , HKK
SELECT 4274 ,'1'    ,'40'      ,1    ,40      ,2    UNION ALL	--RM	--RM , HKK
SELECT 4275 ,'1.25' ,'50'      ,1.25 ,50      ,2    UNION ALL	--RM	--RM , HKK
SELECT 4276 ,'1.25' ,'100'     ,1.25 ,100     ,2    UNION ALL	--RM	--RM , HKK
SELECT 4277 ,'1.25' ,'100'     ,1.25 ,100     ,2    UNION ALL	--RM	--RM , HKK
SELECT 4278 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM , HKK
SELECT 4279 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM , HKK
SELECT 4280 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM , HKK
SELECT 4281 ,'1'    ,'80'      ,1    ,80      ,2    UNION ALL	--RM	--RM , HKK
--RMB , HK$
SELECT 4266 ,'2'    ,'600'     ,2    ,600     ,5    UNION ALL	--HK$	--RMB , HK$
SELECT 4267 ,'2'    ,'300'     ,2    ,300     ,5    UNION ALL	--HK$	--RMB , HK$
SELECT 4268 ,'2'    ,'300'     ,2    ,300     ,5    UNION ALL	--HK$	--RMB , HK$
SELECT 4269 ,'2'    ,'300'     ,2    ,300     ,5    UNION ALL	--HK$	--RMB , HK$
SELECT 4270 ,'2.5'  ,'250'     ,2.5  ,250     ,5    UNION ALL	--HK$	--RMB , HK$
SELECT 4271 ,'2'    ,'300'     ,2    ,300     ,5    UNION ALL	--HK$	--RMB , HK$
SELECT 4272 ,'2.5'  ,'150'     ,2.5  ,150     ,5    UNION ALL	--HK$	--RMB , HK$
SELECT 4273 ,'2'    ,'300'     ,2    ,300     ,5    UNION ALL	--HK$	--RMB , HK$
SELECT 4274 ,'2'    ,'80'      ,2    ,80      ,5    UNION ALL	--HK$	--RMB , HK$
SELECT 4275 ,'2.5'  ,'75'      ,2.5  ,75      ,5    UNION ALL	--HK$	--RMB , HK$
SELECT 4276 ,'2.5'  ,'150'     ,2.5  ,150     ,5    UNION ALL	--HK$	--RMB , HK$
SELECT 4277 ,'2.5'  ,'150'     ,2.5  ,150     ,5    UNION ALL	--HK$	--RMB , HK$
SELECT 4278 ,'2'    ,'300'     ,2    ,300     ,5    UNION ALL	--HK$	--RMB , HK$
SELECT 4279 ,'2'    ,'300'     ,2    ,300     ,5    UNION ALL	--HK$	--RMB , HK$
SELECT 4280 ,'2'    ,'300'     ,2    ,300     ,5    UNION ALL	--HK$	--RMB , HK$
SELECT 4281 ,'2'    ,'160'     ,2    ,160     ,5    UNION ALL	--HK$	--RMB , HK$
SELECT 4266 ,'2'    ,'600'     ,2    ,600     ,13   UNION ALL	--RMB	--RMB , HK$
SELECT 4267 ,'2'    ,'300'     ,2    ,300     ,13   UNION ALL	--RMB	--RMB , HK$
SELECT 4268 ,'2'    ,'300'     ,2    ,300     ,13   UNION ALL	--RMB	--RMB , HK$
SELECT 4269 ,'2'    ,'300'     ,2    ,300     ,13   UNION ALL	--RMB	--RMB , HK$
SELECT 4270 ,'2.5'  ,'250'     ,2.5  ,250     ,13   UNION ALL	--RMB	--RMB , HK$
SELECT 4271 ,'2'    ,'300'     ,2    ,300     ,13   UNION ALL	--RMB	--RMB , HK$
SELECT 4272 ,'2.5'  ,'150'     ,2.5  ,150     ,13   UNION ALL	--RMB	--RMB , HK$
SELECT 4273 ,'2'    ,'300'     ,2    ,300     ,13   UNION ALL	--RMB	--RMB , HK$
SELECT 4274 ,'2'    ,'80'      ,2    ,80      ,13   UNION ALL	--RMB	--RMB , HK$
SELECT 4275 ,'2.5'  ,'75'      ,2.5  ,75      ,13   UNION ALL	--RMB	--RMB , HK$
SELECT 4276 ,'2.5'  ,'150'     ,2.5  ,150     ,13   UNION ALL	--RMB	--RMB , HK$
SELECT 4277 ,'2.5'  ,'150'     ,2.5  ,150     ,13   UNION ALL	--RMB	--RMB , HK$
SELECT 4278 ,'2'    ,'300'     ,2    ,300     ,13   UNION ALL	--RMB	--RMB , HK$
SELECT 4279 ,'2'    ,'300'     ,2    ,300     ,13   UNION ALL	--RMB	--RMB , HK$
SELECT 4280 ,'2'    ,'300'     ,2    ,300     ,13   UNION ALL	--RMB	--RMB , HK$
SELECT 4281 ,'2'    ,'160'     ,2    ,160     ,13   UNION ALL	--RMB	--RMB , HK$

SELECT 4266 ,'2'    ,'600'     ,2    ,600     ,81   UNION ALL	--CY 	--RMB , HK$
SELECT 4267 ,'2'    ,'300'     ,2    ,300     ,81   UNION ALL	--CY 	--RMB , HK$
SELECT 4268 ,'2'    ,'300'     ,2    ,300     ,81   UNION ALL	--CY 	--RMB , HK$
SELECT 4269 ,'2'    ,'300'     ,2    ,300     ,81   UNION ALL	--CY 	--RMB , HK$
SELECT 4270 ,'2.5'  ,'250'     ,2.5  ,250     ,81   UNION ALL	--CY 	--RMB , HK$
SELECT 4271 ,'2'    ,'300'     ,2    ,300     ,81   UNION ALL	--CY 	--RMB , HK$
SELECT 4272 ,'2.5'  ,'150'     ,2.5  ,150     ,81   UNION ALL	--CY 	--RMB , HK$
SELECT 4273 ,'2'    ,'300'     ,2    ,300     ,81   UNION ALL	--CY 	--RMB , HK$
SELECT 4274 ,'2'    ,'80'      ,2    ,80      ,81   UNION ALL	--CY 	--RMB , HK$
SELECT 4275 ,'2.5'  ,'75'      ,2.5  ,75      ,81   UNION ALL	--CY 	--RMB , HK$
SELECT 4276 ,'2.5'  ,'150'     ,2.5  ,150     ,81   UNION ALL	--CY 	--RMB , HK$
SELECT 4277 ,'2.5'  ,'150'     ,2.5  ,150     ,81   UNION ALL	--CY 	--RMB , HK$
SELECT 4278 ,'2'    ,'300'     ,2    ,300     ,81   UNION ALL	--CY 	--RMB , HK$
SELECT 4279 ,'2'    ,'300'     ,2    ,300     ,81   UNION ALL	--CY 	--RMB , HK$
SELECT 4280 ,'2'    ,'300'     ,2    ,300     ,81   UNION ALL	--CY 	--RMB , HK$
SELECT 4281 ,'2'    ,'160'     ,2    ,160     ,81   UNION ALL	--CY 	--RMB , HK$
--THB , TB
SELECT 4266 ,'10'   ,'3000'    ,10   ,3000    ,43   UNION ALL	--THB	--THB , TB
SELECT 4267 ,'10'   ,'1000'    ,10   ,1000    ,43   UNION ALL	--THB	--THB , TB
SELECT 4268 ,'10'   ,'1000'    ,10   ,1000    ,43   UNION ALL	--THB	--THB , TB
SELECT 4269 ,'10'   ,'1000'    ,10   ,1000    ,43   UNION ALL	--THB	--THB , TB
SELECT 4270 ,'12.5' ,'1250'    ,12.5 ,1250    ,43   UNION ALL	--THB	--THB , TB
SELECT 4271 ,'10'   ,'1000'    ,10   ,1000    ,43   UNION ALL	--THB	--THB , TB
SELECT 4272 ,'12.5' ,'500'     ,12.5 ,500     ,43   UNION ALL	--THB	--THB , TB
SELECT 4273 ,'10'   ,'1000'    ,10   ,1000    ,43   UNION ALL	--THB	--THB , TB
SELECT 4274 ,'10'   ,'300'     ,10   ,300     ,43   UNION ALL	--THB	--THB , TB
SELECT 4275 ,'12.5' ,'250'     ,12.5 ,250     ,43   UNION ALL	--THB	--THB , TB
SELECT 4276 ,'12.5' ,'625'     ,12.5 ,625     ,43   UNION ALL	--THB	--THB , TB
SELECT 4277 ,'12.5' ,'500'     ,12.5 ,500     ,43   UNION ALL	--THB	--THB , TB
SELECT 4278 ,'10'   ,'1000'    ,10   ,1000    ,43   UNION ALL	--THB	--THB , TB
SELECT 4279 ,'10'   ,'1000'    ,10   ,1000    ,43   UNION ALL	--THB	--THB , TB
SELECT 4280 ,'10'   ,'1000'    ,10   ,1000    ,43   UNION ALL	--THB	--THB , TB
SELECT 4281 ,'10'   ,'600'     ,10   ,600     ,43   UNION ALL	--THB	--THB , TB
-- US$, USD , YEN , UT , $US , YNG , MMK
SELECT 4266 ,'0.4'  ,'100'     ,0.4  ,100     ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK
SELECT 4267 ,'0.4'  ,'50'      ,0.4  ,50      ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK
SELECT 4268 ,'0.4'  ,'50'      ,0.4  ,50      ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK
SELECT 4269 ,'0.4'  ,'50'      ,0.4  ,50      ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK
SELECT 4270 ,'0.5'  ,'50'      ,0.5  ,50      ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK
SELECT 4271 ,'0.4'  ,'40'      ,0.4  ,40      ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK
SELECT 4272 ,'0.5'  ,'25'      ,0.5  ,25      ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK
SELECT 4273 ,'0.4'  ,'50'      ,0.4  ,50      ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK
SELECT 4274 ,'0.4'  ,'12'      ,0.4  ,12      ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK
SELECT 4275 ,'0.5'  ,'10'      ,0.5  ,10      ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK
SELECT 4276 ,'0.5'  ,'25'      ,0.5  ,25      ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK
SELECT 4277 ,'0.5'  ,'25'      ,0.5  ,25      ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK
SELECT 4278 ,'0.4'  ,'50'      ,0.4  ,50      ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK
SELECT 4279 ,'0.4'  ,'50'      ,0.4  ,50      ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK
SELECT 4280 ,'0.4'  ,'50'      ,0.4  ,50      ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK
SELECT 4281 ,'0.4'  ,'20'      ,0.4  ,20      ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK

SELECT 4266 ,'0.4'  ,'100'     ,0.4  ,100     ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK
SELECT 4267 ,'0.4'  ,'50'      ,0.4  ,50      ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK
SELECT 4268 ,'0.4'  ,'50'      ,0.4  ,50      ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK
SELECT 4269 ,'0.4'  ,'50'      ,0.4  ,50      ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK
SELECT 4270 ,'0.5'  ,'50'      ,0.5  ,50      ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK
SELECT 4271 ,'0.4'  ,'40'      ,0.4  ,40      ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK
SELECT 4272 ,'0.5'  ,'25'      ,0.5  ,25      ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK
SELECT 4273 ,'0.4'  ,'50'      ,0.4  ,50      ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK
SELECT 4274 ,'0.4'  ,'12'      ,0.4  ,12      ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK
SELECT 4275 ,'0.5'  ,'10'      ,0.5  ,10      ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK
SELECT 4276 ,'0.5'  ,'25'      ,0.5  ,25      ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK
SELECT 4277 ,'0.5'  ,'25'      ,0.5  ,25      ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK
SELECT 4278 ,'0.4'  ,'50'      ,0.4  ,50      ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK
SELECT 4279 ,'0.4'  ,'50'      ,0.4  ,50      ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK
SELECT 4280 ,'0.4'  ,'50'      ,0.4  ,50      ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK
SELECT 4281 ,'0.4'  ,'20'      ,0.4  ,20      ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK
SELECT 4266 ,'0.4'  ,'100'     ,0.4  ,100     ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK
SELECT 4267 ,'0.4'  ,'50'      ,0.4  ,50      ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK
SELECT 4268 ,'0.4'  ,'50'      ,0.4  ,50      ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK
SELECT 4269 ,'0.4'  ,'50'      ,0.4  ,50      ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK
SELECT 4270 ,'0.5'  ,'50'      ,0.5  ,50      ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK
SELECT 4271 ,'0.4'  ,'40'      ,0.4  ,40      ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK
SELECT 4272 ,'0.5'  ,'25'      ,0.5  ,25      ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK
SELECT 4273 ,'0.4'  ,'50'      ,0.4  ,50      ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK
SELECT 4274 ,'0.4'  ,'12'      ,0.4  ,12      ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK
SELECT 4275 ,'0.5'  ,'10'      ,0.5  ,10      ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK
SELECT 4276 ,'0.5'  ,'25'      ,0.5  ,25      ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK
SELECT 4277 ,'0.5'  ,'25'      ,0.5  ,25      ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK
SELECT 4278 ,'0.4'  ,'50'      ,0.4  ,50      ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK
SELECT 4279 ,'0.4'  ,'50'      ,0.4  ,50      ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK
SELECT 4280 ,'0.4'  ,'50'      ,0.4  ,50      ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK
SELECT 4281 ,'0.4'  ,'20'      ,0.4  ,20      ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK
SELECT 4266 ,'0.4'  ,'100'     ,0.4  ,100     ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK
SELECT 4267 ,'0.4'  ,'50'      ,0.4  ,50      ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK
SELECT 4268 ,'0.4'  ,'50'      ,0.4  ,50      ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK
SELECT 4269 ,'0.4'  ,'50'      ,0.4  ,50      ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK
SELECT 4270 ,'0.5'  ,'50'      ,0.5  ,50      ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK
SELECT 4271 ,'0.4'  ,'40'      ,0.4  ,40      ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK
SELECT 4272 ,'0.5'  ,'25'      ,0.5  ,25      ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK
SELECT 4273 ,'0.4'  ,'50'      ,0.4  ,50      ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK
SELECT 4274 ,'0.4'  ,'12'      ,0.4  ,12      ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK
SELECT 4275 ,'0.5'  ,'10'      ,0.5  ,10      ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK
SELECT 4276 ,'0.5'  ,'25'      ,0.5  ,25      ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK
SELECT 4277 ,'0.5'  ,'25'      ,0.5  ,25      ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK
SELECT 4278 ,'0.4'  ,'50'      ,0.4  ,50      ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK
SELECT 4279 ,'0.4'  ,'50'      ,0.4  ,50      ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK
SELECT 4280 ,'0.4'  ,'50'      ,0.4  ,50      ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK
SELECT 4281 ,'0.4'  ,'20'      ,0.4  ,20      ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK
SELECT 4266 ,'0.4'  ,'100'     ,0.4  ,100     ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK
SELECT 4267 ,'0.4'  ,'50'      ,0.4  ,50      ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK
SELECT 4268 ,'0.4'  ,'50'      ,0.4  ,50      ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK
SELECT 4269 ,'0.4'  ,'50'      ,0.4  ,50      ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK
SELECT 4270 ,'0.5'  ,'50'      ,0.5  ,50      ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK
SELECT 4271 ,'0.4'  ,'40'      ,0.4  ,40      ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK
SELECT 4272 ,'0.5'  ,'25'      ,0.5  ,25      ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK
SELECT 4273 ,'0.4'  ,'50'      ,0.4  ,50      ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK
SELECT 4274 ,'0.4'  ,'12'      ,0.4  ,12      ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK
SELECT 4275 ,'0.5'  ,'10'      ,0.5  ,10      ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK
SELECT 4276 ,'0.5'  ,'25'      ,0.5  ,25      ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK
SELECT 4277 ,'0.5'  ,'25'      ,0.5  ,25      ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK
SELECT 4278 ,'0.4'  ,'50'      ,0.4  ,50      ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK
SELECT 4279 ,'0.4'  ,'50'      ,0.4  ,50      ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK
SELECT 4280 ,'0.4'  ,'50'      ,0.4  ,50      ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK
SELECT 4281 ,'0.4'  ,'20'      ,0.4  ,20      ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK
SELECT 4266 ,'0.4'  ,'100'     ,0.4  ,100     ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK
SELECT 4267 ,'0.4'  ,'50'      ,0.4  ,50      ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK
SELECT 4268 ,'0.4'  ,'50'      ,0.4  ,50      ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK
SELECT 4269 ,'0.4'  ,'50'      ,0.4  ,50      ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK
SELECT 4270 ,'0.5'  ,'50'      ,0.5  ,50      ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK
SELECT 4271 ,'0.4'  ,'40'      ,0.4  ,40      ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK
SELECT 4272 ,'0.5'  ,'25'      ,0.5  ,25      ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK
SELECT 4273 ,'0.4'  ,'50'      ,0.4  ,50      ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK
SELECT 4274 ,'0.4'  ,'12'      ,0.4  ,12      ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK
SELECT 4275 ,'0.5'  ,'10'      ,0.5  ,10      ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK
SELECT 4276 ,'0.5'  ,'25'      ,0.5  ,25      ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK
SELECT 4277 ,'0.5'  ,'25'      ,0.5  ,25      ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK
SELECT 4278 ,'0.4'  ,'50'      ,0.4  ,50      ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK
SELECT 4279 ,'0.4'  ,'50'      ,0.4  ,50      ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK
SELECT 4280 ,'0.4'  ,'50'      ,0.4  ,50      ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK
SELECT 4281 ,'0.4'  ,'20'      ,0.4  ,20      ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK
SELECT 4266 ,'0.4'  ,'100'     ,0.4  ,100     ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK
SELECT 4267 ,'0.4'  ,'50'      ,0.4  ,50      ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK
SELECT 4268 ,'0.4'  ,'50'      ,0.4  ,50      ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK
SELECT 4269 ,'0.4'  ,'50'      ,0.4  ,50      ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK
SELECT 4270 ,'0.5'  ,'50'      ,0.5  ,50      ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK
SELECT 4271 ,'0.4'  ,'40'      ,0.4  ,40      ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK
SELECT 4272 ,'0.5'  ,'25'      ,0.5  ,25      ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK
SELECT 4273 ,'0.4'  ,'50'      ,0.4  ,50      ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK
SELECT 4274 ,'0.4'  ,'12'      ,0.4  ,12      ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK
SELECT 4275 ,'0.5'  ,'10'      ,0.5  ,10      ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK
SELECT 4276 ,'0.5'  ,'25'      ,0.5  ,25      ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK
SELECT 4277 ,'0.5'  ,'25'      ,0.5  ,25      ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK
SELECT 4278 ,'0.4'  ,'50'      ,0.4  ,50      ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK
SELECT 4279 ,'0.4'  ,'50'      ,0.4  ,50      ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK
SELECT 4280 ,'0.4'  ,'50'      ,0.4  ,50      ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK
SELECT 4281 ,'0.4'  ,'20'      ,0.4  ,20      ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK
--WON , KRW
SELECT 4266 ,'400'  ,'100000'  ,400  ,100000  ,45   UNION ALL	--Won	--WON , KRW
SELECT 4267 ,'400'  ,'40000'   ,400  ,40000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4268 ,'400'  ,'40000'   ,400  ,40000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4269 ,'400'  ,'40000'   ,400  ,40000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4270 ,'500'  ,'50000'   ,500  ,50000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4271 ,'400'  ,'40000'   ,400  ,40000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4272 ,'500'  ,'20000'   ,500  ,20000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4273 ,'400'  ,'40000'   ,400  ,40000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4274 ,'400'  ,'12000'   ,400  ,12000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4275 ,'500'  ,'10000'   ,500  ,10000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4276 ,'500'  ,'20000'   ,500  ,20000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4277 ,'500'  ,'20000'   ,500  ,20000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4278 ,'400'  ,'40000'   ,400  ,40000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4279 ,'400'  ,'40000'   ,400  ,40000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4280 ,'400'  ,'40000'   ,400  ,40000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4281 ,'400'  ,'20000'   ,400  ,20000   ,45				--Won	--WON , KRW
	
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