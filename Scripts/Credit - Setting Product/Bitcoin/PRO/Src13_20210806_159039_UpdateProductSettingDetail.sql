/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Winfred
	Date: 20210806
	Task: Update Product Profile of Bitcoin [Redmine: 159039]
	DB: DBCUST/CustDB
	
	P/s : Step 13 Update Product Profile
*/ 

	USE CustDB
	GO

	PRINT N'Step 13: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

	UPDATE S
	SET S.SettingStatus = 0
	FROM ProductSettingDetail S WITH(ROWLOCK) 
	WHERE Sporttype = 175
	
	PRINT N'Step 13: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
