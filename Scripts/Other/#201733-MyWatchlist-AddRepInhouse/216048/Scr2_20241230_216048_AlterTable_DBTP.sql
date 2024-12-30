/*<info serverAlias="IRS_DBTP-bodb02"></info>*/
/*
	Created: 20240415@Eden
	Task: alter tables add isDeleted column: [#201733]
		WLMonitored_Global
		WLMonitored_Player
		WLMonitored_SMA
	DB: IRS_DBTP-bodb02
*/
USE bodb02
GO
ALTER TABLE WLMonitored_Global ADD isDeleted BIT NULL
ALTER TABLE WLMonitored_Player ADD isDeleted BIT NULL
ALTER TABLE WLMonitored_SMA ADD isDeleted BIT NULL
	
GO
WHILE 1 = 1
BEGIN
	UPDATE TOP (1000) t
	SET t.isDeleted = 0
	FROM WLMonitored_Global t WITH( ROWLOCK, UPDLOCK)
	WHERE t.isDeleted IS NULL

	IF @@ROWCOUNT < 1000
		RETURN

	WAITFOR DELAY '00:00:00.020'
END

WHILE 1 = 1
BEGIN
	UPDATE TOP (1000) t
	SET t.isDeleted = 0
	FROM WLMonitored_Player t WITH( ROWLOCK, UPDLOCK)
	WHERE t.isDeleted IS NULL

	IF @@ROWCOUNT < 1000
		RETURN

	WAITFOR DELAY '00:00:00.020'
END

WHILE 1 = 1
BEGIN
	UPDATE TOP (1000) t
	SET t.isDeleted = 0
	FROM WLMonitored_SMA t WITH( ROWLOCK, UPDLOCK)
	WHERE t.isDeleted IS NULL

	IF @@ROWCOUNT < 1000
		RETURN

	WAITFOR DELAY '00:00:00.020'
END