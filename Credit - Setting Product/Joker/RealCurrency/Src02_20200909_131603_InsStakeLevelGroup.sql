/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200909
	Task:  Insert Setting StakeLevelGroupDetail [Joker] - Credit RedmineID:#131603
	DB: DBCust/CustDB
*/
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(17))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--EURO
SELECT 6401 ,'0.09' ,'18'      ,0.09 ,18      ,6    UNION ALL	--EURO	--EURO
SELECT 6402 ,'0.1'  ,'20'      ,0.1  ,20      ,6    UNION ALL	--EURO	--EURO
SELECT 6403 ,'0.1'  ,'20'      ,0.1  ,20      ,6    UNION ALL	--EURO	--EURO
SELECT 6404 ,'0.2'  ,'20'      ,0.2  ,20      ,6    UNION ALL	--EURO	--EURO
SELECT 6405 ,'0.1'  ,'20'      ,0.1  ,20      ,6    UNION ALL	--EURO	--EURO
SELECT 6406 ,'0.5'  ,'50'      ,0.5  ,50      ,6    UNION ALL	--EURO	--EURO
SELECT 6407 ,'0.5'  ,'50'      ,0.5  ,50      ,6    UNION ALL	--EURO	--EURO
SELECT 6408 ,'0.2'  ,'40'      ,0.2  ,40      ,6    UNION ALL	--EURO	--EURO
SELECT 6409 ,'0.1'  ,'20'      ,0.1  ,20      ,6    UNION ALL	--EURO	--EURO
SELECT 6410 ,'0.1'  ,'20'      ,0.1  ,20      ,6    UNION ALL	--EURO	--EURO
SELECT 6411 ,'0.1'  ,'20'      ,0.1  ,20      ,6    UNION ALL	--EURO	--EURO
SELECT 6412 ,'0.05' ,'25'      ,0.05 ,25      ,6    UNION ALL	--EURO	--EURO
--DDD
SELECT 6401 ,'0.09' ,'54'      ,0.09 ,54      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6402 ,'0.1'  ,'60'      ,0.1  ,60      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6403 ,'0.1'  ,'60'      ,0.1  ,60      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6404 ,'0.2'  ,'120'     ,0.2  ,120     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6405 ,'0.1'  ,'60'      ,0.1  ,60      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6406 ,'0.5'  ,'300'     ,0.5  ,300     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6407 ,'0.5'  ,'300'     ,0.5  ,300     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6408 ,'0.2'  ,'20'      ,0.2  ,20      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6409 ,'0.1'  ,'60'      ,0.1  ,60      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6410 ,'0.1'  ,'60'      ,0.1  ,60      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6411 ,'0.1'  ,'60'      ,0.1  ,60      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6412 ,'0.05' ,'30'      ,0.05 ,30      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
--IDD
SELECT 6401 ,'0.09' ,'54'      ,0.09 ,54      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6402 ,'0.1'  ,'60'      ,0.1  ,60      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6403 ,'0.1'  ,'60'      ,0.1  ,60      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6404 ,'0.2'  ,'120'     ,0.2  ,120     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6405 ,'0.1'  ,'60'      ,0.1  ,60      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6406 ,'0.5'  ,'300'     ,0.5  ,300     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6407 ,'0.5'  ,'300'     ,0.5  ,300     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6408 ,'0.2'  ,'20'      ,0.2  ,20      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6409 ,'0.1'  ,'60'      ,0.1  ,60      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6410 ,'0.1'  ,'60'      ,0.1  ,60      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6411 ,'0.1'  ,'60'      ,0.1  ,60      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6412 ,'0.05' ,'30'      ,0.05 ,30      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
--IDR
SELECT 6401 ,'0.09' ,'54'      ,0.09 ,54      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6402 ,'0.1'  ,'60'      ,0.1  ,60      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6403 ,'0.1'  ,'60'      ,0.1  ,60      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6404 ,'0.2'  ,'120'     ,0.2  ,120     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6405 ,'0.1'  ,'60'      ,0.1  ,60      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6406 ,'0.5'  ,'300'     ,0.5  ,300     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6407 ,'0.5'  ,'300'     ,0.5  ,300     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6408 ,'0.2'  ,'20'      ,0.2  ,20      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6409 ,'0.1'  ,'60'      ,0.1  ,60      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6410 ,'0.1'  ,'60'      ,0.1  ,60      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6411 ,'0.1'  ,'60'      ,0.1  ,60      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6412 ,'0.05' ,'30'      ,0.05 ,30      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
--IN
SELECT 6401 ,'0.09' ,'54'      ,0.09 ,54      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6402 ,'0.1'  ,'60'      ,0.1  ,60      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6403 ,'0.1'  ,'60'      ,0.1  ,60      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6404 ,'0.2'  ,'120'     ,0.2  ,120     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6405 ,'0.1'  ,'60'      ,0.1  ,60      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6406 ,'0.5'  ,'300'     ,0.5  ,300     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6407 ,'0.5'  ,'300'     ,0.5  ,300     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6408 ,'0.2'  ,'20'      ,0.2  ,20      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6409 ,'0.1'  ,'60'      ,0.1  ,60      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6410 ,'0.1'  ,'60'      ,0.1  ,60      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6411 ,'0.1'  ,'60'      ,0.1  ,60      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6412 ,'0.05' ,'30'      ,0.05 ,30      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
--IND
SELECT 6401 ,'0.09' ,'54'      ,0.09 ,54      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6402 ,'0.1'  ,'60'      ,0.1  ,60      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6403 ,'0.1'  ,'60'      ,0.1  ,60      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6404 ,'0.2'  ,'120'     ,0.2  ,120     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6405 ,'0.1'  ,'60'      ,0.1  ,60      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6406 ,'0.5'  ,'300'     ,0.5  ,300     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6407 ,'0.5'  ,'300'     ,0.5  ,300     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6408 ,'0.2'  ,'20'      ,0.2  ,20      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6409 ,'0.1'  ,'60'      ,0.1  ,60      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6410 ,'0.1'  ,'60'      ,0.1  ,60      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6411 ,'0.1'  ,'60'      ,0.1  ,60      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6412 ,'0.05' ,'30'      ,0.05 ,30      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
--UUS
SELECT 6401 ,'0.09' ,'54'      ,0.09 ,54      ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6402 ,'0.1'  ,'60'      ,0.1  ,60      ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6403 ,'0.1'  ,'60'      ,0.1  ,60      ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6404 ,'0.2'  ,'120'     ,0.2  ,120     ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6405 ,'0.1'  ,'60'      ,0.1  ,60      ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6406 ,'0.5'  ,'300'     ,0.5  ,300     ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6407 ,'0.5'  ,'300'     ,0.5  ,300     ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6408 ,'0.2'  ,'20'      ,0.2  ,20      ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6409 ,'0.1'  ,'60'      ,0.1  ,60      ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6410 ,'0.1'  ,'60'      ,0.1  ,60      ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6411 ,'0.1'  ,'60'      ,0.1  ,60      ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6412 ,'0.05' ,'30'      ,0.05 ,30      ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
--INR
SELECT 6401 ,'900'  ,'18000'   ,900  ,18000   ,61   UNION ALL	--INR	--INR
SELECT 6402 ,'1000' ,'20000'   ,1000 ,20000   ,61   UNION ALL	--INR	--INR
SELECT 6403 ,'1000' ,'20000'   ,1000 ,20000   ,61   UNION ALL	--INR	--INR
SELECT 6404 ,'2000' ,'40000'   ,2000 ,40000   ,61   UNION ALL	--INR	--INR
SELECT 6405 ,'1000' ,'20000'   ,1000 ,20000   ,61   UNION ALL	--INR	--INR
SELECT 6406 ,'5000' ,'100000'  ,5000 ,100000  ,61   UNION ALL	--INR	--INR
SELECT 6407 ,'5000' ,'100000'  ,5000 ,100000  ,61   UNION ALL	--INR	--INR
SELECT 6408 ,'2000' ,'40000'   ,2000 ,40000   ,61   UNION ALL	--INR	--INR
SELECT 6409 ,'1000' ,'20000'   ,1000 ,20000   ,61   UNION ALL	--INR	--INR
SELECT 6410 ,'1000' ,'20000'   ,1000 ,20000   ,61   UNION ALL	--INR	--INR
SELECT 6411 ,'1000' ,'20000'   ,1000 ,20000   ,61   UNION ALL	--INR	--INR
SELECT 6412 ,'500'  ,'10000'   ,500  ,10000   ,61   UNION ALL	--INR	--INR
--MMK
SELECT 6401 ,'90'   ,'5400'    ,90   ,5400    ,69   UNION ALL	--MMK	--MMK
SELECT 6402 ,'100'  ,'6000'    ,100  ,6000    ,69   UNION ALL	--MMK	--MMK
SELECT 6403 ,'100'  ,'6000'    ,100  ,6000    ,69   UNION ALL	--MMK	--MMK
SELECT 6404 ,'200'  ,'12000'   ,200  ,12000   ,69   UNION ALL	--MMK	--MMK
SELECT 6405 ,'100'  ,'6000'    ,100  ,6000    ,69   UNION ALL	--MMK	--MMK
SELECT 6406 ,'500'  ,'30000'   ,500  ,30000   ,69   UNION ALL	--MMK	--MMK
SELECT 6407 ,'500'  ,'30000'   ,500  ,30000   ,69   UNION ALL	--MMK	--MMK
SELECT 6408 ,'200'  ,'12000'   ,200  ,12000   ,69   UNION ALL	--MMK	--MMK
SELECT 6409 ,'100'  ,'6000'    ,100  ,6000    ,69   UNION ALL	--MMK	--MMK
SELECT 6410 ,'100'  ,'6000'    ,100  ,6000    ,69   UNION ALL	--MMK	--MMK
SELECT 6411 ,'100'  ,'6000'    ,100  ,6000    ,69   UNION ALL	--MMK	--MMK
SELECT 6412 ,'50'   ,'3000'    ,50   ,3000    ,69   UNION ALL	--MMK	--MMK
--HK$
SELECT 6401 ,'0.09' ,'18'      ,0.09 ,18      ,5    UNION ALL	--HK$	--RM,HK$,HKK
SELECT 6402 ,'0.1'  ,'20'      ,0.1  ,20      ,5    UNION ALL	--HK$	--RM,HK$,HKK
SELECT 6403 ,'0.1'  ,'20'      ,0.1  ,20      ,5    UNION ALL	--HK$	--RM,HK$,HKK
SELECT 6404 ,'0.2'  ,'20'      ,0.2  ,20      ,5    UNION ALL	--HK$	--RM,HK$,HKK
SELECT 6405 ,'0.1'  ,'20'      ,0.1  ,20      ,5    UNION ALL	--HK$	--RM,HK$,HKK
SELECT 6406 ,'0.5'  ,'50'      ,0.5  ,50      ,5    UNION ALL	--HK$	--RM,HK$,HKK
SELECT 6407 ,'0.5'  ,'50'      ,0.5  ,50      ,5    UNION ALL	--HK$	--RM,HK$,HKK
SELECT 6408 ,'0.2'  ,'20'      ,0.2  ,20      ,5    UNION ALL	--HK$	--RM,HK$,HKK
SELECT 6409 ,'0.1'  ,'20'      ,0.1  ,20      ,5    UNION ALL	--HK$	--RM,HK$,HKK
SELECT 6410 ,'0.1'  ,'20'      ,0.1  ,20      ,5    UNION ALL	--HK$	--RM,HK$,HKK
SELECT 6411 ,'0.1'  ,'20'      ,0.1  ,20      ,5    UNION ALL	--HK$	--RM,HK$,HKK
SELECT 6412 ,'0.05' ,'25'      ,0.05 ,25      ,5    UNION ALL	--HK$	--RM,HK$,HKK
--HKK
SELECT 6401 ,'0.09' ,'18'      ,0.09 ,18      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6402 ,'0.1'  ,'20'      ,0.1  ,20      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6403 ,'0.1'  ,'20'      ,0.1  ,20      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6404 ,'0.2'  ,'20'      ,0.2  ,20      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6405 ,'0.1'  ,'20'      ,0.1  ,20      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6406 ,'0.5'  ,'50'      ,0.5  ,50      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6407 ,'0.5'  ,'50'      ,0.5  ,50      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6408 ,'0.2'  ,'20'      ,0.2  ,20      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6409 ,'0.1'  ,'20'      ,0.1  ,20      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6410 ,'0.1'  ,'20'      ,0.1  ,20      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6411 ,'0.1'  ,'20'      ,0.1  ,20      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6412 ,'0.05' ,'25'      ,0.05 ,25      ,67   UNION ALL	--HKK	--RM,HK$,HKK
--RM
SELECT 6401 ,'0.09' ,'18'      ,0.09 ,18      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6402 ,'0.1'  ,'20'      ,0.1  ,20      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6403 ,'0.1'  ,'20'      ,0.1  ,20      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6404 ,'0.2'  ,'20'      ,0.2  ,20      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6405 ,'0.1'  ,'20'      ,0.1  ,20      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6406 ,'0.5'  ,'50'      ,0.5  ,50      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6407 ,'0.5'  ,'50'      ,0.5  ,50      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6408 ,'0.2'  ,'20'      ,0.2  ,20      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6409 ,'0.1'  ,'20'      ,0.1  ,20      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6410 ,'0.1'  ,'20'      ,0.1  ,20      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6411 ,'0.1'  ,'20'      ,0.1  ,20      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6412 ,'0.05' ,'25'      ,0.05 ,25      ,2    UNION ALL	--RM	--RM,HK$,HKK
--RMB
SELECT 6401 ,'9'    ,'4500'    ,9    ,4500    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6402 ,'10'   ,'5000'    ,10   ,5000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6403 ,'10'   ,'5000'    ,10   ,5000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6404 ,'20'   ,'10000'   ,20   ,10000   ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6405 ,'10'   ,'5000'    ,10   ,5000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6406 ,'50'   ,'25000'   ,50   ,25000   ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6407 ,'50'   ,'25000'   ,50   ,25000   ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6408 ,'20'   ,'10000'   ,20   ,10000   ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6409 ,'10'   ,'5000'    ,10   ,5000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6410 ,'10'   ,'5000'    ,10   ,5000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6411 ,'10'   ,'5000'    ,10   ,5000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6412 ,'5'    ,'2500'    ,5    ,2500    ,13   UNION ALL	--RMB	--RMB,YUN
--YUN
SELECT 6401 ,'9'    ,'4500'    ,9    ,4500    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6402 ,'10'   ,'5000'    ,10   ,5000    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6403 ,'10'   ,'5000'    ,10   ,5000    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6404 ,'20'   ,'10000'   ,20   ,10000   ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6405 ,'10'   ,'5000'    ,10   ,5000    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6406 ,'50'   ,'25000'   ,50   ,25000   ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6407 ,'50'   ,'25000'   ,50   ,25000   ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6408 ,'20'   ,'10000'   ,20   ,10000   ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6409 ,'10'   ,'5000'    ,10   ,5000    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6410 ,'10'   ,'5000'    ,10   ,5000    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6411 ,'10'   ,'5000'    ,10   ,5000    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6412 ,'5'    ,'2500'    ,5    ,2500    ,66   UNION ALL	--YUN	--RMB,YUN
--TB
SELECT 6401 ,'0.9'  ,'180'     ,0.9  ,180     ,4    UNION ALL	--TB	--TB,THB
SELECT 6402 ,'1'    ,'200'     ,1    ,200     ,4    UNION ALL	--TB	--TB,THB
SELECT 6403 ,'1'    ,'200'     ,1    ,200     ,4    UNION ALL	--TB	--TB,THB
SELECT 6404 ,'2'    ,'200'     ,2    ,200     ,4    UNION ALL	--TB	--TB,THB
SELECT 6405 ,'1'    ,'200'     ,1    ,200     ,4    UNION ALL	--TB	--TB,THB
SELECT 6406 ,'5'    ,'150'     ,5    ,150     ,4    UNION ALL	--TB	--TB,THB
SELECT 6407 ,'5'    ,'150'     ,5    ,150     ,4    UNION ALL	--TB	--TB,THB
SELECT 6408 ,'2'    ,'200'     ,2    ,200     ,4    UNION ALL	--TB	--TB,THB
SELECT 6409 ,'1'    ,'200'     ,1    ,200     ,4    UNION ALL	--TB	--TB,THB
SELECT 6410 ,'1'    ,'200'     ,1    ,200     ,4    UNION ALL	--TB	--TB,THB
SELECT 6411 ,'1'    ,'200'     ,1    ,200     ,4    UNION ALL	--TB	--TB,THB
SELECT 6412 ,'0.5'  ,'100'     ,0.5  ,100     ,4    UNION ALL	--TB	--TB,THB
--THB
SELECT 6401 ,'0.9'  ,'180'     ,0.9  ,180     ,43   UNION ALL	--THB	--TB,THB
SELECT 6402 ,'1'    ,'200'     ,1    ,200     ,43   UNION ALL	--THB	--TB,THB
SELECT 6403 ,'1'    ,'200'     ,1    ,200     ,43   UNION ALL	--THB	--TB,THB
SELECT 6404 ,'2'    ,'200'     ,2    ,200     ,43   UNION ALL	--THB	--TB,THB
SELECT 6405 ,'1'    ,'200'     ,1    ,200     ,43   UNION ALL	--THB	--TB,THB
SELECT 6406 ,'5'    ,'150'     ,5    ,150     ,43   UNION ALL	--THB	--TB,THB
SELECT 6407 ,'5'    ,'150'     ,5    ,150     ,43   UNION ALL	--THB	--TB,THB
SELECT 6408 ,'2'    ,'200'     ,2    ,200     ,43   UNION ALL	--THB	--TB,THB
SELECT 6409 ,'1'    ,'200'     ,1    ,200     ,43   UNION ALL	--THB	--TB,THB
SELECT 6410 ,'1'    ,'200'     ,1    ,200     ,43   UNION ALL	--THB	--TB,THB
SELECT 6411 ,'1'    ,'200'     ,1    ,200     ,43   UNION ALL	--THB	--TB,THB
SELECT 6412 ,'0.5'  ,'100'     ,0.5  ,100     ,43   UNION ALL	--THB	--TB,THB
--$US
SELECT 6401 ,'0.09' ,'18'      ,0.09 ,18      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6402 ,'0.1'  ,'10'      ,0.1  ,10      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6403 ,'0.1'  ,'20'      ,0.1  ,20      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6404 ,'0.2'  ,'20'      ,0.2  ,20      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6405 ,'0.1'  ,'20'      ,0.1  ,20      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6406 ,'0.5'  ,'50'      ,0.5  ,50      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6407 ,'0.5'  ,'50'      ,0.5  ,50      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6408 ,'0.2'  ,'20'      ,0.2  ,20      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6409 ,'0.1'  ,'20'      ,0.1  ,20      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6410 ,'0.1'  ,'20'      ,0.1  ,20      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6411 ,'0.1'  ,'20'      ,0.1  ,20      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6412 ,'0.05' ,'25'      ,0.05 ,25      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
--US$
SELECT 6401 ,'0.09' ,'18'      ,0.09 ,18      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6402 ,'0.1'  ,'10'      ,0.1  ,10      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6403 ,'0.1'  ,'20'      ,0.1  ,20      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6404 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6405 ,'0.1'  ,'20'      ,0.1  ,20      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6406 ,'0.5'  ,'50'      ,0.5  ,50      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6407 ,'0.5'  ,'50'      ,0.5  ,50      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6408 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6409 ,'0.1'  ,'20'      ,0.1  ,20      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6410 ,'0.1'  ,'20'      ,0.1  ,20      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6411 ,'0.1'  ,'20'      ,0.1  ,20      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6412 ,'0.05' ,'25'      ,0.05 ,25      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
--USD
SELECT 6401 ,'0.09' ,'18'      ,0.09 ,18      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6402 ,'0.1'  ,'10'      ,0.1  ,10      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6403 ,'0.1'  ,'20'      ,0.1  ,20      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6404 ,'0.2'  ,'20'      ,0.2  ,20      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6405 ,'0.1'  ,'20'      ,0.1  ,20      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6406 ,'0.5'  ,'50'      ,0.5  ,50      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6407 ,'0.5'  ,'50'      ,0.5  ,50      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6408 ,'0.2'  ,'20'      ,0.2  ,20      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6409 ,'0.1'  ,'20'      ,0.1  ,20      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6410 ,'0.1'  ,'20'      ,0.1  ,20      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6411 ,'0.1'  ,'20'      ,0.1  ,20      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6412 ,'0.05' ,'25'      ,0.05 ,25      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
--UT
SELECT 6401 ,'0.09' ,'18'      ,0.09 ,18      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6402 ,'0.1'  ,'10'      ,0.1  ,10      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6403 ,'0.1'  ,'20'      ,0.1  ,20      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6404 ,'0.2'  ,'20'      ,0.2  ,20      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6405 ,'0.1'  ,'20'      ,0.1  ,20      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6406 ,'0.5'  ,'50'      ,0.5  ,50      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6407 ,'0.5'  ,'50'      ,0.5  ,50      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6408 ,'0.2'  ,'20'      ,0.2  ,20      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6409 ,'0.1'  ,'20'      ,0.1  ,20      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6410 ,'0.1'  ,'20'      ,0.1  ,20      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6411 ,'0.1'  ,'20'      ,0.1  ,20      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6412 ,'0.05' ,'25'      ,0.05 ,25      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
--Yen
SELECT 6401 ,'0.09' ,'18'      ,0.09 ,18      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6402 ,'0.1'  ,'10'      ,0.1  ,10      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6403 ,'0.1'  ,'20'      ,0.1  ,20      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6404 ,'0.2'  ,'20'      ,0.2  ,20      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6405 ,'0.1'  ,'20'      ,0.1  ,20      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6406 ,'0.5'  ,'50'      ,0.5  ,50      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6407 ,'0.5'  ,'50'      ,0.5  ,50      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6408 ,'0.2'  ,'20'      ,0.2  ,20      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6409 ,'0.1'  ,'20'      ,0.1  ,20      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6410 ,'0.1'  ,'20'      ,0.1  ,20      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6411 ,'0.1'  ,'20'      ,0.1  ,20      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6412 ,'0.05' ,'25'      ,0.05 ,25      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
--Won
SELECT 6401 ,'90'   ,'5400'    ,90   ,5400    ,45   UNION ALL	--Won	--Won
SELECT 6402 ,'100'  ,'6000'    ,100  ,6000    ,45   UNION ALL	--Won	--Won
SELECT 6403 ,'100'  ,'6000'    ,100  ,6000    ,45   UNION ALL	--Won	--Won
SELECT 6404 ,'200'  ,'12000'   ,200  ,12000   ,45   UNION ALL	--Won	--Won
SELECT 6405 ,'100'  ,'6000'    ,100  ,6000    ,45   UNION ALL	--Won	--Won
SELECT 6406 ,'500'  ,'30000'   ,500  ,30000   ,45   UNION ALL	--Won	--Won
SELECT 6407 ,'500'  ,'30000'   ,500  ,30000   ,45   UNION ALL	--Won	--Won
SELECT 6408 ,'200'  ,'12000'   ,200  ,12000   ,45   UNION ALL	--Won	--Won
SELECT 6409 ,'100'  ,'6000'    ,100  ,6000    ,45   UNION ALL	--Won	--Won
SELECT 6410 ,'100'  ,'6000'    ,100  ,6000    ,45   UNION ALL	--Won	--Won
SELECT 6411 ,'100'  ,'6000'    ,100  ,6000    ,45   UNION ALL	--Won	--Won
SELECT 6412 ,'50'   ,'3000'    ,50   ,3000    ,45				--Won	--Won

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999

DELETE  a
FROM StakeLevelGroupDetail a
INNER JOIN StakeLevel b WITH(NOLOCK) ON a.StakeLevelID = b.StakeLevelID
WHERE b.GameTypeID = 6401 AND b.ExchangeId IN (SELECT DISTINCT ExchangeId FROM #StakeLevel_Temp)

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 6401)

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
PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 