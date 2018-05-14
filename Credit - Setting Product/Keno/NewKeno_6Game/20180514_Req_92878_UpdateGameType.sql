/*
	Created by: Winnie
	Date: 2018-05-14
	Task: insert/update data in GameType for new 6 games [Redmine:#92878]	
*/ 

---------------------------------------------------------------
--Insert data DBPRO.bodb02.dbo.GameType-------------------------
----------------------------------------------------------------
USE bodb02 
GO

UPDATE GameType WITH(ROWLOCK,UPDLOCK)
	SET IsDisabled=0
WHERE IBCBetTypeID=1524

GO

