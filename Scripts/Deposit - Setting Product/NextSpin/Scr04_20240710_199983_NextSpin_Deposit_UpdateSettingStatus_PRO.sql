/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240710@Tacy
	Task: Nextspin - Update SettingStatus - PRO [redmine: #199983]
	DB: DBCUST-CustDB
*/
USE CustDB
GO

UPDATE 
[dbo].[Dep_ProductSettingDetail] WITH (ROWLOCK, UPDLOCK)
SET SettingStatus=0
WHERE ProductSettingID IN (200,201)
AND SportType = 229
AND BetType = 10450
GO