/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: Winfred
	Date: 20210223
	Task: Update Sport_Bettype_Reference_Setting of Sports Lottery [Redmine: 147361]
	DB: DBTXN/bodb02
	
	P/s : Step 9 Update Sport_Bettype_Reference_Setting table
*/ 

	USE bodb02
	GO

	PRINT N'Step 9: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

	UPDATE ps
	SET ps.isActive = 1
	FROM dbo.Sport_Bettype_Reference_Setting ps WITH (ROWLOCK,UPDLOCK)
	WHERE SportType = 169
	
	PRINT N'Step 9: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
