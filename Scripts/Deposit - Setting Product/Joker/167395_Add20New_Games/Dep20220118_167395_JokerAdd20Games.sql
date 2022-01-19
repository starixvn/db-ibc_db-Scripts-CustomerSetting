/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220118
	Task:  Add 20 New Games for [Joker] - Deposit RedmineID:#167395
	DB: DBCust/CustDB
*/
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(18))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--EURO
SELECT 6436 ,'0.25'     ,'25'          ,0.25     ,25          ,6    UNION ALL	--EURO	--EURO
SELECT 6437 ,'0.1'      ,'20'          ,0.1      ,20          ,6    UNION ALL	--EURO	--EURO
SELECT 6438 ,'0.25'     ,'25'          ,0.25     ,25          ,6    UNION ALL	--EURO	--EURO
SELECT 6439 ,'0.25'     ,'25'          ,0.25     ,25          ,6    UNION ALL	--EURO	--EURO
SELECT 6440 ,'0.1'      ,'20'          ,0.1      ,20          ,6    UNION ALL	--EURO	--EURO
SELECT 6441 ,'0.25'     ,'25'          ,0.25     ,25          ,6    UNION ALL	--EURO	--EURO
SELECT 6442 ,'0.3'      ,'30'          ,0.3      ,30          ,6    UNION ALL	--EURO	--EURO
SELECT 6443 ,'0.07'     ,'35'          ,0.07     ,35          ,6    UNION ALL	--EURO	--EURO
SELECT 6444 ,'0.1'      ,'20'          ,0.1      ,20          ,6    UNION ALL	--EURO	--EURO
SELECT 6445 ,'0.25'     ,'25'          ,0.25     ,25          ,6    UNION ALL	--EURO	--EURO
SELECT 6446 ,'0.1'      ,'20'          ,0.1      ,20          ,6    UNION ALL	--EURO	--EURO
SELECT 6447 ,'0.2'      ,'20'          ,0.2      ,20          ,6    UNION ALL	--EURO	--EURO
SELECT 6448 ,'0.25'     ,'25'          ,0.25     ,25          ,6    UNION ALL	--EURO	--EURO
SELECT 6449 ,'0.2'      ,'20'          ,0.2      ,20          ,6    UNION ALL	--EURO	--EURO
SELECT 6450 ,'0.3'      ,'30'          ,0.3      ,30          ,6    UNION ALL	--EURO	--EURO
SELECT 6451 ,'0.2'      ,'20'          ,0.2      ,20          ,6    UNION ALL	--EURO	--EURO
SELECT 6452 ,'0.05'     ,'25'          ,0.05     ,25          ,6    UNION ALL	--EURO	--EURO
SELECT 6453 ,'0.15'     ,'15'          ,0.15     ,15          ,6    UNION ALL	--EURO	--EURO
SELECT 6454 ,'0.1'      ,'20'          ,0.1      ,20          ,6    UNION ALL	--EURO	--EURO
SELECT 6455 ,'0.1'      ,'20'          ,0.1      ,20          ,6    UNION ALL	--EURO	--EURO
--IN
SELECT 6436 ,'0.25'     ,'75'          ,0.25     ,75          ,15   UNION ALL	--IN	--IN,UUS
SELECT 6437 ,'0.1'      ,'20'          ,0.1      ,20          ,15   UNION ALL	--IN	--IN,UUS
SELECT 6438 ,'0.25'     ,'50'          ,0.25     ,50          ,15   UNION ALL	--IN	--IN,UUS
SELECT 6439 ,'0.25'     ,'75'          ,0.25     ,75          ,15   UNION ALL	--IN	--IN,UUS
SELECT 6440 ,'0.1'      ,'20'          ,0.1      ,20          ,15   UNION ALL	--IN	--IN,UUS
SELECT 6441 ,'0.25'     ,'75'          ,0.25     ,75          ,15   UNION ALL	--IN	--IN,UUS
SELECT 6442 ,'0.3'      ,'90'          ,0.3      ,90          ,15   UNION ALL	--IN	--IN,UUS
SELECT 6443 ,'0.07'     ,'42'          ,0.07     ,42          ,15   UNION ALL	--IN	--IN,UUS
SELECT 6444 ,'0.1'      ,'60'          ,0.1      ,60          ,15   UNION ALL	--IN	--IN,UUS
SELECT 6445 ,'0.25'     ,'25'          ,0.25     ,25          ,15   UNION ALL	--IN	--IN,UUS
SELECT 6446 ,'0.1'      ,'60'          ,0.1      ,60          ,15   UNION ALL	--IN	--IN,UUS
SELECT 6447 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,UUS
SELECT 6448 ,'0.25'     ,'75'          ,0.25     ,75          ,15   UNION ALL	--IN	--IN,UUS
SELECT 6449 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,UUS
SELECT 6450 ,'0.3'      ,'90'          ,0.3      ,90          ,15   UNION ALL	--IN	--IN,UUS
SELECT 6451 ,'0.2'      ,'20'          ,0.2      ,20          ,15   UNION ALL	--IN	--IN,UUS
SELECT 6452 ,'0.05'     ,'30'          ,0.05     ,30          ,15   UNION ALL	--IN	--IN,UUS
SELECT 6453 ,'0.15'     ,'45'          ,0.15     ,45          ,15   UNION ALL	--IN	--IN,UUS
SELECT 6454 ,'0.1'      ,'60'          ,0.1      ,60          ,15   UNION ALL	--IN	--IN,UUS
SELECT 6455 ,'0.1'      ,'20'          ,0.1      ,20          ,15   UNION ALL	--IN	--IN,UUS
--RM
SELECT 6436 ,'0.25'     ,'25'          ,0.25     ,25          ,2    UNION ALL	--RM	--RM
SELECT 6437 ,'0.1'      ,'20'          ,0.1      ,20          ,2    UNION ALL	--RM	--RM
SELECT 6438 ,'0.25'     ,'25'          ,0.25     ,25          ,2    UNION ALL	--RM	--RM
SELECT 6439 ,'0.25'     ,'25'          ,0.25     ,25          ,2    UNION ALL	--RM	--RM
SELECT 6440 ,'0.1'      ,'20'          ,0.1      ,20          ,2    UNION ALL	--RM	--RM
SELECT 6441 ,'0.25'     ,'50'          ,0.25     ,50          ,2    UNION ALL	--RM	--RM
SELECT 6442 ,'0.3'      ,'30'          ,0.3      ,30          ,2    UNION ALL	--RM	--RM
SELECT 6443 ,'0.07'     ,'35'          ,0.07     ,35          ,2    UNION ALL	--RM	--RM
SELECT 6444 ,'0.1'      ,'20'          ,0.1      ,20          ,2    UNION ALL	--RM	--RM
SELECT 6445 ,'0.25'     ,'25'          ,0.25     ,25          ,2    UNION ALL	--RM	--RM
SELECT 6446 ,'0.1'      ,'20'          ,0.1      ,20          ,2    UNION ALL	--RM	--RM
SELECT 6447 ,'0.2'      ,'20'          ,0.2      ,20          ,2    UNION ALL	--RM	--RM
SELECT 6448 ,'0.25'     ,'25'          ,0.25     ,25          ,2    UNION ALL	--RM	--RM
SELECT 6449 ,'0.2'      ,'20'          ,0.2      ,20          ,2    UNION ALL	--RM	--RM
SELECT 6450 ,'0.3'      ,'30'          ,0.3      ,30          ,2    UNION ALL	--RM	--RM
SELECT 6451 ,'0.2'      ,'20'          ,0.2      ,20          ,2    UNION ALL	--RM	--RM
SELECT 6452 ,'0.05'     ,'25'          ,0.05     ,25          ,2    UNION ALL	--RM	--RM
SELECT 6453 ,'0.15'     ,'15'          ,0.15     ,15          ,2    UNION ALL	--RM	--RM
SELECT 6454 ,'0.1'      ,'20'          ,0.1      ,20          ,2    UNION ALL	--RM	--RM
SELECT 6455 ,'0.1'      ,'20'          ,0.1      ,20          ,2    UNION ALL	--RM	--RM
--RMB,YUN
SELECT 6436 ,'0.25'     ,'50'          ,0.25     ,50          ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6437 ,'0.1'      ,'50'          ,0.1      ,50          ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6438 ,'0.25'     ,'50'          ,0.25     ,50          ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6439 ,'0.25'     ,'50'          ,0.25     ,50          ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6440 ,'0.1'      ,'50'          ,0.1      ,50          ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6441 ,'0.25'     ,'50'          ,0.25     ,50          ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6442 ,'0.3'      ,'60'          ,0.3      ,60          ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6443 ,'0.07'     ,'35'          ,0.07     ,35          ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6444 ,'0.1'      ,'50'          ,0.1      ,50          ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6445 ,'0.25'     ,'50'          ,0.25     ,50          ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6446 ,'0.1'      ,'50'          ,0.1      ,50          ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6447 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6448 ,'0.25'     ,'50'          ,0.25     ,50          ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6449 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6450 ,'0.3'      ,'60'          ,0.3      ,60          ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6451 ,'0.2'      ,'20'          ,0.2      ,20          ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6452 ,'0.05'     ,'25'          ,0.05     ,25          ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6453 ,'0.15'     ,'30'          ,0.15     ,30          ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6454 ,'0.1'      ,'50'          ,0.1      ,50          ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6455 ,'0.1'      ,'50'          ,0.1      ,50          ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6436 ,'0.25'     ,'50'          ,0.25     ,50          ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6437 ,'0.1'      ,'50'          ,0.1      ,50          ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6438 ,'0.25'     ,'50'          ,0.25     ,50          ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6439 ,'0.25'     ,'50'          ,0.25     ,50          ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6440 ,'0.1'      ,'50'          ,0.1      ,50          ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6441 ,'0.25'     ,'50'          ,0.25     ,50          ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6442 ,'0.3'      ,'60'          ,0.3      ,60          ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6443 ,'0.07'     ,'35'          ,0.07     ,35          ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6444 ,'0.1'      ,'50'          ,0.1      ,50          ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6445 ,'0.25'     ,'50'          ,0.25     ,50          ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6446 ,'0.1'      ,'50'          ,0.1      ,50          ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6447 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6448 ,'0.25'     ,'50'          ,0.25     ,50          ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6449 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6450 ,'0.3'      ,'60'          ,0.3      ,60          ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6451 ,'0.2'      ,'20'          ,0.2      ,20          ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6452 ,'0.05'     ,'25'          ,0.05     ,25          ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6453 ,'0.15'     ,'30'          ,0.15     ,30          ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6454 ,'0.1'      ,'50'          ,0.1      ,50          ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6455 ,'0.1'      ,'50'          ,0.1      ,50          ,66   UNION ALL	--YUN	--RMB,YUN
--TB
SELECT 6436 ,'2.5'      ,'250'         ,2.5      ,250         ,4    UNION ALL	--TB	--TB,THB
SELECT 6437 ,'1'        ,'200'         ,1        ,200         ,4    UNION ALL	--TB	--TB,THB
SELECT 6438 ,'2.5'      ,'75'          ,2.5      ,75          ,4    UNION ALL	--TB	--TB,THB
SELECT 6439 ,'2.5'      ,'250'         ,2.5      ,250         ,4    UNION ALL	--TB	--TB,THB
SELECT 6440 ,'1'        ,'200'         ,1        ,200         ,4    UNION ALL	--TB	--TB,THB
SELECT 6441 ,'2.5'      ,'250'         ,2.5      ,250         ,4    UNION ALL	--TB	--TB,THB
SELECT 6442 ,'3'        ,'300'         ,3        ,300         ,4    UNION ALL	--TB	--TB,THB
SELECT 6443 ,'0.7'      ,'140'         ,0.7      ,140         ,4    UNION ALL	--TB	--TB,THB
SELECT 6444 ,'1'        ,'200'         ,1        ,200         ,4    UNION ALL	--TB	--TB,THB
SELECT 6445 ,'2.5'      ,'250'         ,2.5      ,250         ,4    UNION ALL	--TB	--TB,THB
SELECT 6446 ,'1'        ,'200'         ,1        ,200         ,4    UNION ALL	--TB	--TB,THB
SELECT 6447 ,'2'        ,'200'         ,2        ,200         ,4    UNION ALL	--TB	--TB,THB
SELECT 6448 ,'2.5'      ,'250'         ,2.5      ,250         ,4    UNION ALL	--TB	--TB,THB
SELECT 6449 ,'2'        ,'200'         ,2        ,200         ,4    UNION ALL	--TB	--TB,THB
SELECT 6450 ,'3'        ,'300'         ,3        ,300         ,4    UNION ALL	--TB	--TB,THB
SELECT 6451 ,'2'        ,'200'         ,2        ,200         ,4    UNION ALL	--TB	--TB,THB
SELECT 6452 ,'0.5'      ,'100'         ,0.5      ,100         ,4    UNION ALL	--TB	--TB,THB
SELECT 6453 ,'1.5'      ,'150'         ,1.5      ,150         ,4    UNION ALL	--TB	--TB,THB
SELECT 6454 ,'1'        ,'200'         ,1        ,200         ,4    UNION ALL	--TB	--TB,THB
SELECT 6455 ,'1'        ,'200'         ,1        ,200         ,4    UNION ALL	--TB	--TB,THB
--US$
SELECT 6436 ,'0.25'     ,'25'          ,0.25     ,25          ,3    UNION ALL	--US$	--USDT,US$
SELECT 6437 ,'0.1'      ,'20'          ,0.1      ,20          ,3    UNION ALL	--US$	--USDT,US$
SELECT 6438 ,'0.25'     ,'25'          ,0.25     ,25          ,3    UNION ALL	--US$	--USDT,US$
SELECT 6439 ,'0.25'     ,'25'          ,0.25     ,25          ,3    UNION ALL	--US$	--USDT,US$
SELECT 6440 ,'0.1'      ,'20'          ,0.1      ,20          ,3    UNION ALL	--US$	--USDT,US$
SELECT 6441 ,'0.25'     ,'25'          ,0.25     ,25          ,3    UNION ALL	--US$	--USDT,US$
SELECT 6442 ,'0.3'      ,'30'          ,0.3      ,30          ,3    UNION ALL	--US$	--USDT,US$
SELECT 6443 ,'0.07'     ,'35'          ,0.07     ,35          ,3    UNION ALL	--US$	--USDT,US$
SELECT 6444 ,'0.1'      ,'20'          ,0.1      ,20          ,3    UNION ALL	--US$	--USDT,US$
SELECT 6445 ,'0.25'     ,'25'          ,0.25     ,25          ,3    UNION ALL	--US$	--USDT,US$
SELECT 6446 ,'0.1'      ,'20'          ,0.1      ,20          ,3    UNION ALL	--US$	--USDT,US$
SELECT 6447 ,'0.2'      ,'20'          ,0.2      ,20          ,3    UNION ALL	--US$	--USDT,US$
SELECT 6448 ,'0.25'     ,'25'          ,0.25     ,25          ,3    UNION ALL	--US$	--USDT,US$
SELECT 6449 ,'0.2'      ,'20'          ,0.2      ,20          ,3    UNION ALL	--US$	--USDT,US$
SELECT 6450 ,'0.3'      ,'30'          ,0.3      ,30          ,3    UNION ALL	--US$	--USDT,US$
SELECT 6451 ,'0.2'      ,'20'          ,0.2      ,20          ,3    UNION ALL	--US$	--USDT,US$
SELECT 6452 ,'0.05'     ,'25'          ,0.05     ,25          ,3    UNION ALL	--US$	--USDT,US$
SELECT 6453 ,'0.15'     ,'15'          ,0.15     ,15          ,3    UNION ALL	--US$	--USDT,US$
SELECT 6454 ,'0.1'      ,'20'          ,0.1      ,20          ,3    UNION ALL	--US$	--USDT,US$
SELECT 6455 ,'0.1'      ,'20'          ,0.1      ,20          ,3    UNION ALL	--US$	--USDT,US$
--INR
SELECT 6436 ,'25'       ,'500'         ,25       ,500         ,61   UNION ALL	--INR	--INR
SELECT 6437 ,'10'       ,'200'         ,10       ,200         ,61   UNION ALL	--INR	--INR
SELECT 6438 ,'25'       ,'500'         ,25       ,500         ,61   UNION ALL	--INR	--INR
SELECT 6439 ,'25'       ,'500'         ,25       ,500         ,61   UNION ALL	--INR	--INR
SELECT 6440 ,'10'       ,'200'         ,10       ,200         ,61   UNION ALL	--INR	--INR
SELECT 6441 ,'25'       ,'500'         ,25       ,500         ,61   UNION ALL	--INR	--INR
SELECT 6442 ,'30'       ,'600'         ,30       ,600         ,61   UNION ALL	--INR	--INR
SELECT 6443 ,'7'        ,'140'         ,7        ,140         ,61   UNION ALL	--INR	--INR
SELECT 6444 ,'1'        ,'200'         ,1        ,200         ,61   UNION ALL	--INR	--INR
SELECT 6445 ,'25'       ,'250'         ,25       ,250         ,61   UNION ALL	--INR	--INR
SELECT 6446 ,'10'       ,'200'         ,10       ,200         ,61   UNION ALL	--INR	--INR
SELECT 6447 ,'20'       ,'400'         ,20       ,400         ,61   UNION ALL	--INR	--INR
SELECT 6448 ,'25'       ,'500'         ,25       ,500         ,61   UNION ALL	--INR	--INR
SELECT 6449 ,'20'       ,'400'         ,20       ,400         ,61   UNION ALL	--INR	--INR
SELECT 6450 ,'30'       ,'600'         ,30       ,600         ,61   UNION ALL	--INR	--INR
SELECT 6451 ,'20'       ,'400'         ,20       ,400         ,61   UNION ALL	--INR	--INR
SELECT 6452 ,'5'        ,'100'         ,5        ,100         ,61   UNION ALL	--INR	--INR
SELECT 6453 ,'15'       ,'300'         ,15       ,300         ,61   UNION ALL	--INR	--INR
SELECT 6454 ,'1'        ,'200'         ,1        ,200         ,61   UNION ALL	--INR	--INR
SELECT 6455 ,'10'       ,'200'         ,10       ,200         ,61   UNION ALL	--INR	--INR
--Won
SELECT 6436 ,'250'      ,'7500'        ,250      ,7500        ,45   UNION ALL	--Won	--Won
SELECT 6437 ,'100'      ,'6000'        ,100      ,6000        ,45   UNION ALL	--Won	--Won
SELECT 6438 ,'250'      ,'7500'        ,250      ,7500        ,45   UNION ALL	--Won	--Won
SELECT 6439 ,'250'      ,'7500'        ,250      ,7500        ,45   UNION ALL	--Won	--Won
SELECT 6440 ,'100'      ,'6000'        ,100      ,6000        ,45   UNION ALL	--Won	--Won
SELECT 6441 ,'250'      ,'7500'        ,250      ,7500        ,45   UNION ALL	--Won	--Won
SELECT 6442 ,'300'      ,'9000'        ,300      ,9000        ,45   UNION ALL	--Won	--Won
SELECT 6443 ,'70'       ,'4200'        ,70       ,4200        ,45   UNION ALL	--Won	--Won
SELECT 6444 ,'100'      ,'5000'        ,100      ,5000        ,45   UNION ALL	--Won	--Won
SELECT 6445 ,'250'      ,'7500'        ,250      ,7500        ,45   UNION ALL	--Won	--Won
SELECT 6446 ,'100'      ,'6000'        ,100      ,6000        ,45   UNION ALL	--Won	--Won
SELECT 6447 ,'200'      ,'6000'        ,200      ,6000        ,45   UNION ALL	--Won	--Won
SELECT 6448 ,'250'      ,'7500'        ,250      ,7500        ,45   UNION ALL	--Won	--Won
SELECT 6449 ,'200'      ,'6000'        ,200      ,6000        ,45   UNION ALL	--Won	--Won
SELECT 6450 ,'300'      ,'9000'        ,300      ,9000        ,45   UNION ALL	--Won	--Won
SELECT 6451 ,'200'      ,'6000'        ,200      ,6000        ,45   UNION ALL	--Won	--Won
SELECT 6452 ,'50'       ,'3000'        ,50       ,3000        ,45   UNION ALL	--Won	--Won
SELECT 6453 ,'150'      ,'4500'        ,150      ,4500        ,45   UNION ALL	--Won	--Won
SELECT 6454 ,'100'      ,'5000'        ,100      ,5000        ,45   UNION ALL	--Won	--Won
SELECT 6455 ,'100'      ,'6000'        ,100      ,6000        ,45				--Won	--Won


UPDATE t
SET MinLabel = REVERSE(STUFF (REVERSE(t.MinLabel),4,0,','))
FROM #Dep_StakeLevel_Temp t
WHERE MinStake > 999

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
