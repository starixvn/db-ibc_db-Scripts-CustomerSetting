/*<info serverAlias="DBAGE-bodb02"></info>*/
/*
	Created: 20240415@Eden
	Task: Disable job sync [#201733]
		WLMonitored_Global
		WLMonitored_Player
		WLMonitored_SMA
	DB: DBAGE-bodb02
*/
USE bodb02
GO

UPDATE RepInfo WITH (ROWLOCK, UPDLOCK)
SET active=0
WHERE [name] IN ('WLMonitored_Global','WLMonitored_Player','WLMonitored_SMA')
GO

