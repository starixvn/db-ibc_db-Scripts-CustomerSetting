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
--HK$
SELECT 6401 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,5    UNION ALL	--HK$	--HK$,HKK
SELECT 6402 ,'0.5'  ,'8'       ,0.5  ,8       ,5    UNION ALL	--HK$	--HK$,HKK
SELECT 6403 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,5    UNION ALL	--HK$	--HK$,HKK
SELECT 6404 ,'0.18' ,'3'       ,0.18 ,3       ,5    UNION ALL	--HK$	--HK$,HKK
SELECT 6405 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,5    UNION ALL	--HK$	--HK$,HKK
SELECT 6406 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,5    UNION ALL	--HK$	--HK$,HKK
SELECT 6407 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,5    UNION ALL	--HK$	--HK$,HKK
SELECT 6408 ,'0.18' ,'3'       ,0.18 ,3       ,5    UNION ALL	--HK$	--HK$,HKK
SELECT 6409 ,'0.18' ,'3'       ,0.18 ,3       ,5    UNION ALL	--HK$	--HK$,HKK
SELECT 6410 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,5    UNION ALL	--HK$	--HK$,HKK
SELECT 6411 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,5    UNION ALL	--HK$	--HK$,HKK
SELECT 6412 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,5    UNION ALL	--HK$	--HK$,HKK
SELECT 6413 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,5    UNION ALL	--HK$	--HK$,HKK
SELECT 6414 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,5    UNION ALL	--HK$	--HK$,HKK
SELECT 6415 ,'0.9'  ,'15'      ,0.9  ,15      ,5    UNION ALL	--HK$	--HK$,HKK
--HKK
SELECT 6401 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,67   UNION ALL	--HKK	--HK$,HKK
SELECT 6402 ,'0.5'  ,'8'       ,0.5  ,8       ,67   UNION ALL	--HKK	--HK$,HKK
SELECT 6403 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,67   UNION ALL	--HKK	--HK$,HKK
SELECT 6404 ,'0.18' ,'3'       ,0.18 ,3       ,67   UNION ALL	--HKK	--HK$,HKK
SELECT 6405 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,67   UNION ALL	--HKK	--HK$,HKK
SELECT 6406 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,67   UNION ALL	--HKK	--HK$,HKK
SELECT 6407 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,67   UNION ALL	--HKK	--HK$,HKK
SELECT 6408 ,'0.18' ,'3'       ,0.18 ,3       ,67   UNION ALL	--HKK	--HK$,HKK
SELECT 6409 ,'0.18' ,'3'       ,0.18 ,3       ,67   UNION ALL	--HKK	--HK$,HKK
SELECT 6410 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,67   UNION ALL	--HKK	--HK$,HKK
SELECT 6411 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,67   UNION ALL	--HKK	--HK$,HKK
SELECT 6412 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,67   UNION ALL	--HKK	--HK$,HKK
SELECT 6413 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,67   UNION ALL	--HKK	--HK$,HKK
SELECT 6414 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,67   UNION ALL	--HKK	--HK$,HKK
SELECT 6415 ,'0.9'  ,'15'      ,0.9  ,15      ,67   UNION ALL	--HKK	--HK$,HKK
--DDD
SELECT 6401 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6402 ,'0.5'  ,'8'       ,0.5  ,8       ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6403 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6404 ,'0.18' ,'3'       ,0.18 ,3       ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6405 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6406 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6407 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6408 ,'0.18' ,'3'       ,0.18 ,3       ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6409 ,'0.18' ,'3'       ,0.18 ,3       ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6410 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6411 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6412 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6413 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6414 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6415 ,'0.9'  ,'15'      ,0.9  ,15      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
--IDD
SELECT 6401 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6402 ,'0.5'  ,'8'       ,0.5  ,8       ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6403 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6404 ,'0.18' ,'3'       ,0.18 ,3       ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6405 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6406 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6407 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6408 ,'0.18' ,'3'       ,0.18 ,3       ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6409 ,'0.18' ,'3'       ,0.18 ,3       ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6410 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6411 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6412 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6413 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6414 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6415 ,'0.9'  ,'15'      ,0.9  ,15      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
--IDR
SELECT 6401 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6402 ,'0.5'  ,'8'       ,0.5  ,8       ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6403 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6404 ,'0.18' ,'3'       ,0.18 ,3       ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6405 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6406 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6407 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6408 ,'0.18' ,'3'       ,0.18 ,3       ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6409 ,'0.18' ,'3'       ,0.18 ,3       ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6410 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6411 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6412 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6413 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6414 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6415 ,'0.9'  ,'15'      ,0.9  ,15      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
--IN
SELECT 6401 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6402 ,'0.5'  ,'8'       ,0.5  ,8       ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6403 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6404 ,'0.18' ,'3'       ,0.18 ,3       ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6405 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6406 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6407 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6408 ,'0.18' ,'3'       ,0.18 ,3       ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6409 ,'0.18' ,'3'       ,0.18 ,3       ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6410 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6411 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6412 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6413 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6414 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6415 ,'0.9'  ,'15'      ,0.9  ,15      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
--IND
SELECT 6401 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6402 ,'0.5'  ,'8'       ,0.5  ,8       ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6403 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6404 ,'0.18' ,'3'       ,0.18 ,3       ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6405 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6406 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6407 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6408 ,'0.18' ,'3'       ,0.18 ,3       ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6409 ,'0.18' ,'3'       ,0.18 ,3       ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6410 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6411 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6412 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6413 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6414 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6415 ,'0.9'  ,'15'      ,0.9  ,15      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
--UUS
SELECT 6401 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6402 ,'0.5'  ,'8'       ,0.5  ,8       ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6403 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6404 ,'0.18' ,'3'       ,0.18 ,3       ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6405 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6406 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6407 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6408 ,'0.18' ,'3'       ,0.18 ,3       ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6409 ,'0.18' ,'3'       ,0.18 ,3       ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6410 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6411 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6412 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6413 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6414 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6415 ,'0.9'  ,'15'      ,0.9  ,15      ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
--MMK
SELECT 6401 ,'200'  ,'3500'    ,200  ,3500    ,69   UNION ALL	--MMK	--MMK
SELECT 6402 ,'500'  ,'8000'    ,500  ,8000    ,69   UNION ALL	--MMK	--MMK
SELECT 6403 ,'450'  ,'7500'    ,450  ,7500    ,69   UNION ALL	--MMK	--MMK
SELECT 6404 ,'180'  ,'3000'    ,180  ,3000    ,69   UNION ALL	--MMK	--MMK
SELECT 6405 ,'450'  ,'7500'    ,450  ,7500    ,69   UNION ALL	--MMK	--MMK
SELECT 6406 ,'200'  ,'3500'    ,200  ,3500    ,69   UNION ALL	--MMK	--MMK
SELECT 6407 ,'450'  ,'7500'    ,450  ,7500    ,69   UNION ALL	--MMK	--MMK
SELECT 6408 ,'180'  ,'3000'    ,180  ,3000    ,69   UNION ALL	--MMK	--MMK
SELECT 6409 ,'180'  ,'3000'    ,180  ,3000    ,69   UNION ALL	--MMK	--MMK
SELECT 6410 ,'200'  ,'3500'    ,200  ,3500    ,69   UNION ALL	--MMK	--MMK
SELECT 6411 ,'450'  ,'7500'    ,450  ,7500    ,69   UNION ALL	--MMK	--MMK
SELECT 6412 ,'450'  ,'7500'    ,450  ,7500    ,69   UNION ALL	--MMK	--MMK
SELECT 6413 ,'450'  ,'7500'    ,450  ,7500    ,69   UNION ALL	--MMK	--MMK
SELECT 6414 ,'200'  ,'3500'    ,200  ,3500    ,69   UNION ALL	--MMK	--MMK
SELECT 6415 ,'900'  ,'15000'   ,900  ,15000   ,69   UNION ALL	--MMK	--MMK
--RM
SELECT 6401 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,2    UNION ALL	--RM	--RM
SELECT 6402 ,'0.5'  ,'8'       ,0.5  ,8       ,2    UNION ALL	--RM	--RM
SELECT 6403 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,2    UNION ALL	--RM	--RM
SELECT 6404 ,'0.18' ,'3'       ,0.18 ,3       ,2    UNION ALL	--RM	--RM
SELECT 6405 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,2    UNION ALL	--RM	--RM
SELECT 6406 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,2    UNION ALL	--RM	--RM
SELECT 6407 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,2    UNION ALL	--RM	--RM
SELECT 6408 ,'0.18' ,'3'       ,0.18 ,3       ,2    UNION ALL	--RM	--RM
SELECT 6409 ,'0.18' ,'3'       ,0.18 ,3       ,2    UNION ALL	--RM	--RM
SELECT 6410 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,2    UNION ALL	--RM	--RM
SELECT 6411 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,2    UNION ALL	--RM	--RM
SELECT 6412 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,2    UNION ALL	--RM	--RM
SELECT 6413 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,2    UNION ALL	--RM	--RM
SELECT 6414 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,2    UNION ALL	--RM	--RM
SELECT 6415 ,'0.9'  ,'15'      ,0.9  ,15      ,2    UNION ALL	--RM	--RM
--RMB
SELECT 6401 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6402 ,'0.5'  ,'8'       ,0.5  ,8       ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6403 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6404 ,'0.18' ,'3'       ,0.18 ,3       ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6405 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6406 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6407 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6408 ,'0.18' ,'3'       ,0.18 ,3       ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6409 ,'0.18' ,'3'       ,0.18 ,3       ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6410 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6411 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6412 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6413 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6414 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6415 ,'0.9'  ,'15'      ,0.9  ,15      ,13   UNION ALL	--RMB	--RMB,YUN
--YUN
SELECT 6401 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6402 ,'0.5'  ,'8'       ,0.5  ,8       ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6403 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6404 ,'0.18' ,'3'       ,0.18 ,3       ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6405 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6406 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6407 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6408 ,'0.18' ,'3'       ,0.18 ,3       ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6409 ,'0.18' ,'3'       ,0.18 ,3       ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6410 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6411 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6412 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6413 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6414 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6415 ,'0.9'  ,'15'      ,0.9  ,15      ,66   UNION ALL	--YUN	--RMB,YUN
--TB
SELECT 6401 ,'200'  ,'3500'    ,200  ,3500    ,4    UNION ALL	--TB	--TB,THB
SELECT 6402 ,'5'    ,'80'      ,5    ,80      ,4    UNION ALL	--TB	--TB,THB
SELECT 6403 ,'4.5'  ,'75'      ,4.5  ,75      ,4    UNION ALL	--TB	--TB,THB
SELECT 6404 ,'180'  ,'3000'    ,180  ,3000    ,4    UNION ALL	--TB	--TB,THB
SELECT 6405 ,'4.5'  ,'75'      ,4.5  ,75      ,4    UNION ALL	--TB	--TB,THB
SELECT 6406 ,'2'    ,'35'      ,2    ,35      ,4    UNION ALL	--TB	--TB,THB
SELECT 6407 ,'450'  ,'7500'    ,450  ,7500    ,4    UNION ALL	--TB	--TB,THB
SELECT 6408 ,'180'  ,'3000'    ,180  ,3000    ,4    UNION ALL	--TB	--TB,THB
SELECT 6409 ,'1.8'  ,'30'      ,1.8  ,30      ,4    UNION ALL	--TB	--TB,THB
SELECT 6410 ,'200'  ,'3500'    ,200  ,3500    ,4    UNION ALL	--TB	--TB,THB
SELECT 6411 ,'4.5'  ,'75'      ,4.5  ,75      ,4    UNION ALL	--TB	--TB,THB
SELECT 6412 ,'4.5'  ,'75'      ,4.5  ,75      ,4    UNION ALL	--TB	--TB,THB
SELECT 6413 ,'4.5'  ,'75'      ,4.5  ,75      ,4    UNION ALL	--TB	--TB,THB
SELECT 6414 ,'200'  ,'3500'    ,200  ,3500    ,4    UNION ALL	--TB	--TB,THB
SELECT 6415 ,'9'    ,'150'     ,9    ,150     ,4    UNION ALL	--TB	--TB,THB
--THB
SELECT 6401 ,'200'  ,'3500'    ,200  ,3500    ,43   UNION ALL	--THB	--TB,THB
SELECT 6402 ,'5'    ,'80'      ,5    ,80      ,43   UNION ALL	--THB	--TB,THB
SELECT 6403 ,'4.5'  ,'75'      ,4.5  ,75      ,43   UNION ALL	--THB	--TB,THB
SELECT 6404 ,'180'  ,'3000'    ,180  ,3000    ,43   UNION ALL	--THB	--TB,THB
SELECT 6405 ,'4.5'  ,'75'      ,4.5  ,75      ,43   UNION ALL	--THB	--TB,THB
SELECT 6406 ,'2'    ,'35'      ,2    ,35      ,43   UNION ALL	--THB	--TB,THB
SELECT 6407 ,'450'  ,'7500'    ,450  ,7500    ,43   UNION ALL	--THB	--TB,THB
SELECT 6408 ,'180'  ,'3000'    ,180  ,3000    ,43   UNION ALL	--THB	--TB,THB
SELECT 6409 ,'1.8'  ,'30'      ,1.8  ,30      ,43   UNION ALL	--THB	--TB,THB
SELECT 6410 ,'200'  ,'3500'    ,200  ,3500    ,43   UNION ALL	--THB	--TB,THB
SELECT 6411 ,'4.5'  ,'75'      ,4.5  ,75      ,43   UNION ALL	--THB	--TB,THB
SELECT 6412 ,'4.5'  ,'75'      ,4.5  ,75      ,43   UNION ALL	--THB	--TB,THB
SELECT 6413 ,'4.5'  ,'75'      ,4.5  ,75      ,43   UNION ALL	--THB	--TB,THB
SELECT 6414 ,'200'  ,'3500'    ,200  ,3500    ,43   UNION ALL	--THB	--TB,THB
SELECT 6415 ,'9'    ,'150'     ,9    ,150     ,43   UNION ALL	--THB	--TB,THB
--$US
SELECT 6401 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6402 ,'0.5'  ,'8'       ,0.5  ,8       ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6403 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6404 ,'0.18' ,'3'       ,0.18 ,3       ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6405 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6406 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6407 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6408 ,'0.18' ,'3'       ,0.18 ,3       ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6409 ,'0.18' ,'3'       ,0.18 ,3       ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6410 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6411 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6412 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6413 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6414 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6415 ,'0.9'  ,'15'      ,0.9  ,15      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
--US$
SELECT 6401 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6402 ,'0.5'  ,'8'       ,0.5  ,8       ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6403 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6404 ,'0.18' ,'3'       ,0.18 ,3       ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6405 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6406 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6407 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6408 ,'0.18' ,'3'       ,0.18 ,3       ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6409 ,'0.18' ,'3'       ,0.18 ,3       ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6410 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6411 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6412 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6413 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6414 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6415 ,'0.9'  ,'15'      ,0.9  ,15      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
--USD
SELECT 6401 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6402 ,'0.5'  ,'8'       ,0.5  ,8       ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6403 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6404 ,'0.18' ,'3'       ,0.18 ,3       ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6405 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6406 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6407 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6408 ,'0.18' ,'3'       ,0.18 ,3       ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6409 ,'0.18' ,'3'       ,0.18 ,3       ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6410 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6411 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6412 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6413 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6414 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6415 ,'0.9'  ,'15'      ,0.9  ,15      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
--UT
SELECT 6401 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6402 ,'0.5'  ,'8'       ,0.5  ,8       ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6403 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6404 ,'0.18' ,'3'       ,0.18 ,3       ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6405 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6406 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6407 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6408 ,'0.18' ,'3'       ,0.18 ,3       ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6409 ,'0.18' ,'3'       ,0.18 ,3       ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6410 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6411 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6412 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6413 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6414 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6415 ,'0.9'  ,'15'      ,0.9  ,15      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
--Yen
SELECT 6401 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6402 ,'0.5'  ,'8'       ,0.5  ,8       ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6403 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6404 ,'0.18' ,'3'       ,0.18 ,3       ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6405 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6406 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6407 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6408 ,'0.18' ,'3'       ,0.18 ,3       ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6409 ,'0.18' ,'3'       ,0.18 ,3       ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6410 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6411 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6412 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6413 ,'0.45' ,'7.5'     ,0.45 ,7.5     ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6414 ,'0.2'  ,'3.5'     ,0.2  ,3.5     ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6415 ,'0.9'  ,'15'      ,0.9  ,15      ,16				--Yen	--US$,YEN,$US,UT,USD     

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