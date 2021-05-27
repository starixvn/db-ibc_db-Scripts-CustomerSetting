/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210514
	Task: Update isActive Sport_Bettype_Reference_Setting  for AdvantPlay Mini RedmineID:#155133
	DB: DBTXN/bodb02
	P/s : Step  Update isActive Sport_Bettype_Reference_Setting AdvantPlay
*/ 

	USE [bodb02]
	GO
	
	PRINT N'Step 8: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
	DECLARE @SportType SMALLINT
	SELECT @SportType = 174

	UPDATE ps
	SET ps.isActive = 1
	FROM dbo.Sport_Bettype_Reference_Setting ps WITH (ROWLOCK,UPDLOCK)
	WHERE SportType = @SportType
	
	PRINT N'Step 8: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
