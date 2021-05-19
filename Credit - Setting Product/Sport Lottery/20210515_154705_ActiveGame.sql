/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: Winfred
	Date: 20210515
	Task: Update Sport_Bettype_Reference_Setting of Sports Lottery (LOL Champions) [Redmine: 154705]
	DB: DBTXN/bodb02
	
	P/s : Step 1 Update Sport_Bettype_Reference_Setting table
*/ 

	USE bodb02
	GO

	PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

	UPDATE ps
	SET ps.isActive = 1
	FROM dbo.Sport_Bettype_Reference_Setting ps WITH (ROWLOCK,UPDLOCK)
	WHERE SportType = 169 AND Bettype  = 3613
	
	PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
