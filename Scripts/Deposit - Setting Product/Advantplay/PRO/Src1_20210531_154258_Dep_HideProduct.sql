/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 20210531
	Task:	 Update SettingStatus = 2 (PROD) for AdvantPlay [Redmine: 154258]
	DB:		 DBCUST/CustDB
	P/s : Step 1 hide AdvantPlay
*/ 

PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
USE [CustDB]
GO

UPDATE [Dep_ProductSettingDetail] WITH(ROWLOCK,UPDLOCK)
	SET SettingStatus=2
WHERE SportType=172

--SELECT * FROM Dep_ProductSettingDetail S WITH (NOLOCK) where SportType = 172
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 