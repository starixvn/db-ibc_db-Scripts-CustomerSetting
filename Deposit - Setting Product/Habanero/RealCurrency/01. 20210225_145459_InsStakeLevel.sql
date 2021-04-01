/*
	Created: 20210224@Tina
	Task: Insert Setting StakeLevel - DEPOSIT
	Redmine: https://nexdev.net/issues/145459
	DB: DBCUST/CustDB
*/

USE CustDB
GO

PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevel_Temp ( GameTypeID INT,
								ExchangeId int,
								GameGroupID int default(22))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,ExchangeId)
SELECT 7001, 13   UNION ALL --CNY(RMB)
SELECT 7001, 66   UNION ALL --CNY(YUN)
SELECT 7001, 6   UNION ALL --EUR(EURO)
SELECT 7001, 12   UNION ALL --GBP(GBP)
SELECT 7001, 92   UNION ALL --HKD(HID)
SELECT 7001, 5   UNION ALL --HKD(HK$)
SELECT 7001, 15   UNION ALL --IDR(IN)
SELECT 7001, 61   UNION ALL --INR(INR)
SELECT 7001, 32   UNION ALL --JPY(JPY)
SELECT 7001, 45   UNION ALL --KRW(Won)
SELECT 7001, 94   UNION ALL --MMK(MK)
SELECT 7001, 70   UNION ALL --MMK(MKK)
SELECT 7001, 2   UNION ALL --MYR(RM)
SELECT 7001, 55   UNION ALL --RUB(RUB)
SELECT 7001, 4   UNION ALL --THB(TB)
SELECT 7001, 3   UNION ALL --USD(US$)
SELECT 7001, 96   UNION ALL --USD(USDT)
SELECT 7001, 7   UNION ALL --VND(DON)
SELECT 7001, 51			   --VND(INH)


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

/*
SELECT *
FROM Dep_StakeLevel SL WITH (NOLOCK)
WHERE SL.GameTypeID = 7001 AND ExchangeID NOT IN (20,72)
*/