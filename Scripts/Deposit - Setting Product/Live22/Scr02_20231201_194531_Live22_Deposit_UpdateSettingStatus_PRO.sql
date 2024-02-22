/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20231201 
	Task: Live22 - Update SettingStatus - PRO [redmine: #194531]
	DB: DBCUST-CustDB
*/
USE CustDB
GO

UPDATE 
[dbo].[Dep_ProductSettingDetail] WITH (ROWLOCK, UPDLOCK)
SET SettingStatus=0
WHERE ProductSettingID IN (180,181)
AND SportType = 227
AND BetType = 7601
GO