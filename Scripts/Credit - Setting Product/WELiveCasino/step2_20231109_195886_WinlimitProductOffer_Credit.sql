/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: Luke
	Date: 20231109
	Task:  WE Live Casino - Implement customer setting [RedmineID: #195886]
	DB: DBTXN/bodb02
*/
USE bodb02
GO


INSERT INTO WinLimit_ProductOffer(ProductID, BetType, IsActive_SMA, IsActive_Company)
VALUES
	(80, 10300, 1, 1)
