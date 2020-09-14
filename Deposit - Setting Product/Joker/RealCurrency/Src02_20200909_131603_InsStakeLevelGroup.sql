/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200909
	Task:  Insert Setting StakeLevelGroupDetail [Joker] - deposit RedmineID:#131603
	DB: DBCust/CustDB
*/
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(18))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--EURO
SELECT 6401 ,'0.01' ,'1'       ,0.01 ,1       ,6    UNION ALL	--EURO	--EURO
SELECT 6402 ,'0.01' ,'2'       ,0.01 ,2       ,6    UNION ALL	--EURO	--EURO
SELECT 6403 ,'0.01' ,'2'       ,0.01 ,2       ,6    UNION ALL	--EURO	--EURO
SELECT 6404 ,'0.01' ,'1'       ,0.01 ,1       ,6    UNION ALL	--EURO	--EURO
SELECT 6405 ,'0.01' ,'2'       ,0.01 ,2       ,6    UNION ALL	--EURO	--EURO
SELECT 6406 ,'0.01' ,'1'       ,0.01 ,1       ,6    UNION ALL	--EURO	--EURO
SELECT 6407 ,'0.01' ,'2'       ,0.01 ,2       ,6    UNION ALL	--EURO	--EURO
SELECT 6408 ,'0.01' ,'1'       ,0.01 ,1       ,6    UNION ALL	--EURO	--EURO
SELECT 6409 ,'0.01' ,'1'       ,0.01 ,1       ,6    UNION ALL	--EURO	--EURO
SELECT 6410 ,'0.01' ,'2'       ,0.01 ,2       ,6    UNION ALL	--EURO	--EURO
SELECT 6411 ,'0.01' ,'2'       ,0.01 ,2       ,6    UNION ALL	--EURO	--EURO
SELECT 6412 ,'0.01' ,'2'       ,0.01 ,2       ,6    UNION ALL	--EURO	--EURO
SELECT 6413 ,'0.01' ,'2'       ,0.01 ,2       ,6    UNION ALL	--EURO	--EURO
SELECT 6414 ,'0.01' ,'1'       ,0.01 ,1       ,6    UNION ALL	--EURO	--EURO
SELECT 6415 ,'0.01' ,'5'       ,0.01 ,5       ,6    UNION ALL	--EURO	--EURO
--HK$
SELECT 6401 ,'0.01' ,'3'       ,0.01 ,3       ,5    UNION ALL	--HK$	--HK$,HKK
SELECT 6402 ,'0.01' ,'6'       ,0.01 ,6       ,5    UNION ALL	--HK$	--HK$,HKK
SELECT 6403 ,'0.01' ,'6'       ,0.01 ,6       ,5    UNION ALL	--HK$	--HK$,HKK
SELECT 6404 ,'0.01' ,'3'       ,0.01 ,3       ,5    UNION ALL	--HK$	--HK$,HKK
SELECT 6405 ,'0.01' ,'6'       ,0.01 ,6       ,5    UNION ALL	--HK$	--HK$,HKK
SELECT 6406 ,'0.01' ,'6'       ,0.01 ,6       ,5    UNION ALL	--HK$	--HK$,HKK
SELECT 6407 ,'0.01' ,'6'       ,0.01 ,6       ,5    UNION ALL	--HK$	--HK$,HKK
SELECT 6408 ,'1'    ,'60'      ,1    ,60      ,5    UNION ALL	--HK$	--HK$,HKK
SELECT 6409 ,'0.01' ,'6'       ,0.01 ,6       ,5    UNION ALL	--HK$	--HK$,HKK
SELECT 6410 ,'1'    ,'10'      ,1    ,10      ,5    UNION ALL	--HK$	--HK$,HKK
SELECT 6411 ,'1'    ,'60'      ,1    ,60      ,5    UNION ALL	--HK$	--HK$,HKK
SELECT 6412 ,'1'    ,'60'      ,1    ,60      ,5    UNION ALL	--HK$	--HK$,HKK
SELECT 6413 ,'1'    ,'60'      ,1    ,60      ,5    UNION ALL	--HK$	--HK$,HKK
SELECT 6414 ,'0.01' ,'3'       ,0.01 ,3       ,5    UNION ALL	--HK$	--HK$,HKK
SELECT 6415 ,'0.9'  ,'15'      ,0.9  ,15      ,5    UNION ALL	--HK$	--HK$,HKK
--HKK
SELECT 6401 ,'0.01' ,'3'       ,0.01 ,3       ,67   UNION ALL	--HKK	--HK$,HKK
SELECT 6402 ,'0.01' ,'6'       ,0.01 ,6       ,67   UNION ALL	--HKK	--HK$,HKK
SELECT 6403 ,'0.01' ,'6'       ,0.01 ,6       ,67   UNION ALL	--HKK	--HK$,HKK
SELECT 6404 ,'0.01' ,'3'       ,0.01 ,3       ,67   UNION ALL	--HKK	--HK$,HKK
SELECT 6405 ,'0.01' ,'6'       ,0.01 ,6       ,67   UNION ALL	--HKK	--HK$,HKK
SELECT 6406 ,'0.01' ,'6'       ,0.01 ,6       ,67   UNION ALL	--HKK	--HK$,HKK
SELECT 6407 ,'0.01' ,'6'       ,0.01 ,6       ,67   UNION ALL	--HKK	--HK$,HKK
SELECT 6408 ,'1'    ,'60'      ,1    ,60      ,67   UNION ALL	--HKK	--HK$,HKK
SELECT 6409 ,'0.01' ,'6'       ,0.01 ,6       ,67   UNION ALL	--HKK	--HK$,HKK
SELECT 6410 ,'1'    ,'10'      ,1    ,10      ,67   UNION ALL	--HKK	--HK$,HKK
SELECT 6411 ,'1'    ,'60'      ,1    ,60      ,67   UNION ALL	--HKK	--HK$,HKK
SELECT 6412 ,'1'    ,'60'      ,1    ,60      ,67   UNION ALL	--HKK	--HK$,HKK
SELECT 6413 ,'1'    ,'60'      ,1    ,60      ,67   UNION ALL	--HKK	--HK$,HKK
SELECT 6414 ,'0.01' ,'3'       ,0.01 ,3       ,67   UNION ALL	--HKK	--HK$,HKK
SELECT 6415 ,'0.9'  ,'15'      ,0.9  ,15      ,67   UNION ALL	--HKK	--HK$,HKK
--DDD
SELECT 6401 ,'0.01' ,'0.2'     ,0.01 ,0.2     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6402 ,'0.01' ,'6'       ,0.01 ,6       ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6403 ,'0.01' ,'6'       ,0.01 ,6       ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6404 ,'0.01' ,'0.1'     ,0.01 ,0.1     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6405 ,'0.01' ,'6'       ,0.01 ,6       ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6406 ,'0.01' ,'6'       ,0.01 ,6       ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6407 ,'0.01' ,'6'       ,0.01 ,6       ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6408 ,'0.01' ,'6'       ,0.01 ,6       ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6409 ,'0.01' ,'6'       ,0.01 ,6       ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6410 ,'0.01' ,'1'       ,0.01 ,1       ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6411 ,'0.01' ,'6'       ,0.01 ,6       ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6412 ,'0.01' ,'6'       ,0.01 ,6       ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6413 ,'0.01' ,'6'       ,0.01 ,6       ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6414 ,'0.01' ,'0.2'     ,0.01 ,0.2     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6415 ,'0.01' ,'6'       ,0.01 ,6       ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
--IDD
SELECT 6401 ,'0.01' ,'0.2'     ,0.01 ,0.2     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6402 ,'0.01' ,'6'       ,0.01 ,6       ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6403 ,'0.01' ,'6'       ,0.01 ,6       ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6404 ,'0.01' ,'0.1'     ,0.01 ,0.1     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6405 ,'0.01' ,'6'       ,0.01 ,6       ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6406 ,'0.01' ,'6'       ,0.01 ,6       ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6407 ,'0.01' ,'6'       ,0.01 ,6       ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6408 ,'0.01' ,'6'       ,0.01 ,6       ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6409 ,'0.01' ,'6'       ,0.01 ,6       ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6410 ,'0.01' ,'1'       ,0.01 ,1       ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6411 ,'0.01' ,'6'       ,0.01 ,6       ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6412 ,'0.01' ,'6'       ,0.01 ,6       ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6413 ,'0.01' ,'6'       ,0.01 ,6       ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6414 ,'0.01' ,'0.2'     ,0.01 ,0.2     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6415 ,'0.01' ,'6'       ,0.01 ,6       ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
--IDR
SELECT 6401 ,'0.01' ,'0.2'     ,0.01 ,0.2     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6402 ,'0.01' ,'6'       ,0.01 ,6       ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6403 ,'0.01' ,'6'       ,0.01 ,6       ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6404 ,'0.01' ,'0.1'     ,0.01 ,0.1     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6405 ,'0.01' ,'6'       ,0.01 ,6       ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6406 ,'0.01' ,'6'       ,0.01 ,6       ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6407 ,'0.01' ,'6'       ,0.01 ,6       ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6408 ,'0.01' ,'6'       ,0.01 ,6       ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6409 ,'0.01' ,'6'       ,0.01 ,6       ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6410 ,'0.01' ,'1'       ,0.01 ,1       ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6411 ,'0.01' ,'6'       ,0.01 ,6       ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6412 ,'0.01' ,'6'       ,0.01 ,6       ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6413 ,'0.01' ,'6'       ,0.01 ,6       ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6414 ,'0.01' ,'0.2'     ,0.01 ,0.2     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6415 ,'0.01' ,'6'       ,0.01 ,6       ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
--IN
SELECT 6401 ,'0.01' ,'0.2'     ,0.01 ,0.2     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6402 ,'0.01' ,'6'       ,0.01 ,6       ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6403 ,'0.01' ,'6'       ,0.01 ,6       ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6404 ,'0.01' ,'0.1'     ,0.01 ,0.1     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6405 ,'0.01' ,'6'       ,0.01 ,6       ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6406 ,'0.01' ,'6'       ,0.01 ,6       ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6407 ,'0.01' ,'6'       ,0.01 ,6       ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6408 ,'0.01' ,'6'       ,0.01 ,6       ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6409 ,'0.01' ,'6'       ,0.01 ,6       ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6410 ,'0.01' ,'1'       ,0.01 ,1       ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6411 ,'0.01' ,'6'       ,0.01 ,6       ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6412 ,'0.01' ,'6'       ,0.01 ,6       ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6413 ,'0.01' ,'6'       ,0.01 ,6       ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6414 ,'0.01' ,'0.2'     ,0.01 ,0.2     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6415 ,'0.01' ,'6'       ,0.01 ,6       ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
--IND
SELECT 6401 ,'0.01' ,'0.2'     ,0.01 ,0.2     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6402 ,'0.01' ,'6'       ,0.01 ,6       ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6403 ,'0.01' ,'6'       ,0.01 ,6       ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6404 ,'0.01' ,'0.1'     ,0.01 ,0.1     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6405 ,'0.01' ,'6'       ,0.01 ,6       ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6406 ,'0.01' ,'6'       ,0.01 ,6       ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6407 ,'0.01' ,'6'       ,0.01 ,6       ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6408 ,'0.01' ,'6'       ,0.01 ,6       ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6409 ,'0.01' ,'6'       ,0.01 ,6       ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6410 ,'0.01' ,'1'       ,0.01 ,1       ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6411 ,'0.01' ,'6'       ,0.01 ,6       ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6412 ,'0.01' ,'6'       ,0.01 ,6       ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6413 ,'0.01' ,'6'       ,0.01 ,6       ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6414 ,'0.01' ,'0.2'     ,0.01 ,0.2     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6415 ,'0.01' ,'6'       ,0.01 ,6       ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
--UUS
SELECT 6401 ,'0.01' ,'0.2'     ,0.01 ,0.2     ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6402 ,'0.01' ,'6'       ,0.01 ,6       ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6403 ,'0.01' ,'6'       ,0.01 ,6       ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6404 ,'0.01' ,'0.1'     ,0.01 ,0.1     ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6405 ,'0.01' ,'6'       ,0.01 ,6       ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6406 ,'0.01' ,'6'       ,0.01 ,6       ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6407 ,'0.01' ,'6'       ,0.01 ,6       ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6408 ,'0.01' ,'6'       ,0.01 ,6       ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6409 ,'0.01' ,'6'       ,0.01 ,6       ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6410 ,'0.01' ,'1'       ,0.01 ,1       ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6411 ,'0.01' ,'6'       ,0.01 ,6       ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6412 ,'0.01' ,'6'       ,0.01 ,6       ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6413 ,'0.01' ,'6'       ,0.01 ,6       ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6414 ,'0.01' ,'0.2'     ,0.01 ,0.2     ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6415 ,'0.01' ,'6'       ,0.01 ,6       ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
--INR
SELECT 6401 ,'100'  ,'2000'    ,100  ,2000    ,61   UNION ALL	--INR	--INR
SELECT 6402 ,'100'  ,'2000'    ,100  ,2000    ,61   UNION ALL	--INR	--INR
SELECT 6403 ,'100'  ,'2000'    ,100  ,2000    ,61   UNION ALL	--INR	--INR
SELECT 6404 ,'100'  ,'2000'    ,100  ,2000    ,61   UNION ALL	--INR	--INR
SELECT 6405 ,'100'  ,'2000'    ,100  ,2000    ,61   UNION ALL	--INR	--INR
SELECT 6406 ,'100'  ,'2000'    ,100  ,2000    ,61   UNION ALL	--INR	--INR
SELECT 6407 ,'100'  ,'2000'    ,100  ,2000    ,61   UNION ALL	--INR	--INR
SELECT 6408 ,'100'  ,'2000'    ,100  ,2000    ,61   UNION ALL	--INR	--INR
SELECT 6409 ,'100'  ,'2000'    ,100  ,2000    ,61   UNION ALL	--INR	--INR
SELECT 6410 ,'100'  ,'2000'    ,100  ,2000    ,61   UNION ALL	--INR	--INR
SELECT 6411 ,'100'  ,'2000'    ,100  ,2000    ,61   UNION ALL	--INR	--INR
SELECT 6412 ,'100'  ,'2000'    ,100  ,2000    ,61   UNION ALL	--INR	--INR
SELECT 6413 ,'100'  ,'2000'    ,100  ,2000    ,61   UNION ALL	--INR	--INR
SELECT 6414 ,'100'  ,'2000'    ,100  ,2000    ,61   UNION ALL	--INR	--INR
SELECT 6415 ,'100'  ,'2000'    ,100  ,2000    ,61   UNION ALL	--INR	--INR
--MMK
SELECT 6401 ,'10'   ,'300'     ,10   ,300     ,69   UNION ALL	--MMK	--MMK
SELECT 6402 ,'10'   ,'600'     ,10   ,600     ,69   UNION ALL	--MMK	--MMK
SELECT 6403 ,'10'   ,'600'     ,10   ,600     ,69   UNION ALL	--MMK	--MMK
SELECT 6404 ,'10'   ,'300'     ,10   ,300     ,69   UNION ALL	--MMK	--MMK
SELECT 6405 ,'10'   ,'600'     ,10   ,600     ,69   UNION ALL	--MMK	--MMK
SELECT 6406 ,'10'   ,'600'     ,10   ,600     ,69   UNION ALL	--MMK	--MMK
SELECT 6407 ,'10'   ,'600'     ,10   ,600     ,69   UNION ALL	--MMK	--MMK
SELECT 6408 ,'10'   ,'600'     ,10   ,600     ,69   UNION ALL	--MMK	--MMK
SELECT 6409 ,'10'   ,'600'     ,10   ,600     ,69   UNION ALL	--MMK	--MMK
SELECT 6410 ,'10'   ,'600'     ,10   ,600     ,69   UNION ALL	--MMK	--MMK
SELECT 6411 ,'10'   ,'600'     ,10   ,600     ,69   UNION ALL	--MMK	--MMK
SELECT 6412 ,'10'   ,'600'     ,10   ,600     ,69   UNION ALL	--MMK	--MMK
SELECT 6413 ,'10'   ,'600'     ,10   ,600     ,69   UNION ALL	--MMK	--MMK
SELECT 6414 ,'10'   ,'300'     ,10   ,300     ,69   UNION ALL	--MMK	--MMK
SELECT 6415 ,'10'   ,'600'     ,10   ,600     ,69   UNION ALL	--MMK	--MMK
--RM
SELECT 6401 ,'0.01' ,'1'       ,0.01 ,1       ,2    UNION ALL	--RM	--RM
SELECT 6402 ,'0.01' ,'2'       ,0.01 ,2       ,2    UNION ALL	--RM	--RM
SELECT 6403 ,'0.01' ,'2'       ,0.01 ,2       ,2    UNION ALL	--RM	--RM
SELECT 6404 ,'0.01' ,'1'       ,0.01 ,1       ,2    UNION ALL	--RM	--RM
SELECT 6405 ,'0.01' ,'2'       ,0.01 ,2       ,2    UNION ALL	--RM	--RM
SELECT 6406 ,'0.01' ,'1'       ,0.01 ,1       ,2    UNION ALL	--RM	--RM
SELECT 6407 ,'0.01' ,'2'       ,0.01 ,2       ,2    UNION ALL	--RM	--RM
SELECT 6408 ,'0.01' ,'1'       ,0.01 ,1       ,2    UNION ALL	--RM	--RM
SELECT 6409 ,'0.01' ,'1'       ,0.01 ,1       ,2    UNION ALL	--RM	--RM
SELECT 6410 ,'0.01' ,'1'       ,0.01 ,1       ,2    UNION ALL	--RM	--RM
SELECT 6411 ,'0.01' ,'2'       ,0.01 ,2       ,2    UNION ALL	--RM	--RM
SELECT 6412 ,'0.01' ,'2'       ,0.01 ,2       ,2    UNION ALL	--RM	--RM
SELECT 6413 ,'0.01' ,'2'       ,0.01 ,2       ,2    UNION ALL	--RM	--RM
SELECT 6414 ,'0.01' ,'1'       ,0.01 ,1       ,2    UNION ALL	--RM	--RM
SELECT 6415 ,'0.01' ,'5'       ,0.01 ,5       ,2    UNION ALL	--RM	--RM
-RMB
SELECT 6401 ,'1'    ,'200'     ,1    ,200     ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6402 ,'1'    ,'500'     ,1    ,500     ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6403 ,'1'    ,'500'     ,1    ,500     ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6404 ,'1'    ,'200'     ,1    ,200     ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6405 ,'1'    ,'500'     ,1    ,500     ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6406 ,'1'    ,'500'     ,1    ,500     ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6407 ,'1'    ,'500'     ,1    ,500     ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6408 ,'1'    ,'500'     ,1    ,500     ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6409 ,'1'    ,'500'     ,1    ,500     ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6410 ,'1'    ,'500'     ,1    ,500     ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6411 ,'1'    ,'500'     ,1    ,500     ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6412 ,'1'    ,'500'     ,1    ,500     ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6413 ,'1'    ,'500'     ,1    ,500     ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6414 ,'1'    ,'200'     ,1    ,200     ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6415 ,'1'    ,'500'     ,1    ,500     ,13   UNION ALL	--RMB	--RMB,YUN
--YUN
SELECT 6401 ,'1'    ,'200'     ,1    ,200     ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6402 ,'1'    ,'500'     ,1    ,500     ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6403 ,'1'    ,'500'     ,1    ,500     ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6404 ,'1'    ,'200'     ,1    ,200     ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6405 ,'1'    ,'500'     ,1    ,500     ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6406 ,'1'    ,'500'     ,1    ,500     ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6407 ,'1'    ,'500'     ,1    ,500     ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6408 ,'1'    ,'500'     ,1    ,500     ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6409 ,'1'    ,'500'     ,1    ,500     ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6410 ,'1'    ,'500'     ,1    ,500     ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6411 ,'1'    ,'500'     ,1    ,500     ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6412 ,'1'    ,'500'     ,1    ,500     ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6413 ,'1'    ,'500'     ,1    ,500     ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6414 ,'1'    ,'200'     ,1    ,200     ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6415 ,'1'    ,'500'     ,1    ,500     ,66   UNION ALL	--YUN	--RMB,YUN
--TB
SELECT 6401 ,'10'   ,'1000'    ,10   ,1000    ,4    UNION ALL	--TB	--TB,THB
SELECT 6402 ,'10'   ,'2000'    ,10   ,2000    ,4    UNION ALL	--TB	--TB,THB
SELECT 6403 ,'10'   ,'2000'    ,10   ,2000    ,4    UNION ALL	--TB	--TB,THB
SELECT 6404 ,'10'   ,'1000'    ,10   ,1000    ,4    UNION ALL	--TB	--TB,THB
SELECT 6405 ,'10'   ,'2000'    ,10   ,2000    ,4    UNION ALL	--TB	--TB,THB
SELECT 6406 ,'10'   ,'1000'    ,10   ,1000    ,4    UNION ALL	--TB	--TB,THB
SELECT 6407 ,'10'   ,'2000'    ,10   ,2000    ,4    UNION ALL	--TB	--TB,THB
SELECT 6408 ,'10'   ,'300'     ,10   ,300     ,4    UNION ALL	--TB	--TB,THB
SELECT 6409 ,'10'   ,'300'     ,10   ,300     ,4    UNION ALL	--TB	--TB,THB
SELECT 6410 ,'10'   ,'1000'    ,10   ,1000    ,4    UNION ALL	--TB	--TB,THB
SELECT 6411 ,'10'   ,'2000'    ,10   ,2000    ,4    UNION ALL	--TB	--TB,THB
SELECT 6412 ,'10'   ,'2000'    ,10   ,2000    ,4    UNION ALL	--TB	--TB,THB
SELECT 6413 ,'10'   ,'2000'    ,10   ,2000    ,4    UNION ALL	--TB	--TB,THB
SELECT 6414 ,'10'   ,'1000'    ,10   ,1000    ,4    UNION ALL	--TB	--TB,THB
SELECT 6415 ,'10'   ,'2000'    ,10   ,2000    ,4    UNION ALL	--TB	--TB,THB
--THB
SELECT 6401 ,'10'   ,'1000'    ,10   ,1000    ,43   UNION ALL	--THB	--TB,THB
SELECT 6402 ,'10'   ,'2000'    ,10   ,2000    ,43   UNION ALL	--THB	--TB,THB
SELECT 6403 ,'10'   ,'2000'    ,10   ,2000    ,43   UNION ALL	--THB	--TB,THB
SELECT 6404 ,'10'   ,'1000'    ,10   ,1000    ,43   UNION ALL	--THB	--TB,THB
SELECT 6405 ,'10'   ,'2000'    ,10   ,2000    ,43   UNION ALL	--THB	--TB,THB
SELECT 6406 ,'10'   ,'1000'    ,10   ,1000    ,43   UNION ALL	--THB	--TB,THB
SELECT 6407 ,'10'   ,'2000'    ,10   ,2000    ,43   UNION ALL	--THB	--TB,THB
SELECT 6408 ,'10'   ,'300'     ,10   ,300     ,43   UNION ALL	--THB	--TB,THB
SELECT 6409 ,'10'   ,'300'     ,10   ,300     ,43   UNION ALL	--THB	--TB,THB
SELECT 6410 ,'10'   ,'1000'    ,10   ,1000    ,43   UNION ALL	--THB	--TB,THB
SELECT 6411 ,'10'   ,'2000'    ,10   ,2000    ,43   UNION ALL	--THB	--TB,THB
SELECT 6412 ,'10'   ,'2000'    ,10   ,2000    ,43   UNION ALL	--THB	--TB,THB
SELECT 6413 ,'10'   ,'2000'    ,10   ,2000    ,43   UNION ALL	--THB	--TB,THB
SELECT 6414 ,'10'   ,'1000'    ,10   ,1000    ,43   UNION ALL	--THB	--TB,THB
SELECT 6415 ,'10'   ,'2000'    ,10   ,2000    ,43   UNION ALL	--THB	--TB,THB
--$US
SELECT 6401 ,'0.01' ,'1'       ,0.01 ,1       ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6402 ,'0.01' ,'2'       ,0.01 ,2       ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6403 ,'0.01' ,'1'       ,0.01 ,1       ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6404 ,'0.01' ,'1'       ,0.01 ,1       ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6405 ,'0.01' ,'2'       ,0.01 ,2       ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6406 ,'0.01' ,'1'       ,0.01 ,1       ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6407 ,'0.01' ,'2'       ,0.01 ,2       ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6408 ,'0.01' ,'1'       ,0.01 ,1       ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6409 ,'0.01' ,'1'       ,0.01 ,1       ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6410 ,'0.01' ,'1'       ,0.01 ,1       ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6411 ,'0.01' ,'2'       ,0.01 ,2       ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6412 ,'0.01' ,'2'       ,0.01 ,2       ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6413 ,'0.01' ,'2'       ,0.01 ,2       ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6414 ,'0.01' ,'1'       ,0.01 ,1       ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6415 ,'0.01' ,'5'       ,0.01 ,5       ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
--US$
SELECT 6401 ,'0.01' ,'1'       ,0.01 ,1       ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6402 ,'0.01' ,'2'       ,0.01 ,2       ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6403 ,'0.01' ,'1'       ,0.01 ,1       ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6404 ,'0.01' ,'1'       ,0.01 ,1       ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6405 ,'0.01' ,'2'       ,0.01 ,2       ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6406 ,'0.01' ,'1'       ,0.01 ,1       ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6407 ,'0.01' ,'2'       ,0.01 ,2       ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6408 ,'0.01' ,'1'       ,0.01 ,1       ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6409 ,'0.01' ,'1'       ,0.01 ,1       ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6410 ,'0.01' ,'1'       ,0.01 ,1       ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6411 ,'0.01' ,'2'       ,0.01 ,2       ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6412 ,'0.01' ,'2'       ,0.01 ,2       ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6413 ,'0.01' ,'2'       ,0.01 ,2       ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6414 ,'0.01' ,'1'       ,0.01 ,1       ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6415 ,'0.01' ,'5'       ,0.01 ,5       ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
--USD
SELECT 6401 ,'0.01' ,'1'       ,0.01 ,1       ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6402 ,'0.01' ,'2'       ,0.01 ,2       ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6403 ,'0.01' ,'1'       ,0.01 ,1       ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6404 ,'0.01' ,'1'       ,0.01 ,1       ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6405 ,'0.01' ,'2'       ,0.01 ,2       ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6406 ,'0.01' ,'1'       ,0.01 ,1       ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6407 ,'0.01' ,'2'       ,0.01 ,2       ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6408 ,'0.01' ,'1'       ,0.01 ,1       ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6409 ,'0.01' ,'1'       ,0.01 ,1       ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6410 ,'0.01' ,'1'       ,0.01 ,1       ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6411 ,'0.01' ,'2'       ,0.01 ,2       ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6412 ,'0.01' ,'2'       ,0.01 ,2       ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6413 ,'0.01' ,'2'       ,0.01 ,2       ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6414 ,'0.01' ,'1'       ,0.01 ,1       ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6415 ,'0.01' ,'5'       ,0.01 ,5       ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
--UT
SELECT 6401 ,'0.01' ,'1'       ,0.01 ,1       ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6402 ,'0.01' ,'2'       ,0.01 ,2       ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6403 ,'0.01' ,'1'       ,0.01 ,1       ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6404 ,'0.01' ,'1'       ,0.01 ,1       ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6405 ,'0.01' ,'2'       ,0.01 ,2       ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6406 ,'0.01' ,'1'       ,0.01 ,1       ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6407 ,'0.01' ,'2'       ,0.01 ,2       ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6408 ,'0.01' ,'1'       ,0.01 ,1       ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6409 ,'0.01' ,'1'       ,0.01 ,1       ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6410 ,'0.01' ,'1'       ,0.01 ,1       ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6411 ,'0.01' ,'2'       ,0.01 ,2       ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6412 ,'0.01' ,'2'       ,0.01 ,2       ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6413 ,'0.01' ,'2'       ,0.01 ,2       ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6414 ,'0.01' ,'1'       ,0.01 ,1       ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6415 ,'0.01' ,'5'       ,0.01 ,5       ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
--Yen
SELECT 6401 ,'0.01' ,'1'       ,0.01 ,1       ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6402 ,'0.01' ,'2'       ,0.01 ,2       ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6403 ,'0.01' ,'1'       ,0.01 ,1       ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6404 ,'0.01' ,'1'       ,0.01 ,1       ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6405 ,'0.01' ,'2'       ,0.01 ,2       ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6406 ,'0.01' ,'1'       ,0.01 ,1       ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6407 ,'0.01' ,'2'       ,0.01 ,2       ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6408 ,'0.01' ,'1'       ,0.01 ,1       ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6409 ,'0.01' ,'1'       ,0.01 ,1       ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6410 ,'0.01' ,'1'       ,0.01 ,1       ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6411 ,'0.01' ,'2'       ,0.01 ,2       ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6412 ,'0.01' ,'2'       ,0.01 ,2       ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6413 ,'0.01' ,'2'       ,0.01 ,2       ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6414 ,'0.01' ,'1'       ,0.01 ,1       ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6415 ,'0.01' ,'5'       ,0.01 ,5       ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
--Won
SELECT 6401 ,'10'   ,'300'     ,10   ,300     ,45   UNION ALL	--Won	--Won
SELECT 6402 ,'10'   ,'600'     ,10   ,600     ,45   UNION ALL	--Won	--Won
SELECT 6403 ,'10'   ,'600'     ,10   ,600     ,45   UNION ALL	--Won	--Won
SELECT 6404 ,'10'   ,'300'     ,10   ,300     ,45   UNION ALL	--Won	--Won
SELECT 6405 ,'10'   ,'600'     ,10   ,600     ,45   UNION ALL	--Won	--Won
SELECT 6406 ,'10'   ,'600'     ,10   ,600     ,45   UNION ALL	--Won	--Won
SELECT 6407 ,'10'   ,'600'     ,10   ,600     ,45   UNION ALL	--Won	--Won
SELECT 6408 ,'10'   ,'600'     ,10   ,600     ,45   UNION ALL	--Won	--Won
SELECT 6409 ,'10'   ,'600'     ,10   ,600     ,45   UNION ALL	--Won	--Won
SELECT 6410 ,'10'   ,'600'     ,10   ,600     ,45   UNION ALL	--Won	--Won
SELECT 6411 ,'10'   ,'600'     ,10   ,600     ,45   UNION ALL	--Won	--Won
SELECT 6412 ,'10'   ,'600'     ,10   ,600     ,45   UNION ALL	--Won	--Won
SELECT 6413 ,'10'   ,'600'     ,10   ,600     ,45   UNION ALL	--Won	--Won
SELECT 6414 ,'10'   ,'300'     ,10   ,300     ,45   UNION ALL	--Won	--Won
SELECT 6415 ,'10'   ,'600'     ,10   ,600     ,45				--Won	--Won   

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #Dep_StakeLevel_Temp t
WHERE MaxStake > 999

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #Dep_StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 6401)

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
DROP TABLE #Dep_StakeLevel_Temp
PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 