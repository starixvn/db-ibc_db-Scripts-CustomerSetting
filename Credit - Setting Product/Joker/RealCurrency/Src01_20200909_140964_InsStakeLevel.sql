/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200909
	Task:  Insert Setting StakeLevel [Joker] - Credit RedmineID:#140964
	DB: DBCust/CustDB
*/
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #StakeLevel_Temp ( GameTypeID INT,
								ExchangeId int,
								GameGroupID int default(17))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,ExchangeId)
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
FROM #StakeLevel_Temp a
INNER JOIN StakeLevel  b WITH(NOLOCK) on a.GameTypeID = b.GameTypeID AND a.ExchangeId = b.ExchangeID
					AND a.GameGroupID = b.GameGroupID 
WHERE b.GameTypeID = 6401

INSERT INTO StakeLevel(GameTypeID,ExchangeId,GameGroupID)
SELECT GameTypeID,ExchangeId,GameGroupID 
FROM #StakeLevel_Temp

DROP TABLE #StakeLevel_Temp
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 