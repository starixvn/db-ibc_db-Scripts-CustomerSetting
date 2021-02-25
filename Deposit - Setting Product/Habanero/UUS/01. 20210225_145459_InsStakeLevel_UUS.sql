/*
	Created: 20210224@Tina
	Task: Insert Setting StakeLevel for Habanero - CREDIT
	Redmine: https://nexdev.net/issues/145459
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO

PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevel_Temp ( GameTypeID INT,
								ExchangeId int,
								GameGroupID int default(22))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,ExchangeId)
SELECT 7001,20  -- UUS
UNION ALL
SELECT 7001,72  -- YNG

DELETE a
FROM #Dep_StakeLevel_Temp a
INNER JOIN Dep_StakeLevel  b WITH(NOLOCK) on a.GameTypeID = b.GameTypeID AND a.ExchangeId = b.ExchangeID
					AND a.GameGroupID = b.GameGroupID 
WHERE b.GameTypeID = 7001

DECLARE @MaxStakeLevelID INT
SELECT @MaxStakeLevelID = MAX(StakeLevelID) FROM DEP_StakeLevel WITH(NOLOCK)

INSERT INTO Dep_StakeLevel(GameTypeID,ExchangeId,GameGroupID,StakeLevelID)
SELECT a.GameTypeID,a.ExchangeId,a.GameGroupID,StakeLevelID = @MaxStakeLevelID + ROW_NUMBER() OVER(ORDER BY exchangeid) 
FROM #Dep_StakeLevel_Temp a

DROP TABLE #Dep_StakeLevel_Temp

PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 