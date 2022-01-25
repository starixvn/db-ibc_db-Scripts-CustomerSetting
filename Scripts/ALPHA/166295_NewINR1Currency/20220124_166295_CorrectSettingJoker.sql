/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created:	Winfred
	Date:		20220121
	Task:		Update setting 234	Joker (Joker) for currency INR1 RedmineID:#166295
	DB:			DBCust/CustDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(17))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
SELECT 6401 ,'9'       ,'180'         ,9       ,180         ,10   UNION ALL	--INR1
SELECT 6402 ,'10'      ,'200'         ,10      ,200         ,10   UNION ALL	--INR1
SELECT 6403 ,'10'      ,'200'         ,10      ,200         ,10   UNION ALL	--INR1
SELECT 6404 ,'20'      ,'400'         ,20      ,400         ,10   UNION ALL	--INR1
SELECT 6405 ,'10'      ,'200'         ,10      ,200         ,10   UNION ALL	--INR1
SELECT 6406 ,'50'      ,'1000'        ,50      ,1000        ,10   UNION ALL	--INR1
SELECT 6407 ,'50'      ,'1000'        ,50      ,1000        ,10   UNION ALL	--INR1
SELECT 6408 ,'20'      ,'400'         ,20      ,400         ,10   UNION ALL	--INR1
SELECT 6409 ,'10'      ,'200'         ,10      ,200         ,10   UNION ALL	--INR1
SELECT 6410 ,'10'      ,'200'         ,10      ,200         ,10   UNION ALL	--INR1
SELECT 6411 ,'10'      ,'200'         ,10      ,200         ,10   UNION ALL	--INR1
SELECT 6412 ,'5'       ,'100'         ,5       ,100         ,10   UNION ALL	--INR1
SELECT 6413 ,'25'      ,'500'         ,25      ,500         ,10   UNION ALL	--INR1
SELECT 6414 ,'10'      ,'200'         ,10      ,200         ,10   UNION ALL	--INR1
SELECT 6415 ,'20'      ,'400'         ,20      ,400         ,10   UNION ALL	--INR1
SELECT 6416 ,'15'      ,'300'         ,15      ,300         ,10   UNION ALL	--INR1
SELECT 6417 ,'25'      ,'500'         ,25      ,500         ,10   UNION ALL	--INR1
SELECT 6418 ,'25'      ,'500'         ,25      ,500         ,10   UNION ALL	--INR1
SELECT 6419 ,'20'      ,'400'         ,20      ,400         ,10   UNION ALL	--INR1
SELECT 6420 ,'20'      ,'400'         ,20      ,400         ,10   UNION ALL	--INR1
SELECT 6421 ,'40'      ,'800'         ,40      ,800         ,10   UNION ALL	--INR1
SELECT 6422 ,'25'      ,'500'         ,25      ,500         ,10   UNION ALL	--INR1
SELECT 6423 ,'50'      ,'500'         ,50      ,500         ,10   UNION ALL	--INR1
SELECT 6424 ,'9'       ,'180'         ,9       ,180         ,10   UNION ALL	--INR1
SELECT 6425 ,'9'       ,'180'         ,9       ,180         ,10   UNION ALL	--INR1
SELECT 6426 ,'20'      ,'400'         ,20      ,400         ,10   UNION ALL	--INR1
SELECT 6427 ,'50'      ,'1000'        ,50      ,1000        ,10   UNION ALL	--INR1
SELECT 6428 ,'25'      ,'500'         ,25      ,500         ,10   UNION ALL	--INR1
SELECT 6429 ,'9'       ,'180'         ,9       ,180         ,10   UNION ALL	--INR1
SELECT 6430 ,'30'      ,'600'         ,30      ,600         ,10   UNION ALL	--INR1
SELECT 6431 ,'9'       ,'180'         ,9       ,180         ,10   UNION ALL	--INR1
SELECT 6432 ,'9'       ,'180'         ,9       ,180         ,10   UNION ALL	--INR1
SELECT 6433 ,'9'       ,'180'         ,9       ,180         ,10   UNION ALL	--INR1
SELECT 6434 ,'10'      ,'200'         ,10      ,200         ,10   UNION ALL	--INR1
SELECT 6435 ,'15'      ,'300'         ,15      ,300         ,10   UNION ALL	--INR1
SELECT 6436 ,'25'      ,'500'         ,25      ,500         ,10   UNION ALL	--INR1
SELECT 6437 ,'10'      ,'200'         ,10      ,200         ,10   UNION ALL	--INR1
SELECT 6438 ,'25'      ,'500'         ,25      ,500         ,10   UNION ALL	--INR1
SELECT 6439 ,'25'      ,'500'         ,25      ,500         ,10   UNION ALL	--INR1
SELECT 6440 ,'10'      ,'200'         ,10      ,200         ,10   UNION ALL	--INR1
SELECT 6441 ,'25'      ,'500'         ,25      ,500         ,10   UNION ALL	--INR1
SELECT 6442 ,'30'      ,'600'         ,30      ,600         ,10   UNION ALL	--INR1
SELECT 6443 ,'7'       ,'140'         ,7       ,140         ,10   UNION ALL	--INR1
SELECT 6444 ,'1'       ,'200'         ,1       ,200         ,10   UNION ALL	--INR1
SELECT 6445 ,'25'      ,'250'         ,25      ,250         ,10   UNION ALL	--INR1
SELECT 6446 ,'10'      ,'200'         ,10      ,200         ,10   UNION ALL	--INR1
SELECT 6447 ,'20'      ,'400'         ,20      ,400         ,10   UNION ALL	--INR1
SELECT 6448 ,'25'      ,'500'         ,25      ,500         ,10   UNION ALL	--INR1
SELECT 6449 ,'20'      ,'400'         ,20      ,400         ,10   UNION ALL	--INR1
SELECT 6450 ,'30'      ,'600'         ,30      ,600         ,10   UNION ALL	--INR1
SELECT 6451 ,'20'      ,'400'         ,20      ,400         ,10   UNION ALL	--INR1
SELECT 6452 ,'5'       ,'100'         ,5       ,100         ,10   UNION ALL	--INR1
SELECT 6453 ,'15'      ,'300'         ,15      ,300         ,10   UNION ALL	--INR1
SELECT 6454 ,'1'       ,'200'         ,1       ,200         ,10   UNION ALL	--INR1
SELECT 6455 ,'10'      ,'200'         ,10      ,200         ,10				--INR1

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