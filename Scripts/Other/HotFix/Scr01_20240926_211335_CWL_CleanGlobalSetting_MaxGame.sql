/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20240926
	Task: Clean redundant data - Max Game (5404)  [Redmine:#211335] 
	DB:	DBCUST-bodb_Licensee
*/
USE CustDB
GO

DELETE
FROM Winlimit_ProductGlobalSetting  WITH (ROWLOCK)
WHERE ProductID=60 AND BetTypeID=5404
GO