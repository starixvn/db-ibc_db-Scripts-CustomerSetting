/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210506
	Task:  Insert Setting StakeLevel  - UUS for AdvantPlay RedmineID:#154258
	DB: DBCust/CustDB
	P/s : Step 1 Insert StakeLevel UUS
*/
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #StakeLevel_Temp ( GameTypeID INT,
								ExchangeId int, 
								GameGroupID int default(27))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,ExchangeId)
SELECT 7701,20   UNION ALL     -- UUS
SELECT 7701,72			       -- YNG

INSERT INTO StakeLevel(GameTypeID,ExchangeId,GameGroupID)
SELECT GameTypeID,ExchangeId,GameGroupID 
FROM #StakeLevel_Temp

DROP TABLE #StakeLevel_Temp
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 