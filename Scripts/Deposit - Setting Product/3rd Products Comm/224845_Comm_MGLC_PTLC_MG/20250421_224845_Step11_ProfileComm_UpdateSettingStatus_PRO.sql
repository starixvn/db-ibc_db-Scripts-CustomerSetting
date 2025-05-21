/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: 20250421@Tacy
	Task: update profile for Comm Setting for Microgaming Live, Playtech Live, Rich Gaming [redmine: #224845]
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

UPDATE 
[dbo].[Dep_ProductSettingDetail] WITH (ROWLOCK, UPDLOCK)
SET SettingStatus=0
	,RepUpdateTime=dbo.f_GetDateTime2()
WHERE ProductSettingID BETWEEN 247 AND 249
GO
