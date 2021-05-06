/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 20210324
	Task:	 Update SettingStatus = 2 (PROD) for Creative Gaming [Redmine: 146016]
	DB:		 DBCUST/CustDB
	P/s : Step 1 hide Creative Gaming
*/ 

PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
USE [CustDB]
GO

UPDATE [Dep_ProductSettingDetail] WITH(ROWLOCK,UPDLOCK)
	SET SettingStatus=2
WHERE SportType=167

--SELECT * FROM Dep_ProductSettingDetail S WITH (NOLOCK) where SportType = 167
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 