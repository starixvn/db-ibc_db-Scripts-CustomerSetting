/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20211110
	Created: Winfred 
	Task: #164090 - Spadegaming - 10 new games 2021 - Credit  RedmineID:#164090
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(12))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--DDD, IND, IDR, IDD, IN
SELECT 4363 ,'0.2'  ,'1000'    ,0.2  ,1000    ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4364 ,'0.5'  ,'1000'    ,0.5  ,1000    ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4365 ,'0.5'  ,'1000'    ,0.5  ,1000    ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4366 ,'1'    ,'1000'    ,1    ,1000    ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4367 ,'0.5'  ,'1000'    ,0.5  ,1000    ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4368 ,'0.8'  ,'1000'    ,0.8  ,1000    ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4369 ,'0.2'  ,'1000'    ,0.2  ,1000    ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4370 ,'0.2'  ,'1000'    ,0.2  ,1000    ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4371 ,'0.5'  ,'1000'    ,0.5  ,1000    ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4372 ,'0.5'  ,'1000'    ,0.5  ,1000    ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4363 ,'0.2'  ,'1000'    ,0.2  ,1000    ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4364 ,'0.5'  ,'1000'    ,0.5  ,1000    ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4365 ,'0.5'  ,'1000'    ,0.5  ,1000    ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4366 ,'1'    ,'1000'    ,1    ,1000    ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4367 ,'0.5'  ,'1000'    ,0.5  ,1000    ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4368 ,'0.8'  ,'1000'    ,0.8  ,1000    ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4369 ,'0.2'  ,'1000'    ,0.2  ,1000    ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4370 ,'0.2'  ,'1000'    ,0.2  ,1000    ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4371 ,'0.5'  ,'1000'    ,0.5  ,1000    ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4372 ,'0.5'  ,'1000'    ,0.5  ,1000    ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4363 ,'0.2'  ,'1000'    ,0.2  ,1000    ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4364 ,'0.5'  ,'1000'    ,0.5  ,1000    ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4365 ,'0.5'  ,'1000'    ,0.5  ,1000    ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4366 ,'1'    ,'1000'    ,1    ,1000    ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4367 ,'0.5'  ,'1000'    ,0.5  ,1000    ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4368 ,'0.8'  ,'1000'    ,0.8  ,1000    ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4369 ,'0.2'  ,'1000'    ,0.2  ,1000    ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4370 ,'0.2'  ,'1000'    ,0.2  ,1000    ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4371 ,'0.5'  ,'1000'    ,0.5  ,1000    ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4372 ,'0.5'  ,'1000'    ,0.5  ,1000    ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4363 ,'0.2'  ,'1000'    ,0.2  ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4364 ,'0.5'  ,'1000'    ,0.5  ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4365 ,'0.5'  ,'1000'    ,0.5  ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4366 ,'1'    ,'1000'    ,1    ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4367 ,'0.5'  ,'1000'    ,0.5  ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4368 ,'0.8'  ,'1000'    ,0.8  ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4369 ,'0.2'  ,'1000'    ,0.2  ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4370 ,'0.2'  ,'1000'    ,0.2  ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4371 ,'0.5'  ,'1000'    ,0.5  ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4372 ,'0.5'  ,'1000'    ,0.5  ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4363 ,'0.2'  ,'1000'    ,0.2  ,1000    ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4364 ,'0.5'  ,'1000'    ,0.5  ,1000    ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4365 ,'0.5'  ,'1000'    ,0.5  ,1000    ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4366 ,'1'    ,'1000'    ,1    ,1000    ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4367 ,'0.5'  ,'1000'    ,0.5  ,1000    ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4368 ,'0.8'  ,'1000'    ,0.8  ,1000    ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4369 ,'0.2'  ,'1000'    ,0.2  ,1000    ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4370 ,'0.2'  ,'1000'    ,0.2  ,1000    ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4371 ,'0.5'  ,'1000'    ,0.5  ,1000    ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4372 ,'0.5'  ,'1000'    ,0.5  ,1000    ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
--Euro, EUR,GBP
SELECT 4363 ,'0.2'  ,'100'     ,0.2  ,100     ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4364 ,'0.05' ,'100'     ,0.05 ,100     ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4365 ,'0.05' ,'100'     ,0.05 ,100     ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4366 ,'1'    ,'100'     ,1    ,100     ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4367 ,'0.05' ,'100'     ,0.05 ,100     ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4368 ,'0.4'  ,'100'     ,0.4  ,100     ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4369 ,'0.2'  ,'100'     ,0.2  ,100     ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4370 ,'0.2'  ,'100'     ,0.2  ,100     ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4371 ,'0.5'  ,'100'     ,0.5  ,100     ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4372 ,'0.5'  ,'100'     ,0.5  ,100     ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4363 ,'0.2'  ,'100'     ,0.2  ,100     ,12   UNION ALL	--GBP	--Euro, EUR,GBP
SELECT 4364 ,'0.05' ,'100'     ,0.05 ,100     ,12   UNION ALL	--GBP	--Euro, EUR,GBP
SELECT 4365 ,'0.05' ,'100'     ,0.05 ,100     ,12   UNION ALL	--GBP	--Euro, EUR,GBP
SELECT 4366 ,'1'    ,'100'     ,1    ,100     ,12   UNION ALL	--GBP	--Euro, EUR,GBP
SELECT 4367 ,'0.05' ,'100'     ,0.05 ,100     ,12   UNION ALL	--GBP	--Euro, EUR,GBP
SELECT 4368 ,'0.4'  ,'100'     ,0.4  ,100     ,12   UNION ALL	--GBP	--Euro, EUR,GBP
SELECT 4369 ,'0.2'  ,'100'     ,0.2  ,100     ,12   UNION ALL	--GBP	--Euro, EUR,GBP
SELECT 4370 ,'0.2'  ,'100'     ,0.2  ,100     ,12   UNION ALL	--GBP	--Euro, EUR,GBP
SELECT 4371 ,'0.5'  ,'100'     ,0.5  ,100     ,12   UNION ALL	--GBP	--Euro, EUR,GBP
SELECT 4372 ,'0.5'  ,'100'     ,0.5  ,100     ,12   UNION ALL	--GBP	--Euro, EUR,GBP
--INH
SELECT 4363 ,'1'    ,'1000'    ,1    ,1000    ,51   UNION ALL	--INH	--INH,YNG,UUS
SELECT 4364 ,'1'    ,'1000'    ,1    ,1000    ,51   UNION ALL	--INH	--INH,YNG,UUS
SELECT 4365 ,'1'    ,'1000'    ,1    ,1000    ,51   UNION ALL	--INH	--INH,YNG,UUS
SELECT 4366 ,'1'    ,'1000'    ,1    ,1000    ,51   UNION ALL	--INH	--INH,YNG,UUS
SELECT 4367 ,'1'    ,'1000'    ,1    ,1000    ,51   UNION ALL	--INH	--INH,YNG,UUS
SELECT 4368 ,'0.8'  ,'1000'    ,0.8  ,1000    ,51   UNION ALL	--INH	--INH,YNG,UUS
SELECT 4369 ,'1'    ,'1000'    ,1    ,1000    ,51   UNION ALL	--INH	--INH,YNG,UUS
SELECT 4370 ,'1'    ,'1000'    ,1    ,1000    ,51   UNION ALL	--INH	--INH,YNG,UUS
SELECT 4371 ,'1'    ,'1000'    ,1    ,1000    ,51   UNION ALL	--INH	--INH,YNG,UUS
SELECT 4372 ,'1'    ,'1000'    ,1    ,1000    ,51   UNION ALL	--INH	--INH,YNG,UUS
--RM,HKK, HK$,PLN,KHR
SELECT 4363 ,'0.2'  ,'500'     ,0.2  ,500     ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR
SELECT 4364 ,'0.5'  ,'500'     ,0.5  ,500     ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR
SELECT 4365 ,'0.5'  ,'500'     ,0.5  ,500     ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR
SELECT 4366 ,'1'    ,'500'     ,1    ,500     ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR
SELECT 4367 ,'0.5'  ,'500'     ,0.5  ,500     ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR
SELECT 4368 ,'0.4'  ,'500'     ,0.4  ,500     ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR
SELECT 4369 ,'0.2'  ,'500'     ,0.2  ,500     ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR
SELECT 4370 ,'0.2'  ,'500'     ,0.2  ,500     ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR
SELECT 4371 ,'0.5'  ,'500'     ,0.5  ,500     ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR
SELECT 4372 ,'0.5'  ,'500'     ,0.5  ,500     ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR
SELECT 4363 ,'0.2'  ,'500'     ,0.2  ,500     ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR
SELECT 4364 ,'0.5'  ,'500'     ,0.5  ,500     ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR
SELECT 4365 ,'0.5'  ,'500'     ,0.5  ,500     ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR
SELECT 4366 ,'1'    ,'500'     ,1    ,500     ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR
SELECT 4367 ,'0.5'  ,'500'     ,0.5  ,500     ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR
SELECT 4368 ,'0.4'  ,'500'     ,0.4  ,500     ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR
SELECT 4369 ,'0.2'  ,'500'     ,0.2  ,500     ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR
SELECT 4370 ,'0.2'  ,'500'     ,0.2  ,500     ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR
SELECT 4371 ,'0.5'  ,'500'     ,0.5  ,500     ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR
SELECT 4372 ,'0.5'  ,'500'     ,0.5  ,500     ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR
SELECT 4363 ,'0.2'  ,'500'     ,0.2  ,500     ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR
SELECT 4364 ,'0.5'  ,'500'     ,0.5  ,500     ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR
SELECT 4365 ,'0.5'  ,'500'     ,0.5  ,500     ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR
SELECT 4366 ,'1'    ,'500'     ,1    ,500     ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR
SELECT 4367 ,'0.5'  ,'500'     ,0.5  ,500     ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR
SELECT 4368 ,'0.4'  ,'500'     ,0.4  ,500     ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR
SELECT 4369 ,'0.2'  ,'500'     ,0.2  ,500     ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR
SELECT 4370 ,'0.2'  ,'500'     ,0.2  ,500     ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR
SELECT 4371 ,'0.5'  ,'500'     ,0.5  ,500     ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR
SELECT 4372 ,'0.5'  ,'500'     ,0.5  ,500     ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR
--RMB, CY, YUN,NOK,SEK
SELECT 4363 ,'0.2'  ,'1000'    ,0.2  ,1000    ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4364 ,'0.5'  ,'1000'    ,0.5  ,1000    ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4365 ,'0.5'  ,'1000'    ,0.5  ,1000    ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4366 ,'1'    ,'1000'    ,1    ,1000    ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4367 ,'0.5'  ,'1000'    ,0.5  ,1000    ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4368 ,'0.4'  ,'1000'    ,0.4  ,1000    ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4369 ,'0.2'  ,'1000'    ,0.2  ,1000    ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4370 ,'0.2'  ,'1000'    ,0.2  ,1000    ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4371 ,'1'    ,'1000'    ,1    ,1000    ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4372 ,'1'    ,'1000'    ,1    ,1000    ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4363 ,'0.2'  ,'1000'    ,0.2  ,1000    ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4364 ,'0.5'  ,'1000'    ,0.5  ,1000    ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4365 ,'0.5'  ,'1000'    ,0.5  ,1000    ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4366 ,'1'    ,'1000'    ,1    ,1000    ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4367 ,'0.5'  ,'1000'    ,0.5  ,1000    ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4368 ,'0.4'  ,'1000'    ,0.4  ,1000    ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4369 ,'0.2'  ,'1000'    ,0.2  ,1000    ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4370 ,'0.2'  ,'1000'    ,0.2  ,1000    ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4371 ,'1'    ,'1000'    ,1    ,1000    ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4372 ,'1'    ,'1000'    ,1    ,1000    ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4363 ,'0.2'  ,'1000'    ,0.2  ,1000    ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4364 ,'0.5'  ,'1000'    ,0.5  ,1000    ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4365 ,'0.5'  ,'1000'    ,0.5  ,1000    ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4366 ,'1'    ,'1000'    ,1    ,1000    ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4367 ,'0.5'  ,'1000'    ,0.5  ,1000    ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4368 ,'0.4'  ,'1000'    ,0.4  ,1000    ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4369 ,'0.2'  ,'1000'    ,0.2  ,1000    ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4370 ,'0.2'  ,'1000'    ,0.2  ,1000    ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4371 ,'1'    ,'1000'    ,1    ,1000    ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4372 ,'1'    ,'1000'    ,1    ,1000    ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4363 ,'0.2'  ,'1000'    ,0.2  ,1000    ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4364 ,'0.5'  ,'1000'    ,0.5  ,1000    ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4365 ,'0.5'  ,'1000'    ,0.5  ,1000    ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4366 ,'1'    ,'1000'    ,1    ,1000    ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4367 ,'0.5'  ,'1000'    ,0.5  ,1000    ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4368 ,'0.4'  ,'1000'    ,0.4  ,1000    ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4369 ,'0.2'  ,'1000'    ,0.2  ,1000    ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4370 ,'0.2'  ,'1000'    ,0.2  ,1000    ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4371 ,'1'    ,'1000'    ,1    ,1000    ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4372 ,'1'    ,'1000'    ,1    ,1000    ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
--THB, TB
SELECT 4363 ,'2'    ,'5000'    ,2    ,5000    ,43   UNION ALL	--THB	--THB, TB
SELECT 4364 ,'5'    ,'5000'    ,5    ,5000    ,43   UNION ALL	--THB	--THB, TB
SELECT 4365 ,'5'    ,'5000'    ,5    ,5000    ,43   UNION ALL	--THB	--THB, TB
SELECT 4366 ,'5'    ,'5000'    ,5    ,5000    ,43   UNION ALL	--THB	--THB, TB
SELECT 4367 ,'5'    ,'5000'    ,5    ,5000    ,43   UNION ALL	--THB	--THB, TB
SELECT 4368 ,'4'    ,'5000'    ,4    ,5000    ,43   UNION ALL	--THB	--THB, TB
SELECT 4369 ,'2'    ,'5000'    ,2    ,5000    ,43   UNION ALL	--THB	--THB, TB
SELECT 4370 ,'2'    ,'5000'    ,2    ,5000    ,43   UNION ALL	--THB	--THB, TB
SELECT 4371 ,'5'    ,'5000'    ,5    ,5000    ,43   UNION ALL	--THB	--THB, TB
SELECT 4372 ,'5'    ,'5000'    ,5    ,5000    ,43   UNION ALL	--THB	--THB, TB
--Won
SELECT 4363 ,'20'   ,'50000'   ,20   ,50000   ,45   UNION ALL	--Won	--Won
SELECT 4364 ,'50'   ,'50000'   ,50   ,50000   ,45   UNION ALL	--Won	--Won
SELECT 4365 ,'50'   ,'50000'   ,50   ,50000   ,45   UNION ALL	--Won	--Won
SELECT 4366 ,'20'   ,'50000'   ,20   ,50000   ,45   UNION ALL	--Won	--Won
SELECT 4367 ,'50'   ,'50000'   ,50   ,50000   ,45   UNION ALL	--Won	--Won
SELECT 4368 ,'40'   ,'50000'   ,40   ,50000   ,45   UNION ALL	--Won	--Won
SELECT 4369 ,'40'   ,'50000'   ,40   ,50000   ,45   UNION ALL	--Won	--Won
SELECT 4370 ,'40'   ,'50000'   ,40   ,50000   ,45   UNION ALL	--Won	--Won
SELECT 4371 ,'50'   ,'50000'   ,50   ,50000   ,45   UNION ALL	--Won	--Won
SELECT 4372 ,'50'   ,'50000'   ,50   ,50000   ,45   UNION ALL	--Won	--Won
--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK
SELECT 4363 ,'0.2'  ,'100'     ,0.2  ,100     ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4364 ,'0.05' ,'100'     ,0.05 ,100     ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4365 ,'0.05' ,'100'     ,0.05 ,100     ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4366 ,'1'    ,'100'     ,1    ,100     ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4367 ,'0.05' ,'100'     ,0.05 ,100     ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4368 ,'0.4'  ,'100'     ,0.4  ,100     ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4369 ,'0.2'  ,'100'     ,0.2  ,100     ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4370 ,'0.2'  ,'100'     ,0.2  ,100     ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4371 ,'0.5'  ,'100'     ,0.5  ,100     ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4372 ,'0.5'  ,'100'     ,0.5  ,100     ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4363 ,'0.2'  ,'100'     ,0.2  ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4364 ,'0.05' ,'100'     ,0.05 ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4365 ,'0.05' ,'100'     ,0.05 ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4366 ,'1'    ,'100'     ,1    ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4367 ,'0.05' ,'100'     ,0.05 ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4368 ,'0.4'  ,'100'     ,0.4  ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4369 ,'0.2'  ,'100'     ,0.2  ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4370 ,'0.2'  ,'100'     ,0.2  ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4371 ,'0.5'  ,'100'     ,0.5  ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4372 ,'0.5'  ,'100'     ,0.5  ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4363 ,'0.2'  ,'100'     ,0.2  ,100     ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4364 ,'0.05' ,'100'     ,0.05 ,100     ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4365 ,'0.05' ,'100'     ,0.05 ,100     ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4366 ,'1'    ,'100'     ,1    ,100     ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4367 ,'0.05' ,'100'     ,0.05 ,100     ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4368 ,'0.4'  ,'100'     ,0.4  ,100     ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4369 ,'0.2'  ,'100'     ,0.2  ,100     ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4370 ,'0.2'  ,'100'     ,0.2  ,100     ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4371 ,'0.5'  ,'100'     ,0.5  ,100     ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4372 ,'0.5'  ,'100'     ,0.5  ,100     ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4363 ,'0.2'  ,'100'     ,0.2  ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4364 ,'0.05' ,'100'     ,0.05 ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4365 ,'0.05' ,'100'     ,0.05 ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4366 ,'1'    ,'100'     ,1    ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4367 ,'0.05' ,'100'     ,0.05 ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4368 ,'0.4'  ,'100'     ,0.4  ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4369 ,'0.2'  ,'100'     ,0.2  ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4370 ,'0.2'  ,'100'     ,0.2  ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4371 ,'0.5'  ,'100'     ,0.5  ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4372 ,'0.5'  ,'100'     ,0.5  ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4363 ,'0.2'  ,'100'     ,0.2  ,100     ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4364 ,'0.05' ,'100'     ,0.05 ,100     ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4365 ,'0.05' ,'100'     ,0.05 ,100     ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4366 ,'1'    ,'100'     ,1    ,100     ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4367 ,'0.05' ,'100'     ,0.05 ,100     ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4368 ,'0.4'  ,'100'     ,0.4  ,100     ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4369 ,'0.2'  ,'100'     ,0.2  ,100     ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4370 ,'0.2'  ,'100'     ,0.2  ,100     ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4371 ,'0.5'  ,'100'     ,0.5  ,100     ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4372 ,'0.5'  ,'100'     ,0.5  ,100     ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4363 ,'0.2'  ,'100'     ,0.2  ,100     ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4364 ,'0.05' ,'100'     ,0.05 ,100     ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4365 ,'0.05' ,'100'     ,0.05 ,100     ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4366 ,'1'    ,'100'     ,1    ,100     ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4367 ,'0.05' ,'100'     ,0.05 ,100     ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4368 ,'0.4'  ,'100'     ,0.4  ,100     ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4369 ,'0.2'  ,'100'     ,0.2  ,100     ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4370 ,'0.2'  ,'100'     ,0.2  ,100     ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4371 ,'0.5'  ,'100'     ,0.5  ,100     ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4372 ,'0.5'  ,'100'     ,0.5  ,100     ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4363 ,'0.2'  ,'100'     ,0.2  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4364 ,'0.05' ,'100'     ,0.05 ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4365 ,'0.05' ,'100'     ,0.05 ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4366 ,'1'    ,'100'     ,1    ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4367 ,'0.05' ,'100'     ,0.05 ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4368 ,'0.4'  ,'100'     ,0.4  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4369 ,'0.2'  ,'100'     ,0.2  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4370 ,'0.2'  ,'100'     ,0.2  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4371 ,'0.5'  ,'100'     ,0.5  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4372 ,'0.5'  ,'100'     ,0.5  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4363 ,'0.2'  ,'100'     ,0.2  ,100     ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4364 ,'0.05' ,'100'     ,0.05 ,100     ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4365 ,'0.05' ,'100'     ,0.05 ,100     ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4366 ,'1'    ,'100'     ,1    ,100     ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4367 ,'0.05' ,'100'     ,0.05 ,100     ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4368 ,'0.4'  ,'100'     ,0.4  ,100     ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4369 ,'0.2'  ,'100'     ,0.2  ,100     ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4370 ,'0.2'  ,'100'     ,0.2  ,100     ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4371 ,'0.5'  ,'100'     ,0.5  ,100     ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS
SELECT 4372 ,'0.5'  ,'100'     ,0.5  ,100     ,16   			--Yen	--Yen, UT, $US, US$, USD,SD$,AUD,MMK, MKK,UUS

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
