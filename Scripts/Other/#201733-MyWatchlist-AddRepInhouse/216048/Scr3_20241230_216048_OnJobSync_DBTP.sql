/*<info serverAlias="IRS_DBTP-bodb02"></info>*/
/*
	Created: 20241230@Eden
	Task: Enable job sync, change sp put [#216048]
		WLMonitored_Global
		WLMonitored_Player
		WLMonitored_SMA
	DB: IRS_DBTP-bodb02
*/
USE bodb02
GO

UPDATE RepInfo WITH (ROWLOCK, UPDLOCK)
SET active=1,
	put_sp = CASE	WHEN [name] = 'WLMonitored_Global' THEN 'Repl_PutWLMonitored_Global_Dist' 
					WHEN [name] = 'WLMonitored_Player' THEN 'Repl_PutWLMonitored_Player_Dist' 
					WHEN [name] = 'WLMonitored_SMA' THEN 'Repl_PutWLMonitored_SMA_Dist' 
				ELSE [name] END
WHERE [name] IN ('WLMonitored_Global','WLMonitored_Player','WLMonitored_SMA')
GO
/*
SELECT * 
FROM  RepInfo WITH (NOLOCK)
WHERE [name] IN ('WLMonitored_Global','WLMonitored_Player','WLMonitored_SMA')
*/