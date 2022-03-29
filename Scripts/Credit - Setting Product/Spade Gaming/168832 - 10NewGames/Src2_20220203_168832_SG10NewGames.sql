/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20220203
	Created: Winfred 
	Task: #168832 - Spadegaming - 10 new games 2022 - Credit  RedmineID:#168832
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId INT, GameGroupID INT DEFAULT(12))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--DDD, IND, IDR, IDD, IN
SELECT 4363 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4368 ,'0.8'     ,'100'         ,0.8     ,100         ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4372 ,'0.5'     ,'100'         ,0.5     ,100         ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4375 ,'0.5'     ,'1200'        ,0.5     ,1200        ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4376 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4377 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4378 ,'0.3'     ,'150'         ,0.3     ,150         ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4379 ,'0.5'     ,'1000'        ,0.5     ,1000        ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4380 ,'0.5'     ,'1000'        ,0.5     ,1000        ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4381 ,'0.2'     ,'1000'        ,0.2     ,1000        ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4382 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4383 ,'0.2'     ,'100'         ,0.2     ,100         ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4384 ,'0.4'     ,'125'         ,0.4     ,125         ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4363 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4368 ,'0.8'     ,'100'         ,0.8     ,100         ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4372 ,'0.5'     ,'100'         ,0.5     ,100         ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4375 ,'0.5'     ,'1200'        ,0.5     ,1200        ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4376 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4377 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4378 ,'0.3'     ,'150'         ,0.3     ,150         ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4379 ,'0.5'     ,'1000'        ,0.5     ,1000        ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4380 ,'0.5'     ,'1000'        ,0.5     ,1000        ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4381 ,'0.2'     ,'1000'        ,0.2     ,1000        ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4382 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4383 ,'0.2'     ,'100'         ,0.2     ,100         ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4384 ,'0.4'     ,'125'         ,0.4     ,125         ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4363 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4368 ,'0.8'     ,'100'         ,0.8     ,100         ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4372 ,'0.5'     ,'100'         ,0.5     ,100         ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4375 ,'0.5'     ,'1200'        ,0.5     ,1200        ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4376 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4377 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4378 ,'0.3'     ,'150'         ,0.3     ,150         ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4379 ,'0.5'     ,'1000'        ,0.5     ,1000        ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4380 ,'0.5'     ,'1000'        ,0.5     ,1000        ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4381 ,'0.2'     ,'1000'        ,0.2     ,1000        ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4382 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4383 ,'0.2'     ,'100'         ,0.2     ,100         ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4384 ,'0.4'     ,'125'         ,0.4     ,125         ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4363 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4368 ,'0.8'     ,'100'         ,0.8     ,100         ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4372 ,'0.5'     ,'100'         ,0.5     ,100         ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4375 ,'0.5'     ,'1200'        ,0.5     ,1200        ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4376 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4377 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4378 ,'0.3'     ,'150'         ,0.3     ,150         ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4379 ,'0.5'     ,'1000'        ,0.5     ,1000        ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4380 ,'0.5'     ,'1000'        ,0.5     ,1000        ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4381 ,'0.2'     ,'1000'        ,0.2     ,1000        ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4382 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4383 ,'0.2'     ,'100'         ,0.2     ,100         ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4384 ,'0.4'     ,'125'         ,0.4     ,125         ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4363 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4368 ,'0.8'     ,'100'         ,0.8     ,100         ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4372 ,'0.5'     ,'100'         ,0.5     ,100         ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4375 ,'0.5'     ,'1200'        ,0.5     ,1200        ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4376 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4377 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4378 ,'0.3'     ,'150'         ,0.3     ,150         ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4379 ,'0.5'     ,'1000'        ,0.5     ,1000        ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4380 ,'0.5'     ,'1000'        ,0.5     ,1000        ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4381 ,'0.2'     ,'1000'        ,0.2     ,1000        ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4382 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4383 ,'0.2'     ,'100'         ,0.2     ,100         ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4384 ,'0.4'     ,'125'         ,0.4     ,125         ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
--Euro, EUR,GBP
SELECT 4363 ,'0.2'     ,'50'          ,0.2     ,50          ,6    UNION ALL	--EURO	--Euro, GBP
SELECT 4368 ,'0.4'     ,'50'          ,0.4     ,50          ,6    UNION ALL	--EURO	--Euro, GBP
SELECT 4372 ,'0.5'     ,'25'          ,0.5     ,25          ,6    UNION ALL	--EURO	--Euro, GBP
SELECT 4375 ,'0.5'     ,'120'         ,0.5     ,120         ,6    UNION ALL	--EURO	--Euro, GBP
SELECT 4376 ,'0.2'     ,'50'          ,0.2     ,50          ,6    UNION ALL	--EURO	--Euro, GBP
SELECT 4377 ,'0.2'     ,'50'          ,0.2     ,50          ,6    UNION ALL	--EURO	--Euro, GBP
SELECT 4378 ,'0.3'     ,'75'          ,0.3     ,75          ,6    UNION ALL	--EURO	--Euro, GBP
SELECT 4379 ,'0.05'    ,'100'         ,0.05    ,100         ,6    UNION ALL	--EURO	--Euro, GBP
SELECT 4380 ,'0.5'     ,'100'         ,0.5     ,100         ,6    UNION ALL	--EURO	--Euro, GBP
SELECT 4381 ,'0.2'     ,'100'         ,0.2     ,100         ,6    UNION ALL	--EURO	--Euro, GBP
SELECT 4382 ,'0.2'     ,'50'          ,0.2     ,50          ,6    UNION ALL	--EURO	--Euro, GBP
SELECT 4383 ,'0.2'     ,'50'          ,0.2     ,50          ,6    UNION ALL	--EURO	--Euro, GBP
SELECT 4384 ,'0.4'     ,'25'          ,0.4     ,25          ,6    UNION ALL	--EURO	--Euro, GBP
SELECT 4363 ,'0.2'     ,'50'          ,0.2     ,50          ,12   UNION ALL	--GBP	--Euro, GBP
SELECT 4368 ,'0.4'     ,'50'          ,0.4     ,50          ,12   UNION ALL	--GBP	--Euro, GBP
SELECT 4372 ,'0.5'     ,'25'          ,0.5     ,25          ,12   UNION ALL	--GBP	--Euro, GBP
SELECT 4375 ,'0.5'     ,'120'         ,0.5     ,120         ,12   UNION ALL	--GBP	--Euro, GBP
SELECT 4376 ,'0.2'     ,'50'          ,0.2     ,50          ,12   UNION ALL	--GBP	--Euro, GBP
SELECT 4377 ,'0.2'     ,'50'          ,0.2     ,50          ,12   UNION ALL	--GBP	--Euro, GBP
SELECT 4378 ,'0.3'     ,'75'          ,0.3     ,75          ,12   UNION ALL	--GBP	--Euro, GBP
SELECT 4379 ,'0.05'    ,'100'         ,0.05    ,100         ,12   UNION ALL	--GBP	--Euro, GBP
SELECT 4380 ,'0.5'     ,'100'         ,0.5     ,100         ,12   UNION ALL	--GBP	--Euro, GBP
SELECT 4381 ,'0.2'     ,'100'         ,0.2     ,100         ,12   UNION ALL	--GBP	--Euro, GBP
SELECT 4382 ,'0.2'     ,'50'          ,0.2     ,50          ,12   UNION ALL	--GBP	--Euro, GBP
SELECT 4383 ,'0.2'     ,'50'          ,0.2     ,50          ,12   UNION ALL	--GBP	--Euro, GBP
SELECT 4384 ,'0.4'     ,'25'          ,0.4     ,25          ,12   UNION ALL	--GBP	--Euro, GBP
--INH,YNG,UUS,DON
SELECT 4363 ,'1'       ,'100'         ,1       ,100         ,51   UNION ALL	--INH	--INH,YNG,UUS,DON
SELECT 4368 ,'0.8'     ,'100'         ,0.8     ,100         ,51   UNION ALL	--INH	--INH,YNG,UUS,DON
SELECT 4372 ,'1'       ,'100'         ,1       ,100         ,51   UNION ALL	--INH	--INH,YNG,UUS,DON
SELECT 4375 ,'1'       ,'1200'        ,1       ,1200        ,51   UNION ALL	--INH	--INH,YNG,UUS,DON
SELECT 4376 ,'1'       ,'100'         ,1       ,100         ,51   UNION ALL	--INH	--INH,YNG,UUS,DON
SELECT 4377 ,'1'       ,'100'         ,1       ,100         ,51   UNION ALL	--INH	--INH,YNG,UUS,DON
SELECT 4378 ,'0.9'     ,'150'         ,0.9     ,150         ,51   UNION ALL	--INH	--INH,YNG,UUS,DON
SELECT 4379 ,'1'       ,'1000'        ,1       ,1000        ,51   UNION ALL	--INH	--INH,YNG,UUS,DON
SELECT 4380 ,'1'       ,'1000'        ,1       ,1000        ,51   UNION ALL	--INH	--INH,YNG,UUS,DON
SELECT 4381 ,'1'       ,'1000'        ,1       ,1000        ,51   UNION ALL	--INH	--INH,YNG,UUS,DON
SELECT 4382 ,'1'       ,'100'         ,1       ,100         ,51   UNION ALL	--INH	--INH,YNG,UUS,DON
SELECT 4383 ,'1'       ,'100'         ,1       ,100         ,51   UNION ALL	--INH	--INH,YNG,UUS,DON
SELECT 4384 ,'0.8'     ,'125'         ,0.8     ,125         ,51   UNION ALL	--INH	--INH,YNG,UUS,DON
--RM,HKK,HK$,PLN,KHR,HID
SELECT 4363 ,'0.2'     ,'100'         ,0.2     ,100         ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4368 ,'0.4'     ,'100'         ,0.4     ,100         ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4372 ,'0.5'     ,'100'         ,0.5     ,100         ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4375 ,'0.5'     ,'600'         ,0.5     ,600         ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4376 ,'0.2'     ,'100'         ,0.2     ,100         ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4377 ,'0.2'     ,'100'         ,0.2     ,100         ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4378 ,'0.3'     ,'150'         ,0.3     ,150         ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4379 ,'0.5'     ,'500'         ,0.5     ,500         ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4380 ,'0.5'     ,'500'         ,0.5     ,500         ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4381 ,'0.2'     ,'500'         ,0.2     ,500         ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4382 ,'0.2'     ,'100'         ,0.2     ,100         ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4383 ,'0.2'     ,'100'         ,0.2     ,100         ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4384 ,'0.4'     ,'125'         ,0.4     ,125         ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4363 ,'0.2'     ,'100'         ,0.2     ,100         ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4368 ,'0.4'     ,'100'         ,0.4     ,100         ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4372 ,'0.5'     ,'100'         ,0.5     ,100         ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4375 ,'0.5'     ,'600'         ,0.5     ,600         ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4376 ,'0.2'     ,'100'         ,0.2     ,100         ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4377 ,'0.2'     ,'100'         ,0.2     ,100         ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4378 ,'0.3'     ,'150'         ,0.3     ,150         ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4379 ,'0.5'     ,'500'         ,0.5     ,500         ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4380 ,'0.5'     ,'500'         ,0.5     ,500         ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4381 ,'0.2'     ,'500'         ,0.2     ,500         ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4382 ,'0.2'     ,'100'         ,0.2     ,100         ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4383 ,'0.2'     ,'100'         ,0.2     ,100         ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4384 ,'0.4'     ,'125'         ,0.4     ,125         ,67   UNION ALL	--HKK	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4363 ,'0.2'     ,'100'         ,0.2     ,100         ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4368 ,'0.4'     ,'100'         ,0.4     ,100         ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4372 ,'0.5'     ,'100'         ,0.5     ,100         ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4375 ,'0.5'     ,'600'         ,0.5     ,600         ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4376 ,'0.2'     ,'100'         ,0.2     ,100         ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4377 ,'0.2'     ,'100'         ,0.2     ,100         ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4378 ,'0.3'     ,'150'         ,0.3     ,150         ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4379 ,'0.5'     ,'500'         ,0.5     ,500         ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4380 ,'0.5'     ,'500'         ,0.5     ,500         ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4381 ,'0.2'     ,'500'         ,0.2     ,500         ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4382 ,'0.2'     ,'100'         ,0.2     ,100         ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4383 ,'0.2'     ,'100'         ,0.2     ,100         ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4384 ,'0.4'     ,'125'         ,0.4     ,125         ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR,HID
--RMB, CY, YUN,NOK,SEK
SELECT 4363 ,'0.2'     ,'100'         ,0.2     ,100         ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4368 ,'0.4'     ,'100'         ,0.4     ,100         ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4372 ,'1'       ,'250'         ,1       ,250         ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4375 ,'1'       ,'1200'        ,1       ,1200        ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4376 ,'0.2'     ,'100'         ,0.2     ,100         ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4377 ,'0.2'     ,'100'         ,0.2     ,100         ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4378 ,'0.3'     ,'150'         ,0.3     ,150         ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4379 ,'0.5'     ,'1000'        ,0.5     ,1000        ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4380 ,'1'       ,'1000'        ,1       ,1000        ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4381 ,'0.2'     ,'1000'        ,0.2     ,1000        ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4382 ,'0.2'     ,'100'         ,0.2     ,100         ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4383 ,'0.2'     ,'100'         ,0.2     ,100         ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4384 ,'0.4'     ,'250'         ,0.4     ,250         ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4363 ,'0.2'     ,'100'         ,0.2     ,100         ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4368 ,'0.4'     ,'100'         ,0.4     ,100         ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4372 ,'1'       ,'250'         ,1       ,250         ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4375 ,'1'       ,'1200'        ,1       ,1200        ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4376 ,'0.2'     ,'100'         ,0.2     ,100         ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4377 ,'0.2'     ,'100'         ,0.2     ,100         ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4378 ,'0.3'     ,'150'         ,0.3     ,150         ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4379 ,'0.5'     ,'1000'        ,0.5     ,1000        ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4380 ,'1'       ,'1000'        ,1       ,1000        ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4381 ,'0.2'     ,'1000'        ,0.2     ,1000        ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4382 ,'0.2'     ,'100'         ,0.2     ,100         ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4383 ,'0.2'     ,'100'         ,0.2     ,100         ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4384 ,'0.4'     ,'250'         ,0.4     ,250         ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4363 ,'0.2'     ,'100'         ,0.2     ,100         ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4368 ,'0.4'     ,'100'         ,0.4     ,100         ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4372 ,'1'       ,'250'         ,1       ,250         ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4375 ,'1'       ,'1200'        ,1       ,1200        ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4376 ,'0.2'     ,'100'         ,0.2     ,100         ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4377 ,'0.2'     ,'100'         ,0.2     ,100         ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4378 ,'0.3'     ,'150'         ,0.3     ,150         ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4379 ,'0.5'     ,'1000'        ,0.5     ,1000        ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4380 ,'1'       ,'1000'        ,1       ,1000        ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4381 ,'0.2'     ,'1000'        ,0.2     ,1000        ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4382 ,'0.2'     ,'100'         ,0.2     ,100         ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4383 ,'0.2'     ,'100'         ,0.2     ,100         ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4384 ,'0.4'     ,'250'         ,0.4     ,250         ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4363 ,'0.2'     ,'100'         ,0.2     ,100         ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4368 ,'0.4'     ,'100'         ,0.4     ,100         ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4372 ,'1'       ,'250'         ,1       ,250         ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4375 ,'1'       ,'1200'        ,1       ,1200        ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4376 ,'0.2'     ,'100'         ,0.2     ,100         ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4377 ,'0.2'     ,'100'         ,0.2     ,100         ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4378 ,'0.3'     ,'150'         ,0.3     ,150         ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4379 ,'0.5'     ,'1000'        ,0.5     ,1000        ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4380 ,'1'       ,'1000'        ,1       ,1000        ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4381 ,'0.2'     ,'1000'        ,0.2     ,1000        ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4382 ,'0.2'     ,'100'         ,0.2     ,100         ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4383 ,'0.2'     ,'100'         ,0.2     ,100         ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4384 ,'0.4'     ,'250'         ,0.4     ,250         ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
--THB, TB
SELECT 4363 ,'2'       ,'500'         ,2       ,500         ,43   UNION ALL	--THB	--THB, TB
SELECT 4368 ,'4'       ,'1000'        ,4       ,1000        ,43   UNION ALL	--THB	--THB, TB
SELECT 4372 ,'5'       ,'1000'        ,5       ,1000        ,43   UNION ALL	--THB	--THB, TB
SELECT 4375 ,'5'       ,'6000'        ,5       ,6000        ,43   UNION ALL	--THB	--THB, TB
SELECT 4376 ,'4'       ,'300'         ,4       ,300         ,43   UNION ALL	--THB	--THB, TB
SELECT 4377 ,'4'       ,'300'         ,4       ,300         ,43   UNION ALL	--THB	--THB, TB
SELECT 4378 ,'3'       ,'1500'        ,3       ,1500        ,43   UNION ALL	--THB	--THB, TB
SELECT 4379 ,'5'       ,'5000'        ,5       ,5000        ,43   UNION ALL	--THB	--THB, TB
SELECT 4380 ,'5'       ,'5000'        ,5       ,5000        ,43   UNION ALL	--THB	--THB, TB
SELECT 4381 ,'2'       ,'5000'        ,2       ,5000        ,43   UNION ALL	--THB	--THB, TB
SELECT 4382 ,'2'       ,'500'         ,2       ,500         ,43   UNION ALL	--THB	--THB, TB
SELECT 4383 ,'4'       ,'300'         ,4       ,300         ,43   UNION ALL	--THB	--THB, TB
SELECT 4384 ,'4'       ,'1250'        ,4       ,1250        ,43   UNION ALL	--THB	--THB, TB
--Won
SELECT 4363 ,'20'      ,'10000'       ,20      ,10000       ,45   UNION ALL	--Won	--Won
SELECT 4368 ,'40'      ,'10000'       ,40      ,10000       ,45   UNION ALL	--Won	--Won
SELECT 4372 ,'50'      ,'10000'       ,50      ,10000       ,45   UNION ALL	--Won	--Won
SELECT 4375 ,'50'      ,'60000'       ,50      ,60000       ,45   UNION ALL	--Won	--Won
SELECT 4376 ,'40'      ,'10000'       ,40      ,10000       ,45   UNION ALL	--Won	--Won
SELECT 4377 ,'40'      ,'10000'       ,40      ,10000       ,45   UNION ALL	--Won	--Won
SELECT 4378 ,'30'      ,'15000'       ,30      ,15000       ,45   UNION ALL	--Won	--Won
SELECT 4379 ,'50'      ,'50000'       ,50      ,50000       ,45   UNION ALL	--Won	--Won
SELECT 4380 ,'50'      ,'50000'       ,50      ,50000       ,45   UNION ALL	--Won	--Won
SELECT 4381 ,'20'      ,'50000'       ,20      ,50000       ,45   UNION ALL	--Won	--Won
SELECT 4382 ,'40'      ,'10000'       ,40      ,10000       ,45   UNION ALL	--Won	--Won
SELECT 4383 ,'40'      ,'10000'       ,40      ,10000       ,45   UNION ALL	--Won	--Won
SELECT 4384 ,'40'      ,'10000'       ,40      ,10000       ,45   UNION ALL	--Won	--Won
--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4363 ,'0.2'     ,'50'          ,0.2     ,50          ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4368 ,'0.4'     ,'50'          ,0.4     ,50          ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4372 ,'0.5'     ,'25'          ,0.5     ,25          ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4375 ,'0.5'     ,'120'         ,0.5     ,120         ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4376 ,'0.2'     ,'50'          ,0.2     ,50          ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4377 ,'0.2'     ,'50'          ,0.2     ,50          ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4378 ,'0.3'     ,'75'          ,0.3     ,75          ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4379 ,'0.05'    ,'100'         ,0.05    ,100         ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4380 ,'0.5'     ,'100'         ,0.5     ,100         ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4381 ,'0.2'     ,'100'         ,0.2     ,100         ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4382 ,'0.2'     ,'50'          ,0.2     ,50          ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4383 ,'0.2'     ,'50'          ,0.2     ,50          ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4384 ,'0.4'     ,'25'          ,0.4     ,25          ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4363 ,'0.2'     ,'50'          ,0.2     ,50          ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4368 ,'0.4'     ,'50'          ,0.4     ,50          ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4372 ,'0.5'     ,'25'          ,0.5     ,25          ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4375 ,'0.5'     ,'120'         ,0.5     ,120         ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4376 ,'0.2'     ,'50'          ,0.2     ,50          ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4377 ,'0.2'     ,'50'          ,0.2     ,50          ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4378 ,'0.3'     ,'75'          ,0.3     ,75          ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4379 ,'0.05'    ,'100'         ,0.05    ,100         ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4380 ,'0.5'     ,'100'         ,0.5     ,100         ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4381 ,'0.2'     ,'100'         ,0.2     ,100         ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4382 ,'0.2'     ,'50'          ,0.2     ,50          ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4383 ,'0.2'     ,'50'          ,0.2     ,50          ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4384 ,'0.4'     ,'25'          ,0.4     ,25          ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4363 ,'0.2'     ,'50'          ,0.2     ,50          ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4368 ,'0.4'     ,'50'          ,0.4     ,50          ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4372 ,'0.5'     ,'25'          ,0.5     ,25          ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4375 ,'0.5'     ,'120'         ,0.5     ,120         ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4376 ,'0.2'     ,'50'          ,0.2     ,50          ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4377 ,'0.2'     ,'50'          ,0.2     ,50          ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4378 ,'0.3'     ,'75'          ,0.3     ,75          ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4379 ,'0.05'    ,'100'         ,0.05    ,100         ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4380 ,'0.5'     ,'100'         ,0.5     ,100         ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4381 ,'0.2'     ,'100'         ,0.2     ,100         ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4382 ,'0.2'     ,'50'          ,0.2     ,50          ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4383 ,'0.2'     ,'50'          ,0.2     ,50          ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4384 ,'0.4'     ,'25'          ,0.4     ,25          ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4363 ,'0.2'     ,'50'          ,0.2     ,50          ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4368 ,'0.4'     ,'50'          ,0.4     ,50          ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4372 ,'0.5'     ,'25'          ,0.5     ,25          ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4375 ,'0.5'     ,'120'         ,0.5     ,120         ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4376 ,'0.2'     ,'50'          ,0.2     ,50          ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4377 ,'0.2'     ,'50'          ,0.2     ,50          ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4378 ,'0.3'     ,'75'          ,0.3     ,75          ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4379 ,'0.05'    ,'100'         ,0.05    ,100         ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4380 ,'0.5'     ,'100'         ,0.5     ,100         ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4381 ,'0.2'     ,'100'         ,0.2     ,100         ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4382 ,'0.2'     ,'50'          ,0.2     ,50          ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4383 ,'0.2'     ,'50'          ,0.2     ,50          ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4384 ,'0.4'     ,'25'          ,0.4     ,25          ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4363 ,'0.2'     ,'50'          ,0.2     ,50          ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4368 ,'0.4'     ,'50'          ,0.4     ,50          ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4372 ,'0.5'     ,'25'          ,0.5     ,25          ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4375 ,'0.5'     ,'120'         ,0.5     ,120         ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4376 ,'0.2'     ,'50'          ,0.2     ,50          ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4377 ,'0.2'     ,'50'          ,0.2     ,50          ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4378 ,'0.3'     ,'75'          ,0.3     ,75          ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4379 ,'0.05'    ,'100'         ,0.05    ,100         ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4380 ,'0.5'     ,'100'         ,0.5     ,100         ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4381 ,'0.2'     ,'100'         ,0.2     ,100         ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4382 ,'0.2'     ,'50'          ,0.2     ,50          ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4383 ,'0.2'     ,'50'          ,0.2     ,50          ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4384 ,'0.4'     ,'25'          ,0.4     ,25          ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4363 ,'0.2'     ,'50'          ,0.2     ,50          ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4368 ,'0.4'     ,'50'          ,0.4     ,50          ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4372 ,'0.5'     ,'25'          ,0.5     ,25          ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4375 ,'0.5'     ,'120'         ,0.5     ,120         ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4376 ,'0.2'     ,'50'          ,0.2     ,50          ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4377 ,'0.2'     ,'50'          ,0.2     ,50          ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4378 ,'0.3'     ,'75'          ,0.3     ,75          ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4379 ,'0.05'    ,'100'         ,0.05    ,100         ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4380 ,'0.5'     ,'100'         ,0.5     ,100         ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4381 ,'0.2'     ,'100'         ,0.2     ,100         ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4382 ,'0.2'     ,'50'          ,0.2     ,50          ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4383 ,'0.2'     ,'50'          ,0.2     ,50          ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4384 ,'0.4'     ,'25'          ,0.4     ,25          ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4363 ,'0.2'     ,'50'          ,0.2     ,50          ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4368 ,'0.4'     ,'50'          ,0.4     ,50          ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4372 ,'0.5'     ,'25'          ,0.5     ,25          ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4375 ,'0.5'     ,'120'         ,0.5     ,120         ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4376 ,'0.2'     ,'50'          ,0.2     ,50          ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4377 ,'0.2'     ,'50'          ,0.2     ,50          ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4378 ,'0.3'     ,'75'          ,0.3     ,75          ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4379 ,'0.05'    ,'100'         ,0.05    ,100         ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4380 ,'0.5'     ,'100'         ,0.5     ,100         ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4381 ,'0.2'     ,'100'         ,0.2     ,100         ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4382 ,'0.2'     ,'50'          ,0.2     ,50          ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4383 ,'0.2'     ,'50'          ,0.2     ,50          ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4384 ,'0.4'     ,'25'          ,0.4     ,25          ,16				--Yen	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS

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
