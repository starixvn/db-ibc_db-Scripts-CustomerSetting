/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220524
	Task:  Insert Setting StakeLevel [MaxGame] real currency - deposit RedmineID:#172933
	DB: DBCust/CustDB
	P/s : Step 1 Insert Setting StakeLevel
*/
CREATE TABLE #Dep_StakeLevel_Temp ( GameTypeID INT,
								ExchangeId INT,
								GameGroupID INT DEFAULT(37))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,ExchangeId)
SELECT 5401,2    UNION ALL   -- RM
SELECT 5401,3    UNION ALL   -- US$
SELECT 5401,4    UNION ALL   -- TB
SELECT 5401,12   UNION ALL   -- GBP
SELECT 5401,13   UNION ALL   -- RMB
SELECT 5401,15   UNION ALL   -- IN
SELECT 5401,45   UNION ALL   -- Won
SELECT 5401,46   UNION ALL   -- BND
SELECT 5401,51   UNION ALL   -- INH
SELECT 5401,56   UNION ALL   -- PLN
SELECT 5401,61   UNION ALL   -- INR
SELECT 5401,6    UNION ALL   -- EURO
SELECT 5401,70   UNION ALL   -- MKK
SELECT 5401,94   UNION ALL   -- MK
SELECT 5401,96			     -- USDT

DELETE a
FROM #Dep_StakeLevel_Temp a
INNER JOIN Dep_StakeLevel  b WITH(NOLOCK) on a.GameTypeID = b.GameTypeID AND a.ExchangeId = b.ExchangeID AND a.GameGroupID = b.GameGroupID 
WHERE b.GameTypeID = 5401

DECLARE @MaxStakeLevelID INT
SELECT @MaxStakeLevelID = MAX(StakeLevelID) FROM DEP_StakeLevel WITH(NOLOCK)

INSERT INTO Dep_StakeLevel(GameTypeID,ExchangeId,GameGroupID,StakeLevelID)
SELECT a.GameTypeID,a.ExchangeId,a.GameGroupID,StakeLevelID = @MaxStakeLevelID + ROW_NUMBER() OVER(ORDER BY exchangeid) 
FROM #Dep_StakeLevel_Temp a

DROP TABLE #Dep_StakeLevel_Temp