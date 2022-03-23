/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created:	Winfred
	Date:		20220121
	Task:		Update setting 167	CG (CG) for currency INR1 RedmineID:#166295
	DB:			DBCust/CustDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(23))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
SELECT 7301 ,'90'      ,'9000'        ,90      ,9000        ,10   UNION ALL	--INR1
SELECT 7302 ,'12.5'    ,'6250'        ,12.5    ,6250        ,10   UNION ALL	--INR1
SELECT 7303 ,'12.5'    ,'6250'        ,12.5    ,6250        ,10   UNION ALL	--INR1
SELECT 7304 ,'12.5'    ,'6250'        ,12.5    ,6250        ,10   UNION ALL	--INR1
SELECT 7305 ,'75'      ,'10000'       ,75      ,10000       ,10   UNION ALL	--INR1
SELECT 7306 ,'12.5'    ,'6250'        ,12.5    ,6250        ,10   UNION ALL	--INR1
SELECT 7307 ,'100'     ,'10000'       ,100     ,10000       ,10   UNION ALL	--INR1
SELECT 7308 ,'100'     ,'10000'       ,100     ,10000       ,10   UNION ALL	--INR1
SELECT 7309 ,'25'      ,'7500'        ,25      ,7500        ,10   UNION ALL	--INR1
SELECT 7310 ,'25'      ,'7500'        ,25      ,7500        ,10   UNION ALL	--INR1
SELECT 7311 ,'25'      ,'7500'        ,25      ,7500        ,10   UNION ALL	--INR1
SELECT 7312 ,'25'      ,'7500'        ,25      ,7500        ,10   UNION ALL	--INR1
SELECT 7313 ,'25'      ,'750'         ,25      ,750         ,10   UNION ALL	--INR1
SELECT 7314 ,'25'      ,'7500'        ,25      ,7500        ,10   UNION ALL	--INR1
SELECT 7315 ,'100'     ,'10000'       ,100     ,10000       ,10   UNION ALL	--INR1
SELECT 7316 ,'45'      ,'7500'        ,45      ,7500        ,10   UNION ALL	--INR1
SELECT 7317 ,'75'      ,'10000'       ,75      ,10000       ,10   UNION ALL	--INR1
SELECT 7318 ,'100'     ,'10000'       ,100     ,10000       ,10   UNION ALL	--INR1
SELECT 7319 ,'37.5'    ,'750'         ,37.5    ,750         ,10   UNION ALL	--INR1
SELECT 7320 ,'37.5'    ,'2500'        ,37.5    ,2500        ,10   UNION ALL	--INR1
SELECT 7321 ,'25'      ,'2500'        ,25      ,2500        ,10   UNION ALL	--INR1
SELECT 7322 ,'37.5'    ,'750'         ,37.5    ,750         ,10   UNION ALL	--INR1
SELECT 7323 ,'25'      ,'10000'       ,25      ,10000       ,10   UNION ALL	--INR1
SELECT 7324 ,'12.5'    ,'6250'        ,12.5    ,6250        ,10   UNION ALL	--INR1
SELECT 7325 ,'12.5'    ,'6250'        ,12.5    ,6250        ,10   UNION ALL	--INR1
SELECT 7326 ,'45'      ,'7500'        ,45      ,7500        ,10   UNION ALL	--INR1
SELECT 7327 ,'22'      ,'146.67'      ,22      ,146.67      ,10   UNION ALL	--INR1
SELECT 7328 ,'75'      ,'10000'       ,75      ,10000       ,10   UNION ALL	--INR1
SELECT 7329 ,'62.5'    ,'7500'        ,62.5    ,7500        ,10   UNION ALL	--INR1
SELECT 7330 ,'45'      ,'7500'        ,45      ,7500        ,10   UNION ALL	--INR1
SELECT 7331 ,'45'      ,'7500'        ,45      ,7500        ,10   UNION ALL	--INR1
SELECT 7332 ,'62.5'    ,'7500'        ,62.5    ,7500        ,10   UNION ALL	--INR1
SELECT 7333 ,'75'      ,'10000'       ,75      ,10000       ,10   UNION ALL	--INR1
SELECT 7334 ,'37.5'    ,'2500'        ,37.5    ,2500        ,10   UNION ALL	--INR1
SELECT 7335 ,'45'      ,'7500'        ,45      ,7500        ,10   UNION ALL	--INR1
SELECT 7336 ,'45'      ,'7500'        ,45      ,7500        ,10   UNION ALL	--INR1
SELECT 7337 ,'75'      ,'10000'       ,75      ,10000       ,10   UNION ALL	--INR1
SELECT 7338 ,'75'      ,'10000'       ,75      ,10000       ,10   UNION ALL	--INR1
SELECT 7339 ,'45'      ,'7500'        ,45      ,7500        ,10   UNION ALL	--INR1
SELECT 7340 ,'37.5'    ,'750'         ,37.5    ,750         ,10   UNION ALL	--INR1
SELECT 7341 ,'75'      ,'10000'       ,75      ,10000       ,10   UNION ALL	--INR1
SELECT 7342 ,'45'      ,'7500'        ,45      ,7500        ,10   UNION ALL	--INR1
SELECT 7343 ,'100'     ,'10000'       ,100     ,10000       ,10   UNION ALL	--INR1
SELECT 7344 ,'75'      ,'10000'       ,75      ,10000       ,10   UNION ALL	--INR1
SELECT 7345 ,'45'      ,'7500'        ,45      ,7500        ,10   UNION ALL	--INR1
SELECT 7346 ,'37.5'    ,'750'         ,37.5    ,750         ,10   UNION ALL	--INR1
SELECT 7347 ,'75'      ,'10000'       ,75      ,10000       ,10   UNION ALL	--INR1
SELECT 7348 ,'75'      ,'10000'       ,75      ,10000       ,10   UNION ALL	--INR1
SELECT 7349 ,'37.5'    ,'7500'        ,37.5    ,7500        ,10   UNION ALL	--INR1
SELECT 7350 ,'75'      ,'10000'       ,75      ,10000       ,10   UNION ALL	--INR1
SELECT 7351 ,'75'      ,'10000'       ,75      ,10000       ,10   UNION ALL	--INR1
SELECT 7352 ,'75'      ,'10000'       ,75      ,10000       ,10   UNION ALL	--INR1
SELECT 7353 ,'75'      ,'10000'       ,75      ,10000       ,10   UNION ALL	--INR1
SELECT 7354 ,'45'      ,'7500'        ,45      ,7500        ,10   UNION ALL	--INR1
SELECT 7355 ,'37.5'    ,'7500'        ,37.5    ,7500        ,10   UNION ALL	--INR1
SELECT 7356 ,'45'      ,'7500'        ,45      ,7500        ,10   UNION ALL	--INR1
SELECT 7357 ,'37.5'    ,'7500'        ,37.5    ,7500        ,10   UNION ALL	--INR1
SELECT 7358 ,'37.5'    ,'7500'        ,37.5    ,7500        ,10   UNION ALL	--INR1
SELECT 7359 ,'75'      ,'10000'       ,75      ,10000       ,10   UNION ALL	--INR1
SELECT 7360 ,'75'      ,'10000'       ,75      ,10000       ,10   UNION ALL	--INR1
SELECT 7361 ,'75'      ,'10000'       ,75      ,10000       ,10   UNION ALL	--INR1
SELECT 7362 ,'37.5'    ,'7500'        ,37.5    ,7500        ,10   UNION ALL	--INR1
SELECT 7363 ,'22.5'    ,'7500'        ,22.5    ,7500        ,10   UNION ALL	--INR1
SELECT 7364 ,'22.5'    ,'7500'        ,22.5    ,7500        ,10   UNION ALL	--INR1
SELECT 7365 ,'45'      ,'7500'        ,45      ,7500        ,10   UNION ALL	--INR1
SELECT 7366 ,'75'      ,'10000'       ,75      ,10000       ,10   UNION ALL	--INR1
SELECT 7367 ,'75'      ,'10000'       ,75      ,10000       ,10   UNION ALL	--INR1
SELECT 7368 ,'62.5'    ,'7500'        ,62.5    ,7500        ,10   UNION ALL	--INR1
SELECT 7369 ,'45'      ,'7500'        ,45      ,7500        ,10   UNION ALL	--INR1
SELECT 7370 ,'75'      ,'10000'       ,75      ,10000       ,10   UNION ALL	--INR1
SELECT 7371 ,'37.5'    ,'7500'        ,37.5    ,7500        ,10   UNION ALL	--INR1
SELECT 7372 ,'37.5'    ,'7500'        ,37.5    ,7500        ,10   UNION ALL	--INR1
SELECT 7373 ,'75'      ,'10000'       ,75      ,10000       ,10   UNION ALL	--INR1
SELECT 7374 ,'75'      ,'10000'       ,75      ,10000       ,10   UNION ALL	--INR1
SELECT 7375 ,'37.5'    ,'7500'        ,37.5    ,7500        ,10   UNION ALL	--INR1
SELECT 7376 ,'45'      ,'7500'        ,45      ,7500        ,10   UNION ALL	--INR1
SELECT 7377 ,'75'      ,'10000'       ,75      ,10000       ,10   UNION ALL	--INR1
SELECT 7378 ,'75'      ,'10000'       ,75      ,10000       ,10   UNION ALL	--INR1
SELECT 7379 ,'25'      ,'7500'        ,25      ,7500        ,10   UNION ALL	--INR1
SELECT 7380 ,'12.5'    ,'6250'        ,12.5    ,6250        ,10   UNION ALL	--INR1
SELECT 7381 ,'75'      ,'10000'       ,75      ,10000       ,10   UNION ALL	--INR1
SELECT 7382 ,'12.5'    ,'6250'        ,12.5    ,6250        ,10   UNION ALL	--INR1
SELECT 7383 ,'12.5'    ,'6250'        ,12.5    ,6250        ,10   UNION ALL	--INR1
SELECT 7384 ,'62.5'    ,'7500'        ,62.5    ,7500        ,10   UNION ALL	--INR1
SELECT 7385 ,'100'     ,'10000'       ,100     ,10000       ,10   UNION ALL	--INR1
SELECT 7386 ,'45'      ,'7500'        ,45      ,7500        ,10				 --INR1

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
WHERE s.GameTypeID = 7301)

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