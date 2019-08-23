/*
	Created: Eden
	Date: 2019/07/16
	Task: update disable gametype [Redmine:#116466]	
*/ 

---------------------------------------------------------------
--Insert data DBPRO.bodb02.dbo.GameType-------------------------
----------------------------------------------------------------
USE bodb02 
GO

UPDATE GameType WITH(rowlock)
SET		IsDisabled = 1
WHERE GameTypeID IN (25,26)