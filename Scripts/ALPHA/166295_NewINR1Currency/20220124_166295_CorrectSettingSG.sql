/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created:	Winfred
	Date:		20220121
	Task:		Update setting 247	SG (Spadegaming) for currency INR1 RedmineID:#166295
	DB:			DBCust/CustDB
*/

CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId INT, GameGroupID INT DEFAULT(12))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
SELECT 4301 ,'25'      ,'5000'        ,25      ,5000        ,10   UNION ALL	--INR1	
SELECT 4302 ,'5'       ,'5000'        ,5       ,5000        ,10   UNION ALL	--INR1	
SELECT 4303 ,'4'       ,'2000'        ,4       ,2000        ,10   UNION ALL	--INR1	
SELECT 4304 ,'4'       ,'2000'        ,4       ,2000        ,10   UNION ALL	--INR1	
SELECT 4305 ,'10'      ,'5000'        ,10      ,5000        ,10   UNION ALL	--INR1	
SELECT 4306 ,'10'      ,'5000'        ,10      ,5000        ,10   UNION ALL	--INR1	
SELECT 4309 ,'5'       ,'4500'        ,5       ,4500        ,10   UNION ALL	--INR1	
SELECT 4310 ,'50'      ,'5000'        ,50      ,5000        ,10   UNION ALL	--INR1	
SELECT 4311 ,'15'      ,'7500'        ,15      ,7500        ,10   UNION ALL	--INR1	
SELECT 4312 ,'30'      ,'7500'        ,30      ,7500        ,10   UNION ALL	--INR1	
SELECT 4314 ,'25'      ,'5000'        ,25      ,5000        ,10   UNION ALL	--INR1	
SELECT 4315 ,'4'       ,'2000'        ,4       ,2000        ,10   UNION ALL	--INR1	
SELECT 4316 ,'4'       ,'2000'        ,4       ,2000        ,10   UNION ALL	--INR1	
SELECT 4317 ,'5'       ,'4500'        ,5       ,4500        ,10   UNION ALL	--INR1	
SELECT 4318 ,'9'       ,'4500'        ,9       ,4500        ,10   UNION ALL	--INR1	
SELECT 4319 ,'25'      ,'5000'        ,25      ,5000        ,10   UNION ALL	--INR1	
SELECT 4320 ,'25'      ,'5000'        ,25      ,5000        ,10   UNION ALL	--INR1	
SELECT 4321 ,'10'      ,'5000'        ,10      ,5000        ,10   UNION ALL	--INR1	
SELECT 4322 ,'10'      ,'5000'        ,10      ,5000        ,10   UNION ALL	--INR1	
SELECT 4323 ,'5'       ,'4500'        ,5       ,4500        ,10   UNION ALL	--INR1	
SELECT 4324 ,'15'      ,'7500'        ,15      ,7500        ,10   UNION ALL	--INR1	
SELECT 4327 ,'5'       ,'4500'        ,5       ,4500        ,10   UNION ALL	--INR1	
SELECT 4328 ,'5'       ,'4500'        ,5       ,4500        ,10   UNION ALL	--INR1	
SELECT 4329 ,'9'       ,'4500'        ,9       ,4500        ,10   UNION ALL	--INR1	
SELECT 4330 ,'9'       ,'4500'        ,9       ,4500        ,10   UNION ALL	--INR1	
SELECT 4331 ,'9'       ,'4500'        ,9       ,4500        ,10   UNION ALL	--INR1	
SELECT 4332 ,'5'       ,'4500'        ,5       ,4500        ,10   UNION ALL	--INR1	
SELECT 4333 ,'5'       ,'4500'        ,5       ,4500        ,10   UNION ALL	--INR1	
SELECT 4334 ,'40'      ,'5000'        ,40      ,5000        ,10   UNION ALL	--INR1	
SELECT 4335 ,'9'       ,'4500'        ,9       ,4500        ,10   UNION ALL	--INR1	
SELECT 4336 ,'40'      ,'6000'        ,40      ,6000        ,10   UNION ALL	--INR1	
SELECT 4337 ,'25'      ,'5000'        ,25      ,5000        ,10   UNION ALL	--INR1	
SELECT 4338 ,'4'       ,'2000'        ,4       ,2000        ,10   UNION ALL	--INR1	
SELECT 4339 ,'25'      ,'5000'        ,25      ,5000        ,10   UNION ALL	--INR1	
SELECT 4340 ,'10'      ,'5000'        ,10      ,5000        ,10   UNION ALL	--INR1	
SELECT 4341 ,'15'      ,'7500'        ,15      ,7500        ,10   UNION ALL	--INR1	
SELECT 4342 ,'15'      ,'7500'        ,15      ,7500        ,10   UNION ALL	--INR1	
SELECT 4343 ,'15'      ,'7500'        ,15      ,7500        ,10   UNION ALL	--INR1	
SELECT 4344 ,'25'      ,'5000'        ,25      ,5000        ,10   UNION ALL	--INR1	
SELECT 4345 ,'25'      ,'5000'        ,25      ,5000        ,10   UNION ALL	--INR1	
SELECT 4346 ,'25'      ,'5000'        ,25      ,5000        ,10   UNION ALL	--INR1	
SELECT 4347 ,'25'      ,'5000'        ,25      ,5000        ,10   UNION ALL	--INR1	
SELECT 4348 ,'25'      ,'5000'        ,25      ,5000        ,10   UNION ALL	--INR1	
SELECT 4349 ,'15'      ,'7500'        ,15      ,7500        ,10   UNION ALL	--INR1	
SELECT 4350 ,'15'      ,'7500'        ,15      ,7500        ,10   UNION ALL	--INR1	
SELECT 4351 ,'15'      ,'7500'        ,15      ,7500        ,10   UNION ALL	--INR1	
SELECT 4352 ,'9'       ,'4500'        ,9       ,4500        ,10   UNION ALL	--INR1	
SELECT 4353 ,'25'      ,'5000'        ,25      ,5000        ,10   UNION ALL	--INR1	
SELECT 4354 ,'4'       ,'2000'        ,4       ,2000        ,10   UNION ALL	--INR1	
SELECT 4355 ,'10'      ,'5000'        ,10      ,5000        ,10   UNION ALL	--INR1	
SELECT 4356 ,'5'       ,'5000'        ,5       ,5000        ,10   UNION ALL	--INR1	
SELECT 4357 ,'25'      ,'5000'        ,25      ,5000        ,10   UNION ALL	--INR1	
SELECT 4358 ,'15'      ,'7500'        ,15      ,7500        ,10   UNION ALL	--INR1	
SELECT 4359 ,'10'      ,'5000'        ,10      ,5000        ,10   UNION ALL	--INR1	
SELECT 4360 ,'25'      ,'5000'        ,25      ,5000        ,10   UNION ALL	--INR1	
SELECT 4361 ,'25'      ,'5000'        ,25      ,5000        ,10   UNION ALL	--INR1	
SELECT 4362 ,'10'      ,'5000'        ,10      ,5000        ,10   UNION ALL	--INR1	
SELECT 4363 ,'10'      ,'5000'        ,10      ,5000        ,10   UNION ALL	--INR1	
SELECT 4364 ,'5'       ,'5000'        ,5       ,5000        ,10   UNION ALL	--INR1	
SELECT 4365 ,'5'       ,'5000'        ,5       ,5000        ,10   UNION ALL	--INR1	
SELECT 4366 ,'50'      ,'5000'        ,50      ,5000        ,10   UNION ALL	--INR1	
SELECT 4367 ,'5'       ,'5000'        ,5       ,5000        ,10   UNION ALL	--INR1	
SELECT 4368 ,'4'       ,'2000'        ,4       ,2000        ,10   UNION ALL	--INR1	
SELECT 4369 ,'10'      ,'5000'        ,10      ,5000        ,10   UNION ALL	--INR1	
SELECT 4370 ,'10'      ,'5000'        ,10      ,5000        ,10   UNION ALL	--INR1	
SELECT 4371 ,'25'      ,'5000'        ,25      ,5000        ,10   UNION ALL	--INR1	
SELECT 4372 ,'25'      ,'5000'        ,25      ,5000        ,10   UNION ALL	--INR1	
SELECT 4373 ,'4'       ,'11000'       ,4       ,11000       ,10   UNION ALL	--INR1	
SELECT 4374 ,'4'       ,'11000'       ,4       ,11000       ,10				--INR1	

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
