/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200909
	Task:  Insert Setting StakeLevel [Joker] - deposit RedmineID:#131603
	DB: DBCust/CustDB
*/
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevel_Temp ( GameTypeID INT,
								ExchangeId int,
								GameGroupID int default(18))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,ExchangeId)
SELECT 6401,35   UNION ALL     -- $US
SELECT 6401,3    UNION ALL     -- US$
SELECT 6401,95   UNION ALL     -- USD
SELECT 6401,64   UNION ALL     -- UT
SELECT 6401,16   UNION ALL     -- Yen
SELECT 6401,4    UNION ALL     -- TB
SELECT 6401,43   UNION ALL     -- THB
SELECT 6401,2    UNION ALL     -- RM
SELECT 6401,69   UNION ALL     -- MMK
SELECT 6401,47   UNION ALL     -- DDD
SELECT 6401,33   UNION ALL     -- IDD
SELECT 6401,34   UNION ALL     -- IDR
SELECT 6401,15   UNION ALL     -- IN
SELECT 6401,22   UNION ALL     -- IND
SELECT 6401,20   UNION ALL     -- UUS
SELECT 6401,5    UNION ALL     -- HK$
SELECT 6401,67   UNION ALL     -- HKK
SELECT 6401,13   UNION ALL     -- RMB
SELECT 6401,66				   -- YUN


DELETE a
FROM #Dep_StakeLevel_Temp a
INNER JOIN Dep_StakeLevel  b WITH(NOLOCK) on a.GameTypeID = b.GameTypeID AND a.ExchangeId = b.ExchangeID
					AND a.GameGroupID = b.GameGroupID 
WHERE b.GameTypeID = 6401

DECLARE @MaxStakeLevelID INT
SELECT @MaxStakeLevelID = MAX(StakeLevelID) FROM DEP_StakeLevel WITH(NOLOCK)

INSERT INTO Dep_StakeLevel(GameTypeID,ExchangeId,GameGroupID,StakeLevelID)
SELECT a.GameTypeID,a.ExchangeId,a.GameGroupID,StakeLevelID = @MaxStakeLevelID + ROW_NUMBER() OVER(ORDER BY exchangeid) 
FROM #Dep_StakeLevel_Temp a

DROP TABLE #Dep_StakeLevel_Temp
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 