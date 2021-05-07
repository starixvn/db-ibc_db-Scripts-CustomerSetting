/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210506
	Task:  Insert Setting StakeLevel for AdvantPlay RedmineID:#154258
	DB: DBCust/CustDB
	P/s : Step 2 Insert Setting StakeLevel AdvantPlay
*/
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #StakeLevel_Temp ( GameTypeID INT,
								ExchangeId int, 
								GameGroupID int default(27))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,ExchangeId)
SELECT 7701,2    UNION ALL     -- RM
SELECT 7701,3    UNION ALL     -- US$
SELECT 7701,7    UNION ALL     -- DON
SELECT 7701,13   UNION ALL     -- RMB
SELECT 7701,15   UNION ALL     -- IN
SELECT 7701,16   UNION ALL     -- Yen
SELECT 7701,22   UNION ALL     -- IND
SELECT 7701,33   UNION ALL     -- IDD
SELECT 7701,34   UNION ALL     -- IDR
SELECT 7701,35   UNION ALL     -- $US
SELECT 7701,43   UNION ALL     -- THB
SELECT 7701,45   UNION ALL     -- Won
SELECT 7701,47   UNION ALL     -- DDD
SELECT 7701,51   UNION ALL     -- INH
SELECT 7701,64   UNION ALL     -- UT
SELECT 7701,67   UNION ALL     -- HKK
SELECT 7701,95			       -- USD

INSERT INTO StakeLevel(GameTypeID,ExchangeId,GameGroupID)
SELECT GameTypeID,ExchangeId,GameGroupID 
FROM #StakeLevel_Temp

DROP TABLE #StakeLevel_Temp
PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 