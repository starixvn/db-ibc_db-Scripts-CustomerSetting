/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240619 
	Task: FastSpin - Update SettingStatus - PRO [redmine: #205741]
	DB: DBCUST-CustDB
*/
USE CustDB
GO

UPDATE 
[dbo].[Dep_ProductSettingDetail] WITH (ROWLOCK, UPDLOCK)
SET SettingStatus=0
WHERE ProductSettingID IN (196,197)
AND SportType = 230
AND BetType = 11100
GO