/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: Winfred
	Date: 20210806
	Task: Update Sport_Bettype_Reference_Setting of Bitcoin [Redmine: 159039]
	DB: DBTXN/bodb02
	
	P/s : Step 11 Update Sport_Bettype_Reference_Setting table
*/ 

	USE bodb02
	GO

	PRINT N'Step 11: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

	UPDATE ps
	SET ps.isActive = 1
	FROM dbo.Sport_Bettype_Reference_Setting ps WITH (ROWLOCK,UPDLOCK)
	WHERE SportType = 175
	
	PRINT N'Step 11: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
