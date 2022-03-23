/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created:	Winfred
	Date:		20220209
	Task:		Update setting 224	Funky Games (Funky Games) for currency INR1 RedmineID:#166295
	DB:			DBCust/CustDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId INT, GameGroupID INT DEFAULT(32))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
SELECT 5500 ,'50'      ,'100000'      ,50      ,100000      ,10   UNION ALL	--INR1
SELECT 5501 ,'50'      ,'30000'       ,50      ,30000       ,10   UNION ALL	--INR1
SELECT 5502 ,'50'      ,'30000'       ,50      ,30000       ,10   UNION ALL	--INR1
SELECT 5503 ,'50'      ,'30000'       ,50      ,30000       ,10   UNION ALL	--INR1
SELECT 5504 ,'50'      ,'30000'       ,50      ,30000       ,10   UNION ALL	--INR1
SELECT 5505 ,'50'      ,'30000'       ,50      ,30000       ,10   UNION ALL	--INR1
SELECT 5506 ,'50'      ,'5000'        ,50      ,5000        ,10   UNION ALL	--INR1
SELECT 5507 ,'50'      ,'5000'        ,50      ,5000        ,10   UNION ALL	--INR1
SELECT 5508 ,'50'      ,'5000'        ,50      ,5000        ,10   UNION ALL	--INR1
SELECT 5509 ,'50'      ,'5000'        ,50      ,5000        ,10   UNION ALL	--INR1
SELECT 5510 ,'15'      ,'300'         ,15      ,300         ,10   UNION ALL	--INR1
SELECT 5511 ,'18'      ,'360'         ,18      ,360         ,10   UNION ALL	--INR1
SELECT 5512 ,'20'      ,'400'         ,20      ,400         ,10   UNION ALL	--INR1
SELECT 5513 ,'15'      ,'2400'        ,15      ,2400        ,10   UNION ALL	--INR1
SELECT 5514 ,'18'      ,'360'         ,18      ,360         ,10   UNION ALL	--INR1
SELECT 5515 ,'0.8'     ,'88'          ,0.8     ,88          ,10   UNION ALL	--INR1
SELECT 5516 ,'0.8'     ,'88'          ,0.8     ,88          ,10   UNION ALL	--INR1
SELECT 5517 ,'16'      ,'320'         ,16      ,320         ,10   UNION ALL	--INR1
SELECT 5518 ,'16'      ,'320'         ,16      ,320         ,10   UNION ALL	--INR1
SELECT 5519 ,'18'      ,'360'         ,18      ,360         ,10   UNION ALL	--INR1
SELECT 5520 ,'18'      ,'360'         ,18      ,360         ,10   UNION ALL	--INR1
SELECT 5521 ,'15'      ,'300'         ,15      ,300         ,10   UNION ALL	--INR1
SELECT 5522 ,'15.2'    ,'304'         ,15.2    ,304         ,10   UNION ALL	--INR1
SELECT 5523 ,'15.2'    ,'304'         ,15.2    ,304         ,10   UNION ALL	--INR1
SELECT 5524 ,'25'      ,'1625'        ,25      ,1625        ,10   UNION ALL	--INR1
SELECT 5525 ,'5'       ,'4000'        ,5       ,4000        ,10   UNION ALL	--INR1
SELECT 5526 ,'5'       ,'2000'        ,5       ,2000        ,10   UNION ALL	--INR1
SELECT 5527 ,'5'       ,'100'         ,5       ,100         ,10   UNION ALL	--INR1
SELECT 5528 ,'5'       ,'2000'        ,5       ,2000        ,10				--INR1
	
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
WHERE s.GameTypeID = 5500)

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