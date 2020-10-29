/*
	Date: 20201029
	Created: Winfred 
	Task: #144173 - Spadegaming - 10 new games Oct 2020 - Credit UUS
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(12))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--DDD, IND, IDR, IDD, IN
--DDD
SELECT 4310 ,'1'    ,'1000'    ,1    ,1000    ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4345 ,'0.5'  ,'1000'    ,0.5  ,1000    ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4346 ,'0.5'  ,'1000'    ,0.5  ,1000    ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4347 ,'0.5'  ,'750'     ,0.5  ,750     ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4348 ,'0.5'  ,'750'     ,0.5  ,750     ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4349 ,'0.3'  ,'750'     ,0.3  ,750     ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4350 ,'0.3'  ,'750'     ,0.3  ,750     ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4351 ,'0.3'  ,'750'     ,0.3  ,750     ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4352 ,'0.9'  ,'1800'    ,0.9  ,1800    ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4353 ,'0.5'  ,'1000'    ,0.5  ,1000    ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
--IDD
SELECT 4310 ,'1'    ,'1000'    ,1    ,1000    ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4345 ,'0.5'  ,'1000'    ,0.5  ,1000    ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4346 ,'0.5'  ,'1000'    ,0.5  ,1000    ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4347 ,'0.5'  ,'750'     ,0.5  ,750     ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4348 ,'0.5'  ,'750'     ,0.5  ,750     ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4349 ,'0.3'  ,'750'     ,0.3  ,750     ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4350 ,'0.3'  ,'750'     ,0.3  ,750     ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4351 ,'0.3'  ,'750'     ,0.3  ,750     ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4352 ,'0.9'  ,'1800'    ,0.9  ,1800    ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4353 ,'0.5'  ,'1000'    ,0.5  ,1000    ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
--IDR
SELECT 4310 ,'1'    ,'1000'    ,1    ,1000    ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4345 ,'0.5'  ,'1000'    ,0.5  ,1000    ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4346 ,'0.5'  ,'1000'    ,0.5  ,1000    ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4347 ,'0.5'  ,'750'     ,0.5  ,750     ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4348 ,'0.5'  ,'750'     ,0.5  ,750     ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4349 ,'0.3'  ,'750'     ,0.3  ,750     ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4350 ,'0.3'  ,'750'     ,0.3  ,750     ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4351 ,'0.3'  ,'750'     ,0.3  ,750     ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4352 ,'0.9'  ,'1800'    ,0.9  ,1800    ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4353 ,'0.5'  ,'1000'    ,0.5  ,1000    ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
--IN
SELECT 4310 ,'1'    ,'1000'    ,1    ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4345 ,'0.5'  ,'1000'    ,0.5  ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4346 ,'0.5'  ,'1000'    ,0.5  ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4347 ,'0.5'  ,'750'     ,0.5  ,750     ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4348 ,'0.5'  ,'750'     ,0.5  ,750     ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4349 ,'0.3'  ,'750'     ,0.3  ,750     ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4350 ,'0.3'  ,'750'     ,0.3  ,750     ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4351 ,'0.3'  ,'750'     ,0.3  ,750     ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4352 ,'0.9'  ,'1800'    ,0.9  ,1800    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4353 ,'0.5'  ,'1000'    ,0.5  ,1000    ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
--IND
SELECT 4310 ,'1'    ,'1000'    ,1    ,1000    ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4345 ,'0.5'  ,'1000'    ,0.5  ,1000    ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4346 ,'0.5'  ,'1000'    ,0.5  ,1000    ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4347 ,'0.5'  ,'750'     ,0.5  ,750     ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4348 ,'0.5'  ,'750'     ,0.5  ,750     ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4349 ,'0.3'  ,'750'     ,0.3  ,750     ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4350 ,'0.3'  ,'750'     ,0.3  ,750     ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4351 ,'0.3'  ,'750'     ,0.3  ,750     ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4352 ,'0.9'  ,'1800'    ,0.9  ,1800    ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4353 ,'0.5'  ,'1000'    ,0.5  ,1000    ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
--=============================================================
--Euro, EUR,GBP
--EUR
SELECT 4310 ,'1'    ,'100'     ,1    ,100     ,78   UNION ALL	--EUR	--Euro, EUR,GBP
SELECT 4345 ,'0.5'  ,'60'      ,0.5  ,60      ,78   UNION ALL	--EUR	--Euro, EUR,GBP
SELECT 4346 ,'0.5'  ,'100'     ,0.5  ,100     ,78   UNION ALL	--EUR	--Euro, EUR,GBP
SELECT 4347 ,'0.5'  ,'50'      ,0.5  ,50      ,78   UNION ALL	--EUR	--Euro, EUR,GBP
SELECT 4348 ,'0.5'  ,'50'      ,0.5  ,50      ,78   UNION ALL	--EUR	--Euro, EUR,GBP
SELECT 4349 ,'0.15' ,'15'      ,0.15 ,15      ,78   UNION ALL	--EUR	--Euro, EUR,GBP
SELECT 4350 ,'0.15' ,'15'      ,0.15 ,15      ,78   UNION ALL	--EUR	--Euro, EUR,GBP
SELECT 4351 ,'0.15' ,'15'      ,0.15 ,15      ,78   UNION ALL	--EUR	--Euro, EUR,GBP
SELECT 4352 ,'0.09' ,'45'      ,0.09 ,45      ,78   UNION ALL	--EUR	--Euro, EUR,GBP
SELECT 4353 ,'0.5'  ,'60'      ,0.5  ,60      ,78   UNION ALL	--EUR	--Euro, EUR,GBP
--EURO
SELECT 4310 ,'1'    ,'100'     ,1    ,100     ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4345 ,'0.5'  ,'60'      ,0.5  ,60      ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4346 ,'0.5'  ,'100'     ,0.5  ,100     ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4347 ,'0.5'  ,'50'      ,0.5  ,50      ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4348 ,'0.5'  ,'50'      ,0.5  ,50      ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4349 ,'0.15' ,'15'      ,0.15 ,15      ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4350 ,'0.15' ,'15'      ,0.15 ,15      ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4351 ,'0.15' ,'15'      ,0.15 ,15      ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4352 ,'0.09' ,'45'      ,0.09 ,45      ,6    UNION ALL	--EURO	--Euro, EUR,GBP
SELECT 4353 ,'0.5'  ,'60'      ,0.5  ,60      ,6    UNION ALL	--EURO	--Euro, EUR,GBP
--GBP
SELECT 4310 ,'1'    ,'100'     ,1    ,100     ,12   UNION ALL	--GBP	--Euro, EUR,GBP
SELECT 4345 ,'0.5'  ,'60'      ,0.5  ,60      ,12   UNION ALL	--GBP	--Euro, EUR,GBP
SELECT 4346 ,'0.5'  ,'100'     ,0.5  ,100     ,12   UNION ALL	--GBP	--Euro, EUR,GBP
SELECT 4347 ,'0.5'  ,'50'      ,0.5  ,50      ,12   UNION ALL	--GBP	--Euro, EUR,GBP
SELECT 4348 ,'0.5'  ,'50'      ,0.5  ,50      ,12   UNION ALL	--GBP	--Euro, EUR,GBP
SELECT 4349 ,'0.15' ,'15'      ,0.15 ,15      ,12   UNION ALL	--GBP	--Euro, EUR,GBP
SELECT 4350 ,'0.15' ,'15'      ,0.15 ,15      ,12   UNION ALL	--GBP	--Euro, EUR,GBP
SELECT 4351 ,'0.15' ,'15'      ,0.15 ,15      ,12   UNION ALL	--GBP	--Euro, EUR,GBP
SELECT 4352 ,'0.09' ,'45'      ,0.09 ,45      ,12   UNION ALL	--GBP	--Euro, EUR,GBP
SELECT 4353 ,'0.5'  ,'60'      ,0.5  ,60      ,12   UNION ALL	--GBP	--Euro, EUR,GBP
--=============================================================
--INH
SELECT 4310 ,'1'    ,'2000'    ,1    ,2000    ,51   UNION ALL	--INH	--INH
SELECT 4345 ,'1'    ,'2000'    ,1    ,2000    ,51   UNION ALL	--INH	--INH
SELECT 4346 ,'1'    ,'1000'    ,1    ,1000    ,51   UNION ALL	--INH	--INH
SELECT 4347 ,'0.5'  ,'1250'    ,0.5  ,1250    ,51   UNION ALL	--INH	--INH
SELECT 4348 ,'0.5'  ,'1250'    ,0.5  ,1250    ,51   UNION ALL	--INH	--INH
SELECT 4349 ,'0.3'  ,'750'     ,0.3  ,750     ,51   UNION ALL	--INH	--INH
SELECT 4350 ,'0.3'  ,'750'     ,0.3  ,750     ,51   UNION ALL	--INH	--INH
SELECT 4351 ,'0.3'  ,'750'     ,0.3  ,750     ,51   UNION ALL	--INH	--INH
SELECT 4352 ,'0.9'  ,'2250'    ,0.9  ,2250    ,51   UNION ALL	--INH	--INH
SELECT 4353 ,'1'    ,'2000'    ,1    ,2000    ,51   UNION ALL	--INH	--INH
--=============================================================
--RM,HKK, HK$,PLN,KHR
--HK$
SELECT 4310 ,'1'    ,'500'     ,1    ,500     ,5    UNION ALL	--HK$	--RM,HKK, HK$,PLN,KHR
SELECT 4345 ,'0.5'  ,'500'     ,0.5  ,500     ,5    UNION ALL	--HK$	--RM,HKK, HK$,PLN,KHR
SELECT 4346 ,'0.5'  ,'500'     ,0.5  ,500     ,5    UNION ALL	--HK$	--RM,HKK, HK$,PLN,KHR
SELECT 4347 ,'0.5'  ,'250'     ,0.5  ,250     ,5    UNION ALL	--HK$	--RM,HKK, HK$,PLN,KHR
SELECT 4348 ,'0.5'  ,'250'     ,0.5  ,250     ,5    UNION ALL	--HK$	--RM,HKK, HK$,PLN,KHR
SELECT 4349 ,'0.3'  ,'150'     ,0.3  ,150     ,5    UNION ALL	--HK$	--RM,HKK, HK$,PLN,KHR
SELECT 4350 ,'0.3'  ,'150'     ,0.3  ,150     ,5    UNION ALL	--HK$	--RM,HKK, HK$,PLN,KHR
SELECT 4351 ,'0.3'  ,'150'     ,0.3  ,150     ,5    UNION ALL	--HK$	--RM,HKK, HK$,PLN,KHR
SELECT 4352 ,'0.09' ,'450'     ,0.09 ,450     ,5    UNION ALL	--HK$	--RM,HKK, HK$,PLN,KHR
SELECT 4353 ,'0.25' ,'500'     ,0.25 ,500     ,5    UNION ALL	--HK$	--RM,HKK, HK$,PLN,KHR
--HKK
SELECT 4310 ,'1'    ,'500'     ,1    ,500     ,67   UNION ALL	--HKK	--RM,HKK, HK$,PLN,KHR
SELECT 4345 ,'0.5'  ,'500'     ,0.5  ,500     ,67   UNION ALL	--HKK	--RM,HKK, HK$,PLN,KHR
SELECT 4346 ,'0.5'  ,'500'     ,0.5  ,500     ,67   UNION ALL	--HKK	--RM,HKK, HK$,PLN,KHR
SELECT 4347 ,'0.5'  ,'250'     ,0.5  ,250     ,67   UNION ALL	--HKK	--RM,HKK, HK$,PLN,KHR
SELECT 4348 ,'0.5'  ,'250'     ,0.5  ,250     ,67   UNION ALL	--HKK	--RM,HKK, HK$,PLN,KHR
SELECT 4349 ,'0.3'  ,'150'     ,0.3  ,150     ,67   UNION ALL	--HKK	--RM,HKK, HK$,PLN,KHR
SELECT 4350 ,'0.3'  ,'150'     ,0.3  ,150     ,67   UNION ALL	--HKK	--RM,HKK, HK$,PLN,KHR
SELECT 4351 ,'0.3'  ,'150'     ,0.3  ,150     ,67   UNION ALL	--HKK	--RM,HKK, HK$,PLN,KHR
SELECT 4352 ,'0.09' ,'450'     ,0.09 ,450     ,67   UNION ALL	--HKK	--RM,HKK, HK$,PLN,KHR
SELECT 4353 ,'0.25' ,'500'     ,0.25 ,500     ,67   UNION ALL	--HKK	--RM,HKK, HK$,PLN,KHR
--KHR
SELECT 4310 ,'1'    ,'500'     ,1    ,500     ,71   UNION ALL	--KHR	--RM,HKK, HK$,PLN,KHR
SELECT 4345 ,'0.5'  ,'500'     ,0.5  ,500     ,71   UNION ALL	--KHR	--RM,HKK, HK$,PLN,KHR
SELECT 4346 ,'0.5'  ,'500'     ,0.5  ,500     ,71   UNION ALL	--KHR	--RM,HKK, HK$,PLN,KHR
SELECT 4347 ,'0.5'  ,'250'     ,0.5  ,250     ,71   UNION ALL	--KHR	--RM,HKK, HK$,PLN,KHR
SELECT 4348 ,'0.5'  ,'250'     ,0.5  ,250     ,71   UNION ALL	--KHR	--RM,HKK, HK$,PLN,KHR
SELECT 4349 ,'0.3'  ,'150'     ,0.3  ,150     ,71   UNION ALL	--KHR	--RM,HKK, HK$,PLN,KHR
SELECT 4350 ,'0.3'  ,'150'     ,0.3  ,150     ,71   UNION ALL	--KHR	--RM,HKK, HK$,PLN,KHR
SELECT 4351 ,'0.3'  ,'150'     ,0.3  ,150     ,71   UNION ALL	--KHR	--RM,HKK, HK$,PLN,KHR
SELECT 4352 ,'0.09' ,'450'     ,0.09 ,450     ,71   UNION ALL	--KHR	--RM,HKK, HK$,PLN,KHR
SELECT 4353 ,'0.25' ,'500'     ,0.25 ,500     ,71   UNION ALL	--KHR	--RM,HKK, HK$,PLN,KHR
--PLN
SELECT 4310 ,'1'    ,'500'     ,1    ,500     ,56   UNION ALL	--PLN	--RM,HKK, HK$,PLN,KHR
SELECT 4345 ,'0.5'  ,'500'     ,0.5  ,500     ,56   UNION ALL	--PLN	--RM,HKK, HK$,PLN,KHR
SELECT 4346 ,'0.5'  ,'500'     ,0.5  ,500     ,56   UNION ALL	--PLN	--RM,HKK, HK$,PLN,KHR
SELECT 4347 ,'0.5'  ,'250'     ,0.5  ,250     ,56   UNION ALL	--PLN	--RM,HKK, HK$,PLN,KHR
SELECT 4348 ,'0.5'  ,'250'     ,0.5  ,250     ,56   UNION ALL	--PLN	--RM,HKK, HK$,PLN,KHR
SELECT 4349 ,'0.3'  ,'150'     ,0.3  ,150     ,56   UNION ALL	--PLN	--RM,HKK, HK$,PLN,KHR
SELECT 4350 ,'0.3'  ,'150'     ,0.3  ,150     ,56   UNION ALL	--PLN	--RM,HKK, HK$,PLN,KHR
SELECT 4351 ,'0.3'  ,'150'     ,0.3  ,150     ,56   UNION ALL	--PLN	--RM,HKK, HK$,PLN,KHR
SELECT 4352 ,'0.09' ,'450'     ,0.09 ,450     ,56   UNION ALL	--PLN	--RM,HKK, HK$,PLN,KHR
SELECT 4353 ,'0.25' ,'500'     ,0.25 ,500     ,56   UNION ALL	--PLN	--RM,HKK, HK$,PLN,KHR
--RM
SELECT 4310 ,'1'    ,'500'     ,1    ,500     ,2    UNION ALL	--RM	--RM,HKK, HK$,PLN,KHR
SELECT 4345 ,'0.5'  ,'500'     ,0.5  ,500     ,2    UNION ALL	--RM	--RM,HKK, HK$,PLN,KHR
SELECT 4346 ,'0.5'  ,'500'     ,0.5  ,500     ,2    UNION ALL	--RM	--RM,HKK, HK$,PLN,KHR
SELECT 4347 ,'0.5'  ,'250'     ,0.5  ,250     ,2    UNION ALL	--RM	--RM,HKK, HK$,PLN,KHR
SELECT 4348 ,'0.5'  ,'250'     ,0.5  ,250     ,2    UNION ALL	--RM	--RM,HKK, HK$,PLN,KHR
SELECT 4349 ,'0.3'  ,'150'     ,0.3  ,150     ,2    UNION ALL	--RM	--RM,HKK, HK$,PLN,KHR
SELECT 4350 ,'0.3'  ,'150'     ,0.3  ,150     ,2    UNION ALL	--RM	--RM,HKK, HK$,PLN,KHR
SELECT 4351 ,'0.3'  ,'150'     ,0.3  ,150     ,2    UNION ALL	--RM	--RM,HKK, HK$,PLN,KHR
SELECT 4352 ,'0.09' ,'450'     ,0.09 ,450     ,2    UNION ALL	--RM	--RM,HKK, HK$,PLN,KHR
SELECT 4353 ,'0.25' ,'500'     ,0.25 ,500     ,2    UNION ALL	--RM	--RM,HKK, HK$,PLN,KHR
--=============================================================
--RMB, CY, YUN,NOK,SEK
--CY
SELECT 4310 ,'1'    ,'1000'    ,1    ,1000    ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4345 ,'0.5'  ,'1000'    ,0.5  ,1000    ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4346 ,'0.5'  ,'1000'    ,0.5  ,1000    ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4347 ,'1'    ,'500'     ,1    ,500     ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4348 ,'1'    ,'500'     ,1    ,500     ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4349 ,'0.3'  ,'300'     ,0.3  ,300     ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4350 ,'0.3'  ,'300'     ,0.3  ,300     ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4351 ,'0.3'  ,'300'     ,0.3  ,300     ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4352 ,'0.9'  ,'900'     ,0.9  ,900     ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
SELECT 4353 ,'0.5'  ,'1000'    ,0.5  ,1000    ,81   UNION ALL	--CY	--RMB, CY, YUN,NOK,SEK
--NOK
SELECT 4310 ,'1'    ,'1000'    ,1    ,1000    ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4345 ,'0.5'  ,'1000'    ,0.5  ,1000    ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4346 ,'0.5'  ,'1000'    ,0.5  ,1000    ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4347 ,'1'    ,'500'     ,1    ,500     ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4348 ,'1'    ,'500'     ,1    ,500     ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4349 ,'0.3'  ,'300'     ,0.3  ,300     ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4350 ,'0.3'  ,'300'     ,0.3  ,300     ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4351 ,'0.3'  ,'300'     ,0.3  ,300     ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4352 ,'0.9'  ,'900'     ,0.9  ,900     ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
SELECT 4353 ,'0.5'  ,'1000'    ,0.5  ,1000    ,54   UNION ALL	--NOK	--RMB, CY, YUN,NOK,SEK
--RMB
SELECT 4310 ,'1'    ,'1000'    ,1    ,1000    ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4345 ,'0.5'  ,'1000'    ,0.5  ,1000    ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4346 ,'0.5'  ,'1000'    ,0.5  ,1000    ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4347 ,'1'    ,'500'     ,1    ,500     ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4348 ,'1'    ,'500'     ,1    ,500     ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4349 ,'0.3'  ,'300'     ,0.3  ,300     ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4350 ,'0.3'  ,'300'     ,0.3  ,300     ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4351 ,'0.3'  ,'300'     ,0.3  ,300     ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4352 ,'0.9'  ,'900'     ,0.9  ,900     ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
SELECT 4353 ,'0.5'  ,'1000'    ,0.5  ,1000    ,13   UNION ALL	--RMB	--RMB, CY, YUN,NOK,SEK
--SEK
SELECT 4310 ,'1'    ,'1000'    ,1    ,1000    ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4345 ,'0.5'  ,'1000'    ,0.5  ,1000    ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4346 ,'0.5'  ,'1000'    ,0.5  ,1000    ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4347 ,'1'    ,'500'     ,1    ,500     ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4348 ,'1'    ,'500'     ,1    ,500     ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4349 ,'0.3'  ,'300'     ,0.3  ,300     ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4350 ,'0.3'  ,'300'     ,0.3  ,300     ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4351 ,'0.3'  ,'300'     ,0.3  ,300     ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4352 ,'0.9'  ,'900'     ,0.9  ,900     ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
SELECT 4353 ,'0.5'  ,'1000'    ,0.5  ,1000    ,53   UNION ALL	--SEK	--RMB, CY, YUN,NOK,SEK
--YUN
SELECT 4310 ,'1'    ,'1000'    ,1    ,1000    ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4345 ,'0.5'  ,'1000'    ,0.5  ,1000    ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4346 ,'0.5'  ,'1000'    ,0.5  ,1000    ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4347 ,'1'    ,'500'     ,1    ,500     ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4348 ,'1'    ,'500'     ,1    ,500     ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4349 ,'0.3'  ,'300'     ,0.3  ,300     ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4350 ,'0.3'  ,'300'     ,0.3  ,300     ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4351 ,'0.3'  ,'300'     ,0.3  ,300     ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4352 ,'0.9'  ,'900'     ,0.9  ,900     ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
SELECT 4353 ,'0.5'  ,'1000'    ,0.5  ,1000    ,66   UNION ALL	--YUN	--RMB, CY, YUN,NOK,SEK
--=============================================================
--RUB,INR,JPY
--INR
SELECT 4310 ,'5'    ,'5000'    ,5    ,5000    ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4345 ,'5'    ,'5000'    ,5    ,5000    ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4346 ,'5'    ,'2500'    ,5    ,2500    ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4347 ,'5'    ,'5000'    ,5    ,5000    ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4348 ,'5'    ,'5000'    ,5    ,5000    ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4349 ,'1.5'  ,'1500'    ,1.5  ,1500    ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4350 ,'1.5'  ,'1500'    ,1.5  ,1500    ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4351 ,'1.5'  ,'1500'    ,1.5  ,1500    ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4352 ,'9'    ,'4500'    ,9    ,4500    ,61   UNION ALL	--INR	--RUB,INR,JPY
SELECT 4353 ,'5'    ,'5000'    ,5    ,5000    ,61   UNION ALL	--INR	--RUB,INR,JPY
--JPY
SELECT 4310 ,'5'    ,'5000'    ,5    ,5000    ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4345 ,'5'    ,'5000'    ,5    ,5000    ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4346 ,'5'    ,'2500'    ,5    ,2500    ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4347 ,'5'    ,'5000'    ,5    ,5000    ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4348 ,'5'    ,'5000'    ,5    ,5000    ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4349 ,'1.5'  ,'1500'    ,1.5  ,1500    ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4350 ,'1.5'  ,'1500'    ,1.5  ,1500    ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4351 ,'1.5'  ,'1500'    ,1.5  ,1500    ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4352 ,'9'    ,'4500'    ,9    ,4500    ,32   UNION ALL	--JPY	--RUB,INR,JPY
SELECT 4353 ,'5'    ,'5000'    ,5    ,5000    ,32   UNION ALL	--JPY	--RUB,INR,JPY
--RUB
SELECT 4310 ,'5'    ,'5000'    ,5    ,5000    ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4345 ,'5'    ,'5000'    ,5    ,5000    ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4346 ,'5'    ,'2500'    ,5    ,2500    ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4347 ,'5'    ,'5000'    ,5    ,5000    ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4348 ,'5'    ,'5000'    ,5    ,5000    ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4349 ,'1.5'  ,'1500'    ,1.5  ,1500    ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4350 ,'1.5'  ,'1500'    ,1.5  ,1500    ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4351 ,'1.5'  ,'1500'    ,1.5  ,1500    ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4352 ,'9'    ,'4500'    ,9    ,4500    ,55   UNION ALL	--RUB	--RUB,INR,JPY
SELECT 4353 ,'5'    ,'5000'    ,5    ,5000    ,55   UNION ALL	--RUB	--RUB,INR,JPY
--=============================================================
--THB, TB
--TB
SELECT 4310 ,'5'    ,'5000'    ,5    ,5000    ,4    UNION ALL	--TB	--THB, TB
SELECT 4345 ,'5'    ,'5000'    ,5    ,5000    ,4    UNION ALL	--TB	--THB, TB
SELECT 4346 ,'5'    ,'5000'    ,5    ,5000    ,4    UNION ALL	--TB	--THB, TB
SELECT 4347 ,'5'    ,'2500'    ,5    ,2500    ,4    UNION ALL	--TB	--THB, TB
SELECT 4348 ,'5'    ,'2500'    ,5    ,2500    ,4    UNION ALL	--TB	--THB, TB
SELECT 4349 ,'1.5'  ,'1500'    ,1.5  ,1500    ,4    UNION ALL	--TB	--THB, TB
SELECT 4350 ,'1.5'  ,'1500'    ,1.5  ,1500    ,4    UNION ALL	--TB	--THB, TB
SELECT 4351 ,'1.5'  ,'1500'    ,1.5  ,1500    ,4    UNION ALL	--TB	--THB, TB
SELECT 4352 ,'9'    ,'4500'    ,9    ,4500    ,4    UNION ALL	--TB	--THB, TB
SELECT 4353 ,'5'    ,'5000'    ,5    ,5000    ,4    UNION ALL	--TB	--THB, TB
--THB
SELECT 4310 ,'5'    ,'5000'    ,5    ,5000    ,43   UNION ALL	--THB	--THB, TB
SELECT 4345 ,'5'    ,'5000'    ,5    ,5000    ,43   UNION ALL	--THB	--THB, TB
SELECT 4346 ,'5'    ,'5000'    ,5    ,5000    ,43   UNION ALL	--THB	--THB, TB
SELECT 4347 ,'5'    ,'2500'    ,5    ,2500    ,43   UNION ALL	--THB	--THB, TB
SELECT 4348 ,'5'    ,'2500'    ,5    ,2500    ,43   UNION ALL	--THB	--THB, TB
SELECT 4349 ,'1.5'  ,'1500'    ,1.5  ,1500    ,43   UNION ALL	--THB	--THB, TB
SELECT 4350 ,'1.5'  ,'1500'    ,1.5  ,1500    ,43   UNION ALL	--THB	--THB, TB
SELECT 4351 ,'1.5'  ,'1500'    ,1.5  ,1500    ,43   UNION ALL	--THB	--THB, TB
SELECT 4352 ,'9'    ,'4500'    ,9    ,4500    ,43   UNION ALL	--THB	--THB, TB
SELECT 4353 ,'5'    ,'5000'    ,5    ,5000    ,43   UNION ALL	--THB	--THB, TB
--=============================================================
--Won
SELECT 4310 ,'20'   ,'100000'  ,20   ,100000  ,45   UNION ALL	--Won	--Won
SELECT 4345 ,'50'   ,'125000'  ,50   ,125000  ,45   UNION ALL	--Won	--Won
SELECT 4346 ,'50'   ,'50000'   ,50   ,50000   ,45   UNION ALL	--Won	--Won
SELECT 4347 ,'100'  ,'50000'   ,100  ,50000   ,45   UNION ALL	--Won	--Won
SELECT 4348 ,'100'  ,'50000'   ,100  ,50000   ,45   UNION ALL	--Won	--Won
SELECT 4349 ,'150'  ,'30000'   ,150  ,30000   ,45   UNION ALL	--Won	--Won
SELECT 4350 ,'150'  ,'30000'   ,150  ,30000   ,45   UNION ALL	--Won	--Won
SELECT 4351 ,'150'  ,'30000'   ,150  ,30000   ,45   UNION ALL	--Won	--Won
SELECT 4352 ,'90'   ,'90000'   ,90   ,90000   ,45   UNION ALL	--Won	--Won
SELECT 4353 ,'50'   ,'125000'  ,50   ,125000  ,45   UNION ALL	--Won	--Won
--=============================================================
--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
--$US
SELECT 4310 ,'1'    ,'100'     ,1    ,100     ,35   UNION ALL	--$US	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4345 ,'0.5'  ,'100'     ,0.5  ,100     ,35   UNION ALL	--$US	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4346 ,'0.5'  ,'100'     ,0.5  ,100     ,35   UNION ALL	--$US	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4347 ,'0.5'  ,'75'      ,0.5  ,75      ,35   UNION ALL	--$US	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4348 ,'0.5'  ,'75'      ,0.5  ,75      ,35   UNION ALL	--$US	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4349 ,'0.3'  ,'30'      ,0.3  ,30      ,35   UNION ALL	--$US	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4350 ,'0.3'  ,'30'      ,0.3  ,30      ,35   UNION ALL	--$US	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4351 ,'0.3'  ,'30'      ,0.3  ,30      ,35   UNION ALL	--$US	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4352 ,'0.09' ,'90'      ,0.09 ,90      ,35   UNION ALL	--$US	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4353 ,'0.5'  ,'100'     ,0.5  ,100     ,35   UNION ALL	--$US	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
--AUD
SELECT 4310 ,'1'    ,'100'     ,1    ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4345 ,'0.5'  ,'100'     ,0.5  ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4346 ,'0.5'  ,'100'     ,0.5  ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4347 ,'0.5'  ,'75'      ,0.5  ,75      ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4348 ,'0.5'  ,'75'      ,0.5  ,75      ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4349 ,'0.3'  ,'30'      ,0.3  ,30      ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4350 ,'0.3'  ,'30'      ,0.3  ,30      ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4351 ,'0.3'  ,'30'      ,0.3  ,30      ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4352 ,'0.09' ,'90'      ,0.09 ,90      ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4353 ,'0.5'  ,'100'     ,0.5  ,100     ,9    UNION ALL	--AUD	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
--MKK
SELECT 4310 ,'1'    ,'100'     ,1    ,100     ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4345 ,'0.5'  ,'100'     ,0.5  ,100     ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4346 ,'0.5'  ,'100'     ,0.5  ,100     ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4347 ,'0.5'  ,'75'      ,0.5  ,75      ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4348 ,'0.5'  ,'75'      ,0.5  ,75      ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4349 ,'0.3'  ,'30'      ,0.3  ,30      ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4350 ,'0.3'  ,'30'      ,0.3  ,30      ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4351 ,'0.3'  ,'30'      ,0.3  ,30      ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4352 ,'0.09' ,'90'      ,0.09 ,90      ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4353 ,'0.5'  ,'100'     ,0.5  ,100     ,70   UNION ALL	--MKK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
--MMK
SELECT 4310 ,'1'    ,'100'     ,1    ,100     ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4345 ,'0.5'  ,'100'     ,0.5  ,100     ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4346 ,'0.5'  ,'100'     ,0.5  ,100     ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4347 ,'0.5'  ,'75'      ,0.5  ,75      ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4348 ,'0.5'  ,'75'      ,0.5  ,75      ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4349 ,'0.3'  ,'30'      ,0.3  ,30      ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4350 ,'0.3'  ,'30'      ,0.3  ,30      ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4351 ,'0.3'  ,'30'      ,0.3  ,30      ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4352 ,'0.09' ,'90'      ,0.09 ,90      ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4353 ,'0.5'  ,'100'     ,0.5  ,100     ,69   UNION ALL	--MMK	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
--SD$
SELECT 4310 ,'1'    ,'100'     ,1    ,100     ,1    UNION ALL	--SD$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4345 ,'0.5'  ,'100'     ,0.5  ,100     ,1    UNION ALL	--SD$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4346 ,'0.5'  ,'100'     ,0.5  ,100     ,1    UNION ALL	--SD$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4347 ,'0.5'  ,'75'      ,0.5  ,75      ,1    UNION ALL	--SD$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4348 ,'0.5'  ,'75'      ,0.5  ,75      ,1    UNION ALL	--SD$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4349 ,'0.3'  ,'30'      ,0.3  ,30      ,1    UNION ALL	--SD$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4350 ,'0.3'  ,'30'      ,0.3  ,30      ,1    UNION ALL	--SD$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4351 ,'0.3'  ,'30'      ,0.3  ,30      ,1    UNION ALL	--SD$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4352 ,'0.09' ,'90'      ,0.09 ,90      ,1    UNION ALL	--SD$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4353 ,'0.5'  ,'100'     ,0.5  ,100     ,1    UNION ALL	--SD$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
--TH
SELECT 4310 ,'1'    ,'100'     ,1    ,100     ,74   UNION ALL	--TH	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4345 ,'0.5'  ,'100'     ,0.5  ,100     ,74   UNION ALL	--TH	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4346 ,'0.5'  ,'100'     ,0.5  ,100     ,74   UNION ALL	--TH	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4347 ,'0.5'  ,'75'      ,0.5  ,75      ,74   UNION ALL	--TH	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4348 ,'0.5'  ,'75'      ,0.5  ,75      ,74   UNION ALL	--TH	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4349 ,'0.3'  ,'30'      ,0.3  ,30      ,74   UNION ALL	--TH	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4350 ,'0.3'  ,'30'      ,0.3  ,30      ,74   UNION ALL	--TH	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4351 ,'0.3'  ,'30'      ,0.3  ,30      ,74   UNION ALL	--TH	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4352 ,'0.09' ,'90'      ,0.09 ,90      ,74   UNION ALL	--TH	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4353 ,'0.5'  ,'100'     ,0.5  ,100     ,74   UNION ALL	--TH	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
--US$
SELECT 4310 ,'1'    ,'100'     ,1    ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4345 ,'0.5'  ,'100'     ,0.5  ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4346 ,'0.5'  ,'100'     ,0.5  ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4347 ,'0.5'  ,'75'      ,0.5  ,75      ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4348 ,'0.5'  ,'75'      ,0.5  ,75      ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4349 ,'0.3'  ,'30'      ,0.3  ,30      ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4350 ,'0.3'  ,'30'      ,0.3  ,30      ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4351 ,'0.3'  ,'30'      ,0.3  ,30      ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4352 ,'0.09' ,'90'      ,0.09 ,90      ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4353 ,'0.5'  ,'100'     ,0.5  ,100     ,3    UNION ALL	--US$	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
--UT
SELECT 4310 ,'1'    ,'100'     ,1    ,100     ,64   UNION ALL	--UT	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4345 ,'0.5'  ,'100'     ,0.5  ,100     ,64   UNION ALL	--UT	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4346 ,'0.5'  ,'100'     ,0.5  ,100     ,64   UNION ALL	--UT	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4347 ,'0.5'  ,'75'      ,0.5  ,75      ,64   UNION ALL	--UT	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4348 ,'0.5'  ,'75'      ,0.5  ,75      ,64   UNION ALL	--UT	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4349 ,'0.3'  ,'30'      ,0.3  ,30      ,64   UNION ALL	--UT	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4350 ,'0.3'  ,'30'      ,0.3  ,30      ,64   UNION ALL	--UT	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4351 ,'0.3'  ,'30'      ,0.3  ,30      ,64   UNION ALL	--UT	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4352 ,'0.09' ,'90'      ,0.09 ,90      ,64   UNION ALL	--UT	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4353 ,'0.5'  ,'100'     ,0.5  ,100     ,64   UNION ALL	--UT	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
--UUS
SELECT 4310 ,'1'    ,'100'     ,1    ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4345 ,'0.5'  ,'100'     ,0.5  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4346 ,'0.5'  ,'100'     ,0.5  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4347 ,'0.5'  ,'75'      ,0.5  ,75      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4348 ,'0.5'  ,'75'      ,0.5  ,75      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4349 ,'0.3'  ,'30'      ,0.3  ,30      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4350 ,'0.3'  ,'30'      ,0.3  ,30      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4351 ,'0.3'  ,'30'      ,0.3  ,30      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4352 ,'0.09' ,'90'      ,0.09 ,90      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4353 ,'0.5'  ,'100'     ,0.5  ,100     ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
--Yen
SELECT 4310 ,'1'    ,'100'     ,1    ,100     ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4345 ,'0.5'  ,'100'     ,0.5  ,100     ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4346 ,'0.5'  ,'100'     ,0.5  ,100     ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4347 ,'0.5'  ,'75'      ,0.5  ,75      ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4348 ,'0.5'  ,'75'      ,0.5  ,75      ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4349 ,'0.3'  ,'30'      ,0.3  ,30      ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4350 ,'0.3'  ,'30'      ,0.3  ,30      ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4351 ,'0.3'  ,'30'      ,0.3  ,30      ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4352 ,'0.09' ,'90'      ,0.09 ,90      ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4353 ,'0.5'  ,'100'     ,0.5  ,100     ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
--YNG
SELECT 4310 ,'1'    ,'100'     ,1    ,100     ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4345 ,'0.5'  ,'100'     ,0.5  ,100     ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4346 ,'0.5'  ,'100'     ,0.5  ,100     ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4347 ,'0.5'  ,'75'      ,0.5  ,75      ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4348 ,'0.5'  ,'75'      ,0.5  ,75      ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4349 ,'0.3'  ,'30'      ,0.3  ,30      ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4350 ,'0.3'  ,'30'      ,0.3  ,30      ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4351 ,'0.3'  ,'30'      ,0.3  ,30      ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4352 ,'0.09' ,'90'      ,0.09 ,90      ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS
SELECT 4353 ,'0.5'  ,'100'     ,0.5  ,100     ,72				--YNG	--Yen, UT, $US, US$, TH,SD$,AUD,MMK, MKK,YNG,UUS		

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
