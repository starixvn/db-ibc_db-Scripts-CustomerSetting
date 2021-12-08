/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20211110
	Task: PG Soft - Add 9 new games - UUS - Credit RedmineID:#163595
	DB: DBCust/CustDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(15))
								
--#region Insert to temp table
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--UUS
SELECT 6078 ,'2'    ,'200'     ,2    ,200     ,20   UNION ALL --(UUS)
SELECT 6079 ,'2.5'  ,'1000'    ,2.5  ,1000    ,20   UNION ALL --(UUS)
SELECT 6080 ,'2'    ,'200'     ,2    ,200     ,20   UNION ALL --(UUS)
SELECT 6081 ,'2'    ,'200'     ,2    ,200     ,20   UNION ALL --(UUS)
SELECT 6082 ,'2'    ,'2000'    ,2    ,2000    ,20   UNION ALL --(UUS)
SELECT 6083 ,'2'    ,'200'     ,2    ,200     ,20   UNION ALL --(UUS)
SELECT 6084 ,'2'    ,'1000'    ,2    ,1000    ,20   UNION ALL --(UUS)
SELECT 6085 ,'2'    ,'2000'    ,2    ,2000    ,20   UNION ALL --(UUS)
SELECT 6086 ,'2'    ,'200'     ,2    ,200     ,20   UNION ALL --(UUS)
--YNG
SELECT 6078 ,'2'    ,'200'     ,2    ,200     ,72   UNION ALL --YNG(YNG)
SELECT 6079 ,'2.5'  ,'1000'    ,2.5  ,1000    ,72   UNION ALL --YNG(YNG)
SELECT 6080 ,'2'    ,'200'     ,2    ,200     ,72   UNION ALL --YNG(YNG)
SELECT 6081 ,'2'    ,'200'     ,2    ,200     ,72   UNION ALL --YNG(YNG)
SELECT 6082 ,'2'    ,'2000'    ,2    ,2000    ,72   UNION ALL --YNG(YNG)
SELECT 6083 ,'2'    ,'200'     ,2    ,200     ,72   UNION ALL --YNG(YNG)
SELECT 6084 ,'2'    ,'1000'    ,2    ,1000    ,72   UNION ALL --YNG(YNG)
SELECT 6085 ,'2'    ,'2000'    ,2    ,2000    ,72   UNION ALL --YNG(YNG)
SELECT 6086 ,'2'    ,'200'     ,2    ,200     ,72			  --YNG(YNG)

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999

;WITH STAKE_TEMP AS 
(
	SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
	FROM StakeLevel s WITH(NOLOCK)
	CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
				  FROM #StakeLevel_Temp t 
				  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
	WHERE s.GameTypeID = 6001
)

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


