/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210324
	Task:  Insert Setting StakeLevel  - UUS [Creative Gaming] RedmineID:#146016
	DB: DBCust/CustDB
	P/s : Step 1 Insert StakeLevel UUS
*/
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #StakeLevel_Temp ( GameTypeID INT,
								ExchangeId int, 
								GameGroupID int default(23))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,ExchangeId)
SELECT 7301,20   UNION ALL     -- UUS
SELECT 7301,72			       -- YNG

INSERT INTO StakeLevel(GameTypeID,ExchangeId,GameGroupID)
SELECT GameTypeID,ExchangeId,GameGroupID 
FROM #StakeLevel_Temp

DROP TABLE #StakeLevel_Temp
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 