/*<info serverAlias="DBTP-bodb02"></info>*/
/*
	Created: Eden@20240729
	Task: Add column Isdeleted on DBTP to replicate KL [Redmine: #204358]   
	DB: DBTP-bodb02
*/
USE bodb02
GO

ALTER TABLE BetSetting3rd_Agent ADD [isDeleted] [bit] NULL CONSTRAINT DF_BetSetting3rd_Agent_isDeleted DEFAULT 0
GO
ALTER TABLE BetSetting3rd_Member ADD [isDeleted] [bit] NULL CONSTRAINT DF_BetSetting3rd_Member_isDeleted DEFAULT 0
GO


WHILE 1 = 1
BEGIN
	UPDATE TOP(5000) BetSetting3rd_Agent 
	SET isDeleted = 0
	WHERE isDeleted IS NULL

	IF @@ROWCOUNT = 0
	BREAK;
END

WHILE 1 = 1
BEGIN
	UPDATE TOP(5000) BetSetting3rd_Member 
	SET isDeleted = 0
	WHERE isDeleted IS NULL

	IF @@ROWCOUNT = 0
	BREAK;

END