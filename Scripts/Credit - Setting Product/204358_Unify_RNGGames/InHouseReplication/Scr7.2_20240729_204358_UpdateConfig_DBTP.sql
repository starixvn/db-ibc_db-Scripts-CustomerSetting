/*<info serverAlias="DBTP-bodb02"></info>*/
/*
	Created: Eden@20240729
	Task: Alter config [Redmine: #204358]   
	DB: DBTP-bodb02
*/
USE bodb02
GO
DECLARE @Group INT = 0 -- Group whole replicate data from DBCUST.custdb --> DBTP.bodb02

UPDATE c
SET c.get_sp = 'Repl_GetBetSetting3rd_Agent',
	c.put_sp = 'Repl_PutBetSetting3rd_Agent_Dist',
	c.active = 0,
	c.[group] = @Group
FROM RepInfo c WITH (ROWLOCK, UPDLOCK)
WHERE [name] IN ('BetSetting3rd_Agent')

UPDATE c
SET c.get_sp = 'Repl_GetBetSetting3rd_Member',
	c.put_sp = 'Repl_PutBetSetting3rd_Member_Dist',
	c.active = 0,
	c.[group] = @Group
FROM RepInfo c WITH (ROWLOCK, UPDLOCK)
WHERE [name] IN ('BetSetting3rd_Member')
GO
/*

SELECT * FROM RepInfoGroup (NOLOCK)

SELECT * 
FROM RepInfo WITH (NOLOCK)
WHERE [name] IN ('BetSetting3rd_Agent','BetSetting3rd_Member')
*/