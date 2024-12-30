/*<info serverAlias="IRS_DBTP-bodb02"></info>*/
/*
	Created: 20241230@Eden
	Task: Disable job sync [#216048]
		WLMonitored_Global
		WLMonitored_Player
		WLMonitored_SMA
	DB: IRS_DBTP-bodb02
*/
USE bodb02
GO

UPDATE RepInfo WITH (ROWLOCK, UPDLOCK)
SET active=0
WHERE [name] IN ('WLMonitored_Global','WLMonitored_Player','WLMonitored_SMA')
GO

