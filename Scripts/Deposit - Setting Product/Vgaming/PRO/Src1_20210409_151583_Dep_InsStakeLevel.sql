/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210409
	Task:  Insert Setting StakeLevel [Vgaming] - deposit RedmineID:#151583
	DB: DBCust/CustDB
	P/s : Step 1 Insert Setting StakeLevel
*/
CREATE TABLE #Dep_StakeLevel_Temp ( GameTypeID INT,
								ExchangeId int,
								GameGroupID int default(26))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,ExchangeId)
SELECT 3801,2    UNION ALL     -- RM
SELECT 3801,3    UNION ALL     -- US$
SELECT 3801,4    UNION ALL     -- TB
SELECT 3801,5    UNION ALL     -- HK$
SELECT 3801,6    UNION ALL     -- EURO
SELECT 3801,9    UNION ALL     -- AUD
SELECT 3801,12   UNION ALL     -- GBP
SELECT 3801,13   UNION ALL     -- RMB
SELECT 3801,15   UNION ALL     -- IN
SELECT 3801,32   UNION ALL     -- JPY
SELECT 3801,41   UNION ALL     -- CHF
SELECT 3801,45   UNION ALL     -- Won
SELECT 3801,46   UNION ALL     -- BND
SELECT 3801,49   UNION ALL     -- MXN
SELECT 3801,50   UNION ALL     -- CAN
SELECT 3801,52   UNION ALL     -- DKK
SELECT 3801,53   UNION ALL     -- SEK
SELECT 3801,54   UNION ALL     -- NOK
SELECT 3801,55   UNION ALL     -- RUB
SELECT 3801,56   UNION ALL     -- PLN
SELECT 3801,57   UNION ALL     -- CZK
SELECT 3801,58   UNION ALL     -- RON
SELECT 3801,61   UNION ALL     -- INR
SELECT 3801,66   UNION ALL     -- YUN
SELECT 3801,70   UNION ALL     -- MKK
SELECT 3801,71   UNION ALL     -- KHR
SELECT 3801,73   UNION ALL     -- LIR
SELECT 3801,79   UNION ALL     -- KES
SELECT 3801,80   UNION ALL     -- GHS
SELECT 3801,82   UNION ALL     -- BRL
SELECT 3801,83   UNION ALL     -- CLP
SELECT 3801,85   UNION ALL     -- PEN
SELECT 3801,86   UNION ALL     -- ARS
SELECT 3801,92   UNION ALL     -- HID
SELECT 3801,93   UNION ALL     -- LAK
SELECT 3801,94   UNION ALL     -- MK
SELECT 3801,96   UNION ALL     -- USDT
SELECT 3801,97   UNION ALL     -- BDT
SELECT 3801,121			       -- PKR

DELETE a
FROM #Dep_StakeLevel_Temp a
INNER JOIN Dep_StakeLevel  b WITH(NOLOCK) on a.GameTypeID = b.GameTypeID AND a.ExchangeId = b.ExchangeID
					AND a.GameGroupID = b.GameGroupID 
WHERE b.GameTypeID = 3801

DECLARE @MaxStakeLevelID INT
SELECT @MaxStakeLevelID = MAX(StakeLevelID) FROM DEP_StakeLevel WITH(NOLOCK)

INSERT INTO Dep_StakeLevel(GameTypeID,ExchangeId,GameGroupID,StakeLevelID)
SELECT a.GameTypeID,a.ExchangeId,a.GameGroupID,StakeLevelID = @MaxStakeLevelID + ROW_NUMBER() OVER(ORDER BY exchangeid) 
FROM #Dep_StakeLevel_Temp a

DROP TABLE #Dep_StakeLevel_Temp