/*
	Created: 20200611@Max
	Task: https://nexdev.net/issues/130032
	DB: DBSPARE.bodb02
*/
USE bodb02
GO
IF @@SERVERNAME NOT IN ('DBSPARE')
	RETURN
	
EXEC dbo.DBA_ArchiveAccount1_CloseAgentLine_GenScript


