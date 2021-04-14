/*
	Date: 20210409
	Created: Winfred 
	Task: #152755 - Spadegaming - 9 new games Mar 2021 - Credit
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(12))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--DDD, IND, IDR, IDD, IN
SELECT 4354 ,'0.4'  ,'1000'    ,0.4  ,1000    ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4355 ,'0.2'  ,'1000'    ,0.2  ,1000    ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4356 ,'0.5'  ,'1000'    ,0.5  ,1000    ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4357 ,'0.5'  ,'1000'    ,0.5  ,1000    ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4358 ,'0.3'  ,'900'     ,0.3  ,900     ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4359 ,'0.2'  ,'1000'    ,0.2  ,1000    ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4360 ,'0.5'  ,'1000'    ,0.5  ,1000    ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4361 ,'0.5'  ,'1000'    ,0.5  ,1000    ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4362 ,'0.2'  ,'1000'    ,0.2  ,1000    ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4354 ,'0.4'  ,'1000'    ,0.4  ,1000    ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4355 ,'0.2'  ,'1000'    ,0.2  ,1000    ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4356 ,'0.5'  ,'1000'    ,0.5  ,1000    ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4357 ,'0.5'  ,'1000'    ,0.5  ,1000    ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4358 ,'0.3'  ,'900'     ,0.3  ,900     ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4359 ,'0.2'  ,'1000'    ,0.2  ,1000    ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4360 ,'0.5'  ,'1000'    ,0.5  ,1000    ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4361 ,'0.5'  ,'1000'    ,0.5  ,1000    ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4362 ,'0.2'  ,'1000'    ,0.2  ,1000    ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4354 ,'0.4'  ,'1000'    ,0.4  ,1000    ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4355 ,'0.2'  ,'1000'    ,0.2  ,1000    ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4356 ,'0.5'  ,'1000'    ,0.5  ,1000    ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4357 ,'0.5'  ,'1000'    ,0.5  ,1000    ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4358 ,'0.3'  ,'900'     ,0.3  ,900     ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4359 ,'0.2'  ,'1000'    ,0.2  ,1000    ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4360 ,'0.5'  ,'1000'    ,0.5  ,1000    ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4361 ,'0.5'  ,'1000'    ,0.5  ,1000    ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4362 ,'0.2'  ,'1000'    ,0.2  ,1000    ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4354 ,'0.4'  ,'1000'    ,0.4  ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4355 ,'0.2'  ,'1000'    ,0.2  ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4356 ,'0.5'  ,'1000'    ,0.5  ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4357 ,'0.5'  ,'1000'    ,0.5  ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4358 ,'0.3'  ,'900'     ,0.3  ,900     ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4359 ,'0.2'  ,'1000'    ,0.2  ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4360 ,'0.5'  ,'1000'    ,0.5  ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4361 ,'0.5'  ,'1000'    ,0.5  ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4362 ,'0.2'  ,'1000'    ,0.2  ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4354 ,'0.4'  ,'1000'    ,0.4  ,1000    ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4355 ,'0.2'  ,'1000'    ,0.2  ,1000    ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4356 ,'0.5'  ,'1000'    ,0.5  ,1000    ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4357 ,'0.5'  ,'1000'    ,0.5  ,1000    ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4358 ,'0.3'  ,'900'     ,0.3  ,900     ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4359 ,'0.2'  ,'1000'    ,0.2  ,1000    ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4360 ,'0.5'  ,'1000'    ,0.5  ,1000    ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4361 ,'0.5'  ,'1000'    ,0.5  ,1000    ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4362 ,'0.2'  ,'1000'    ,0.2  ,1000    ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
--Euro, EUR,GBP
SELECT 4354 ,'0.4'  ,'100'     ,0.4  ,100     ,78   UNION ALL	--EUR	--Euro, EUR,GBP
SELECT 4355 ,'0.2'  ,'100'     ,0.2  ,100     ,78   UNION ALL	--EUR	--Euro, EUR,GBP
SELECT 4356 ,'0.05' ,'100'     ,0.05 ,100     ,78   UNION ALL	--EUR	--Euro, EUR,GBP
SELECT 4357 ,'0.5'  ,'100'     ,0.5  ,100     ,78   UNION ALL	--EUR	--Euro, EUR,GBP
SELECT 4358 ,'0.3'  ,'150'     ,0.3  ,150     ,78   UNION ALL	--EUR	--Euro, EUR,GBP
SELECT 4359 ,'0.2'  ,'100'     ,0.2  ,100     ,78   UNION ALL	--EUR	--Euro, EUR,GBP
SELECT 4360 ,'0.5'  ,'100'     ,0.5  ,100     ,78   UNION ALL	--EUR	--Euro, EUR,GBP
SELECT 4361 ,'0.5'  ,'100'     ,0.5  ,100     ,78   UNION ALL	--EUR	--Euro, EUR,GBP
SELECT 4362 ,'0.2'  ,'100'     ,0.2  ,100     ,78   UNION ALL	--EUR	--Euro, EUR,GBP
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
SELECT 4354 ,'0.4'  ,'500'     ,0.4  ,500     ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR
SELECT 4355 ,'0.2'  ,'500'     ,0.2  ,500     ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR
SELECT 4356 ,'0.5'  ,'500'     ,0.5  ,500     ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR
SELECT 4357 ,'0.5'  ,'500'     ,0.5  ,500     ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR
SELECT 4358 ,'0.3'  ,'450'     ,0.3  ,450     ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR
SELECT 4359 ,'0.2'  ,'500'     ,0.2  ,500     ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR
SELECT 4360 ,'0.5'  ,'500'     ,0.5  ,500     ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR
SELECT 4361 ,'0.5'  ,'500'     ,0.5  ,500     ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR
SELECT 4362 ,'0.2'  ,'500'     ,0.2  ,500     ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR
SELECT 4354 ,'0.4'  ,'500'     ,0.4  ,500     ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR
SELECT 4355 ,'0.2'  ,'500'     ,0.2  ,500     ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR
SELECT 4356 ,'0.5'  ,'500'     ,0.5  ,500     ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR
SELECT 4357 ,'0.5'  ,'500'     ,0.5  ,500     ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR
SELECT 4358 ,'0.3'  ,'450'     ,0.3  ,450     ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR
SELECT 4359 ,'0.2'  ,'500'     ,0.2  ,500     ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR
SELECT 4360 ,'0.5'  ,'500'     ,0.5  ,500     ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR
SELECT 4361 ,'0.5'  ,'500'     ,0.5  ,500     ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR
SELECT 4362 ,'0.2'  ,'500'     ,0.2  ,500     ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR
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
SELECT 4354 ,'0.4'  ,'1000'    ,0.4  ,1000    ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4355 ,'0.2'  ,'1000'    ,0.2  ,1000    ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4356 ,'0.5'  ,'1000'    ,0.5  ,1000    ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4357 ,'0.5'  ,'1000'    ,0.5  ,1000    ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4358 ,'0.3'  ,'900'     ,0.3  ,900     ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4359 ,'0.2'  ,'1000'    ,0.2  ,1000    ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4360 ,'0.5'  ,'1000'    ,0.5  ,1000    ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4361 ,'0.5'  ,'1000'    ,0.5  ,1000    ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4362 ,'0.2'  ,'1000'    ,0.2  ,1000    ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
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
--THB, TB
SELECT 4354 ,'4'    ,'5000'    ,4    ,5000    ,43   UNION ALL	--THB	--THB, TB
SELECT 4355 ,'2'    ,'5000'    ,2    ,5000    ,43   UNION ALL	--THB	--THB, TB
SELECT 4356 ,'5'    ,'5000'    ,5    ,5000    ,43   UNION ALL	--THB	--THB, TB
SELECT 4357 ,'5'    ,'5000'    ,5    ,5000    ,43   UNION ALL	--THB	--THB, TB
SELECT 4358 ,'3'    ,'4500'    ,3    ,4500    ,43   UNION ALL	--THB	--THB, TB
SELECT 4359 ,'2'    ,'5000'    ,2    ,5000    ,43   UNION ALL	--THB	--THB, TB
SELECT 4360 ,'5'    ,'5000'    ,5    ,5000    ,43   UNION ALL	--THB	--THB, TB
SELECT 4361 ,'5'    ,'5000'    ,5    ,5000    ,43   UNION ALL	--THB	--THB, TB
SELECT 4362 ,'2'    ,'5000'    ,2    ,5000    ,43   UNION ALL	--THB	--THB, TB
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
SELECT 4354 ,'0.4'  ,'100'     ,0.4  ,100     ,35   UNION ALL	--$US	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4355 ,'0.2'  ,'100'     ,0.2  ,100     ,35   UNION ALL	--$US	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4356 ,'0.05' ,'100'     ,0.05 ,100     ,35   UNION ALL	--$US	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4357 ,'0.5'  ,'100'     ,0.5  ,100     ,35   UNION ALL	--$US	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4358 ,'0.3'  ,'150'     ,0.3  ,150     ,35   UNION ALL	--$US	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4359 ,'0.2'  ,'100'     ,0.2  ,100     ,35   UNION ALL	--$US	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4360 ,'0.5'  ,'100'     ,0.5  ,100     ,35   UNION ALL	--$US	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4361 ,'0.5'  ,'100'     ,0.5  ,100     ,35   UNION ALL	--$US	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4362 ,'0.2'  ,'100'     ,0.2  ,100     ,35   UNION ALL	--$US	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4354 ,'0.4'  ,'100'     ,0.4  ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4355 ,'0.2'  ,'100'     ,0.2  ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4356 ,'0.05' ,'100'     ,0.05 ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4357 ,'0.5'  ,'100'     ,0.5  ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4358 ,'0.3'  ,'150'     ,0.3  ,150     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4359 ,'0.2'  ,'100'     ,0.2  ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4360 ,'0.5'  ,'100'     ,0.5  ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4361 ,'0.5'  ,'100'     ,0.5  ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4362 ,'0.2'  ,'100'     ,0.2  ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4354 ,'0.4'  ,'100'     ,0.4  ,100     ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4355 ,'0.2'  ,'100'     ,0.2  ,100     ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4356 ,'0.05' ,'100'     ,0.05 ,100     ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4357 ,'0.5'  ,'100'     ,0.5  ,100     ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4358 ,'0.3'  ,'150'     ,0.3  ,150     ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4359 ,'0.2'  ,'100'     ,0.2  ,100     ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4360 ,'0.5'  ,'100'     ,0.5  ,100     ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4361 ,'0.5'  ,'100'     ,0.5  ,100     ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4362 ,'0.2'  ,'100'     ,0.2  ,100     ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4354 ,'0.4'  ,'100'     ,0.4  ,100     ,1    UNION ALL	--SD$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4355 ,'0.2'  ,'100'     ,0.2  ,100     ,1    UNION ALL	--SD$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4356 ,'0.05' ,'100'     ,0.05 ,100     ,1    UNION ALL	--SD$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4357 ,'0.5'  ,'100'     ,0.5  ,100     ,1    UNION ALL	--SD$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4358 ,'0.3'  ,'150'     ,0.3  ,150     ,1    UNION ALL	--SD$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4359 ,'0.2'  ,'100'     ,0.2  ,100     ,1    UNION ALL	--SD$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4360 ,'0.5'  ,'100'     ,0.5  ,100     ,1    UNION ALL	--SD$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4361 ,'0.5'  ,'100'     ,0.5  ,100     ,1    UNION ALL	--SD$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4362 ,'0.2'  ,'100'     ,0.2  ,100     ,1    UNION ALL	--SD$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4354 ,'0.4'  ,'100'     ,0.4  ,100     ,74   UNION ALL	--TH	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4355 ,'0.2'  ,'100'     ,0.2  ,100     ,74   UNION ALL	--TH	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4356 ,'0.05' ,'100'     ,0.05 ,100     ,74   UNION ALL	--TH	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4357 ,'0.5'  ,'100'     ,0.5  ,100     ,74   UNION ALL	--TH	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4358 ,'0.3'  ,'150'     ,0.3  ,150     ,74   UNION ALL	--TH	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4359 ,'0.2'  ,'100'     ,0.2  ,100     ,74   UNION ALL	--TH	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4360 ,'0.5'  ,'100'     ,0.5  ,100     ,74   UNION ALL	--TH	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4361 ,'0.5'  ,'100'     ,0.5  ,100     ,74   UNION ALL	--TH	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4362 ,'0.2'  ,'100'     ,0.2  ,100     ,74   UNION ALL	--TH	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4354 ,'0.4'  ,'100'     ,0.4  ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4355 ,'0.2'  ,'100'     ,0.2  ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4356 ,'0.05' ,'100'     ,0.05 ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4357 ,'0.5'  ,'100'     ,0.5  ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4358 ,'0.3'  ,'150'     ,0.3  ,150     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4359 ,'0.2'  ,'100'     ,0.2  ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4360 ,'0.5'  ,'100'     ,0.5  ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4361 ,'0.5'  ,'100'     ,0.5  ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4362 ,'0.2'  ,'100'     ,0.2  ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4354 ,'0.4'  ,'100'     ,0.4  ,100     ,64   UNION ALL	--UT	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4355 ,'0.2'  ,'100'     ,0.2  ,100     ,64   UNION ALL	--UT	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4356 ,'0.05' ,'100'     ,0.05 ,100     ,64   UNION ALL	--UT	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4357 ,'0.5'  ,'100'     ,0.5  ,100     ,64   UNION ALL	--UT	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4358 ,'0.3'  ,'150'     ,0.3  ,150     ,64   UNION ALL	--UT	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4359 ,'0.2'  ,'100'     ,0.2  ,100     ,64   UNION ALL	--UT	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4360 ,'0.5'  ,'100'     ,0.5  ,100     ,64   UNION ALL	--UT	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4361 ,'0.5'  ,'100'     ,0.5  ,100     ,64   UNION ALL	--UT	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4362 ,'0.2'  ,'100'     ,0.2  ,100     ,64   UNION ALL	--UT	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4354 ,'0.4'  ,'100'     ,0.4  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4355 ,'0.2'  ,'100'     ,0.2  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4356 ,'0.05' ,'100'     ,0.05 ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4357 ,'0.5'  ,'100'     ,0.5  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4358 ,'0.3'  ,'150'     ,0.3  ,150     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4359 ,'0.2'  ,'100'     ,0.2  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4360 ,'0.5'  ,'100'     ,0.5  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4361 ,'0.5'  ,'100'     ,0.5  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4362 ,'0.2'  ,'100'     ,0.2  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4354 ,'0.4'  ,'100'     ,0.4  ,100     ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4355 ,'0.2'  ,'100'     ,0.2  ,100     ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4356 ,'0.05' ,'100'     ,0.05 ,100     ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4357 ,'0.5'  ,'100'     ,0.5  ,100     ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4358 ,'0.3'  ,'150'     ,0.3  ,150     ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4359 ,'0.2'  ,'100'     ,0.2  ,100     ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4360 ,'0.5'  ,'100'     ,0.5  ,100     ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4361 ,'0.5'  ,'100'     ,0.5  ,100     ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS
SELECT 4362 ,'0.2'  ,'100'     ,0.2  ,100     ,16				--Yen	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,UUS

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
WHERE s.GameTypeID = 4301)

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
