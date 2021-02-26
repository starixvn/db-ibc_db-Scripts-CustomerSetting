/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Winfred
	Date: 20210223
	Task: Update Product Profile of Sports Lottery [Redmine: 147361]
	DB: DBCUST/CustDB
	
	P/s : Step 9 Update Product Profile
*/ 

	USE CustDB
	GO

	PRINT N'Step 9: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

	UPDATE S
	SET S.SettingStatus = 0
	FROM ProductSettingDetail S WITH(ROWLOCK) 
	WHERE Sporttype = 169
	
	PRINT N'Step 9: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
