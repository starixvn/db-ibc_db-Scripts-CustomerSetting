/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210514
	Task:  Insert Setting StakeLevel  - UUS for AdvantPlay Mini RedmineID:#155133
	DB: DBCust/CustDB
	P/s : Step 1 Insert StakeLevel UUS
*/
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #StakeLevel_Temp ( GameTypeID INT,
								ExchangeId int, 
								GameGroupID int default(29))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,ExchangeId)
SELECT 7801,20   UNION ALL     -- UUS
SELECT 7801,72			       -- YNG

INSERT INTO StakeLevel(GameTypeID,ExchangeId,GameGroupID)
SELECT GameTypeID,ExchangeId,GameGroupID 
FROM #StakeLevel_Temp

DROP TABLE #StakeLevel_Temp
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 