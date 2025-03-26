/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: Tacy@20250307 
	Task: Funky Games - Update SettingStatus - PRO [redmine: #218180]
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

UPDATE 
[dbo].[Dep_ProductSettingDetail] WITH (ROWLOCK, UPDLOCK)
SET SettingStatus=0
	,RepUpdateTime=dbo.f_GetDateTime2()
WHERE ProductSettingID IN (230,231)
AND SportType = 131
AND BetType = 15200
GO