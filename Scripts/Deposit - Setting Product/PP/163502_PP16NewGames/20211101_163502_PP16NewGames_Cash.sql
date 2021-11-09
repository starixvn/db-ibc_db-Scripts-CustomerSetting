/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 202111101
	Created: Winfred 
	Task: #163502 - Pragmatic - Integrate 16 new games for Deposit [Redmine:163502]
	DB: DBCUST/CUSTDB
*/

CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
									,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
									,ExchangeId int)
									
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--GBP
SELECT 4282 ,'0.4'  ,'4'       ,0.4  ,4       ,12   UNION ALL	--GBP	--GBP
SELECT 4283 ,'0.2'  ,'5'       ,0.2  ,5       ,12   UNION ALL	--GBP	--GBP
SELECT 4284 ,'0.9'  ,'9'       ,0.9  ,9       ,12   UNION ALL	--GBP	--GBP
SELECT 4285 ,'0.6'  ,'6'       ,0.6  ,6       ,12   UNION ALL	--GBP	--GBP
SELECT 4286 ,'0.2'  ,'4'       ,0.2  ,4       ,12   UNION ALL	--GBP	--GBP
SELECT 4287 ,'0.2'  ,'4'       ,0.2  ,4       ,12   UNION ALL	--GBP	--GBP
SELECT 4288 ,'0.2'  ,'4'       ,0.2  ,4       ,12   UNION ALL	--GBP	--GBP
SELECT 4289 ,'0.2'  ,'4'       ,0.2  ,4       ,12   UNION ALL	--GBP	--GBP
SELECT 4290 ,'0.2'  ,'4'       ,0.2  ,4       ,12   UNION ALL	--GBP	--GBP
SELECT 4291 ,'0.2'  ,'2'       ,0.2  ,2       ,12   UNION ALL	--GBP	--GBP
--IN,IDR
SELECT 4282 ,'0.4'  ,'80'      ,0.4  ,80      ,15   UNION ALL	--IN	--IN,IDR
SELECT 4283 ,'0.2'  ,'80'      ,0.2  ,80      ,15   UNION ALL	--IN	--IN,IDR
SELECT 4284 ,'0.9'  ,'63'      ,0.9  ,63      ,15   UNION ALL	--IN	--IN,IDR
SELECT 4285 ,'0.6'  ,'120'     ,0.6  ,120     ,15   UNION ALL	--IN	--IN,IDR
SELECT 4286 ,'0.2'  ,'80'      ,0.2  ,80      ,15   UNION ALL	--IN	--IN,IDR
SELECT 4287 ,'0.2'  ,'80'      ,0.2  ,80      ,15   UNION ALL	--IN	--IN,IDR
SELECT 4288 ,'0.2'  ,'80'      ,0.2  ,80      ,15   UNION ALL	--IN	--IN,IDR
SELECT 4289 ,'0.2'  ,'80'      ,0.2  ,80      ,15   UNION ALL	--IN	--IN,IDR
SELECT 4290 ,'0.2'  ,'80'      ,0.2  ,80      ,15   UNION ALL	--IN	--IN,IDR
SELECT 4291 ,'0.2'  ,'60'      ,0.2  ,60      ,15   UNION ALL	--IN	--IN,IDR
--INH,VND
SELECT 4282 ,'4'    ,'200'     ,4    ,200     ,7    UNION ALL	--DON	--INH,VND,DON
SELECT 4283 ,'2'    ,'280'     ,2    ,280     ,7    UNION ALL	--DON	--INH,VND,DON
SELECT 4284 ,'9'    ,'135'     ,9    ,135     ,7    UNION ALL	--DON	--INH,VND,DON
SELECT 4285 ,'6'    ,'180'     ,6    ,180     ,7    UNION ALL	--DON	--INH,VND,DON
SELECT 4286 ,'2'    ,'160'     ,2    ,160     ,7    UNION ALL	--DON	--INH,VND,DON
SELECT 4287 ,'2'    ,'160'     ,2    ,160     ,7    UNION ALL	--DON	--INH,VND,DON
SELECT 4288 ,'2'    ,'160'     ,2    ,160     ,7    UNION ALL	--DON	--INH,VND,DON
SELECT 4289 ,'2'    ,'160'     ,2    ,160     ,7    UNION ALL	--DON	--INH,VND,DON
SELECT 4290 ,'2'    ,'160'     ,2    ,160     ,7    UNION ALL	--DON	--INH,VND,DON
SELECT 4291 ,'2'    ,'160'     ,2    ,160     ,7    UNION ALL	--DON	--INH,VND,DON
SELECT 4282 ,'4'    ,'200'     ,4    ,200     ,51   UNION ALL	--INH	--INH,VND,DON
SELECT 4283 ,'2'    ,'280'     ,2    ,280     ,51   UNION ALL	--INH	--INH,VND,DON
SELECT 4284 ,'9'    ,'135'     ,9    ,135     ,51   UNION ALL	--INH	--INH,VND,DON
SELECT 4285 ,'6'    ,'180'     ,6    ,180     ,51   UNION ALL	--INH	--INH,VND,DON
SELECT 4286 ,'2'    ,'160'     ,2    ,160     ,51   UNION ALL	--INH	--INH,VND,DON
SELECT 4287 ,'2'    ,'160'     ,2    ,160     ,51   UNION ALL	--INH	--INH,VND,DON
SELECT 4288 ,'2'    ,'160'     ,2    ,160     ,51   UNION ALL	--INH	--INH,VND,DON
SELECT 4289 ,'2'    ,'160'     ,2    ,160     ,51   UNION ALL	--INH	--INH,VND,DON
SELECT 4290 ,'2'    ,'160'     ,2    ,160     ,51   UNION ALL	--INH	--INH,VND,DON
SELECT 4291 ,'2'    ,'160'     ,2    ,160     ,51   UNION ALL	--INH	--INH,VND,DON
--INR, RUB
SELECT 4282 ,'2'    ,'400'     ,2    ,400     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4283 ,'1'    ,'600'     ,1    ,600     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4284 ,'4.5'  ,'180'     ,4.5  ,180     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4285 ,'3'    ,'600'     ,3    ,600     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4286 ,'1'    ,'600'     ,1    ,600     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4287 ,'1'    ,'600'     ,1    ,600     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4288 ,'1'    ,'600'     ,1    ,600     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4289 ,'1'    ,'600'     ,1    ,600     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4290 ,'1'    ,'600'     ,1    ,600     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4291 ,'1'    ,'400'     ,1    ,400     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4282 ,'2'    ,'400'     ,2    ,400     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4283 ,'1'    ,'600'     ,1    ,600     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4284 ,'4.5'  ,'180'     ,4.5  ,180     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4285 ,'3'    ,'600'     ,3    ,600     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4286 ,'1'    ,'600'     ,1    ,600     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4287 ,'1'    ,'600'     ,1    ,600     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4288 ,'1'    ,'600'     ,1    ,600     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4289 ,'1'    ,'600'     ,1    ,600     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4290 ,'1'    ,'600'     ,1    ,600     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4291 ,'1'    ,'400'     ,1    ,400     ,55   UNION ALL	--RUB	--INR, RUB
--JPY
SELECT 4282 ,'20'   ,'800'     ,20   ,800     ,32   UNION ALL	--JPY	--JPY
SELECT 4283 ,'10'   ,'1000'    ,10   ,1000    ,32   UNION ALL	--JPY	--JPY
SELECT 4284 ,'45'   ,'450'     ,45   ,450     ,32   UNION ALL	--JPY	--JPY
SELECT 4285 ,'30'   ,'1200'    ,30   ,1200    ,32   UNION ALL	--JPY	--JPY
SELECT 4286 ,'10'   ,'1000'    ,10   ,1000    ,32   UNION ALL	--JPY	--JPY
SELECT 4287 ,'10'   ,'800'     ,10   ,800     ,32   UNION ALL	--JPY	--JPY
SELECT 4288 ,'10'   ,'800'     ,10   ,800     ,32   UNION ALL	--JPY	--JPY
SELECT 4289 ,'10'   ,'1000'    ,10   ,1000    ,32   UNION ALL	--JPY	--JPY
SELECT 4290 ,'10'   ,'1000'    ,10   ,1000    ,32   UNION ALL	--JPY	--JPY
SELECT 4291 ,'10'   ,'400'     ,10   ,400     ,32   UNION ALL	--JPY	--JPY
--RM, MYR,  PLN, KHR
SELECT 4282 ,'0.4'  ,'28'      ,0.4  ,28      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4283 ,'0.2'  ,'30'      ,0.2  ,30      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4284 ,'0.9'  ,'18'      ,0.9  ,18      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4285 ,'0.6'  ,'36'      ,0.6  ,36      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4286 ,'0.2'  ,'30'      ,0.2  ,30      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4287 ,'0.2'  ,'30'      ,0.2  ,30      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4288 ,'0.2'  ,'30'      ,0.2  ,30      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4289 ,'0.2'  ,'30'      ,0.2  ,30      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4290 ,'0.2'  ,'30'      ,0.2  ,30      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4291 ,'0.2'  ,'16'      ,0.2  ,16      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4282 ,'0.4'  ,'28'      ,0.4  ,28      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4283 ,'0.2'  ,'30'      ,0.2  ,30      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4284 ,'0.9'  ,'18'      ,0.9  ,18      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4285 ,'0.6'  ,'36'      ,0.6  ,36      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4286 ,'0.2'  ,'30'      ,0.2  ,30      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4287 ,'0.2'  ,'30'      ,0.2  ,30      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4288 ,'0.2'  ,'30'      ,0.2  ,30      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4289 ,'0.2'  ,'30'      ,0.2  ,30      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4290 ,'0.2'  ,'30'      ,0.2  ,30      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4291 ,'0.2'  ,'16'      ,0.2  ,16      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4282 ,'0.4'  ,'28'      ,0.4  ,28      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4283 ,'0.2'  ,'30'      ,0.2  ,30      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4284 ,'0.9'  ,'18'      ,0.9  ,18      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4285 ,'0.6'  ,'36'      ,0.6  ,36      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4286 ,'0.2'  ,'30'      ,0.2  ,30      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4287 ,'0.2'  ,'30'      ,0.2  ,30      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4288 ,'0.2'  ,'30'      ,0.2  ,30      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4289 ,'0.2'  ,'30'      ,0.2  ,30      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4290 ,'0.2'  ,'30'      ,0.2  ,30      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4291 ,'0.2'  ,'16'      ,0.2  ,16      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4282 ,'0.8'  ,'20'      ,0.8  ,20      ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4283 ,'0.4'  ,'50'      ,0.4  ,50      ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4284 ,'1.8'  ,'27'      ,1.8  ,27      ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4285 ,'1.2'  ,'30'      ,1.2  ,30      ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4286 ,'0.4'  ,'50'      ,0.4  ,50      ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4287 ,'0.4'  ,'50'      ,0.4  ,50      ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4288 ,'0.4'  ,'50'      ,0.4  ,50      ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4289 ,'0.4'  ,'50'      ,0.4  ,50      ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4290 ,'0.4'  ,'50'      ,0.4  ,50      ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4291 ,'0.4'  ,'40'      ,0.4  ,40      ,52   UNION ALL	--DKK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4282 ,'0.8'  ,'20'      ,0.8  ,20      ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4283 ,'0.4'  ,'50'      ,0.4  ,50      ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4284 ,'1.8'  ,'27'      ,1.8  ,27      ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4285 ,'1.2'  ,'30'      ,1.2  ,30      ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4286 ,'0.4'  ,'50'      ,0.4  ,50      ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4287 ,'0.4'  ,'50'      ,0.4  ,50      ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4288 ,'0.4'  ,'50'      ,0.4  ,50      ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4289 ,'0.4'  ,'50'      ,0.4  ,50      ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4290 ,'0.4'  ,'50'      ,0.4  ,50      ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4291 ,'0.4'  ,'40'      ,0.4  ,40      ,54   UNION ALL	--NOK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4282 ,'0.8'  ,'20'      ,0.8  ,20      ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4283 ,'0.4'  ,'50'      ,0.4  ,50      ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4284 ,'1.8'  ,'27'      ,1.8  ,27      ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4285 ,'1.2'  ,'30'      ,1.2  ,30      ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4286 ,'0.4'  ,'50'      ,0.4  ,50      ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4287 ,'0.4'  ,'50'      ,0.4  ,50      ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4288 ,'0.4'  ,'50'      ,0.4  ,50      ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4289 ,'0.4'  ,'50'      ,0.4  ,50      ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4290 ,'0.4'  ,'50'      ,0.4  ,50      ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4291 ,'0.4'  ,'40'      ,0.4  ,40      ,13   UNION ALL	--RMB	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4282 ,'0.8'  ,'20'      ,0.8  ,20      ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4283 ,'0.4'  ,'50'      ,0.4  ,50      ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4284 ,'1.8'  ,'27'      ,1.8  ,27      ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4285 ,'1.2'  ,'30'      ,1.2  ,30      ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4286 ,'0.4'  ,'50'      ,0.4  ,50      ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4287 ,'0.4'  ,'50'      ,0.4  ,50      ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4288 ,'0.4'  ,'50'      ,0.4  ,50      ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4289 ,'0.4'  ,'50'      ,0.4  ,50      ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4290 ,'0.4'  ,'50'      ,0.4  ,50      ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4291 ,'0.4'  ,'40'      ,0.4  ,40      ,53   UNION ALL	--SEK	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4282 ,'0.8'  ,'20'      ,0.8  ,20      ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4283 ,'0.4'  ,'50'      ,0.4  ,50      ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4284 ,'1.8'  ,'27'      ,1.8  ,27      ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4285 ,'1.2'  ,'30'      ,1.2  ,30      ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4286 ,'0.4'  ,'50'      ,0.4  ,50      ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4287 ,'0.4'  ,'50'      ,0.4  ,50      ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4288 ,'0.4'  ,'50'      ,0.4  ,50      ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4289 ,'0.4'  ,'50'      ,0.4  ,50      ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4290 ,'0.4'  ,'50'      ,0.4  ,50      ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
SELECT 4291 ,'0.4'  ,'40'      ,0.4  ,40      ,66   UNION ALL	--YUN	--RMB, CNY,PTH, YUN, DKK, SEK, NOK
--THB , TB
SELECT 4282 ,'4'    ,'320'     ,4    ,320     ,4    UNION ALL	--TB	--THB , TB
SELECT 4283 ,'2'    ,'400'     ,2    ,400     ,4    UNION ALL	--TB	--THB , TB
SELECT 4284 ,'9'    ,'225'     ,9    ,225     ,4    UNION ALL	--TB	--THB , TB
SELECT 4285 ,'6'    ,'360'     ,6    ,360     ,4    UNION ALL	--TB	--THB , TB
SELECT 4286 ,'2'    ,'240'     ,2    ,240     ,4    UNION ALL	--TB	--THB , TB
SELECT 4287 ,'2'    ,'240'     ,2    ,240     ,4    UNION ALL	--TB	--THB , TB
SELECT 4288 ,'2'    ,'240'     ,2    ,240     ,4    UNION ALL	--TB	--THB , TB
SELECT 4289 ,'2'    ,'240'     ,2    ,240     ,4    UNION ALL	--TB	--THB , TB
SELECT 4290 ,'2'    ,'240'     ,2    ,240     ,4    UNION ALL	--TB	--THB , TB
SELECT 4291 ,'2'    ,'240'     ,2    ,240     ,4    UNION ALL	--TB	--THB , TB
--USD, AUD, EUR, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4282 ,'0.4'  ,'6'       ,0.4  ,6       ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4283 ,'0.2'  ,'7'       ,0.2  ,7       ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4284 ,'0.9'  ,'9'       ,0.9  ,9       ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4285 ,'0.6'  ,'9'       ,0.6  ,9       ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4286 ,'0.2'  ,'6'       ,0.2  ,6       ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4287 ,'0.2'  ,'6'       ,0.2  ,6       ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4288 ,'0.2'  ,'6'       ,0.2  ,6       ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4289 ,'0.2'  ,'6'       ,0.2  ,6       ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4290 ,'0.2'  ,'6'       ,0.2  ,6       ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4291 ,'0.2'  ,'6'       ,0.2  ,6       ,9    UNION ALL	--AUD	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4282 ,'0.4'  ,'6'       ,0.4  ,6       ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4283 ,'0.2'  ,'7'       ,0.2  ,7       ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4284 ,'0.9'  ,'9'       ,0.9  ,9       ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4285 ,'0.6'  ,'9'       ,0.6  ,9       ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4286 ,'0.2'  ,'6'       ,0.2  ,6       ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4287 ,'0.2'  ,'6'       ,0.2  ,6       ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4288 ,'0.2'  ,'6'       ,0.2  ,6       ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4289 ,'0.2'  ,'6'       ,0.2  ,6       ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4290 ,'0.2'  ,'6'       ,0.2  ,6       ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4291 ,'0.2'  ,'6'       ,0.2  ,6       ,41   UNION ALL	--CHF	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4282 ,'0.4'  ,'6'       ,0.4  ,6       ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4283 ,'0.2'  ,'7'       ,0.2  ,7       ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4284 ,'0.9'  ,'9'       ,0.9  ,9       ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4285 ,'0.6'  ,'9'       ,0.6  ,9       ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4286 ,'0.2'  ,'6'       ,0.2  ,6       ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4287 ,'0.2'  ,'6'       ,0.2  ,6       ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4288 ,'0.2'  ,'6'       ,0.2  ,6       ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4289 ,'0.2'  ,'6'       ,0.2  ,6       ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4290 ,'0.2'  ,'6'       ,0.2  ,6       ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4291 ,'0.2'  ,'6'       ,0.2  ,6       ,6    UNION ALL	--EURO	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4282 ,'0.4'  ,'6'       ,0.4  ,6       ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4283 ,'0.2'  ,'7'       ,0.2  ,7       ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4284 ,'0.9'  ,'9'       ,0.9  ,9       ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4285 ,'0.6'  ,'9'       ,0.6  ,9       ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4286 ,'0.2'  ,'6'       ,0.2  ,6       ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4287 ,'0.2'  ,'6'       ,0.2  ,6       ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4288 ,'0.2'  ,'6'       ,0.2  ,6       ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4289 ,'0.2'  ,'6'       ,0.2  ,6       ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4290 ,'0.2'  ,'6'       ,0.2  ,6       ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4291 ,'0.2'  ,'6'       ,0.2  ,6       ,3    UNION ALL	--US$	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4282 ,'0.4'  ,'6'       ,0.4  ,6       ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4283 ,'0.2'  ,'7'       ,0.2  ,7       ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4284 ,'0.9'  ,'9'       ,0.9  ,9       ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4285 ,'0.6'  ,'9'       ,0.6  ,9       ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4286 ,'0.2'  ,'6'       ,0.2  ,6       ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4287 ,'0.2'  ,'6'       ,0.2  ,6       ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4288 ,'0.2'  ,'6'       ,0.2  ,6       ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4289 ,'0.2'  ,'6'       ,0.2  ,6       ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4290 ,'0.2'  ,'6'       ,0.2  ,6       ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
SELECT 4291 ,'0.2'  ,'6'       ,0.2  ,6       ,96   UNION ALL	--USDT	--US$ ,USDT, USD, AUD, EURO, SGD,PTU,PS,YNG,UUS, CHF
--WON , KRW
SELECT 4282 ,'160'  ,'8000'    ,160  ,8000    ,45   UNION ALL	--Won	--WON , KRW
SELECT 4283 ,'80'   ,'10000'   ,80   ,10000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4284 ,'360'  ,'4500'    ,360  ,4500    ,45   UNION ALL	--Won	--WON , KRW
SELECT 4285 ,'240'  ,'12000'   ,240  ,12000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4286 ,'80'   ,'10000'   ,80   ,10000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4287 ,'80'   ,'10000'   ,80   ,10000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4288 ,'80'   ,'10000'   ,80   ,10000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4289 ,'80'   ,'10000'   ,80   ,10000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4290 ,'80'   ,'10000'   ,80   ,10000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4291 ,'80'   ,'4000'    ,80   ,4000    ,45   			--Won	--WON , KRW


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