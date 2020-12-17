/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20201116
	Task: SET UAT Product [Leap Gaming Virtual Sports] RedmineID:#131370
	DB: DBCust/CustDB
*/

USE CustDB
GO

PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

UPDATE S
SET S.SettingStatus = 1
FROM ProductSettingDetail S WITH(ROWLOCK) 
WHERE Sporttype = 231

PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 