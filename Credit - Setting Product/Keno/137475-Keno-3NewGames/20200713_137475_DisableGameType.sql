/*
	Created: 20200713@Eden
	Task: update disable new gametypes [Redmine:#137475]	
	DB: DBPRO/bodb02
*/ 

USE bodb02 
GO
UPDATE GameType WITH(rowlock)
SET	  IsDisabled = 1
WHERE GameTypeID IN (27,28,29)