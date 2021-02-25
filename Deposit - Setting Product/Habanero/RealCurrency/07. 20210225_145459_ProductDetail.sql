/*
	Created: 20210224@Tina
	Task: Update Product Setting Detail for Habanero - Deposit - Real Currency
	Redmine: https://nexdev.net/issues/145459
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO

PRINT N'Step 7: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
UPDATE [Dep_ProductSettingDetail] WITH(ROWLOCK,UPDLOCK)
	SET SettingStatus=0
WHERE SportType=238
PRINT N'Step 7: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
