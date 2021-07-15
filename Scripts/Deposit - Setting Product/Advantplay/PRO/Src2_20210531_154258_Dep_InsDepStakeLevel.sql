/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created:Winfred
	Date:	20210531
	Task:	Insert Setting StakeLevel [AdvantPlay] - deposit RedmineID:#154258
	DB:		DBCust/CustDB
	P/s : Step 2 Insert Setting StakeLevel AdvantPlay
*/
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevel_Temp ( GameTypeID INT,
								ExchangeId int,
								GameGroupID int default(28))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,ExchangeId)
SELECT 7701,2    UNION ALL     -- RM
SELECT 7701,3    UNION ALL     -- US$
SELECT 7701,4    UNION ALL     -- TB
SELECT 7701,7    UNION ALL     -- DON
SELECT 7701,13   UNION ALL     -- RMB
SELECT 7701,15   UNION ALL     -- IN
SELECT 7701,45   UNION ALL     -- Won
SELECT 7701,51   UNION ALL     -- INH
SELECT 7701,61   UNION ALL     -- INR
SELECT 7701,66   UNION ALL     -- YUN
SELECT 7701,96			       -- USDT

DELETE a
FROM #Dep_StakeLevel_Temp a
INNER JOIN Dep_StakeLevel  b WITH(NOLOCK) on a.GameTypeID = b.GameTypeID AND a.ExchangeId = b.ExchangeID
					AND a.GameGroupID = b.GameGroupID 
WHERE b.GameTypeID = 7701

DECLARE @MaxStakeLevelID INT
SELECT @MaxStakeLevelID = MAX(StakeLevelID) FROM DEP_StakeLevel WITH(NOLOCK)

INSERT INTO Dep_StakeLevel(GameTypeID,ExchangeId,GameGroupID,StakeLevelID)
SELECT a.GameTypeID,a.ExchangeId,a.GameGroupID,StakeLevelID = @MaxStakeLevelID + ROW_NUMBER() OVER(ORDER BY exchangeid) 
FROM #Dep_StakeLevel_Temp a

DROP TABLE #Dep_StakeLevel_Temp

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 