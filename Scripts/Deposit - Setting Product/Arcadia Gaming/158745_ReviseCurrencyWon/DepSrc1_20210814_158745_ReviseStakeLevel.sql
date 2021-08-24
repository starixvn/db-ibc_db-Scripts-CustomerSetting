/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210814
	Task:  Arcadia Gaming - Revise the betting limit for currency Won RedmineID:#158745
	DB: DBCust/CustDB
*/
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
CREATE TABLE #Dep_StakeLevel_Temp (StakeLevelID	INT,GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId INT, GameGroupID INT DEFAULT(10))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
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
SELECT 1912 ,'1000' ,'300000'  ,1000 ,300000  ,45	UNION ALL	--Won	--WON
SELECT 1904 ,'1000' ,'500000'  ,1000 ,500000  ,45				--Won	--WON

UPDATE t
SET t.StakeLevelID = s.StakeLevelID
FROM #Dep_StakeLevel_Temp t
INNER JOIN Dep_StakeLevel s WITH(NOLOCK) ON t.ExchangeId = s.ExchangeId  AND t.GameGroupID = s.GameGroupID 
AND s.GameTypeID = 1901
-- corect data 
INSERT INTO #Dep_StakeLevel_Temp(StakeLevelID,GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake)
SELECT  604   ,  1901   ,'2.5'     ,'1250'   ,2.5  ,1250      UNION ALL
SELECT  604   ,  1902   ,'10'      ,'10000'  ,10   ,10000     UNION ALL
SELECT  604   ,  1903   ,'10'      ,'10000'  ,10   ,10000     UNION ALL
SELECT  604   ,  1904   ,'20'      ,'15000'  ,20   ,15000     UNION ALL
SELECT  604   ,  1905   ,'10'      ,'10000'  ,10   ,10000     UNION ALL
SELECT  605   ,  1904   ,'2'       ,'1500'   ,2    ,1500      UNION ALL
SELECT  607   ,  1902   ,'1'       ,'1000'   ,1    ,1000      UNION ALL
SELECT  607   ,  1903   ,'1'       ,'1000'   ,1    ,1000      UNION ALL
SELECT  607   ,  1904   ,'2'       ,'1500'   ,2    ,1500      UNION ALL
SELECT  607   ,  1905   ,'1'       ,'1000'   ,1    ,1000      UNION ALL
SELECT  608   ,  1901   ,'10'      ,'5000'   ,10   ,5000      UNION ALL
SELECT  608   ,  1902   ,'100'     ,'50000'  ,100  ,50000     UNION ALL
SELECT  608   ,  1903   ,'100'     ,'50000'  ,100  ,50000     UNION ALL
SELECT  608   ,  1904   ,'100'     ,'75000'  ,100  ,75000     UNION ALL
SELECT  608   ,  1905   ,'100'     ,'50000'  ,100  ,50000     UNION ALL
SELECT  613   ,  1902   ,'3'       ,'4000'   ,3    ,4000      UNION ALL
SELECT  613   ,  1903   ,'3'       ,'4000'   ,3    ,4000      UNION ALL
SELECT  613   ,  1904   ,'6'       ,'4500'   ,6    ,4500      UNION ALL
SELECT  613   ,  1905   ,'3'       ,'4000'   ,3    ,4000      UNION ALL
SELECT  616   ,  1902   ,'3'       ,'4000'   ,3    ,4000      UNION ALL
SELECT  616   ,  1903   ,'3'       ,'4000'   ,3    ,4000      UNION ALL
SELECT  616   ,  1904   ,'6'       ,'4500'   ,6    ,4500      UNION ALL
SELECT  616   ,  1905   ,'3'       ,'4000'   ,3    ,4000      UNION ALL
SELECT  617   ,  1902   ,'3'       ,'4000'   ,3    ,4000      UNION ALL
SELECT  617   ,  1903   ,'3'       ,'4000'   ,3    ,4000      UNION ALL
SELECT  617   ,  1904   ,'6'       ,'4500'   ,6    ,4500      UNION ALL
SELECT  617   ,  1905   ,'3'       ,'4000'   ,3    ,4000      UNION ALL
SELECT  618   ,  1902   ,'3'       ,'4000'   ,3    ,4000      UNION ALL
SELECT  618   ,  1903   ,'3'       ,'4000'   ,3    ,4000      UNION ALL
SELECT  618   ,  1904   ,'6'       ,'4500'   ,6    ,4500      UNION ALL
SELECT  618   ,  1905   ,'3'       ,'4000'   ,3    ,4000      UNION ALL
SELECT  620   ,  1901   ,'2.5'     ,'1250'   ,2.5  ,1250      UNION ALL
SELECT  620   ,  1902   ,'10'      ,'10000'  ,10   ,10000     UNION ALL
SELECT  620   ,  1903   ,'10'      ,'10000'  ,10   ,10000     UNION ALL
SELECT  620   ,  1904   ,'20'      ,'15000'  ,20   ,15000     UNION ALL
SELECT  620   ,  1905   ,'10'      ,'10000'  ,10   ,10000     UNION ALL
SELECT  621   ,  1901   ,'50'      ,'25000'  ,50   ,25000     UNION ALL
SELECT  622   ,  1902   ,'3'       ,'4000'   ,3    ,4000      UNION ALL
SELECT  622   ,  1903   ,'3'       ,'4000'   ,3    ,4000      UNION ALL
SELECT  622   ,  1904   ,'6'       ,'4500'   ,6    ,4500      UNION ALL
SELECT  622   ,  1905   ,'3'       ,'4000'   ,3    ,4000      UNION ALL
SELECT  623   ,  1901   ,'2.5'     ,'1000'   ,2.5  ,1000      UNION ALL
SELECT  623   ,  1902   ,'5'       ,'5000'   ,5    ,5000      UNION ALL
SELECT  623   ,  1903   ,'5'       ,'5000'   ,5    ,5000      UNION ALL
SELECT  623   ,  1904   ,'10'      ,'7500'   ,10   ,7500      UNION ALL
SELECT  623   ,  1905   ,'5'       ,'5000'   ,5    ,5000      UNION ALL
SELECT  624   ,  1901   ,'4'       ,'2000'   ,4    ,2000      UNION ALL
SELECT  626   ,  1904   ,'2'       ,'1500'   ,2    ,1500      UNION ALL
SELECT  629   ,  1901   ,'2.5'     ,'1250'   ,2.5  ,1250      UNION ALL
SELECT  632   ,  1901   ,'5'       ,'1000'   ,5    ,1000      UNION ALL
SELECT  636   ,  1901   ,'4'       ,'2000'   ,4    ,2000      UNION ALL
SELECT  638   ,  1901   ,'5'       ,'1000'   ,5    ,1000      UNION ALL
SELECT  652   ,  1901   ,'10'      ,'5000'   ,10   ,5000      UNION ALL
SELECT  654   ,  1904   ,'2'       ,'1500'   ,2    ,1500      UNION ALL
SELECT  656   ,  1901   ,'50'      ,'10000'  ,50   ,10000     UNION ALL
SELECT  657   ,  1901   ,'200'     ,'100000' ,200  ,100000    UNION ALL
SELECT  659   ,  1901   ,'2.5'     ,'1250'   ,2.5  ,1250      UNION ALL
SELECT  660   ,  1901   ,'500'     ,'100000' ,500  ,100000    UNION ALL
SELECT  661   ,  1901   ,'2'       ,'1000'   ,2    ,1000      

UPDATE t
SET MinLabel = REVERSE(STUFF (REVERSE(t.MinLabel),4,0,','))
FROM #Dep_StakeLevel_Temp t
WHERE MinStake > 999

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #Dep_StakeLevel_Temp t
WHERE MaxStake > 999

MERGE Dep_StakeLevelGroupDetail as g 
USING #Dep_StakeLevel_Temp s on g.StakeLevelID = s.StakeLevelID AND g.GameTypeID = s.GameTypeID
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
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
