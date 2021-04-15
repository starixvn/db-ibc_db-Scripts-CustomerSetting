/*
	Date: 20210409
	Created: Winfred 
	Task: #145333 - Spadegaming - 1 new games 2021 - Cash
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(11))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--DDD, IND, IDR, IDD, IN
SELECT 4354 ,'0.4'  ,'1000'    ,0.4  ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4355 ,'0.2'  ,'1000'    ,0.2  ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4356 ,'0.5'  ,'1000'    ,0.5  ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4357 ,'0.5'  ,'1000'    ,0.5  ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4358 ,'0.3'  ,'900'     ,0.3  ,900     ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4359 ,'0.2'  ,'1000'    ,0.2  ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4360 ,'0.5'  ,'1000'    ,0.5  ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4361 ,'0.5'  ,'1000'    ,0.5  ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4362 ,'0.2'  ,'1000'    ,0.2  ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
--Euro, EUR,GBP
SELECT 4354 ,'0.4'  ,'100'     ,0.4  ,100     ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4355 ,'0.2'  ,'100'     ,0.2  ,100     ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4356 ,'0.05' ,'100'     ,0.05 ,100     ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4357 ,'0.5'  ,'100'     ,0.5  ,100     ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4358 ,'0.3'  ,'150'     ,0.3  ,150     ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4359 ,'0.2'  ,'100'     ,0.2  ,100     ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4360 ,'0.5'  ,'100'     ,0.5  ,100     ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4361 ,'0.5'  ,'100'     ,0.5  ,100     ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4362 ,'0.2'  ,'100'     ,0.2  ,100     ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4354 ,'0.4'  ,'100'     ,0.4  ,100     ,12   UNION ALL	--GBP	--Euro, EUR,GBP
SELECT 4355 ,'0.2'  ,'100'     ,0.2  ,100     ,12   UNION ALL	--GBP	--Euro, EUR,GBP
SELECT 4356 ,'0.05' ,'100'     ,0.05 ,100     ,12   UNION ALL	--GBP	--Euro, EUR,GBP
SELECT 4357 ,'0.5'  ,'100'     ,0.5  ,100     ,12   UNION ALL	--GBP	--Euro, EUR,GBP
SELECT 4358 ,'0.3'  ,'150'     ,0.3  ,150     ,12   UNION ALL	--GBP	--Euro, EUR,GBP
SELECT 4359 ,'0.2'  ,'100'     ,0.2  ,100     ,12   UNION ALL	--GBP	--Euro, EUR,GBP
SELECT 4360 ,'0.5'  ,'100'     ,0.5  ,100     ,12   UNION ALL	--GBP	--Euro, EUR,GBP
SELECT 4361 ,'0.5'  ,'100'     ,0.5  ,100     ,12   UNION ALL	--GBP	--Euro, EUR,GBP
SELECT 4362 ,'0.2'  ,'100'     ,0.2  ,100     ,12   UNION ALL	--GBP	--Euro, EUR,GBP
--INH
SELECT 4354 ,'0.8'  ,'1000'    ,0.8  ,1000    ,51   UNION ALL	--INH	--INH,YNG,UUS
SELECT 4355 ,'1'    ,'1000'    ,1    ,1000    ,51   UNION ALL	--INH	--INH,YNG,UUS
SELECT 4356 ,'1'    ,'1000'    ,1    ,1000    ,51   UNION ALL	--INH	--INH,YNG,UUS
SELECT 4357 ,'1'    ,'1000'    ,1    ,1000    ,51   UNION ALL	--INH	--INH,YNG,UUS
SELECT 4358 ,'0.9'  ,'900'     ,0.9  ,900     ,51   UNION ALL	--INH	--INH,YNG,UUS
SELECT 4359 ,'1'    ,'1000'    ,1    ,1000    ,51   UNION ALL	--INH	--INH,YNG,UUS
SELECT 4360 ,'1'    ,'1000'    ,1    ,1000    ,51   UNION ALL	--INH	--INH,YNG,UUS
SELECT 4361 ,'1'    ,'1000'    ,1    ,1000    ,51   UNION ALL	--INH	--INH,YNG,UUS
SELECT 4362 ,'1'    ,'1000'    ,1    ,1000    ,51   UNION ALL	--INH	--INH,YNG,UUS
--RM,HKK, HK$,PLN,KHR
SELECT 4354 ,'0.4'  ,'500'     ,0.4  ,500     ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR
SELECT 4355 ,'0.2'  ,'500'     ,0.2  ,500     ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR
SELECT 4356 ,'0.5'  ,'500'     ,0.5  ,500     ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR
SELECT 4357 ,'0.5'  ,'500'     ,0.5  ,500     ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR
SELECT 4358 ,'0.3'  ,'450'     ,0.3  ,450     ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR
SELECT 4359 ,'0.2'  ,'500'     ,0.2  ,500     ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR
SELECT 4360 ,'0.5'  ,'500'     ,0.5  ,500     ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR
SELECT 4361 ,'0.5'  ,'500'     ,0.5  ,500     ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR
SELECT 4362 ,'0.2'  ,'500'     ,0.2  ,500     ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR
SELECT 4354 ,'0.4'  ,'500'     ,0.4  ,500     ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR
SELECT 4355 ,'0.2'  ,'500'     ,0.2  ,500     ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR
SELECT 4356 ,'0.5'  ,'500'     ,0.5  ,500     ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR
SELECT 4357 ,'0.5'  ,'500'     ,0.5  ,500     ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR
SELECT 4358 ,'0.3'  ,'450'     ,0.3  ,450     ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR
SELECT 4359 ,'0.2'  ,'500'     ,0.2  ,500     ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR
SELECT 4360 ,'0.5'  ,'500'     ,0.5  ,500     ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR
SELECT 4361 ,'0.5'  ,'500'     ,0.5  ,500     ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR
SELECT 4362 ,'0.2'  ,'500'     ,0.2  ,500     ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR
SELECT 4354 ,'0.4'  ,'500'     ,0.4  ,500     ,56   UNION ALL	--PLN	--RM,HKK,HK$,PLN,KHR
SELECT 4355 ,'0.2'  ,'500'     ,0.2  ,500     ,56   UNION ALL	--PLN	--RM,HKK,HK$,PLN,KHR
SELECT 4356 ,'0.5'  ,'500'     ,0.5  ,500     ,56   UNION ALL	--PLN	--RM,HKK,HK$,PLN,KHR
SELECT 4357 ,'0.5'  ,'500'     ,0.5  ,500     ,56   UNION ALL	--PLN	--RM,HKK,HK$,PLN,KHR
SELECT 4358 ,'0.3'  ,'450'     ,0.3  ,450     ,56   UNION ALL	--PLN	--RM,HKK,HK$,PLN,KHR
SELECT 4359 ,'0.2'  ,'500'     ,0.2  ,500     ,56   UNION ALL	--PLN	--RM,HKK,HK$,PLN,KHR
SELECT 4360 ,'0.5'  ,'500'     ,0.5  ,500     ,56   UNION ALL	--PLN	--RM,HKK,HK$,PLN,KHR
SELECT 4361 ,'0.5'  ,'500'     ,0.5  ,500     ,56   UNION ALL	--PLN	--RM,HKK,HK$,PLN,KHR
SELECT 4362 ,'0.2'  ,'500'     ,0.2  ,500     ,56   UNION ALL	--PLN	--RM,HKK,HK$,PLN,KHR
SELECT 4354 ,'0.4'  ,'500'     ,0.4  ,500     ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR
SELECT 4355 ,'0.2'  ,'500'     ,0.2  ,500     ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR
SELECT 4356 ,'0.5'  ,'500'     ,0.5  ,500     ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR
SELECT 4357 ,'0.5'  ,'500'     ,0.5  ,500     ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR
SELECT 4358 ,'0.3'  ,'450'     ,0.3  ,450     ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR
SELECT 4359 ,'0.2'  ,'500'     ,0.2  ,500     ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR
SELECT 4360 ,'0.5'  ,'500'     ,0.5  ,500     ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR
SELECT 4361 ,'0.5'  ,'500'     ,0.5  ,500     ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR
SELECT 4362 ,'0.2'  ,'500'     ,0.2  ,500     ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR
--RMB, CY, YUN,NOK,SEK
SELECT 4354 ,'0.4'  ,'1000'    ,0.4  ,1000    ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4355 ,'0.2'  ,'1000'    ,0.2  ,1000    ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4356 ,'0.5'  ,'1000'    ,0.5  ,1000    ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4357 ,'0.5'  ,'1000'    ,0.5  ,1000    ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4358 ,'0.3'  ,'900'     ,0.3  ,900     ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4359 ,'0.2'  ,'1000'    ,0.2  ,1000    ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4360 ,'0.5'  ,'1000'    ,0.5  ,1000    ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4361 ,'0.5'  ,'1000'    ,0.5  ,1000    ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4362 ,'0.2'  ,'1000'    ,0.2  ,1000    ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4354 ,'0.4'  ,'1000'    ,0.4  ,1000    ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4355 ,'0.2'  ,'1000'    ,0.2  ,1000    ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4356 ,'0.5'  ,'1000'    ,0.5  ,1000    ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4357 ,'0.5'  ,'1000'    ,0.5  ,1000    ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4358 ,'0.3'  ,'900'     ,0.3  ,900     ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4359 ,'0.2'  ,'1000'    ,0.2  ,1000    ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4360 ,'0.5'  ,'1000'    ,0.5  ,1000    ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4361 ,'0.5'  ,'1000'    ,0.5  ,1000    ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4362 ,'0.2'  ,'1000'    ,0.2  ,1000    ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4354 ,'0.4'  ,'1000'    ,0.4  ,1000    ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4355 ,'0.2'  ,'1000'    ,0.2  ,1000    ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4356 ,'0.5'  ,'1000'    ,0.5  ,1000    ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4357 ,'0.5'  ,'1000'    ,0.5  ,1000    ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4358 ,'0.3'  ,'900'     ,0.3  ,900     ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4359 ,'0.2'  ,'1000'    ,0.2  ,1000    ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4360 ,'0.5'  ,'1000'    ,0.5  ,1000    ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4361 ,'0.5'  ,'1000'    ,0.5  ,1000    ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4362 ,'0.2'  ,'1000'    ,0.2  ,1000    ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4354 ,'0.4'  ,'1000'    ,0.4  ,1000    ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4355 ,'0.2'  ,'1000'    ,0.2  ,1000    ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4356 ,'0.5'  ,'1000'    ,0.5  ,1000    ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4357 ,'0.5'  ,'1000'    ,0.5  ,1000    ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4358 ,'0.3'  ,'900'     ,0.3  ,900     ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4359 ,'0.2'  ,'1000'    ,0.2  ,1000    ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4360 ,'0.5'  ,'1000'    ,0.5  ,1000    ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4361 ,'0.5'  ,'1000'    ,0.5  ,1000    ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4362 ,'0.2'  ,'1000'    ,0.2  ,1000    ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
--RUB,INR,JPY
SELECT 4354 ,'20'   ,'10000'   ,20   ,10000   ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4355 ,'20'   ,'15000'   ,20   ,15000   ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4356 ,'20'   ,'12500'   ,20   ,12500   ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4357 ,'25'   ,'12500'   ,25   ,12500   ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4358 ,'30'   ,'15000'   ,30   ,15000   ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4359 ,'20'   ,'15000'   ,20   ,15000   ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4360 ,'25'   ,'12500'   ,25   ,12500   ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4361 ,'25'   ,'12500'   ,25   ,12500   ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4362 ,'20'   ,'15000'   ,20   ,15000   ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4354 ,'20'   ,'10000'   ,20   ,10000   ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4355 ,'20'   ,'15000'   ,20   ,15000   ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4356 ,'20'   ,'12500'   ,20   ,12500   ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4357 ,'25'   ,'12500'   ,25   ,12500   ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4358 ,'30'   ,'15000'   ,30   ,15000   ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4359 ,'20'   ,'15000'   ,20   ,15000   ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4360 ,'25'   ,'12500'   ,25   ,12500   ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4361 ,'25'   ,'12500'   ,25   ,12500   ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4362 ,'20'   ,'15000'   ,20   ,15000   ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4354 ,'20'   ,'10000'   ,20   ,10000   ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4355 ,'20'   ,'15000'   ,20   ,15000   ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4356 ,'20'   ,'12500'   ,20   ,12500   ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4357 ,'25'   ,'12500'   ,25   ,12500   ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4358 ,'30'   ,'15000'   ,30   ,15000   ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4359 ,'20'   ,'15000'   ,20   ,15000   ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4360 ,'25'   ,'12500'   ,25   ,12500   ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4361 ,'25'   ,'12500'   ,25   ,12500   ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4362 ,'20'   ,'15000'   ,20   ,15000   ,55   UNION ALL	--RUB	--RUB,INR,JPY
--THB, TB
SELECT 4354 ,'4'    ,'5000'    ,4    ,5000    ,4    UNION ALL	--TB	--THB, TB
SELECT 4355 ,'2'    ,'5000'    ,2    ,5000    ,4    UNION ALL	--TB	--THB, TB
SELECT 4356 ,'5'    ,'5000'    ,5    ,5000    ,4    UNION ALL	--TB	--THB, TB
SELECT 4357 ,'5'    ,'5000'    ,5    ,5000    ,4    UNION ALL	--TB	--THB, TB
SELECT 4358 ,'3'    ,'4500'    ,3    ,4500    ,4    UNION ALL	--TB	--THB, TB
SELECT 4359 ,'2'    ,'5000'    ,2    ,5000    ,4    UNION ALL	--TB	--THB, TB
SELECT 4360 ,'5'    ,'5000'    ,5    ,5000    ,4    UNION ALL	--TB	--THB, TB
SELECT 4361 ,'5'    ,'5000'    ,5    ,5000    ,4    UNION ALL	--TB	--THB, TB
SELECT 4362 ,'2'    ,'5000'    ,2    ,5000    ,4    UNION ALL	--TB	--THB, TB
--Won
SELECT 4354 ,'40'   ,'50000'   ,40   ,50000   ,45   UNION ALL	--Won	--Won
SELECT 4355 ,'40'   ,'50000'   ,40   ,50000   ,45   UNION ALL	--Won	--Won
SELECT 4356 ,'50'   ,'50000'   ,50   ,50000   ,45   UNION ALL	--Won	--Won
SELECT 4357 ,'50'   ,'50000'   ,50   ,50000   ,45   UNION ALL	--Won	--Won
SELECT 4358 ,'30'   ,'45000'   ,30   ,45000   ,45   UNION ALL	--Won	--Won
SELECT 4359 ,'40'   ,'50000'   ,40   ,50000   ,45   UNION ALL	--Won	--Won
SELECT 4360 ,'50'   ,'50000'   ,50   ,50000   ,45   UNION ALL	--Won	--Won
SELECT 4361 ,'50'   ,'50000'   ,50   ,50000   ,45   UNION ALL	--Won	--Won
SELECT 4362 ,'40'   ,'50000'   ,40   ,50000   ,45   UNION ALL	--Won	--Won
--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK
SELECT 4354 ,'0.4'  ,'100'     ,0.4  ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4355 ,'0.2'  ,'100'     ,0.2  ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4356 ,'0.05' ,'100'     ,0.05 ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4357 ,'0.5'  ,'100'     ,0.5  ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4358 ,'0.3'  ,'150'     ,0.3  ,150     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4359 ,'0.2'  ,'100'     ,0.2  ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4360 ,'0.5'  ,'100'     ,0.5  ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4361 ,'0.5'  ,'100'     ,0.5  ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4362 ,'0.2'  ,'100'     ,0.2  ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4354 ,'0.4'  ,'100'     ,0.4  ,100     ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4355 ,'0.2'  ,'100'     ,0.2  ,100     ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4356 ,'0.05' ,'100'     ,0.05 ,100     ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4357 ,'0.5'  ,'100'     ,0.5  ,100     ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4358 ,'0.3'  ,'150'     ,0.3  ,150     ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4359 ,'0.2'  ,'100'     ,0.2  ,100     ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4360 ,'0.5'  ,'100'     ,0.5  ,100     ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4361 ,'0.5'  ,'100'     ,0.5  ,100     ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4362 ,'0.2'  ,'100'     ,0.2  ,100     ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4354 ,'0.4'  ,'100'     ,0.4  ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4355 ,'0.2'  ,'100'     ,0.2  ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4356 ,'0.05' ,'100'     ,0.05 ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4357 ,'0.5'  ,'100'     ,0.5  ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4358 ,'0.3'  ,'150'     ,0.3  ,150     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4359 ,'0.2'  ,'100'     ,0.2  ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4360 ,'0.5'  ,'100'     ,0.5  ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4361 ,'0.5'  ,'100'     ,0.5  ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4362 ,'0.2'  ,'100'     ,0.2  ,100     ,3				--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999		

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 4301)

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
