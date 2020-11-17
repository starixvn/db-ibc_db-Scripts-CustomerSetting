/*
	Created: Winfred
	Date: 20201116
	Task: Update SettingStatus = 0 (PROD) for Leap Gaming Virtual Sports [Redmine: 131370]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO
PRINT N'Step 8: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

UPDATE S
SET S.SettingStatus = 0
FROM ProductSettingDetail S WITH(ROWLOCK) 
WHERE Sporttype = 231

PRINT N'Step 8: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
