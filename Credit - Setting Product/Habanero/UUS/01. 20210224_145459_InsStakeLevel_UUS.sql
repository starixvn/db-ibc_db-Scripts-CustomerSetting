/*
	Created: 20210224@Tina
	Task: Insert StakeLevel for Habanero - Credit - Test Currency
	Redmine: https://nexdev.net/issues/145459
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO

PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
CREATE TABLE #StakeLevel_Temp ( GameTypeID INT,
								ExchangeId int, 
								GameGroupID int default(17))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,ExchangeId)
SELECT 7001,20   -- UUS
UNION ALL
SELECT 7001,72   -- YNG

DELETE a
FROM #StakeLevel_Temp a
INNER JOIN StakeLevel b WITH(NOLOCK) on a.GameTypeID = b.GameTypeID AND a.ExchangeId = b.ExchangeID
					AND a.GameGroupID = b.GameGroupID 
WHERE b.GameTypeID = 7001

INSERT INTO StakeLevel(GameTypeID,ExchangeId,GameGroupID)
SELECT GameTypeID,ExchangeId,GameGroupID 
FROM #StakeLevel_Temp

DROP TABLE #StakeLevel_Temp
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 