/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 202209152
	Task:	 Macau Game - Rename the setting page into RNG Slot and hide all bet limit setting [Redmine: 174513]
	DB:		 DBPOL.NAP_UserControl
*/ 
USE NAP_UserControl
GO

UPDATE a
SET a.ProductID = 53
FROM dbo.eaGroupConfiguration a WITH(ROWLOCK,UPDLOCK)
WHERE a.ProductID = 22

