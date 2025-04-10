/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: Tacy@20250314 
	Task: HOTDOG - Update SettingStatus - PRO [redmine: #219766]
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

UPDATE 
[dbo].[Dep_ProductSettingDetail] WITH (ROWLOCK, UPDLOCK)
SET SettingStatus=0
	,RepUpdateTime=dbo.f_GetDateTime2()
WHERE SportType = 139
AND BetType = 11900 
GO