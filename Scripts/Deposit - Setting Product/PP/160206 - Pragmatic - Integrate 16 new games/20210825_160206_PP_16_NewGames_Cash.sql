/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20210825
	Created: Winfred 
	Task: #160206 - Pragmatic - Integrate 16 new games for Deposit [Redmine:160206]
	DB: DBCUST/CUSTDB
*/

CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
									,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
									,ExchangeId int)
									
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
SELECT 4266 ,'0.2'  ,'10'      ,0.2  ,10      ,12   UNION ALL	--GBP	--GBP
SELECT 4267 ,'0.2'  ,'5'       ,0.2  ,5       ,12   UNION ALL	--GBP	--GBP
SELECT 4268 ,'0.2'  ,'5'       ,0.2  ,5       ,12   UNION ALL	--GBP	--GBP
SELECT 4269 ,'0.2'  ,'5'       ,0.2  ,5       ,12   UNION ALL	--GBP	--GBP
SELECT 4270 ,'0.25' ,'5'       ,0.25 ,5       ,12   UNION ALL	--GBP	--GBP
SELECT 4271 ,'0.2'  ,'5'       ,0.2  ,5       ,12   UNION ALL	--GBP	--GBP
SELECT 4272 ,'0.25' ,'2.5'     ,0.25 ,2.5     ,12   UNION ALL	--GBP	--GBP
SELECT 4273 ,'0.2'  ,'5'       ,0.2  ,5       ,12   UNION ALL	--GBP	--GBP
SELECT 4274 ,'0.2'  ,'2'       ,0.2  ,2       ,12   UNION ALL	--GBP	--GBP
SELECT 4275 ,'0.1'  ,'1'       ,0.1  ,1       ,12   UNION ALL	--GBP	--GBP
SELECT 4276 ,'0.25' ,'2.5'     ,0.25 ,2.5     ,12   UNION ALL	--GBP	--GBP
SELECT 4277 ,'0.25' ,'2.5'     ,0.25 ,2.5     ,12   UNION ALL	--GBP	--GBP
SELECT 4278 ,'0.2'  ,'5'       ,0.2  ,5       ,12   UNION ALL	--GBP	--GBP
SELECT 4279 ,'0.2'  ,'5'       ,0.2  ,5       ,12   UNION ALL	--GBP	--GBP
SELECT 4280 ,'0.2'  ,'5'       ,0.2  ,5       ,12   UNION ALL	--GBP	--GBP
SELECT 4281 ,'0.2'  ,'2'       ,0.2  ,2       ,12   UNION ALL	--GBP	--GBP
--IN,IDR
SELECT 4266 ,'1'    ,'220'     ,1    ,220     ,15   UNION ALL	--IN	--IN,IDR
SELECT 4267 ,'1'    ,'100'     ,1    ,100     ,15   UNION ALL	--IN	--IN,IDR
SELECT 4268 ,'1'    ,'100'     ,1    ,100     ,15   UNION ALL	--IN	--IN,IDR
SELECT 4269 ,'1'    ,'100'     ,1    ,100     ,15   UNION ALL	--IN	--IN,IDR
SELECT 4270 ,'1.25' ,'100'     ,1.25 ,100     ,15   UNION ALL	--IN	--IN,IDR
SELECT 4271 ,'1'    ,'100'     ,1    ,100     ,15   UNION ALL	--IN	--IN,IDR
SELECT 4272 ,'1.25' ,'50'      ,1.25 ,50      ,15   UNION ALL	--IN	--IN,IDR
SELECT 4273 ,'1'    ,'100'     ,1    ,100     ,15   UNION ALL	--IN	--IN,IDR
SELECT 4274 ,'1'    ,'18'      ,1    ,18      ,15   UNION ALL	--IN	--IN,IDR
SELECT 4275 ,'0.5'  ,'20'      ,0.5  ,20      ,15   UNION ALL	--IN	--IN,IDR
SELECT 4276 ,'1.25' ,'50'      ,1.25 ,50      ,15   UNION ALL	--IN	--IN,IDR
SELECT 4277 ,'1.25' ,'50'      ,1.25 ,50      ,15   UNION ALL	--IN	--IN,IDR
SELECT 4278 ,'1'    ,'100'     ,1    ,100     ,15   UNION ALL	--IN	--IN,IDR
SELECT 4279 ,'1'    ,'100'     ,1    ,100     ,15   UNION ALL	--IN	--IN,IDR
SELECT 4280 ,'1'    ,'100'     ,1    ,100     ,15   UNION ALL	--IN	--IN,IDR
SELECT 4281 ,'1'    ,'40'      ,1    ,40      ,15   UNION ALL	--IN	--IN,IDR
--INH,VND
SELECT 4266 ,'2'    ,'360'     ,2    ,360     ,51   UNION ALL	--INH	--INH,VND
SELECT 4267 ,'2'    ,'160'     ,2    ,160     ,51   UNION ALL	--INH	--INH,VND
SELECT 4268 ,'2'    ,'160'     ,2    ,160     ,51   UNION ALL	--INH	--INH,VND
SELECT 4269 ,'2'    ,'160'     ,2    ,160     ,51   UNION ALL	--INH	--INH,VND
SELECT 4270 ,'2.5'  ,'200'     ,2.5  ,200     ,51   UNION ALL	--INH	--INH,VND
SELECT 4271 ,'2'    ,'160'     ,2    ,160     ,51   UNION ALL	--INH	--INH,VND
SELECT 4272 ,'2.5'  ,'75'      ,2.5  ,75      ,51   UNION ALL	--INH	--INH,VND
SELECT 4273 ,'2'    ,'160'     ,2    ,160     ,51   UNION ALL	--INH	--INH,VND
SELECT 4274 ,'2'    ,'50'      ,2    ,50      ,51   UNION ALL	--INH	--INH,VND
SELECT 4275 ,'1'    ,'50'      ,1    ,50      ,51   UNION ALL	--INH	--INH,VND
SELECT 4276 ,'2.5'  ,'75'      ,2.5  ,75      ,51   UNION ALL	--INH	--INH,VND
SELECT 4277 ,'2.5'  ,'75'      ,2.5  ,75      ,51   UNION ALL	--INH	--INH,VND
SELECT 4278 ,'2'    ,'160'     ,2    ,160     ,51   UNION ALL	--INH	--INH,VND
SELECT 4279 ,'2'    ,'160'     ,2    ,160     ,51   UNION ALL	--INH	--INH,VND
SELECT 4280 ,'2'    ,'160'     ,2    ,160     ,51   UNION ALL	--INH	--INH,VND
SELECT 4281 ,'2'    ,'100'     ,2    ,100     ,51   UNION ALL	--INH	--INH,VND
SELECT 4266 ,'2'    ,'360'     ,2    ,360     ,7    UNION ALL	--DON	--INH,VND
SELECT 4267 ,'2'    ,'160'     ,2    ,160     ,7    UNION ALL	--DON	--INH,VND
SELECT 4268 ,'2'    ,'160'     ,2    ,160     ,7    UNION ALL	--DON	--INH,VND
SELECT 4269 ,'2'    ,'160'     ,2    ,160     ,7    UNION ALL	--DON	--INH,VND
SELECT 4270 ,'2.5'  ,'200'     ,2.5  ,200     ,7    UNION ALL	--DON	--INH,VND
SELECT 4271 ,'2'    ,'160'     ,2    ,160     ,7    UNION ALL	--DON	--INH,VND
SELECT 4272 ,'2.5'  ,'75'      ,2.5  ,75      ,7    UNION ALL	--DON	--INH,VND
SELECT 4273 ,'2'    ,'160'     ,2    ,160     ,7    UNION ALL	--DON	--INH,VND
SELECT 4274 ,'2'    ,'50'      ,2    ,50      ,7    UNION ALL	--DON	--INH,VND
SELECT 4275 ,'1'    ,'50'      ,1    ,50      ,7    UNION ALL	--DON	--INH,VND
SELECT 4276 ,'2.5'  ,'75'      ,2.5  ,75      ,7    UNION ALL	--DON	--INH,VND
SELECT 4277 ,'2.5'  ,'75'      ,2.5  ,75      ,7    UNION ALL	--DON	--INH,VND
SELECT 4278 ,'2'    ,'160'     ,2    ,160     ,7    UNION ALL	--DON	--INH,VND
SELECT 4279 ,'2'    ,'160'     ,2    ,160     ,7    UNION ALL	--DON	--INH,VND
SELECT 4280 ,'2'    ,'160'     ,2    ,160     ,7    UNION ALL	--DON	--INH,VND
SELECT 4281 ,'2'    ,'100'     ,2    ,100     ,7    UNION ALL	--DON	--INH,VND

--INR, RUB
SELECT 4266 ,'1'    ,'1200'    ,1    ,1200    ,61   UNION ALL	--INR	--INR, RUB
SELECT 4267 ,'1'    ,'600'     ,1    ,600     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4268 ,'1'    ,'600'     ,1    ,600     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4269 ,'1'    ,'600'     ,1    ,600     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4270 ,'1.25' ,'500'     ,1.25 ,500     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4271 ,'1'    ,'400'     ,1    ,400     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4272 ,'1.25' ,'250'     ,1.25 ,250     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4273 ,'1'    ,'600'     ,1    ,600     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4274 ,'1'    ,'100'     ,1    ,100     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4275 ,'0.5'  ,'100'     ,0.5  ,100     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4276 ,'1.25' ,'250'     ,1.25 ,250     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4277 ,'1.25' ,'250'     ,1.25 ,250     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4278 ,'1'    ,'600'     ,1    ,600     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4279 ,'1'    ,'600'     ,1    ,600     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4280 ,'1'    ,'600'     ,1    ,600     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4281 ,'1'    ,'200'     ,1    ,200     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4266 ,'1'    ,'1200'    ,1    ,1200    ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4267 ,'1'    ,'600'     ,1    ,600     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4268 ,'1'    ,'600'     ,1    ,600     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4269 ,'1'    ,'600'     ,1    ,600     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4270 ,'1.25' ,'500'     ,1.25 ,500     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4271 ,'1'    ,'400'     ,1    ,400     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4272 ,'1.25' ,'250'     ,1.25 ,250     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4273 ,'1'    ,'600'     ,1    ,600     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4274 ,'1'    ,'100'     ,1    ,100     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4275 ,'0.5'  ,'100'     ,0.5  ,100     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4276 ,'1.25' ,'250'     ,1.25 ,250     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4277 ,'1.25' ,'250'     ,1.25 ,250     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4278 ,'1'    ,'600'     ,1    ,600     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4279 ,'1'    ,'600'     ,1    ,600     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4280 ,'1'    ,'600'     ,1    ,600     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4281 ,'1'    ,'200'     ,1    ,200     ,55   UNION ALL	--RUB	--INR, RUB
--JPY
SELECT 4266 ,'10'   ,'2000'    ,10   ,2000    ,32   UNION ALL	--JPY	--JPY
SELECT 4267 ,'10'   ,'1000'    ,10   ,1000    ,32   UNION ALL	--JPY	--JPY
SELECT 4268 ,'10'   ,'1000'    ,10   ,1000    ,32   UNION ALL	--JPY	--JPY
SELECT 4269 ,'10'   ,'1000'    ,10   ,1000    ,32   UNION ALL	--JPY	--JPY
SELECT 4270 ,'12.5' ,'1000'    ,12.5 ,1000    ,32   UNION ALL	--JPY	--JPY
SELECT 4271 ,'10'   ,'800'     ,10   ,800     ,32   UNION ALL	--JPY	--JPY
SELECT 4272 ,'12.5' ,'375'     ,12.5 ,375     ,32   UNION ALL	--JPY	--JPY
SELECT 4273 ,'10'   ,'1000'    ,10   ,1000    ,32   UNION ALL	--JPY	--JPY
SELECT 4274 ,'10'   ,'200'     ,10   ,200     ,32   UNION ALL	--JPY	--JPY
SELECT 4275 ,'5'    ,'200'     ,5    ,200     ,32   UNION ALL	--JPY	--JPY
SELECT 4276 ,'12.5' ,'375'     ,12.5 ,375     ,32   UNION ALL	--JPY	--JPY
SELECT 4277 ,'12.5' ,'375'     ,12.5 ,375     ,32   UNION ALL	--JPY	--JPY
SELECT 4278 ,'10'   ,'1000'    ,10   ,1000    ,32   UNION ALL	--JPY	--JPY
SELECT 4279 ,'10'   ,'1000'    ,10   ,1000    ,32   UNION ALL	--JPY	--JPY
SELECT 4280 ,'10'   ,'1000'    ,10   ,1000    ,32   UNION ALL	--JPY	--JPY
SELECT 4281 ,'10'   ,'400'     ,10   ,400     ,32   UNION ALL	--JPY	--JPY
--RM, MYR,  PLN, KHR
SELECT 4266 ,'0.2'  ,'60'      ,0.2  ,60      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4267 ,'0.2'  ,'30'      ,0.2  ,30      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4268 ,'0.2'  ,'30'      ,0.2  ,30      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4269 ,'0.2'  ,'30'      ,0.2  ,30      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4270 ,'0.25' ,'30'      ,0.25 ,30      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4271 ,'0.2'  ,'24'      ,0.2  ,24      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4272 ,'0.25' ,'12.5'    ,0.25 ,12.5    ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4273 ,'0.2'  ,'30'      ,0.2  ,30      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4274 ,'0.2'  ,'6'       ,0.2  ,6       ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4275 ,'0.1'  ,'7'       ,0.1  ,7       ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4276 ,'0.25' ,'12.5'    ,0.25 ,12.5    ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4277 ,'0.25' ,'12.5'    ,0.25 ,12.5    ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4278 ,'0.2'  ,'30'      ,0.2  ,30      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4279 ,'0.2'  ,'30'      ,0.2  ,30      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4280 ,'0.2'  ,'30'      ,0.2  ,30      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4281 ,'0.2'  ,'14'      ,0.2  ,14      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4266 ,'0.2'  ,'60'      ,0.2  ,60      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4267 ,'0.2'  ,'30'      ,0.2  ,30      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4268 ,'0.2'  ,'30'      ,0.2  ,30      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4269 ,'0.2'  ,'30'      ,0.2  ,30      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4270 ,'0.25' ,'30'      ,0.25 ,30      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4271 ,'0.2'  ,'24'      ,0.2  ,24      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4272 ,'0.25' ,'12.5'    ,0.25 ,12.5    ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4273 ,'0.2'  ,'30'      ,0.2  ,30      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4274 ,'0.2'  ,'6'       ,0.2  ,6       ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4275 ,'0.1'  ,'7'       ,0.1  ,7       ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4276 ,'0.25' ,'12.5'    ,0.25 ,12.5    ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4277 ,'0.25' ,'12.5'    ,0.25 ,12.5    ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4278 ,'0.2'  ,'30'      ,0.2  ,30      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4279 ,'0.2'  ,'30'      ,0.2  ,30      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4280 ,'0.2'  ,'30'      ,0.2  ,30      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4281 ,'0.2'  ,'14'      ,0.2  ,14      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4266 ,'0.2'  ,'60'      ,0.2  ,60      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4267 ,'0.2'  ,'30'      ,0.2  ,30      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4268 ,'0.2'  ,'30'      ,0.2  ,30      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4269 ,'0.2'  ,'30'      ,0.2  ,30      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4270 ,'0.25' ,'30'      ,0.25 ,30      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4271 ,'0.2'  ,'24'      ,0.2  ,24      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4272 ,'0.25' ,'12.5'    ,0.25 ,12.5    ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4273 ,'0.2'  ,'30'      ,0.2  ,30      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4274 ,'0.2'  ,'6'       ,0.2  ,6       ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4275 ,'0.1'  ,'7'       ,0.1  ,7       ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4276 ,'0.25' ,'12.5'    ,0.25 ,12.5    ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4277 ,'0.25' ,'12.5'    ,0.25 ,12.5    ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4278 ,'0.2'  ,'30'      ,0.2  ,30      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4279 ,'0.2'  ,'30'      ,0.2  ,30      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4280 ,'0.2'  ,'30'      ,0.2  ,30      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4281 ,'0.2'  ,'14'      ,0.2  ,14      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4266 ,'0.4'  ,'100'     ,0.4  ,100     ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4267 ,'0.4'  ,'50'      ,0.4  ,50      ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4268 ,'0.4'  ,'50'      ,0.4  ,50      ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4269 ,'0.4'  ,'50'      ,0.4  ,50      ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4270 ,'0.5'  ,'50'      ,0.5  ,50      ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4271 ,'0.4'  ,'40'      ,0.4  ,40      ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4272 ,'0.5'  ,'12.5'    ,0.5  ,12.5    ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4273 ,'0.4'  ,'50'      ,0.4  ,50      ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4274 ,'0.4'  ,'10'      ,0.4  ,10      ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4275 ,'0.2'  ,'5'       ,0.2  ,5       ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4276 ,'0.5'  ,'12.5'    ,0.5  ,12.5    ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4277 ,'0.5'  ,'12.5'    ,0.5  ,12.5    ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4278 ,'0.4'  ,'50'      ,0.4  ,50      ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4279 ,'0.4'  ,'50'      ,0.4  ,50      ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4280 ,'0.4'  ,'50'      ,0.4  ,50      ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4281 ,'0.4'  ,'10'      ,0.4  ,10      ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4266 ,'0.4'  ,'100'     ,0.4  ,100     ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4267 ,'0.4'  ,'50'      ,0.4  ,50      ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4268 ,'0.4'  ,'50'      ,0.4  ,50      ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4269 ,'0.4'  ,'50'      ,0.4  ,50      ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4270 ,'0.5'  ,'50'      ,0.5  ,50      ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4271 ,'0.4'  ,'40'      ,0.4  ,40      ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4272 ,'0.5'  ,'12.5'    ,0.5  ,12.5    ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4273 ,'0.4'  ,'50'      ,0.4  ,50      ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4274 ,'0.4'  ,'10'      ,0.4  ,10      ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4275 ,'0.2'  ,'5'       ,0.2  ,5       ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4276 ,'0.5'  ,'12.5'    ,0.5  ,12.5    ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4277 ,'0.5'  ,'12.5'    ,0.5  ,12.5    ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4278 ,'0.4'  ,'50'      ,0.4  ,50      ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4279 ,'0.4'  ,'50'      ,0.4  ,50      ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4280 ,'0.4'  ,'50'      ,0.4  ,50      ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4281 ,'0.4'  ,'10'      ,0.4  ,10      ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4266 ,'0.4'  ,'100'     ,0.4  ,100     ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4267 ,'0.4'  ,'50'      ,0.4  ,50      ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4268 ,'0.4'  ,'50'      ,0.4  ,50      ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4269 ,'0.4'  ,'50'      ,0.4  ,50      ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4270 ,'0.5'  ,'50'      ,0.5  ,50      ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4271 ,'0.4'  ,'40'      ,0.4  ,40      ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4272 ,'0.5'  ,'12.5'    ,0.5  ,12.5    ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4273 ,'0.4'  ,'50'      ,0.4  ,50      ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4274 ,'0.4'  ,'10'      ,0.4  ,10      ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4275 ,'0.2'  ,'5'       ,0.2  ,5       ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4276 ,'0.5'  ,'12.5'    ,0.5  ,12.5    ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4277 ,'0.5'  ,'12.5'    ,0.5  ,12.5    ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4278 ,'0.4'  ,'50'      ,0.4  ,50      ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4279 ,'0.4'  ,'50'      ,0.4  ,50      ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4280 ,'0.4'  ,'50'      ,0.4  ,50      ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4281 ,'0.4'  ,'10'      ,0.4  ,10      ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4266 ,'0.4'  ,'100'     ,0.4  ,100     ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4267 ,'0.4'  ,'50'      ,0.4  ,50      ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4268 ,'0.4'  ,'50'      ,0.4  ,50      ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4269 ,'0.4'  ,'50'      ,0.4  ,50      ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4270 ,'0.5'  ,'50'      ,0.5  ,50      ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4271 ,'0.4'  ,'40'      ,0.4  ,40      ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4272 ,'0.5'  ,'12.5'    ,0.5  ,12.5    ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4273 ,'0.4'  ,'50'      ,0.4  ,50      ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4274 ,'0.4'  ,'10'      ,0.4  ,10      ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4275 ,'0.2'  ,'5'       ,0.2  ,5       ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4276 ,'0.5'  ,'12.5'    ,0.5  ,12.5    ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4277 ,'0.5'  ,'12.5'    ,0.5  ,12.5    ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4278 ,'0.4'  ,'50'      ,0.4  ,50      ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4279 ,'0.4'  ,'50'      ,0.4  ,50      ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4280 ,'0.4'  ,'50'      ,0.4  ,50      ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4281 ,'0.4'  ,'10'      ,0.4  ,10      ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4266 ,'0.4'  ,'100'     ,0.4  ,100     ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4267 ,'0.4'  ,'50'      ,0.4  ,50      ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4268 ,'0.4'  ,'50'      ,0.4  ,50      ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4269 ,'0.4'  ,'50'      ,0.4  ,50      ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4270 ,'0.5'  ,'50'      ,0.5  ,50      ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4271 ,'0.4'  ,'40'      ,0.4  ,40      ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4272 ,'0.5'  ,'12.5'    ,0.5  ,12.5    ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4273 ,'0.4'  ,'50'      ,0.4  ,50      ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4274 ,'0.4'  ,'10'      ,0.4  ,10      ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4275 ,'0.2'  ,'5'       ,0.2  ,5       ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4276 ,'0.5'  ,'12.5'    ,0.5  ,12.5    ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4277 ,'0.5'  ,'12.5'    ,0.5  ,12.5    ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4278 ,'0.4'  ,'50'      ,0.4  ,50      ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4279 ,'0.4'  ,'50'      ,0.4  ,50      ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4280 ,'0.4'  ,'50'      ,0.4  ,50      ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4281 ,'0.4'  ,'10'      ,0.4  ,10      ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
--THB , TB
SELECT 4266 ,'2'    ,'500'     ,2    ,500     ,4    UNION ALL	--TB	--THB , TB
SELECT 4267 ,'2'    ,'240'     ,2    ,240     ,4    UNION ALL	--TB	--THB , TB
SELECT 4268 ,'2'    ,'240'     ,2    ,240     ,4    UNION ALL	--TB	--THB , TB
SELECT 4269 ,'2'    ,'240'     ,2    ,240     ,4    UNION ALL	--TB	--THB , TB
SELECT 4270 ,'2.5'  ,'300'     ,2.5  ,300     ,4    UNION ALL	--TB	--THB , TB
SELECT 4271 ,'2'    ,'240'     ,2    ,240     ,4    UNION ALL	--TB	--THB , TB
SELECT 4272 ,'2.5'  ,'150'     ,2.5  ,150     ,4    UNION ALL	--TB	--THB , TB
SELECT 4273 ,'2'    ,'240'     ,2    ,240     ,4    UNION ALL	--TB	--THB , TB
SELECT 4274 ,'2'    ,'80'      ,2    ,80      ,4    UNION ALL	--TB	--THB , TB
SELECT 4275 ,'1'    ,'60'      ,1    ,60      ,4    UNION ALL	--TB	--THB , TB
SELECT 4276 ,'2.5'  ,'150'     ,2.5  ,150     ,4    UNION ALL	--TB	--THB , TB
SELECT 4277 ,'2.5'  ,'150'     ,2.5  ,150     ,4    UNION ALL	--TB	--THB , TB
SELECT 4278 ,'2'    ,'240'     ,2    ,240     ,4    UNION ALL	--TB	--THB , TB
SELECT 4279 ,'2'    ,'240'     ,2    ,240     ,4    UNION ALL	--TB	--THB , TB
SELECT 4280 ,'2'    ,'240'     ,2    ,240     ,4    UNION ALL	--TB	--THB , TB
SELECT 4281 ,'2'    ,'160'     ,2    ,160     ,4    UNION ALL	--TB	--THB , TB
--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4266 ,'0.2'  ,'16'      ,0.2  ,16      ,3    UNION ALL	--US$	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4267 ,'0.2'  ,'7'       ,0.2  ,7       ,3    UNION ALL	--US$	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4268 ,'0.2'  ,'7'       ,0.2  ,7       ,3    UNION ALL	--US$	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4269 ,'0.2'  ,'7'       ,0.2  ,7       ,3    UNION ALL	--US$	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4270 ,'0.25' ,'7.5'     ,0.25 ,7.5     ,3    UNION ALL	--US$	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4271 ,'0.2'  ,'7'       ,0.2  ,7       ,3    UNION ALL	--US$	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4272 ,'0.25' ,'2.5'     ,0.25 ,2.5     ,3    UNION ALL	--US$	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4273 ,'0.2'  ,'7'       ,0.2  ,7       ,3    UNION ALL	--US$	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4274 ,'0.2'  ,'2'       ,0.2  ,2       ,3    UNION ALL	--US$	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4275 ,'0.1'  ,'1.5'     ,0.1  ,1.5     ,3    UNION ALL	--US$	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4276 ,'0.25' ,'2.5'     ,0.25 ,2.5     ,3    UNION ALL	--US$	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4277 ,'0.25' ,'2.5'     ,0.25 ,2.5     ,3    UNION ALL	--US$	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4278 ,'0.2'  ,'7'       ,0.2  ,7       ,3    UNION ALL	--US$	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4279 ,'0.2'  ,'7'       ,0.2  ,7       ,3    UNION ALL	--US$	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4280 ,'0.2'  ,'7'       ,0.2  ,7       ,3    UNION ALL	--US$	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4281 ,'0.2'  ,'3'       ,0.2  ,3       ,3    UNION ALL	--US$	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF

SELECT 4266 ,'0.2'  ,'16'      ,0.2  ,16      ,96   UNION ALL	--USDT	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4267 ,'0.2'  ,'7'       ,0.2  ,7       ,96   UNION ALL	--USDT	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4268 ,'0.2'  ,'7'       ,0.2  ,7       ,96   UNION ALL	--USDT	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4269 ,'0.2'  ,'7'       ,0.2  ,7       ,96   UNION ALL	--USDT	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4270 ,'0.25' ,'7.5'     ,0.25 ,7.5     ,96   UNION ALL	--USDT	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4271 ,'0.2'  ,'7'       ,0.2  ,7       ,96   UNION ALL	--USDT	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4272 ,'0.25' ,'2.5'     ,0.25 ,2.5     ,96   UNION ALL	--USDT	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4273 ,'0.2'  ,'7'       ,0.2  ,7       ,96   UNION ALL	--USDT	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4274 ,'0.2'  ,'2'       ,0.2  ,2       ,96   UNION ALL	--USDT	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4275 ,'0.1'  ,'1.5'     ,0.1  ,1.5     ,96   UNION ALL	--USDT	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4276 ,'0.25' ,'2.5'     ,0.25 ,2.5     ,96   UNION ALL	--USDT	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4277 ,'0.25' ,'2.5'     ,0.25 ,2.5     ,96   UNION ALL	--USDT	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4278 ,'0.2'  ,'7'       ,0.2  ,7       ,96   UNION ALL	--USDT	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4279 ,'0.2'  ,'7'       ,0.2  ,7       ,96   UNION ALL	--USDT	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4280 ,'0.2'  ,'7'       ,0.2  ,7       ,96   UNION ALL	--USDT	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4281 ,'0.2'  ,'3'       ,0.2  ,3       ,96   UNION ALL	--USDT	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF

SELECT 4266 ,'0.2'  ,'16'      ,0.2  ,16      ,9    UNION ALL	--AUD	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4267 ,'0.2'  ,'7'       ,0.2  ,7       ,9    UNION ALL	--AUD	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4268 ,'0.2'  ,'7'       ,0.2  ,7       ,9    UNION ALL	--AUD	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4269 ,'0.2'  ,'7'       ,0.2  ,7       ,9    UNION ALL	--AUD	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4270 ,'0.25' ,'7.5'     ,0.25 ,7.5     ,9    UNION ALL	--AUD	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4271 ,'0.2'  ,'7'       ,0.2  ,7       ,9    UNION ALL	--AUD	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4272 ,'0.25' ,'2.5'     ,0.25 ,2.5     ,9    UNION ALL	--AUD	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4273 ,'0.2'  ,'7'       ,0.2  ,7       ,9    UNION ALL	--AUD	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4274 ,'0.2'  ,'2'       ,0.2  ,2       ,9    UNION ALL	--AUD	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4275 ,'0.1'  ,'1.5'     ,0.1  ,1.5     ,9    UNION ALL	--AUD	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4276 ,'0.25' ,'2.5'     ,0.25 ,2.5     ,9    UNION ALL	--AUD	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4277 ,'0.25' ,'2.5'     ,0.25 ,2.5     ,9    UNION ALL	--AUD	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4278 ,'0.2'  ,'7'       ,0.2  ,7       ,9    UNION ALL	--AUD	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4279 ,'0.2'  ,'7'       ,0.2  ,7       ,9    UNION ALL	--AUD	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4280 ,'0.2'  ,'7'       ,0.2  ,7       ,9    UNION ALL	--AUD	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4281 ,'0.2'  ,'3'       ,0.2  ,3       ,9    UNION ALL	--AUD	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4266 ,'0.2'  ,'16'      ,0.2  ,16      ,41   UNION ALL	--CHF	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4267 ,'0.2'  ,'7'       ,0.2  ,7       ,41   UNION ALL	--CHF	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4268 ,'0.2'  ,'7'       ,0.2  ,7       ,41   UNION ALL	--CHF	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4269 ,'0.2'  ,'7'       ,0.2  ,7       ,41   UNION ALL	--CHF	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4270 ,'0.25' ,'7.5'     ,0.25 ,7.5     ,41   UNION ALL	--CHF	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4271 ,'0.2'  ,'7'       ,0.2  ,7       ,41   UNION ALL	--CHF	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4272 ,'0.25' ,'2.5'     ,0.25 ,2.5     ,41   UNION ALL	--CHF	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4273 ,'0.2'  ,'7'       ,0.2  ,7       ,41   UNION ALL	--CHF	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4274 ,'0.2'  ,'2'       ,0.2  ,2       ,41   UNION ALL	--CHF	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4275 ,'0.1'  ,'1.5'     ,0.1  ,1.5     ,41   UNION ALL	--CHF	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4276 ,'0.25' ,'2.5'     ,0.25 ,2.5     ,41   UNION ALL	--CHF	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4277 ,'0.25' ,'2.5'     ,0.25 ,2.5     ,41   UNION ALL	--CHF	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4278 ,'0.2'  ,'7'       ,0.2  ,7       ,41   UNION ALL	--CHF	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4279 ,'0.2'  ,'7'       ,0.2  ,7       ,41   UNION ALL	--CHF	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4280 ,'0.2'  ,'7'       ,0.2  ,7       ,41   UNION ALL	--CHF	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4281 ,'0.2'  ,'3'       ,0.2  ,3       ,41   UNION ALL	--CHF	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4266 ,'0.2'  ,'16'      ,0.2  ,16      ,6    UNION ALL	--EURO	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4267 ,'0.2'  ,'7'       ,0.2  ,7       ,6    UNION ALL	--EURO	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4268 ,'0.2'  ,'7'       ,0.2  ,7       ,6    UNION ALL	--EURO	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4269 ,'0.2'  ,'7'       ,0.2  ,7       ,6    UNION ALL	--EURO	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4270 ,'0.25' ,'7.5'     ,0.25 ,7.5     ,6    UNION ALL	--EURO	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4271 ,'0.2'  ,'7'       ,0.2  ,7       ,6    UNION ALL	--EURO	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4272 ,'0.25' ,'2.5'     ,0.25 ,2.5     ,6    UNION ALL	--EURO	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4273 ,'0.2'  ,'7'       ,0.2  ,7       ,6    UNION ALL	--EURO	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4274 ,'0.2'  ,'2'       ,0.2  ,2       ,6    UNION ALL	--EURO	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4275 ,'0.1'  ,'1.5'     ,0.1  ,1.5     ,6    UNION ALL	--EURO	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4276 ,'0.25' ,'2.5'     ,0.25 ,2.5     ,6    UNION ALL	--EURO	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4277 ,'0.25' ,'2.5'     ,0.25 ,2.5     ,6    UNION ALL	--EURO	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4278 ,'0.2'  ,'7'       ,0.2  ,7       ,6    UNION ALL	--EURO	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4279 ,'0.2'  ,'7'       ,0.2  ,7       ,6    UNION ALL	--EURO	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4280 ,'0.2'  ,'7'       ,0.2  ,7       ,6    UNION ALL	--EURO	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4281 ,'0.2'  ,'3'       ,0.2  ,3       ,6    UNION ALL	--EURO	--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
--WON , KRW
SELECT 4266 ,'80'   ,'20000'   ,80   ,20000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4267 ,'80'   ,'10000'   ,80   ,10000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4268 ,'80'   ,'10000'   ,80   ,10000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4269 ,'80'   ,'10000'   ,80   ,10000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4270 ,'100'  ,'10000'   ,100  ,10000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4271 ,'80'   ,'8000'    ,80   ,8000    ,45   UNION ALL	--Won	--WON , KRW
SELECT 4272 ,'100'  ,'2500'    ,100  ,2500    ,45   UNION ALL	--Won	--WON , KRW
SELECT 4273 ,'80'   ,'10000'   ,80   ,10000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4274 ,'80'   ,'2000'    ,80   ,2000    ,45   UNION ALL	--Won	--WON , KRW
SELECT 4275 ,'40'   ,'2000'    ,40   ,2000    ,45   UNION ALL	--Won	--WON , KRW
SELECT 4276 ,'100'  ,'5000'    ,100  ,5000    ,45   UNION ALL	--Won	--WON , KRW
SELECT 4277 ,'100'  ,'2500'    ,100  ,2500    ,45   UNION ALL	--Won	--WON , KRW
SELECT 4278 ,'80'   ,'10000'   ,80   ,10000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4279 ,'80'   ,'10000'   ,80   ,10000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4280 ,'80'   ,'10000'   ,80   ,10000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4281 ,'80'   ,'4000'    ,80   ,4000    ,45				--Won	--WON , KRW


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