/*
	Created: 20200713@Eden
	Task: Remove data in GameType for new 3 games on DBTXN [Redmine:#137475]	
	DB: DBTXN/bodb02
*/ 
USE bodb02 
GO
DELETE FROM GameType WITH(ROWLOCK) WHERE GameTypeID IN (27,28,29)
GO
