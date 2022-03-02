/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20220203
	Created: Winfred 
	Task: #168832 - Spadegaming - 10 new games 2022 - deposit  RedmineID:#168832
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId INT, GameGroupID INT DEFAULT(11))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--DDD, IND, IDR, IDD, IN
SELECT 4363 ,'0.2'      ,'100'         ,0.2      ,100         ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4368 ,'0.8'      ,'100'         ,0.8      ,100         ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4372 ,'0.5'      ,'100'         ,0.5      ,100         ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4375 ,'0.5'      ,'1200'        ,0.5      ,1200        ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4376 ,'0.2'      ,'100'         ,0.2      ,100         ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4377 ,'0.2'      ,'100'         ,0.2      ,100         ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4378 ,'0.3'      ,'150'         ,0.3      ,150         ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4379 ,'0.5'      ,'1000'        ,0.5      ,1000        ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4380 ,'0.5'      ,'1000'        ,0.5      ,1000        ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4381 ,'0.2'      ,'1000'        ,0.2      ,1000        ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4382 ,'0.2'      ,'100'         ,0.2      ,100         ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4383 ,'0.2'      ,'100'         ,0.2      ,100         ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4384 ,'0.4'      ,'125'         ,0.4      ,125         ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
--Euro, GBP
SELECT 4363 ,'0.2'      ,'50'          ,0.2      ,50          ,6    UNION ALL	--EURO	--Euro, GBP
SELECT 4368 ,'0.4'      ,'50'          ,0.4      ,50          ,6    UNION ALL	--EURO	--Euro, GBP
SELECT 4372 ,'0.5'      ,'25'          ,0.5      ,25          ,6    UNION ALL	--EURO	--Euro, GBP
SELECT 4375 ,'0.5'      ,'120'         ,0.5      ,120         ,6    UNION ALL	--EURO	--Euro, GBP
SELECT 4376 ,'0.2'      ,'50'          ,0.2      ,50          ,6    UNION ALL	--EURO	--Euro, GBP
SELECT 4377 ,'0.2'      ,'50'          ,0.2      ,50          ,6    UNION ALL	--EURO	--Euro, GBP
SELECT 4378 ,'0.3'      ,'75'          ,0.3      ,75          ,6    UNION ALL	--EURO	--Euro, GBP
SELECT 4379 ,'0.05'     ,'100'         ,0.05     ,100         ,6    UNION ALL	--EURO	--Euro, GBP
SELECT 4380 ,'0.5'      ,'100'         ,0.5      ,100         ,6    UNION ALL	--EURO	--Euro, GBP
SELECT 4381 ,'0.2'      ,'100'         ,0.2      ,100         ,6    UNION ALL	--EURO	--Euro, GBP
SELECT 4382 ,'0.2'      ,'50'          ,0.2      ,50          ,6    UNION ALL	--EURO	--Euro, GBP
SELECT 4383 ,'0.2'      ,'50'          ,0.2      ,50          ,6    UNION ALL	--EURO	--Euro, GBP
SELECT 4384 ,'0.4'      ,'25'          ,0.4      ,25          ,6    UNION ALL	--EURO	--Euro, GBP
SELECT 4363 ,'0.2'      ,'50'          ,0.2      ,50          ,12   UNION ALL	--GBP	--Euro, GBP
SELECT 4368 ,'0.4'      ,'50'          ,0.4      ,50          ,12   UNION ALL	--GBP	--Euro, GBP
SELECT 4372 ,'0.5'      ,'25'          ,0.5      ,25          ,12   UNION ALL	--GBP	--Euro, GBP
SELECT 4375 ,'0.5'      ,'120'         ,0.5      ,120         ,12   UNION ALL	--GBP	--Euro, GBP
SELECT 4376 ,'0.2'      ,'50'          ,0.2      ,50          ,12   UNION ALL	--GBP	--Euro, GBP
SELECT 4377 ,'0.2'      ,'50'          ,0.2      ,50          ,12   UNION ALL	--GBP	--Euro, GBP
SELECT 4378 ,'0.3'      ,'75'          ,0.3      ,75          ,12   UNION ALL	--GBP	--Euro, GBP
SELECT 4379 ,'0.05'     ,'100'         ,0.05     ,100         ,12   UNION ALL	--GBP	--Euro, GBP
SELECT 4380 ,'0.5'      ,'100'         ,0.5      ,100         ,12   UNION ALL	--GBP	--Euro, GBP
SELECT 4381 ,'0.2'      ,'100'         ,0.2      ,100         ,12   UNION ALL	--GBP	--Euro, GBP
SELECT 4382 ,'0.2'      ,'50'          ,0.2      ,50          ,12   UNION ALL	--GBP	--Euro, GBP
SELECT 4383 ,'0.2'      ,'50'          ,0.2      ,50          ,12   UNION ALL	--GBP	--Euro, GBP
SELECT 4384 ,'0.4'      ,'25'          ,0.4      ,25          ,12   UNION ALL	--GBP	--Euro, GBP
--INH,YNG,UUS,DON
SELECT 4363 ,'1'        ,'100'         ,1        ,100         ,51   UNION ALL	--INH	--INH,YNG,UUS,DON
SELECT 4368 ,'0.8'      ,'100'         ,0.8      ,100         ,51   UNION ALL	--INH	--INH,YNG,UUS,DON
SELECT 4372 ,'1'        ,'100'         ,1        ,100         ,51   UNION ALL	--INH	--INH,YNG,UUS,DON
SELECT 4375 ,'1'        ,'1200'        ,1        ,1200        ,51   UNION ALL	--INH	--INH,YNG,UUS,DON
SELECT 4376 ,'1'        ,'100'         ,1        ,100         ,51   UNION ALL	--INH	--INH,YNG,UUS,DON
SELECT 4377 ,'1'        ,'100'         ,1        ,100         ,51   UNION ALL	--INH	--INH,YNG,UUS,DON
SELECT 4378 ,'0.9'      ,'150'         ,0.9      ,150         ,51   UNION ALL	--INH	--INH,YNG,UUS,DON
SELECT 4379 ,'1'        ,'1000'        ,1        ,1000        ,51   UNION ALL	--INH	--INH,YNG,UUS,DON
SELECT 4380 ,'1'        ,'1000'        ,1        ,1000        ,51   UNION ALL	--INH	--INH,YNG,UUS,DON
SELECT 4381 ,'1'        ,'1000'        ,1        ,1000        ,51   UNION ALL	--INH	--INH,YNG,UUS,DON
SELECT 4382 ,'1'        ,'100'         ,1        ,100         ,51   UNION ALL	--INH	--INH,YNG,UUS,DON
SELECT 4383 ,'1'        ,'100'         ,1        ,100         ,51   UNION ALL	--INH	--INH,YNG,UUS,DON
SELECT 4384 ,'0.8'      ,'125'         ,0.8      ,125         ,51   UNION ALL	--INH	--INH,YNG,UUS,DON
--RM,HKK,HK$,PLN,KHR,HID
SELECT 4363 ,'0.2'      ,'100'         ,0.2      ,100         ,92   UNION ALL	--HID	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4368 ,'0.4'      ,'100'         ,0.4      ,100         ,92   UNION ALL	--HID	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4372 ,'0.5'      ,'100'         ,0.5      ,100         ,92   UNION ALL	--HID	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4375 ,'0.5'      ,'600'         ,0.5      ,600         ,92   UNION ALL	--HID	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4376 ,'0.2'      ,'100'         ,0.2      ,100         ,92   UNION ALL	--HID	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4377 ,'0.2'      ,'100'         ,0.2      ,100         ,92   UNION ALL	--HID	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4378 ,'0.3'      ,'150'         ,0.3      ,150         ,92   UNION ALL	--HID	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4379 ,'0.5'      ,'500'         ,0.5      ,500         ,92   UNION ALL	--HID	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4380 ,'0.5'      ,'500'         ,0.5      ,500         ,92   UNION ALL	--HID	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4381 ,'0.2'      ,'500'         ,0.2      ,500         ,92   UNION ALL	--HID	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4382 ,'0.2'      ,'100'         ,0.2      ,100         ,92   UNION ALL	--HID	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4383 ,'0.2'      ,'100'         ,0.2      ,100         ,92   UNION ALL	--HID	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4384 ,'0.4'      ,'125'         ,0.4      ,125         ,92   UNION ALL	--HID	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4363 ,'0.2'      ,'100'         ,0.2      ,100         ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4368 ,'0.4'      ,'100'         ,0.4      ,100         ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4372 ,'0.5'      ,'100'         ,0.5      ,100         ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4375 ,'0.5'      ,'600'         ,0.5      ,600         ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4376 ,'0.2'      ,'100'         ,0.2      ,100         ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4377 ,'0.2'      ,'100'         ,0.2      ,100         ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4378 ,'0.3'      ,'150'         ,0.3      ,150         ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4379 ,'0.5'      ,'500'         ,0.5      ,500         ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4380 ,'0.5'      ,'500'         ,0.5      ,500         ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4381 ,'0.2'      ,'500'         ,0.2      ,500         ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4382 ,'0.2'      ,'100'         ,0.2      ,100         ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4383 ,'0.2'      ,'100'         ,0.2      ,100         ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4384 ,'0.4'      ,'125'         ,0.4      ,125         ,5    UNION ALL	--HK$	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4363 ,'0.2'      ,'100'         ,0.2      ,100         ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4368 ,'0.4'      ,'100'         ,0.4      ,100         ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4372 ,'0.5'      ,'100'         ,0.5      ,100         ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4375 ,'0.5'      ,'600'         ,0.5      ,600         ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4376 ,'0.2'      ,'100'         ,0.2      ,100         ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4377 ,'0.2'      ,'100'         ,0.2      ,100         ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4378 ,'0.3'      ,'150'         ,0.3      ,150         ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4379 ,'0.5'      ,'500'         ,0.5      ,500         ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4380 ,'0.5'      ,'500'         ,0.5      ,500         ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4381 ,'0.2'      ,'500'         ,0.2      ,500         ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4382 ,'0.2'      ,'100'         ,0.2      ,100         ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4383 ,'0.2'      ,'100'         ,0.2      ,100         ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4384 ,'0.4'      ,'125'         ,0.4      ,125         ,71   UNION ALL	--KHR	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4363 ,'0.2'      ,'100'         ,0.2      ,100         ,56   UNION ALL	--PLN	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4368 ,'0.4'      ,'100'         ,0.4      ,100         ,56   UNION ALL	--PLN	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4372 ,'0.5'      ,'100'         ,0.5      ,100         ,56   UNION ALL	--PLN	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4375 ,'0.5'      ,'600'         ,0.5      ,600         ,56   UNION ALL	--PLN	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4376 ,'0.2'      ,'100'         ,0.2      ,100         ,56   UNION ALL	--PLN	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4377 ,'0.2'      ,'100'         ,0.2      ,100         ,56   UNION ALL	--PLN	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4378 ,'0.3'      ,'150'         ,0.3      ,150         ,56   UNION ALL	--PLN	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4379 ,'0.5'      ,'500'         ,0.5      ,500         ,56   UNION ALL	--PLN	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4380 ,'0.5'      ,'500'         ,0.5      ,500         ,56   UNION ALL	--PLN	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4381 ,'0.2'      ,'500'         ,0.2      ,500         ,56   UNION ALL	--PLN	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4382 ,'0.2'      ,'100'         ,0.2      ,100         ,56   UNION ALL	--PLN	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4383 ,'0.2'      ,'100'         ,0.2      ,100         ,56   UNION ALL	--PLN	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4384 ,'0.4'      ,'125'         ,0.4      ,125         ,56   UNION ALL	--PLN	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4363 ,'0.2'      ,'100'         ,0.2      ,100         ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4368 ,'0.4'      ,'100'         ,0.4      ,100         ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4372 ,'0.5'      ,'100'         ,0.5      ,100         ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4375 ,'0.5'      ,'600'         ,0.5      ,600         ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4376 ,'0.2'      ,'100'         ,0.2      ,100         ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4377 ,'0.2'      ,'100'         ,0.2      ,100         ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4378 ,'0.3'      ,'150'         ,0.3      ,150         ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4379 ,'0.5'      ,'500'         ,0.5      ,500         ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4380 ,'0.5'      ,'500'         ,0.5      ,500         ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4381 ,'0.2'      ,'500'         ,0.2      ,500         ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4382 ,'0.2'      ,'100'         ,0.2      ,100         ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4383 ,'0.2'      ,'100'         ,0.2      ,100         ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR,HID
SELECT 4384 ,'0.4'      ,'125'         ,0.4      ,125         ,2    UNION ALL	--RM	--RM,HKK,HK$,PLN,KHR,HID
--RMB, CY, YUN,NOK,SEK
SELECT 4363 ,'0.2'      ,'100'         ,0.2      ,100         ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4368 ,'0.4'      ,'100'         ,0.4      ,100         ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4372 ,'1'        ,'250'         ,1        ,250         ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4375 ,'1'        ,'1200'        ,1        ,1200        ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4376 ,'0.2'      ,'100'         ,0.2      ,100         ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4377 ,'0.2'      ,'100'         ,0.2      ,100         ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4378 ,'0.3'      ,'150'         ,0.3      ,150         ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4379 ,'0.5'      ,'1000'        ,0.5      ,1000        ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4380 ,'1'        ,'1000'        ,1        ,1000        ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4381 ,'0.2'      ,'1000'        ,0.2      ,1000        ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4382 ,'0.2'      ,'100'         ,0.2      ,100         ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4383 ,'0.2'      ,'100'         ,0.2      ,100         ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4384 ,'0.4'      ,'250'         ,0.4      ,250         ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4363 ,'0.2'      ,'100'         ,0.2      ,100         ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4368 ,'0.4'      ,'100'         ,0.4      ,100         ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4372 ,'1'        ,'250'         ,1        ,250         ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4375 ,'1'        ,'1200'        ,1        ,1200        ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4376 ,'0.2'      ,'100'         ,0.2      ,100         ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4377 ,'0.2'      ,'100'         ,0.2      ,100         ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4378 ,'0.3'      ,'150'         ,0.3      ,150         ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4379 ,'0.5'      ,'1000'        ,0.5      ,1000        ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4380 ,'1'        ,'1000'        ,1        ,1000        ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4381 ,'0.2'      ,'1000'        ,0.2      ,1000        ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4382 ,'0.2'      ,'100'         ,0.2      ,100         ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4383 ,'0.2'      ,'100'         ,0.2      ,100         ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4384 ,'0.4'      ,'250'         ,0.4      ,250         ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4363 ,'0.2'      ,'100'         ,0.2      ,100         ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4368 ,'0.4'      ,'100'         ,0.4      ,100         ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4372 ,'1'        ,'250'         ,1        ,250         ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4375 ,'1'        ,'1200'        ,1        ,1200        ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4376 ,'0.2'      ,'100'         ,0.2      ,100         ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4377 ,'0.2'      ,'100'         ,0.2      ,100         ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4378 ,'0.3'      ,'150'         ,0.3      ,150         ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4379 ,'0.5'      ,'1000'        ,0.5      ,1000        ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4380 ,'1'        ,'1000'        ,1        ,1000        ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4381 ,'0.2'      ,'1000'        ,0.2      ,1000        ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4382 ,'0.2'      ,'100'         ,0.2      ,100         ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4383 ,'0.2'      ,'100'         ,0.2      ,100         ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4384 ,'0.4'      ,'250'         ,0.4      ,250         ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4363 ,'0.2'      ,'100'         ,0.2      ,100         ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4368 ,'0.4'      ,'100'         ,0.4      ,100         ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4372 ,'1'        ,'250'         ,1        ,250         ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4375 ,'1'        ,'1200'        ,1        ,1200        ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4376 ,'0.2'      ,'100'         ,0.2      ,100         ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4377 ,'0.2'      ,'100'         ,0.2      ,100         ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4378 ,'0.3'      ,'150'         ,0.3      ,150         ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4379 ,'0.5'      ,'1000'        ,0.5      ,1000        ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4380 ,'1'        ,'1000'        ,1        ,1000        ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4381 ,'0.2'      ,'1000'        ,0.2      ,1000        ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4382 ,'0.2'      ,'100'         ,0.2      ,100         ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4383 ,'0.2'      ,'100'         ,0.2      ,100         ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4384 ,'0.4'      ,'250'         ,0.4      ,250         ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
--RUB,INR,JPY
SELECT 4363 ,'10'       ,'1000'        ,10       ,1000        ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4368 ,'4'        ,'1000'        ,4        ,1000        ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4372 ,'25'       ,'1250'        ,25       ,1250        ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4375 ,'25'       ,'6000'        ,25       ,6000        ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4376 ,'10'       ,'2500'        ,10       ,2500        ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4377 ,'10'       ,'2500'        ,10       ,2500        ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4378 ,'15'       ,'3750'        ,15       ,3750        ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4379 ,'5'        ,'2500'        ,5        ,2500        ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4380 ,'25'       ,'5000'        ,25       ,5000        ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4381 ,'10'       ,'2000'        ,10       ,2000        ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4382 ,'10'       ,'1000'        ,10       ,1000        ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4383 ,'10'       ,'2500'        ,10       ,2500        ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4384 ,'20'       ,'1250'        ,20       ,1250        ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4363 ,'10'       ,'1000'        ,10       ,1000        ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4368 ,'4'        ,'1000'        ,4        ,1000        ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4372 ,'25'       ,'1250'        ,25       ,1250        ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4375 ,'25'       ,'6000'        ,25       ,6000        ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4376 ,'10'       ,'2500'        ,10       ,2500        ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4377 ,'10'       ,'2500'        ,10       ,2500        ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4378 ,'15'       ,'3750'        ,15       ,3750        ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4379 ,'5'        ,'2500'        ,5        ,2500        ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4380 ,'25'       ,'5000'        ,25       ,5000        ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4381 ,'10'       ,'2000'        ,10       ,2000        ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4382 ,'10'       ,'1000'        ,10       ,1000        ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4383 ,'10'       ,'2500'        ,10       ,2500        ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4384 ,'20'       ,'1250'        ,20       ,1250        ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4363 ,'10'       ,'1000'        ,10       ,1000        ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4368 ,'4'        ,'1000'        ,4        ,1000        ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4372 ,'25'       ,'1250'        ,25       ,1250        ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4375 ,'25'       ,'6000'        ,25       ,6000        ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4376 ,'10'       ,'2500'        ,10       ,2500        ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4377 ,'10'       ,'2500'        ,10       ,2500        ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4378 ,'15'       ,'3750'        ,15       ,3750        ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4379 ,'5'        ,'2500'        ,5        ,2500        ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4380 ,'25'       ,'5000'        ,25       ,5000        ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4381 ,'10'       ,'2000'        ,10       ,2000        ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4382 ,'10'       ,'1000'        ,10       ,1000        ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4383 ,'10'       ,'2500'        ,10       ,2500        ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4384 ,'20'       ,'1250'        ,20       ,1250        ,55   UNION ALL	--RUB	--RUB,INR,JPY
--THB, TB
SELECT 4363 ,'2'        ,'500'         ,2        ,500         ,4    UNION ALL	--TB	--THB, TB
SELECT 4368 ,'4'        ,'1000'        ,4        ,1000        ,4    UNION ALL	--TB	--THB, TB
SELECT 4372 ,'5'        ,'1000'        ,5        ,1000        ,4    UNION ALL	--TB	--THB, TB
SELECT 4375 ,'5'        ,'6000'        ,5        ,6000        ,4    UNION ALL	--TB	--THB, TB
SELECT 4376 ,'4'        ,'300'         ,4        ,300         ,4    UNION ALL	--TB	--THB, TB
SELECT 4377 ,'4'        ,'300'         ,4        ,300         ,4    UNION ALL	--TB	--THB, TB
SELECT 4378 ,'3'        ,'1500'        ,3        ,1500        ,4    UNION ALL	--TB	--THB, TB
SELECT 4379 ,'5'        ,'5000'        ,5        ,5000        ,4    UNION ALL	--TB	--THB, TB
SELECT 4380 ,'5'        ,'5000'        ,5        ,5000        ,4    UNION ALL	--TB	--THB, TB
SELECT 4381 ,'2'        ,'5000'        ,2        ,5000        ,4    UNION ALL	--TB	--THB, TB
SELECT 4382 ,'2'        ,'500'         ,2        ,500         ,4    UNION ALL	--TB	--THB, TB
SELECT 4383 ,'4'        ,'300'         ,4        ,300         ,4    UNION ALL	--TB	--THB, TB
SELECT 4384 ,'4'        ,'1250'        ,4        ,1250        ,4    UNION ALL	--TB	--THB, TB
--Won
SELECT 4363 ,'20'       ,'10000'       ,20       ,10000       ,45   UNION ALL	--Won	--Won
SELECT 4368 ,'40'       ,'10000'       ,40       ,10000       ,45   UNION ALL	--Won	--Won
SELECT 4372 ,'50'       ,'10000'       ,50       ,10000       ,45   UNION ALL	--Won	--Won
SELECT 4375 ,'50'       ,'60000'       ,50       ,60000       ,45   UNION ALL	--Won	--Won
SELECT 4376 ,'40'       ,'10000'       ,40       ,10000       ,45   UNION ALL	--Won	--Won
SELECT 4377 ,'40'       ,'10000'       ,40       ,10000       ,45   UNION ALL	--Won	--Won
SELECT 4378 ,'30'       ,'15000'       ,30       ,15000       ,45   UNION ALL	--Won	--Won
SELECT 4379 ,'50'       ,'50000'       ,50       ,50000       ,45   UNION ALL	--Won	--Won
SELECT 4380 ,'50'       ,'50000'       ,50       ,50000       ,45   UNION ALL	--Won	--Won
SELECT 4381 ,'20'       ,'50000'       ,20       ,50000       ,45   UNION ALL	--Won	--Won
SELECT 4382 ,'40'       ,'10000'       ,40       ,10000       ,45   UNION ALL	--Won	--Won
SELECT 4383 ,'40'       ,'10000'       ,40       ,10000       ,45   UNION ALL	--Won	--Won
SELECT 4384 ,'40'       ,'10000'       ,40       ,10000       ,45   UNION ALL	--Won	--Won
--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4363 ,'0.2'      ,'50'          ,0.2      ,50          ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4368 ,'0.4'      ,'50'          ,0.4      ,50          ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4372 ,'0.5'      ,'25'          ,0.5      ,25          ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4375 ,'0.5'      ,'120'         ,0.5      ,120         ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4376 ,'0.2'      ,'50'          ,0.2      ,50          ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4377 ,'0.2'      ,'50'          ,0.2      ,50          ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4378 ,'0.3'      ,'75'          ,0.3      ,75          ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4379 ,'0.05'     ,'100'         ,0.05     ,100         ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4380 ,'0.5'      ,'100'         ,0.5      ,100         ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4381 ,'0.2'      ,'100'         ,0.2      ,100         ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4382 ,'0.2'      ,'50'          ,0.2      ,50          ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4383 ,'0.2'      ,'50'          ,0.2      ,50          ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4384 ,'0.4'      ,'25'          ,0.4      ,25          ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4363 ,'0.2'      ,'50'          ,0.2      ,50          ,94   UNION ALL	--MK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4368 ,'0.4'      ,'50'          ,0.4      ,50          ,94   UNION ALL	--MK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4372 ,'0.5'      ,'25'          ,0.5      ,25          ,94   UNION ALL	--MK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4375 ,'0.5'      ,'120'         ,0.5      ,120         ,94   UNION ALL	--MK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4376 ,'0.2'      ,'50'          ,0.2      ,50          ,94   UNION ALL	--MK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4377 ,'0.2'      ,'50'          ,0.2      ,50          ,94   UNION ALL	--MK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4378 ,'0.3'      ,'75'          ,0.3      ,75          ,94   UNION ALL	--MK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4379 ,'0.05'     ,'100'         ,0.05     ,100         ,94   UNION ALL	--MK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4380 ,'0.5'      ,'100'         ,0.5      ,100         ,94   UNION ALL	--MK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4381 ,'0.2'      ,'100'         ,0.2      ,100         ,94   UNION ALL	--MK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4382 ,'0.2'      ,'50'          ,0.2      ,50          ,94   UNION ALL	--MK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4383 ,'0.2'      ,'50'          ,0.2      ,50          ,94   UNION ALL	--MK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4384 ,'0.4'      ,'25'          ,0.4      ,25          ,94   UNION ALL	--MK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4363 ,'0.2'      ,'50'          ,0.2      ,50          ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4368 ,'0.4'      ,'50'          ,0.4      ,50          ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4372 ,'0.5'      ,'25'          ,0.5      ,25          ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4375 ,'0.5'      ,'120'         ,0.5      ,120         ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4376 ,'0.2'      ,'50'          ,0.2      ,50          ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4377 ,'0.2'      ,'50'          ,0.2      ,50          ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4378 ,'0.3'      ,'75'          ,0.3      ,75          ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4379 ,'0.05'     ,'100'         ,0.05     ,100         ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4380 ,'0.5'      ,'100'         ,0.5      ,100         ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4381 ,'0.2'      ,'100'         ,0.2      ,100         ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4382 ,'0.2'      ,'50'          ,0.2      ,50          ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4383 ,'0.2'      ,'50'          ,0.2      ,50          ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4384 ,'0.4'      ,'25'          ,0.4      ,25          ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4363 ,'0.2'      ,'50'          ,0.2      ,50          ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4368 ,'0.4'      ,'50'          ,0.4      ,50          ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4372 ,'0.5'      ,'25'          ,0.5      ,25          ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4375 ,'0.5'      ,'120'         ,0.5      ,120         ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4376 ,'0.2'      ,'50'          ,0.2      ,50          ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4377 ,'0.2'      ,'50'          ,0.2      ,50          ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4378 ,'0.3'      ,'75'          ,0.3      ,75          ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4379 ,'0.05'     ,'100'         ,0.05     ,100         ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4380 ,'0.5'      ,'100'         ,0.5      ,100         ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4381 ,'0.2'      ,'100'         ,0.2      ,100         ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4382 ,'0.2'      ,'50'          ,0.2      ,50          ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4383 ,'0.2'      ,'50'          ,0.2      ,50          ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4384 ,'0.4'      ,'25'          ,0.4      ,25          ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4363 ,'0.2'      ,'50'          ,0.2      ,50          ,96   UNION ALL	--USDT	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4368 ,'0.4'      ,'50'          ,0.4      ,50          ,96   UNION ALL	--USDT	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4372 ,'0.5'      ,'25'          ,0.5      ,25          ,96   UNION ALL	--USDT	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4375 ,'0.5'      ,'120'         ,0.5      ,120         ,96   UNION ALL	--USDT	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4376 ,'0.2'      ,'50'          ,0.2      ,50          ,96   UNION ALL	--USDT	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4377 ,'0.2'      ,'50'          ,0.2      ,50          ,96   UNION ALL	--USDT	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4378 ,'0.3'      ,'75'          ,0.3      ,75          ,96   UNION ALL	--USDT	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4379 ,'0.05'     ,'100'         ,0.05     ,100         ,96   UNION ALL	--USDT	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4380 ,'0.5'      ,'100'         ,0.5      ,100         ,96   UNION ALL	--USDT	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4381 ,'0.2'      ,'100'         ,0.2      ,100         ,96   UNION ALL	--USDT	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4382 ,'0.2'      ,'50'          ,0.2      ,50          ,96   UNION ALL	--USDT	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4383 ,'0.2'      ,'50'          ,0.2      ,50          ,96   UNION ALL	--USDT	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS
SELECT 4384 ,'0.4'      ,'25'          ,0.4      ,25          ,96				--USDT	--Yen, UT, $US, US$, USD, USDT,MK,AUD,MMK, MKK,UUS

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
