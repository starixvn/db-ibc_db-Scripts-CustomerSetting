/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210514
	Task:  Insert Setting StakeLevel for AdvantPlay Mini RedmineID:#155133
	DB: DBCust/CustDB
	P/s : Step 2 Insert Setting StakeLevel AdvantPlay
*/
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #StakeLevel_Temp ( GameTypeID INT,
								ExchangeId int, 
								GameGroupID int default(29))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,ExchangeId)
SELECT 7801,2    UNION ALL     -- RM
SELECT 7801,3    UNION ALL     -- US$
SELECT 7801,5    UNION ALL     -- HK$
SELECT 7801,6    UNION ALL     -- EURO
SELECT 7801,7    UNION ALL     -- DON
SELECT 7801,12   UNION ALL     -- GBP
SELECT 7801,13   UNION ALL     -- RMB
SELECT 7801,15   UNION ALL     -- IN
SELECT 7801,16   UNION ALL     -- Yen
SELECT 7801,22   UNION ALL     -- IND
SELECT 7801,33   UNION ALL     -- IDD
SELECT 7801,34   UNION ALL     -- IDR
SELECT 7801,35   UNION ALL     -- $US
SELECT 7801,43   UNION ALL     -- THB
SELECT 7801,45   UNION ALL     -- Won
SELECT 7801,47   UNION ALL     -- DDD
SELECT 7801,51   UNION ALL     -- INH
SELECT 7801,64   UNION ALL     -- UT
SELECT 7801,67   UNION ALL     -- HKK
SELECT 7801,69   UNION ALL     -- MMK
SELECT 7801,95			       -- USD

INSERT INTO StakeLevel(GameTypeID,ExchangeId,GameGroupID)
SELECT GameTypeID,ExchangeId,GameGroupID 
FROM #StakeLevel_Temp

DROP TABLE #StakeLevel_Temp
PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 