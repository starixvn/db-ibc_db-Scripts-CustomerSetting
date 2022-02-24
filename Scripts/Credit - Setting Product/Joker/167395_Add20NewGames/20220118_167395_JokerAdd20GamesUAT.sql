/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220118
	Task:  Add 20 New Games for [Joker] - Credit - UUS RedmineID:#167395
	DB: DBCust/CustDB
*/
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(17))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--UUS
SELECT 6436 ,'0.25'    ,'75'          ,0.25    ,75          ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6437 ,'0.1'     ,'20'          ,0.1     ,20          ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6438 ,'0.25'    ,'50'          ,0.25    ,50          ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6439 ,'0.25'    ,'75'          ,0.25    ,75          ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6440 ,'0.1'     ,'20'          ,0.1     ,20          ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6441 ,'0.25'    ,'75'          ,0.25    ,75          ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6442 ,'0.3'     ,'90'          ,0.3     ,90          ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6443 ,'0.07'    ,'42'          ,0.07    ,42          ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6444 ,'0.1'     ,'60'          ,0.1     ,60          ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6445 ,'0.25'    ,'25'          ,0.25    ,25          ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6446 ,'0.1'     ,'60'          ,0.1     ,60          ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6447 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6448 ,'0.25'    ,'75'          ,0.25    ,75          ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6449 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6450 ,'0.3'     ,'90'          ,0.3     ,90          ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6451 ,'0.2'     ,'20'          ,0.2     ,20          ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6452 ,'0.05'    ,'30'          ,0.05    ,30          ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6453 ,'0.15'    ,'45'          ,0.15    ,45          ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6454 ,'0.1'     ,'60'          ,0.1     ,60          ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6455 ,'0.1'     ,'20'          ,0.1     ,20          ,20				--UUS	--IN,IND,IDD,IDR,DDD,UUS

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
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 