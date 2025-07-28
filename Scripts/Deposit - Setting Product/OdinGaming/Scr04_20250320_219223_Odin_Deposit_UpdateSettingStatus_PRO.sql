/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: Tacy@20250320 
	Task: Odin Gaming - Update SettingStatus - PRO [redmine: #219223]
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

UPDATE 
[dbo].[Dep_ProductSettingDetail] WITH (ROWLOCK, UPDLOCK)
SET SettingStatus=0
	,RepUpdateTime=dbo.f_GetDateTime2()
WHERE SportType = 128
AND BetType = 15400  
GO