/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20211215
	Task:  Update 35 Games for [Joker] - Deposit RedmineID:#166020
	DB: DBCust/CustDB
*/
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(18))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--RMB,YUN
SELECT 6401 ,'0.09' ,'45'      ,0.09 ,45      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6402 ,'0.1'  ,'50'      ,0.1  ,50      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6403 ,'0.1'  ,'50'      ,0.1  ,50      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6404 ,'0.2'  ,'100'     ,0.2  ,100     ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6405 ,'0.1'  ,'50'      ,0.1  ,50      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6406 ,'0.25' ,'125'     ,0.25 ,125     ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6407 ,'0.25' ,'125'     ,0.25 ,125     ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6408 ,'0.2'  ,'20'      ,0.2  ,20      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6409 ,'0.1'  ,'50'      ,0.1  ,50      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6410 ,'0.1'  ,'50'      ,0.1  ,50      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6411 ,'0.1'  ,'50'      ,0.1  ,50      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6412 ,'0.05' ,'25'      ,0.05 ,25      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6413 ,'0.25' ,'50'      ,0.25 ,50      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6414 ,'0.1'  ,'50'      ,0.1  ,50      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6415 ,'0.2'  ,'20'      ,0.2  ,20      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6416 ,'0.15' ,'45'      ,0.15 ,45      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6417 ,'0.25' ,'50'      ,0.25 ,50      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6418 ,'0.25' ,'50'      ,0.25 ,50      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6419 ,'0.2'  ,'40'      ,0.2  ,40      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6420 ,'0.25' ,'50'      ,0.25 ,50      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6421 ,'0.4'  ,'40'      ,0.4  ,40      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6422 ,'0.25' ,'50'      ,0.25 ,50      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6423 ,'0.5'  ,'50'      ,0.5  ,50      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6424 ,'0.09' ,'45'      ,0.09 ,45      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6425 ,'0.09' ,'45'      ,0.09 ,45      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6426 ,'0.2'  ,'40'      ,0.2  ,40      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6427 ,'0.5'  ,'50'      ,0.5  ,50      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6428 ,'0.25' ,'50'      ,0.25 ,50      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6429 ,'0.09' ,'45'      ,0.09 ,45      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6430 ,'0.3'  ,'60'      ,0.3  ,60      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6431 ,'0.09' ,'45'      ,0.09 ,45      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6432 ,'0.09' ,'45'      ,0.09 ,45      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6433 ,'0.09' ,'45'      ,0.09 ,45      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6434 ,'0.1'  ,'50'      ,0.1  ,50      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6435 ,'0.15' ,'45'      ,0.15 ,45      ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6401 ,'0.09' ,'45'      ,0.09 ,45      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6402 ,'0.1'  ,'50'      ,0.1  ,50      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6403 ,'0.1'  ,'50'      ,0.1  ,50      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6404 ,'0.2'  ,'100'     ,0.2  ,100     ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6405 ,'0.1'  ,'50'      ,0.1  ,50      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6406 ,'0.25' ,'125'     ,0.25 ,125     ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6407 ,'0.25' ,'125'     ,0.25 ,125     ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6408 ,'0.2'  ,'20'      ,0.2  ,20      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6409 ,'0.1'  ,'50'      ,0.1  ,50      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6410 ,'0.1'  ,'50'      ,0.1  ,50      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6411 ,'0.1'  ,'50'      ,0.1  ,50      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6412 ,'0.05' ,'25'      ,0.05 ,25      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6413 ,'0.25' ,'50'      ,0.25 ,50      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6414 ,'0.1'  ,'50'      ,0.1  ,50      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6415 ,'0.2'  ,'20'      ,0.2  ,20      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6416 ,'0.15' ,'45'      ,0.15 ,45      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6417 ,'0.25' ,'50'      ,0.25 ,50      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6418 ,'0.25' ,'50'      ,0.25 ,50      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6419 ,'0.2'  ,'40'      ,0.2  ,40      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6420 ,'0.25' ,'50'      ,0.25 ,50      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6421 ,'0.4'  ,'40'      ,0.4  ,40      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6422 ,'0.25' ,'50'      ,0.25 ,50      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6423 ,'0.5'  ,'50'      ,0.5  ,50      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6424 ,'0.09' ,'45'      ,0.09 ,45      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6425 ,'0.09' ,'45'      ,0.09 ,45      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6426 ,'0.2'  ,'40'      ,0.2  ,40      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6427 ,'0.5'  ,'50'      ,0.5  ,50      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6428 ,'0.25' ,'50'      ,0.25 ,50      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6429 ,'0.09' ,'45'      ,0.09 ,45      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6430 ,'0.3'  ,'60'      ,0.3  ,60      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6431 ,'0.09' ,'45'      ,0.09 ,45      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6432 ,'0.09' ,'45'      ,0.09 ,45      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6433 ,'0.09' ,'45'      ,0.09 ,45      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6434 ,'0.1'  ,'50'      ,0.1  ,50      ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6435 ,'0.15' ,'45'      ,0.15 ,45      ,66   UNION ALL	--YUN	--RMB,YUN
--TB,THB
SELECT 6401 ,'0.9'  ,'180'     ,0.9  ,180     ,4    UNION ALL	--TB	--TB,THB
SELECT 6402 ,'1'    ,'200'     ,1    ,200     ,4    UNION ALL	--TB	--TB,THB
SELECT 6403 ,'1'    ,'200'     ,1    ,200     ,4    UNION ALL	--TB	--TB,THB
SELECT 6404 ,'2'    ,'200'     ,2    ,200     ,4    UNION ALL	--TB	--TB,THB
SELECT 6405 ,'1'    ,'200'     ,1    ,200     ,4    UNION ALL	--TB	--TB,THB
SELECT 6406 ,'2.5'  ,'75'      ,2.5  ,75      ,4    UNION ALL	--TB	--TB,THB
SELECT 6407 ,'2.5'  ,'75'      ,2.5  ,75      ,4    UNION ALL	--TB	--TB,THB
SELECT 6408 ,'2'    ,'200'     ,2    ,200     ,4    UNION ALL	--TB	--TB,THB
SELECT 6409 ,'1'    ,'200'     ,1    ,200     ,4    UNION ALL	--TB	--TB,THB
SELECT 6410 ,'1'    ,'200'     ,1    ,200     ,4    UNION ALL	--TB	--TB,THB
SELECT 6411 ,'1'    ,'200'     ,1    ,200     ,4    UNION ALL	--TB	--TB,THB
SELECT 6412 ,'0.5'  ,'100'     ,0.5  ,100     ,4    UNION ALL	--TB	--TB,THB
SELECT 6413 ,'2.5'  ,'75'      ,2.5  ,75      ,4    UNION ALL	--TB	--TB,THB
SELECT 6414 ,'1'    ,'200'     ,1    ,200     ,4    UNION ALL	--TB	--TB,THB
SELECT 6415 ,'2'    ,'200'     ,2    ,200     ,4    UNION ALL	--TB	--TB,THB
SELECT 6416 ,'1.5'  ,'150'     ,1.5  ,150     ,4    UNION ALL	--TB	--TB,THB
SELECT 6417 ,'2.5'  ,'250'     ,2.5  ,250     ,4    UNION ALL	--TB	--TB,THB
SELECT 6418 ,'2.5'  ,'250'     ,2.5  ,250     ,4    UNION ALL	--TB	--TB,THB
SELECT 6419 ,'2'    ,'200'     ,2    ,200     ,4    UNION ALL	--TB	--TB,THB
SELECT 6420 ,'2.5'  ,'250'     ,2.5  ,250     ,4    UNION ALL	--TB	--TB,THB
SELECT 6421 ,'4'    ,'240'     ,4    ,240     ,4    UNION ALL	--TB	--TB,THB
SELECT 6422 ,'2.5'  ,'250'     ,2.5  ,250     ,4    UNION ALL	--TB	--TB,THB
SELECT 6423 ,'5'    ,'250'     ,5    ,250     ,4    UNION ALL	--TB	--TB,THB
SELECT 6424 ,'0.9'  ,'180'     ,0.9  ,180     ,4    UNION ALL	--TB	--TB,THB
SELECT 6425 ,'0.9'  ,'180'     ,0.9  ,180     ,4    UNION ALL	--TB	--TB,THB
SELECT 6426 ,'2'    ,'200'     ,2    ,200     ,4    UNION ALL	--TB	--TB,THB
SELECT 6427 ,'5'    ,'300'     ,5    ,300     ,4    UNION ALL	--TB	--TB,THB
SELECT 6428 ,'2.5'  ,'250'     ,2.5  ,250     ,4    UNION ALL	--TB	--TB,THB
SELECT 6429 ,'0.9'  ,'180'     ,0.9  ,180     ,4    UNION ALL	--TB	--TB,THB
SELECT 6430 ,'3'    ,'90'      ,3    ,90      ,4    UNION ALL	--TB	--TB,THB
SELECT 6431 ,'0.9'  ,'180'     ,0.9  ,180     ,4    UNION ALL	--TB	--TB,THB
SELECT 6432 ,'0.9'  ,'180'     ,0.9  ,180     ,4    UNION ALL	--TB	--TB,THB
SELECT 6433 ,'0.9'  ,'180'     ,0.9  ,180     ,4    UNION ALL	--TB	--TB,THB
SELECT 6434 ,'1'    ,'200'     ,1    ,200     ,4    UNION ALL	--TB	--TB,THB
SELECT 6435 ,'1.5'  ,'150'     ,1.5  ,150     ,4				--TB	--TB,THB


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
