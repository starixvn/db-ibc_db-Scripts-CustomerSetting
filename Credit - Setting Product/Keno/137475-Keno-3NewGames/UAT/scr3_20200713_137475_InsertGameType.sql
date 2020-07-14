/*
	Created: 20200713@Eden
	Task: insert data in GameType for new 3 games [Redmine:#137475]	
	DB: DBTXN/bodb02
*/ 
USE bodb02 
GO

DELETE FROM GameType WITH(ROWLOCK) WHERE GameTypeID IN (27,28,29)
GO

INSERT INTO GameType (GameTypeID, GameTypeName, IsDisabled, IBCBetTypeID)          
SELECT 27, 'Lucky28', 0, 1527
UNION ALL SELECT 28, 'Max Keno (20+1)', 0, 1528
UNION ALL SELECT 29, 'Max Keno (20+1) 2', 0, 1529
GO

--Update Disable GameType of Keno 
 UPDATE GameType WITH(ROWLOCK) 
 SET IsDisabled = 1 
 WHERE IBCBetTypeID IN (1502,1507,1509)