/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210814
	Task:  Arcadia Gaming - Revise the betting limit for currency Won RedmineID:#158745
	DB: DBCust/CustDB
*/
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
CREATE TABLE #StakeLevel_Temp (StakeLevelID	INT,GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(9))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--Won
SELECT 1902 ,'1000' ,'300000'  ,1000 ,300000  ,45   UNION ALL	--Won	--WON
SELECT 1903 ,'1000' ,'300000'  ,1000 ,300000  ,45   UNION ALL	--Won	--WON
SELECT 1905 ,'1000' ,'300000'  ,1000 ,300000  ,45   UNION ALL	--Won	--WON
SELECT 1907 ,'1000' ,'300000'  ,1000 ,300000  ,45   UNION ALL	--Won	--WON
SELECT 1908 ,'1000' ,'300000'  ,1000 ,300000  ,45	UNION ALL	--Won	--WON
SELECT 1909 ,'1000' ,'300000'  ,1000 ,300000  ,45	UNION ALL	--Won	--WON
SELECT 1910 ,'1000' ,'300000'  ,1000 ,300000  ,45	UNION ALL	--Won	--WON
SELECT 1911 ,'1000' ,'300000'  ,1000 ,300000  ,45	UNION ALL	--Won	--WON
SELECT 1912 ,'1000' ,'300000'  ,1000 ,300000  ,45				--Won	--WON

UPDATE t
SET t.StakeLevelID = s.StakeLevelID
FROM #StakeLevel_Temp t
INNER JOIN StakeLevel s WITH(NOLOCK) ON t.ExchangeId = s.ExchangeId  AND t.GameGroupID = s.GameGroupID AND s.GameTypeID = 1901
-- corect data 
INSERT INTO #StakeLevel_Temp(StakeLevelID,GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake)
SELECT  966   ,  1901   ,'2.5'     ,'1250'   ,2.5  ,1250      UNION ALL
SELECT  970   ,  1901   ,'10'      ,'5000'   ,10   ,5000      UNION ALL
SELECT  982   ,  1901   ,'2.5'     ,'1250'   ,2.5  ,1250      UNION ALL
SELECT  983   ,  1901   ,'50'      ,'25000'  ,50   ,25000     UNION ALL
SELECT  985   ,  1901   ,'2.5'     ,'1000'   ,2.5  ,1000      UNION ALL
SELECT  986   ,  1901   ,'4'       ,'2000'   ,4    ,2000      UNION ALL
SELECT  991   ,  1901   ,'2.5'     ,'1250'   ,2.5  ,1250      UNION ALL
SELECT  994   ,  1901   ,'5'       ,'1000'   ,5    ,1000      UNION ALL
SELECT  998   ,  1901   ,'4'       ,'2000'   ,4    ,2000      UNION ALL
SELECT  1000  ,  1901   ,'5'       ,'1000'   ,5    ,1000      UNION ALL
SELECT  1014  ,  1901   ,'10'      ,'5000'   ,10   ,5000      UNION ALL
SELECT  1018  ,  1901   ,'50'      ,'10000'  ,50   ,10000     UNION ALL
SELECT  1019  ,  1901   ,'200'     ,'100000' ,200  ,100000    UNION ALL
SELECT  1021  ,  1901   ,'2.5'     ,'1250'   ,2.5  ,1250      UNION ALL
SELECT  1022  ,  1901   ,'500'     ,'100000' ,500  ,100000    UNION ALL
SELECT  1023  ,  1901   ,'2'       ,'1000'   ,2    ,1000         

UPDATE t
SET MinLabel = REVERSE(STUFF (REVERSE(t.MinLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MinStake > 999

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999

MERGE StakeLevelGroupDetail as g 
USING #StakeLevel_Temp s on g.StakeLevelID = s.StakeLevelID AND g.GameTypeID = s.GameTypeID
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
