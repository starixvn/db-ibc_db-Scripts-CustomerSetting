/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240729 
	Task: GPI - Update SettingStatus - PRO [redmine: #207175]
	DB: DBCUST-CustDB
*/
USE CustDB
GO

UPDATE 
[dbo].[Dep_ProductSettingDetail] WITH (ROWLOCK, UPDLOCK)
SET SettingStatus=0
	,RepUpdateTime=dbo.f_GetDateTime2()
WHERE ProductSettingID IN (202,203)
AND SportType = 145
AND BetType = 11400
GO