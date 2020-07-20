/*
	Created: 20200713@Eden
	Task: update Enable new gametypes [Redmine:#137475]	
	DB: DBPRO/bodb02
*/ 
USE bodb02 
GO
UPDATE GameType WITH(ROWLOCK)
SET   IsDisabled = 0
WHERE GameTypeID IN (27,28,29)