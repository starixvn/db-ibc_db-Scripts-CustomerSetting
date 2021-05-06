/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210324
	Task:  Insert Setting StakeLevel [Creative Gaming] RedmineID:#146016
	DB: DBCust/CustDB
	P/s : Step 2 Insert Setting StakeLevel Creative Gaming
*/
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #StakeLevel_Temp ( GameTypeID INT,
								ExchangeId int, 
								GameGroupID int default(23))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,ExchangeId)
SELECT 7301,2    UNION ALL     -- RM
SELECT 7301,3    UNION ALL     -- US$
SELECT 7301,5    UNION ALL     -- HK$
SELECT 7301,6    UNION ALL     -- EURO
SELECT 7301,7    UNION ALL     -- DON
SELECT 7301,12   UNION ALL     -- GBP
SELECT 7301,13   UNION ALL     -- RMB
SELECT 7301,15   UNION ALL     -- IN
SELECT 7301,16   UNION ALL     -- Yen
SELECT 7301,22   UNION ALL     -- IND
SELECT 7301,33   UNION ALL     -- IDD
SELECT 7301,34   UNION ALL     -- IDR
SELECT 7301,35   UNION ALL     -- $US
SELECT 7301,43   UNION ALL     -- THB
SELECT 7301,45   UNION ALL     -- Won
SELECT 7301,47   UNION ALL     -- DDD
SELECT 7301,51   UNION ALL     -- INH
SELECT 7301,64   UNION ALL     -- UT
SELECT 7301,67   UNION ALL     -- HKK
SELECT 7301,69   UNION ALL     -- MMK
SELECT 7301,95			       -- USD

INSERT INTO StakeLevel(GameTypeID,ExchangeId,GameGroupID)
SELECT GameTypeID,ExchangeId,GameGroupID 
FROM #StakeLevel_Temp

DROP TABLE #StakeLevel_Temp
PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 