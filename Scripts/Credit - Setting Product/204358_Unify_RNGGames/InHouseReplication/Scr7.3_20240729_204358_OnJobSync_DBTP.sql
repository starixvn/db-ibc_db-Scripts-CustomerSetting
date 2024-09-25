/*<info serverAlias="DBTP-bodb02"></info>*/
/*
	Created: Eden@20240729
	Task: On job [Redmine: #204358]   
	DB: DBTP-bodb02
*/
USE bodb02
GO
UPDATE RepInfo WITH (ROWLOCK, UPDLOCK)
SET active=1
WHERE [name] IN ('BetSetting3rd_Agent','BetSetting3rd_Member')
GO
/*

SELECT * FROM RepInfoGroup (NOLOCK)

SELECT * 
FROM RepInfo WITH (NOLOCK)
WHERE [name] IN ('BetSetting3rd_Agent','BetSetting3rd_Member')
*/