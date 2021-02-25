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
SELECT 7001, 13   UNION ALL --CNY(RMB)
SELECT 7001, 6    UNION ALL --EUR(EURO)
SELECT 7001, 12   UNION ALL --GBP(GBP)
SELECT 7001, 5    UNION ALL --HKD(HK$)
SELECT 7001, 67   UNION ALL --HKD(HKK)
SELECT 7001, 15   UNION ALL --IDR(IN)
SELECT 7001, 22   UNION ALL --IDR(IND)
SELECT 7001, 33   UNION ALL --IDR(IDD)
SELECT 7001, 34   UNION ALL --IDR(IDR)
SELECT 7001, 47   UNION ALL --IDR(DDD)
SELECT 7001, 45   UNION ALL --KRW(Won)
SELECT 7001, 69   UNION ALL --MMK(MMK)
SELECT 7001, 2    UNION ALL --MYR(RM)
SELECT 7001, 43   UNION ALL --THB(THB)
SELECT 7001, 35   UNION ALL --USD($US)
SELECT 7001, 3    UNION ALL --USD(US$)
SELECT 7001, 16   UNION ALL --USD(Yen)
SELECT 7001, 95   UNION ALL --USD(USD)
SELECT 7001, 64   UNION ALL --USD(UT)
SELECT 7001, 7    UNION ALL --VND(DON)
SELECT 7001, 51				--VND(INH)

DELETE a
FROM #StakeLevel_Temp a
INNER JOIN StakeLevel  b WITH(NOLOCK) on a.GameTypeID = b.GameTypeID AND a.ExchangeId = b.ExchangeID
					AND a.GameGroupID = b.GameGroupID 
WHERE b.GameTypeID = 7001

INSERT INTO StakeLevel(GameTypeID,ExchangeId,GameGroupID)
SELECT GameTypeID,ExchangeId,GameGroupID 
FROM #StakeLevel_Temp

DROP TABLE #StakeLevel_Temp
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 