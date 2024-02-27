/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240108 
	Task: Update SettingStatus [redmine: #198008]
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO

UPDATE 
[dbo].[Dep_ProductSettingDetail] WITH (ROWLOCK, UPDLOCK)
SET SettingStatus=0
WHERE ProductSettingID BETWEEN 182 AND 185
AND SportType = 9908
AND BetType = 1201
GO
