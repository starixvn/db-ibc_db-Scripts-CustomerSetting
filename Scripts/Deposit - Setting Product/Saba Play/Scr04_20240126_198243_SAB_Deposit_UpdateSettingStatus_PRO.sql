/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240126 
	Task: Saba Play - Update mode PRO [redmine: #198243]
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO

UPDATE 
[dbo].[Dep_ProductSettingDetail] WITH (ROWLOCK, UPDLOCK)
SET SettingStatus=0
WHERE ProductSettingID IN (186,187)
AND SportType = 9917
AND BetType = 2000
GO