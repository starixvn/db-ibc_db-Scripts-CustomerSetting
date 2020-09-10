/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200909
	Task:  Insert Setting StakeLevel [Joker] - UUS Credit RedmineID:#131603
	DB: DBCust/CustDB
*/
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
CREATE TABLE #StakeLevel_Temp ( GameTypeID INT,
								ExchangeId int, 
								GameGroupID int default(17))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,ExchangeId)
SELECT 6401,20   -- UUS

DELETE a
FROM #StakeLevel_Temp a
INNER JOIN StakeLevel b WITH(NOLOCK) on a.GameTypeID = b.GameTypeID AND a.ExchangeId = b.ExchangeID
					AND a.GameGroupID = b.GameGroupID 
WHERE b.GameTypeID = 6401

INSERT INTO StakeLevel(GameTypeID,ExchangeId,GameGroupID)
SELECT GameTypeID,ExchangeId,GameGroupID 
FROM #StakeLevel_Temp

DROP TABLE #StakeLevel_Temp
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 