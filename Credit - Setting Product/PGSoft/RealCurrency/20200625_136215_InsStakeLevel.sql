/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200805
	Task:  Insert Setting StakeLevel [PG Game] RedmineID:#137763
	DB: DBCust/CustDB
*/
CREATE TABLE #StakeLevel_Temp ( GameTypeID INT,
								ExchangeId int,
								GameGroupID int default(15))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,ExchangeId)
SELECT 6001,47   UNION ALL     -- DDD
SELECT 6001,33   UNION ALL     -- IDD
SELECT 6001,34   UNION ALL     -- IDR
SELECT 6001,15   UNION ALL     -- IN
SELECT 6001,22   UNION ALL     -- IND
SELECT 6001,45   UNION ALL     -- Won
SELECT 6001,4    UNION ALL     -- TB
SELECT 6001,43   UNION ALL     -- THB
SELECT 6001,3    UNION ALL     -- US$
SELECT 6001,95   UNION ALL     -- USD
SELECT 6001,64   UNION ALL     -- UT
SELECT 6001,6   UNION ALL      -- EURO
SELECT 6001,35   UNION ALL     -- $US
SELECT 6001,16			       -- Yen

INSERT INTO StakeLevel(GameTypeID,ExchangeId,GameGroupID)
SELECT GameTypeID,ExchangeId,GameGroupID 
FROM #StakeLevel_Temp

DROP TABLE #StakeLevel_Temp