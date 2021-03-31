/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created:Winfred
	Date:	20210324
	Task:	Insert Setting StakeLevel [Creative Gaming] - deposit RedmineID:#146016
	DB:		DBCust/CustDB
	P/s : Step 2 Insert Setting StakeLevel
*/
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevel_Temp ( GameTypeID INT,
								ExchangeId int,
								GameGroupID int default(24))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,ExchangeId)
SELECT 7301,2    UNION ALL     -- RM
SELECT 7301,3    UNION ALL     -- US$
SELECT 7301,4    UNION ALL     -- TB
SELECT 7301,5    UNION ALL     -- HK$
SELECT 7301,6    UNION ALL     -- EURO
SELECT 7301,7    UNION ALL     -- DON
SELECT 7301,12   UNION ALL     -- GBP
SELECT 7301,13   UNION ALL     -- RMB
SELECT 7301,15   UNION ALL     -- IN
SELECT 7301,45   UNION ALL     -- Won
SELECT 7301,51   UNION ALL     -- INH
SELECT 7301,66   UNION ALL     -- YUN
SELECT 7301,70   UNION ALL     -- MKK
SELECT 7301,92   UNION ALL     -- HID
SELECT 7301,94   UNION ALL     -- MK
SELECT 7301,96			     -- USDT

DELETE a
FROM #Dep_StakeLevel_Temp a
INNER JOIN Dep_StakeLevel  b WITH(NOLOCK) on a.GameTypeID = b.GameTypeID AND a.ExchangeId = b.ExchangeID
					AND a.GameGroupID = b.GameGroupID 
WHERE b.GameTypeID = 7301

DECLARE @MaxStakeLevelID INT
SELECT @MaxStakeLevelID = MAX(StakeLevelID) FROM DEP_StakeLevel WITH(NOLOCK)

INSERT INTO Dep_StakeLevel(GameTypeID,ExchangeId,GameGroupID,StakeLevelID)
SELECT a.GameTypeID,a.ExchangeId,a.GameGroupID,StakeLevelID = @MaxStakeLevelID + ROW_NUMBER() OVER(ORDER BY exchangeid) 
FROM #Dep_StakeLevel_Temp a

DROP TABLE #Dep_StakeLevel_Temp

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 