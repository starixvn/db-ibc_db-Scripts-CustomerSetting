/*
	Created by: Elodie
	Date: 2018-05-02
	Task: insert data in GameType for new 6 games [Redmine:#92878]	
*/ 

---------------------------------------------------------------
--Insert data DBPRO.bodb02.dbo.GameType-------------------------
----------------------------------------------------------------
USE bodb02 
GO

DELETE FROM GameType WHERE GameTypeID IN (17,19,20,21,22,24)
GO

INSERT INTO GameType (GameTypeID, GameTypeName, IsDisabled, IBCBetTypeID)          
SELECT 17, 'Mini Keno', 0, 1517
UNION ALL SELECT 19, 'Spring', 0, 1519     
UNION ALL SELECT 20, 'Summer', 0, 1520
UNION ALL SELECT 21, 'Autumn', 0, 1521
UNION ALL SELECT 22, 'Winter', 0, 1522
UNION ALL SELECT 24, 'Mini Keno 2', 0, 1524

GO

