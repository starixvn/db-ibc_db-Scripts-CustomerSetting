/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220118
	Task:  Add 20 New Games for [Joker] - Credit RedmineID:#167395
	DB: DBCust/CustDB
*/
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(17))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--EURO
SELECT 6436 ,'0.25'    ,'25'          ,0.25    ,25          ,6    UNION ALL	--EURO	--EURO
SELECT 6437 ,'0.1'     ,'20'          ,0.1     ,20          ,6    UNION ALL	--EURO	--EURO
SELECT 6438 ,'0.25'    ,'25'          ,0.25    ,25          ,6    UNION ALL	--EURO	--EURO
SELECT 6439 ,'0.25'    ,'25'          ,0.25    ,25          ,6    UNION ALL	--EURO	--EURO
SELECT 6440 ,'0.1'     ,'20'          ,0.1     ,20          ,6    UNION ALL	--EURO	--EURO
SELECT 6441 ,'0.25'    ,'25'          ,0.25    ,25          ,6    UNION ALL	--EURO	--EURO
SELECT 6442 ,'0.3'     ,'30'          ,0.3     ,30          ,6    UNION ALL	--EURO	--EURO
SELECT 6443 ,'0.07'    ,'35'          ,0.07    ,35          ,6    UNION ALL	--EURO	--EURO
SELECT 6444 ,'0.1'     ,'20'          ,0.1     ,20          ,6    UNION ALL	--EURO	--EURO
SELECT 6445 ,'0.25'    ,'25'          ,0.25    ,25          ,6    UNION ALL	--EURO	--EURO
SELECT 6446 ,'0.1'     ,'20'          ,0.1     ,20          ,6    UNION ALL	--EURO	--EURO
SELECT 6447 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--EURO
SELECT 6448 ,'0.25'    ,'25'          ,0.25    ,25          ,6    UNION ALL	--EURO	--EURO
SELECT 6449 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--EURO
SELECT 6450 ,'0.3'     ,'30'          ,0.3     ,30          ,6    UNION ALL	--EURO	--EURO
SELECT 6451 ,'0.2'     ,'20'          ,0.2     ,20          ,6    UNION ALL	--EURO	--EURO
SELECT 6452 ,'0.05'    ,'25'          ,0.05    ,25          ,6    UNION ALL	--EURO	--EURO
SELECT 6453 ,'0.15'    ,'15'          ,0.15    ,15          ,6    UNION ALL	--EURO	--EURO
SELECT 6454 ,'0.1'     ,'20'          ,0.1     ,20          ,6    UNION ALL	--EURO	--EURO
SELECT 6455 ,'0.1'     ,'20'          ,0.1     ,20          ,6    UNION ALL	--EURO	--EURO
--IN,IND,IDD,IDR,DDD,UUS
SELECT 6436 ,'0.25'    ,'75'          ,0.25    ,75          ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6437 ,'0.1'     ,'20'          ,0.1     ,20          ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6438 ,'0.25'    ,'50'          ,0.25    ,50          ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6439 ,'0.25'    ,'75'          ,0.25    ,75          ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6440 ,'0.1'     ,'20'          ,0.1     ,20          ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6441 ,'0.25'    ,'75'          ,0.25    ,75          ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6442 ,'0.3'     ,'90'          ,0.3     ,90          ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6443 ,'0.07'    ,'42'          ,0.07    ,42          ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6444 ,'0.1'     ,'60'          ,0.1     ,60          ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6445 ,'0.25'    ,'25'          ,0.25    ,25          ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6446 ,'0.1'     ,'60'          ,0.1     ,60          ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6447 ,'0.2'     ,'20'          ,0.2     ,20          ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6448 ,'0.25'    ,'75'          ,0.25    ,75          ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6449 ,'0.2'     ,'20'          ,0.2     ,20          ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6450 ,'0.3'     ,'90'          ,0.3     ,90          ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6451 ,'0.2'     ,'20'          ,0.2     ,20          ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6452 ,'0.05'    ,'30'          ,0.05    ,30          ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6453 ,'0.15'    ,'45'          ,0.15    ,45          ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6454 ,'0.1'     ,'60'          ,0.1     ,60          ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6455 ,'0.1'     ,'20'          ,0.1     ,20          ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6436 ,'0.25'    ,'75'          ,0.25    ,75          ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6437 ,'0.1'     ,'20'          ,0.1     ,20          ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6438 ,'0.25'    ,'50'          ,0.25    ,50          ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6439 ,'0.25'    ,'75'          ,0.25    ,75          ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6440 ,'0.1'     ,'20'          ,0.1     ,20          ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6441 ,'0.25'    ,'75'          ,0.25    ,75          ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6442 ,'0.3'     ,'90'          ,0.3     ,90          ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6443 ,'0.07'    ,'42'          ,0.07    ,42          ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6444 ,'0.1'     ,'60'          ,0.1     ,60          ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6445 ,'0.25'    ,'25'          ,0.25    ,25          ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6446 ,'0.1'     ,'60'          ,0.1     ,60          ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6447 ,'0.2'     ,'20'          ,0.2     ,20          ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6448 ,'0.25'    ,'75'          ,0.25    ,75          ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6449 ,'0.2'     ,'20'          ,0.2     ,20          ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6450 ,'0.3'     ,'90'          ,0.3     ,90          ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6451 ,'0.2'     ,'20'          ,0.2     ,20          ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6452 ,'0.05'    ,'30'          ,0.05    ,30          ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6453 ,'0.15'    ,'45'          ,0.15    ,45          ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6454 ,'0.1'     ,'60'          ,0.1     ,60          ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6455 ,'0.1'     ,'20'          ,0.1     ,20          ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6436 ,'0.25'    ,'75'          ,0.25    ,75          ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6437 ,'0.1'     ,'20'          ,0.1     ,20          ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6438 ,'0.25'    ,'50'          ,0.25    ,50          ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6439 ,'0.25'    ,'75'          ,0.25    ,75          ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6440 ,'0.1'     ,'20'          ,0.1     ,20          ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6441 ,'0.25'    ,'75'          ,0.25    ,75          ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6442 ,'0.3'     ,'90'          ,0.3     ,90          ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6443 ,'0.07'    ,'42'          ,0.07    ,42          ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6444 ,'0.1'     ,'60'          ,0.1     ,60          ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6445 ,'0.25'    ,'25'          ,0.25    ,25          ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6446 ,'0.1'     ,'60'          ,0.1     ,60          ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6447 ,'0.2'     ,'20'          ,0.2     ,20          ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6448 ,'0.25'    ,'75'          ,0.25    ,75          ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6449 ,'0.2'     ,'20'          ,0.2     ,20          ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6450 ,'0.3'     ,'90'          ,0.3     ,90          ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6451 ,'0.2'     ,'20'          ,0.2     ,20          ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6452 ,'0.05'    ,'30'          ,0.05    ,30          ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6453 ,'0.15'    ,'45'          ,0.15    ,45          ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6454 ,'0.1'     ,'60'          ,0.1     ,60          ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6455 ,'0.1'     ,'20'          ,0.1     ,20          ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6436 ,'0.25'    ,'75'          ,0.25    ,75          ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6437 ,'0.1'     ,'20'          ,0.1     ,20          ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6438 ,'0.25'    ,'50'          ,0.25    ,50          ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6439 ,'0.25'    ,'75'          ,0.25    ,75          ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6440 ,'0.1'     ,'20'          ,0.1     ,20          ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6441 ,'0.25'    ,'75'          ,0.25    ,75          ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6442 ,'0.3'     ,'90'          ,0.3     ,90          ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6443 ,'0.07'    ,'42'          ,0.07    ,42          ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6444 ,'0.1'     ,'60'          ,0.1     ,60          ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6445 ,'0.25'    ,'25'          ,0.25    ,25          ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6446 ,'0.1'     ,'60'          ,0.1     ,60          ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6447 ,'0.2'     ,'20'          ,0.2     ,20          ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6448 ,'0.25'    ,'75'          ,0.25    ,75          ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6449 ,'0.2'     ,'20'          ,0.2     ,20          ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6450 ,'0.3'     ,'90'          ,0.3     ,90          ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6451 ,'0.2'     ,'20'          ,0.2     ,20          ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6452 ,'0.05'    ,'30'          ,0.05    ,30          ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6453 ,'0.15'    ,'45'          ,0.15    ,45          ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6454 ,'0.1'     ,'60'          ,0.1     ,60          ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6455 ,'0.1'     ,'20'          ,0.1     ,20          ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6436 ,'0.25'    ,'75'          ,0.25    ,75          ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6437 ,'0.1'     ,'20'          ,0.1     ,20          ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6438 ,'0.25'    ,'50'          ,0.25    ,50          ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6439 ,'0.25'    ,'75'          ,0.25    ,75          ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6440 ,'0.1'     ,'20'          ,0.1     ,20          ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6441 ,'0.25'    ,'75'          ,0.25    ,75          ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6442 ,'0.3'     ,'90'          ,0.3     ,90          ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6443 ,'0.07'    ,'42'          ,0.07    ,42          ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6444 ,'0.1'     ,'60'          ,0.1     ,60          ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6445 ,'0.25'    ,'25'          ,0.25    ,25          ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6446 ,'0.1'     ,'60'          ,0.1     ,60          ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6447 ,'0.2'     ,'20'          ,0.2     ,20          ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6448 ,'0.25'    ,'75'          ,0.25    ,75          ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6449 ,'0.2'     ,'20'          ,0.2     ,20          ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6450 ,'0.3'     ,'90'          ,0.3     ,90          ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6451 ,'0.2'     ,'20'          ,0.2     ,20          ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6452 ,'0.05'    ,'30'          ,0.05    ,30          ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6453 ,'0.15'    ,'45'          ,0.15    ,45          ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6454 ,'0.1'     ,'60'          ,0.1     ,60          ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6455 ,'0.1'     ,'20'          ,0.1     ,20          ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
--MMK
SELECT 6436 ,'250'     ,'7500'        ,250     ,7500        ,69   UNION ALL	--MMK	--MMK
SELECT 6437 ,'100'     ,'6000'        ,100     ,6000        ,69   UNION ALL	--MMK	--MMK
SELECT 6438 ,'250'     ,'7500'        ,250     ,7500        ,69   UNION ALL	--MMK	--MMK
SELECT 6439 ,'250'     ,'7500'        ,250     ,7500        ,69   UNION ALL	--MMK	--MMK
SELECT 6440 ,'100'     ,'6000'        ,100     ,6000        ,69   UNION ALL	--MMK	--MMK
SELECT 6441 ,'250'     ,'7500'        ,250     ,7500        ,69   UNION ALL	--MMK	--MMK
SELECT 6442 ,'300'     ,'9000'        ,300     ,9000        ,69   UNION ALL	--MMK	--MMK
SELECT 6443 ,'70'      ,'4200'        ,70      ,4200        ,69   UNION ALL	--MMK	--MMK
SELECT 6444 ,'100'     ,'5000'        ,100     ,5000        ,69   UNION ALL	--MMK	--MMK
SELECT 6445 ,'250'     ,'7500'        ,250     ,7500        ,69   UNION ALL	--MMK	--MMK
SELECT 6446 ,'100'     ,'6000'        ,100     ,6000        ,69   UNION ALL	--MMK	--MMK
SELECT 6447 ,'200'     ,'6000'        ,200     ,6000        ,69   UNION ALL	--MMK	--MMK
SELECT 6448 ,'250'     ,'7500'        ,250     ,7500        ,69   UNION ALL	--MMK	--MMK
SELECT 6449 ,'200'     ,'6000'        ,200     ,6000        ,69   UNION ALL	--MMK	--MMK
SELECT 6450 ,'300'     ,'9000'        ,300     ,9000        ,69   UNION ALL	--MMK	--MMK
SELECT 6451 ,'200'     ,'6000'        ,200     ,6000        ,69   UNION ALL	--MMK	--MMK
SELECT 6452 ,'50'      ,'3000'        ,50      ,3000        ,69   UNION ALL	--MMK	--MMK
SELECT 6453 ,'150'     ,'4500'        ,150     ,4500        ,69   UNION ALL	--MMK	--MMK
SELECT 6454 ,'100'     ,'5000'        ,100     ,5000        ,69   UNION ALL	--MMK	--MMK
SELECT 6455 ,'100'     ,'6000'        ,100     ,6000        ,69   UNION ALL	--MMK	--MMK
--RM,HK$,HKK
SELECT 6436 ,'0.25'    ,'25'          ,0.25    ,25          ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6437 ,'0.1'     ,'20'          ,0.1     ,20          ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6438 ,'0.25'    ,'25'          ,0.25    ,25          ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6439 ,'0.25'    ,'25'          ,0.25    ,25          ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6440 ,'0.1'     ,'20'          ,0.1     ,20          ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6441 ,'0.25'    ,'50'          ,0.25    ,50          ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6442 ,'0.3'     ,'30'          ,0.3     ,30          ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6443 ,'0.07'    ,'35'          ,0.07    ,35          ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6444 ,'0.1'     ,'20'          ,0.1     ,20          ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6445 ,'0.25'    ,'25'          ,0.25    ,25          ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6446 ,'0.1'     ,'20'          ,0.1     ,20          ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6447 ,'0.2'     ,'20'          ,0.2     ,20          ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6448 ,'0.25'    ,'25'          ,0.25    ,25          ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6449 ,'0.2'     ,'20'          ,0.2     ,20          ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6450 ,'0.3'     ,'30'          ,0.3     ,30          ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6451 ,'0.2'     ,'20'          ,0.2     ,20          ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6452 ,'0.05'    ,'25'          ,0.05    ,25          ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6453 ,'0.15'    ,'15'          ,0.15    ,15          ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6454 ,'0.1'     ,'20'          ,0.1     ,20          ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6455 ,'0.1'     ,'20'          ,0.1     ,20          ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6436 ,'0.25'    ,'25'          ,0.25    ,25          ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6437 ,'0.1'     ,'20'          ,0.1     ,20          ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6438 ,'0.25'    ,'25'          ,0.25    ,25          ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6439 ,'0.25'    ,'25'          ,0.25    ,25          ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6440 ,'0.1'     ,'20'          ,0.1     ,20          ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6441 ,'0.25'    ,'50'          ,0.25    ,50          ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6442 ,'0.3'     ,'30'          ,0.3     ,30          ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6443 ,'0.07'    ,'35'          ,0.07    ,35          ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6444 ,'0.1'     ,'20'          ,0.1     ,20          ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6445 ,'0.25'    ,'25'          ,0.25    ,25          ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6446 ,'0.1'     ,'20'          ,0.1     ,20          ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6447 ,'0.2'     ,'20'          ,0.2     ,20          ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6448 ,'0.25'    ,'25'          ,0.25    ,25          ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6449 ,'0.2'     ,'20'          ,0.2     ,20          ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6450 ,'0.3'     ,'30'          ,0.3     ,30          ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6451 ,'0.2'     ,'20'          ,0.2     ,20          ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6452 ,'0.05'    ,'25'          ,0.05    ,25          ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6453 ,'0.15'    ,'15'          ,0.15    ,15          ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6454 ,'0.1'     ,'20'          ,0.1     ,20          ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6455 ,'0.1'     ,'20'          ,0.1     ,20          ,2    UNION ALL	--RM	--RM,HK$,HKK
--RMB,CY
SELECT 6436 ,'0.25'    ,'50'          ,0.25    ,50          ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6437 ,'0.1'     ,'50'          ,0.1     ,50          ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6438 ,'0.25'    ,'50'          ,0.25    ,50          ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6439 ,'0.25'    ,'50'          ,0.25    ,50          ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6440 ,'0.1'     ,'50'          ,0.1     ,50          ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6441 ,'0.25'    ,'50'          ,0.25    ,50          ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6442 ,'0.3'     ,'60'          ,0.3     ,60          ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6443 ,'0.07'    ,'35'          ,0.07    ,35          ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6444 ,'0.1'     ,'50'          ,0.1     ,50          ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6445 ,'0.25'    ,'50'          ,0.25    ,50          ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6446 ,'0.1'     ,'50'          ,0.1     ,50          ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6447 ,'0.2'     ,'20'          ,0.2     ,20          ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6448 ,'0.25'    ,'50'          ,0.25    ,50          ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6449 ,'0.2'     ,'20'          ,0.2     ,20          ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6450 ,'0.3'     ,'60'          ,0.3     ,60          ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6451 ,'0.2'     ,'20'          ,0.2     ,20          ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6452 ,'0.05'    ,'25'          ,0.05    ,25          ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6453 ,'0.15'    ,'30'          ,0.15    ,30          ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6454 ,'0.1'     ,'50'          ,0.1     ,50          ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6455 ,'0.1'     ,'50'          ,0.1     ,50          ,13   UNION ALL	--RMB	--RMB,CY
--TB,THB
SELECT 6436 ,'2.5'     ,'250'         ,2.5     ,250         ,43   UNION ALL	--THB	--TB,THB
SELECT 6437 ,'1'       ,'200'         ,1       ,200         ,43   UNION ALL	--THB	--TB,THB
SELECT 6438 ,'2.5'     ,'75'          ,2.5     ,75          ,43   UNION ALL	--THB	--TB,THB
SELECT 6439 ,'2.5'     ,'250'         ,2.5     ,250         ,43   UNION ALL	--THB	--TB,THB
SELECT 6440 ,'1'       ,'200'         ,1       ,200         ,43   UNION ALL	--THB	--TB,THB
SELECT 6441 ,'2.5'     ,'250'         ,2.5     ,250         ,43   UNION ALL	--THB	--TB,THB
SELECT 6442 ,'3'       ,'300'         ,3       ,300         ,43   UNION ALL	--THB	--TB,THB
SELECT 6443 ,'0.7'     ,'140'         ,0.7     ,140         ,43   UNION ALL	--THB	--TB,THB
SELECT 6444 ,'1'       ,'200'         ,1       ,200         ,43   UNION ALL	--THB	--TB,THB
SELECT 6445 ,'2.5'     ,'250'         ,2.5     ,250         ,43   UNION ALL	--THB	--TB,THB
SELECT 6446 ,'1'       ,'200'         ,1       ,200         ,43   UNION ALL	--THB	--TB,THB
SELECT 6447 ,'2'       ,'200'         ,2       ,200         ,43   UNION ALL	--THB	--TB,THB
SELECT 6448 ,'2.5'     ,'250'         ,2.5     ,250         ,43   UNION ALL	--THB	--TB,THB
SELECT 6449 ,'2'       ,'200'         ,2       ,200         ,43   UNION ALL	--THB	--TB,THB
SELECT 6450 ,'3'       ,'300'         ,3       ,300         ,43   UNION ALL	--THB	--TB,THB
SELECT 6451 ,'2'       ,'200'         ,2       ,200         ,43   UNION ALL	--THB	--TB,THB
SELECT 6452 ,'0.5'     ,'100'         ,0.5     ,100         ,43   UNION ALL	--THB	--TB,THB
SELECT 6453 ,'1.5'     ,'150'         ,1.5     ,150         ,43   UNION ALL	--THB	--TB,THB
SELECT 6454 ,'1'       ,'200'         ,1       ,200         ,43   UNION ALL	--THB	--TB,THB
SELECT 6455 ,'1'       ,'200'         ,1       ,200         ,43   UNION ALL	--THB	--TB,THB
--US$,YEN,$US,UT,USD
SELECT 6436 ,'0.25'    ,'25'          ,0.25    ,25          ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6437 ,'0.1'     ,'20'          ,0.1     ,20          ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6438 ,'0.25'    ,'25'          ,0.25    ,25          ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6439 ,'0.25'    ,'25'          ,0.25    ,25          ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6440 ,'0.1'     ,'20'          ,0.1     ,20          ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6441 ,'0.25'    ,'25'          ,0.25    ,25          ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6442 ,'0.3'     ,'30'          ,0.3     ,30          ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6443 ,'0.07'    ,'35'          ,0.07    ,35          ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6444 ,'0.1'     ,'20'          ,0.1     ,20          ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6445 ,'0.25'    ,'25'          ,0.25    ,25          ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6446 ,'0.1'     ,'20'          ,0.1     ,20          ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6447 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6448 ,'0.25'    ,'25'          ,0.25    ,25          ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6449 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6450 ,'0.3'     ,'30'          ,0.3     ,30          ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6451 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6452 ,'0.05'    ,'25'          ,0.05    ,25          ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6453 ,'0.15'    ,'15'          ,0.15    ,15          ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6454 ,'0.1'     ,'20'          ,0.1     ,20          ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6455 ,'0.1'     ,'20'          ,0.1     ,20          ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6436 ,'0.25'    ,'25'          ,0.25    ,25          ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6437 ,'0.1'     ,'20'          ,0.1     ,20          ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6438 ,'0.25'    ,'25'          ,0.25    ,25          ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6439 ,'0.25'    ,'25'          ,0.25    ,25          ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6440 ,'0.1'     ,'20'          ,0.1     ,20          ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6441 ,'0.25'    ,'25'          ,0.25    ,25          ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6442 ,'0.3'     ,'30'          ,0.3     ,30          ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6443 ,'0.07'    ,'35'          ,0.07    ,35          ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6444 ,'0.1'     ,'20'          ,0.1     ,20          ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6445 ,'0.25'    ,'25'          ,0.25    ,25          ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6446 ,'0.1'     ,'20'          ,0.1     ,20          ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6447 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6448 ,'0.25'    ,'25'          ,0.25    ,25          ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6449 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6450 ,'0.3'     ,'30'          ,0.3     ,30          ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6451 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6452 ,'0.05'    ,'25'          ,0.05    ,25          ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6453 ,'0.15'    ,'15'          ,0.15    ,15          ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6454 ,'0.1'     ,'20'          ,0.1     ,20          ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6455 ,'0.1'     ,'20'          ,0.1     ,20          ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6436 ,'0.25'    ,'25'          ,0.25    ,25          ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6437 ,'0.1'     ,'20'          ,0.1     ,20          ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6438 ,'0.25'    ,'25'          ,0.25    ,25          ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6439 ,'0.25'    ,'25'          ,0.25    ,25          ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6440 ,'0.1'     ,'20'          ,0.1     ,20          ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6441 ,'0.25'    ,'25'          ,0.25    ,25          ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6442 ,'0.3'     ,'30'          ,0.3     ,30          ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6443 ,'0.07'    ,'35'          ,0.07    ,35          ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6444 ,'0.1'     ,'20'          ,0.1     ,20          ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6445 ,'0.25'    ,'25'          ,0.25    ,25          ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6446 ,'0.1'     ,'20'          ,0.1     ,20          ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6447 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6448 ,'0.25'    ,'25'          ,0.25    ,25          ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6449 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6450 ,'0.3'     ,'30'          ,0.3     ,30          ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6451 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6452 ,'0.05'    ,'25'          ,0.05    ,25          ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6453 ,'0.15'    ,'15'          ,0.15    ,15          ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6454 ,'0.1'     ,'20'          ,0.1     ,20          ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6455 ,'0.1'     ,'20'          ,0.1     ,20          ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6436 ,'0.25'    ,'25'          ,0.25    ,25          ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6437 ,'0.1'     ,'20'          ,0.1     ,20          ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6438 ,'0.25'    ,'25'          ,0.25    ,25          ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6439 ,'0.25'    ,'25'          ,0.25    ,25          ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6440 ,'0.1'     ,'20'          ,0.1     ,20          ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6441 ,'0.25'    ,'25'          ,0.25    ,25          ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6442 ,'0.3'     ,'30'          ,0.3     ,30          ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6443 ,'0.07'    ,'35'          ,0.07    ,35          ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6444 ,'0.1'     ,'20'          ,0.1     ,20          ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6445 ,'0.25'    ,'25'          ,0.25    ,25          ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6446 ,'0.1'     ,'20'          ,0.1     ,20          ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6447 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6448 ,'0.25'    ,'25'          ,0.25    ,25          ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6449 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6450 ,'0.3'     ,'30'          ,0.3     ,30          ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6451 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6452 ,'0.05'    ,'25'          ,0.05    ,25          ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6453 ,'0.15'    ,'15'          ,0.15    ,15          ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6454 ,'0.1'     ,'20'          ,0.1     ,20          ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6455 ,'0.1'     ,'20'          ,0.1     ,20          ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6436 ,'0.25'    ,'25'          ,0.25    ,25          ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6437 ,'0.1'     ,'20'          ,0.1     ,20          ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6438 ,'0.25'    ,'25'          ,0.25    ,25          ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6439 ,'0.25'    ,'25'          ,0.25    ,25          ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6440 ,'0.1'     ,'20'          ,0.1     ,20          ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6441 ,'0.25'    ,'25'          ,0.25    ,25          ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6442 ,'0.3'     ,'30'          ,0.3     ,30          ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6443 ,'0.07'    ,'35'          ,0.07    ,35          ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6444 ,'0.1'     ,'20'          ,0.1     ,20          ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6445 ,'0.25'    ,'25'          ,0.25    ,25          ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6446 ,'0.1'     ,'20'          ,0.1     ,20          ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6447 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6448 ,'0.25'    ,'25'          ,0.25    ,25          ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6449 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6450 ,'0.3'     ,'30'          ,0.3     ,30          ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6451 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6452 ,'0.05'    ,'25'          ,0.05    ,25          ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6453 ,'0.15'    ,'15'          ,0.15    ,15          ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6454 ,'0.1'     ,'20'          ,0.1     ,20          ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6455 ,'0.1'     ,'20'          ,0.1     ,20          ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
--Won
SELECT 6436 ,'250'     ,'7500'        ,250     ,7500        ,45   UNION ALL	--Won	--Won
SELECT 6437 ,'100'     ,'6000'        ,100     ,6000        ,45   UNION ALL	--Won	--Won
SELECT 6438 ,'250'     ,'7500'        ,250     ,7500        ,45   UNION ALL	--Won	--Won
SELECT 6439 ,'250'     ,'7500'        ,250     ,7500        ,45   UNION ALL	--Won	--Won
SELECT 6440 ,'100'     ,'6000'        ,100     ,6000        ,45   UNION ALL	--Won	--Won
SELECT 6441 ,'250'     ,'7500'        ,250     ,7500        ,45   UNION ALL	--Won	--Won
SELECT 6442 ,'300'     ,'9000'        ,300     ,9000        ,45   UNION ALL	--Won	--Won
SELECT 6443 ,'70'      ,'4200'        ,70      ,4200        ,45   UNION ALL	--Won	--Won
SELECT 6444 ,'100'     ,'5000'        ,100     ,5000        ,45   UNION ALL	--Won	--Won
SELECT 6445 ,'250'     ,'7500'        ,250     ,7500        ,45   UNION ALL	--Won	--Won
SELECT 6446 ,'100'     ,'6000'        ,100     ,6000        ,45   UNION ALL	--Won	--Won
SELECT 6447 ,'200'     ,'6000'        ,200     ,6000        ,45   UNION ALL	--Won	--Won
SELECT 6448 ,'250'     ,'7500'        ,250     ,7500        ,45   UNION ALL	--Won	--Won
SELECT 6449 ,'200'     ,'6000'        ,200     ,6000        ,45   UNION ALL	--Won	--Won
SELECT 6450 ,'300'     ,'9000'        ,300     ,9000        ,45   UNION ALL	--Won	--Won
SELECT 6451 ,'200'     ,'6000'        ,200     ,6000        ,45   UNION ALL	--Won	--Won
SELECT 6452 ,'50'      ,'3000'        ,50      ,3000        ,45   UNION ALL	--Won	--Won
SELECT 6453 ,'150'     ,'4500'        ,150     ,4500        ,45   UNION ALL	--Won	--Won
SELECT 6454 ,'100'     ,'5000'        ,100     ,5000        ,45   UNION ALL	--Won	--Won
SELECT 6455 ,'100'     ,'6000'        ,100     ,6000        ,45				--Won	--Won

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