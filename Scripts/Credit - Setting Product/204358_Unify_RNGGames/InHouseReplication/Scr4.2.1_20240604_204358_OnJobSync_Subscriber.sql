/*<info serverAlias="DBACC-bodb02,DBTP-bodb02"></info>*/
/*
	Created: 20240604@Eden
	Task: Enable job sync [#204358]
		BetSetting3rd_Agent
		BetSetting3rd_Member
	DB: DBACC-bodb02,DBTP-bodb02
*/
USE bodb02
GO

UPDATE RepInfo WITH (ROWLOCK, UPDLOCK)
SET active=1
WHERE [name] IN ('BetSetting3rd_Agent','BetSetting3rd_Member')
GO

