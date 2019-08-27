/*
	Created: Eden
	Date: 2019/08/27
	Task: update enable gametype [Redmine:#116466]	
*/ 

---------------------------------------------------------------
--Insert data DBPRO.bodb02.dbo.GameType-------------------------
----------------------------------------------------------------
USE bodb02 
GO
UPDATE GameType WITH(ROWLOCK)
SET    IsDisabled = 0
WHERE  GameTypeID IN(25, 26)