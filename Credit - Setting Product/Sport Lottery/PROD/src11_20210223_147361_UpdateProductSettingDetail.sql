/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Winfred
	Date: 20210223
	Task: Update Product Profile of Sports Lottery [Redmine: 147361]
	DB: DBCUST/CustDB
	
	P/s : Step 10 Update Product Profile
*/ 

	USE CustDB
	GO

	PRINT N'Step 10: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

	UPDATE S
	SET S.SettingStatus = 0
	FROM ProductSettingDetail S WITH(ROWLOCK) 
	WHERE Sporttype = 169
	
	PRINT N'Step 10: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
