/*
	Created: Eden
	Date: 2019/07/16
	Task: insert data in GameType for new 2 games [Redmine:#116466]	
*/ 

---------------------------------------------------------------
--Insert data DBPRO.bodb02.dbo.GameType-------------------------
----------------------------------------------------------------
USE bodb02 
GO

DELETE FROM GameType WHERE GameTypeID IN (25,26)
GO

INSERT INTO GameType (GameTypeID, GameTypeName, IsDisabled, IBCBetTypeID)          
SELECT 25, 'Keno War', 0, 1525
UNION ALL SELECT 26, 'Keno War 2', 0, 1526

GO

