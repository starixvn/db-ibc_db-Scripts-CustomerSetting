/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210617
	Task:  Add 7 new game [PG Game]  - Deposit - UUS RedmineID:#156676
	DB: DBCust/CustDB
*/
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(16))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--UUS
SELECT 6071 ,'2'    ,'2000'    ,2    ,2000    ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 6072 ,'2'    ,'200'     ,2    ,200     ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 6073 ,'2'    ,'2000'    ,2    ,2000    ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 6074 ,'2'    ,'2000'    ,2    ,2000    ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 6075 ,'2'    ,'200'     ,2    ,200     ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 6076 ,'2'    ,'200'     ,2    ,200     ,20   UNION ALL	--UUS	--UUS,YNG
SELECT 6077 ,'2'    ,'200'     ,2    ,200     ,20   UNION ALL	--UUS	--UUS,YNG
--YNG
SELECT 6071 ,'2'    ,'2000'    ,2    ,2000    ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 6072 ,'2'    ,'200'     ,2    ,200     ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 6073 ,'2'    ,'2000'    ,2    ,2000    ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 6074 ,'2'    ,'2000'    ,2    ,2000    ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 6075 ,'2'    ,'200'     ,2    ,200     ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 6076 ,'2'    ,'200'     ,2    ,200     ,72   UNION ALL	--YNG	--UUS,YNG
SELECT 6077 ,'2'    ,'200'     ,2    ,200     ,72				--YNG	--UUS,YNG

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
WHERE s.GameTypeID = 6001)

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