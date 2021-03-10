/*
	Created: Tina
	Date: 20210310
	Task: Update Sport_Bettype_Reference_Setting of PP Live Casino [Redmine: 134041]
	DB: DBTXN/bodb02
*/ 

	USE [bodb02]
	GO

	PRINT N'Step 9: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

	UPDATE ps
	SET ps.isActive = 1
	FROM dbo.Sport_Bettype_Reference_Setting ps WITH (ROWLOCK,UPDLOCK)
	WHERE SportType = 170
	
	PRINT N'Step 9: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
