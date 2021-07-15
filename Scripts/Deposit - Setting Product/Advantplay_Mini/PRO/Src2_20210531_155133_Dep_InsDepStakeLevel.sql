/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created:Winfred
	Date:	20210531
	Task:	Insert Setting StakeLevel [AdvantPlay Mini] - deposit RedmineID:#155133
	DB:		DBCust/CustDB
	P/s : Step 2 Insert Setting StakeLevel AdvantPlay Mini
*/
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevel_Temp ( GameTypeID INT,
								ExchangeId int,
								GameGroupID int default(30))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,ExchangeId)
SELECT 7801,2    UNION ALL     -- RM
SELECT 7801,3    UNION ALL     -- US$
SELECT 7801,4    UNION ALL     -- TB
SELECT 7801,5    UNION ALL     -- HK$
SELECT 7801,6    UNION ALL     -- EURO
SELECT 7801,7    UNION ALL     -- DON
SELECT 7801,12   UNION ALL     -- GBP
SELECT 7801,13   UNION ALL     -- RMB
SELECT 7801,15   UNION ALL     -- IN
SELECT 7801,32   UNION ALL     -- JPY
SELECT 7801,45   UNION ALL     -- Won
SELECT 7801,46   UNION ALL     -- BND
SELECT 7801,49   UNION ALL     -- MXN
SELECT 7801,51   UNION ALL     -- INH
SELECT 7801,55   UNION ALL     -- RUB
SELECT 7801,56   UNION ALL     -- PLN
SELECT 7801,61   UNION ALL     -- INR
SELECT 7801,66   UNION ALL     -- YUN
SELECT 7801,70   UNION ALL     -- MKK
SELECT 7801,71   UNION ALL     -- KHR
SELECT 7801,79   UNION ALL     -- KES
SELECT 7801,80   UNION ALL     -- GHS
SELECT 7801,82   UNION ALL     -- BRL
SELECT 7801,83   UNION ALL     -- CLP
SELECT 7801,85   UNION ALL     -- PEN
SELECT 7801,86   UNION ALL     -- ARS
SELECT 7801,92   UNION ALL     -- HID
SELECT 7801,93   UNION ALL     -- LAK
SELECT 7801,94   UNION ALL     -- MK
SELECT 7801,96   UNION ALL     -- USDT
SELECT 7801,97			       -- BDT

DELETE a
FROM #Dep_StakeLevel_Temp a
INNER JOIN Dep_StakeLevel  b WITH(NOLOCK) on a.GameTypeID = b.GameTypeID AND a.ExchangeId = b.ExchangeID
					AND a.GameGroupID = b.GameGroupID 
WHERE b.GameTypeID = 7801

DECLARE @MaxStakeLevelID INT
SELECT @MaxStakeLevelID = MAX(StakeLevelID) FROM DEP_StakeLevel WITH(NOLOCK)

INSERT INTO Dep_StakeLevel(GameTypeID,ExchangeId,GameGroupID,StakeLevelID)
SELECT a.GameTypeID,a.ExchangeId,a.GameGroupID,StakeLevelID = @MaxStakeLevelID + ROW_NUMBER() OVER(ORDER BY exchangeid) 
FROM #Dep_StakeLevel_Temp a

DROP TABLE #Dep_StakeLevel_Temp

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 