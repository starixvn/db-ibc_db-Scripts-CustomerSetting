/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240626 
	Task: FA CHAI - Update SettingStatus - PRO [redmine: #206632]
	DB: DBCUST-CustDB
*/
USE CustDB
GO

UPDATE 
[dbo].[Dep_ProductSettingDetail] WITH (ROWLOCK, UPDLOCK)
SET SettingStatus=0
WHERE ProductSettingID IN (198,199)
AND SportType = 146
AND BetType = 11300
GO