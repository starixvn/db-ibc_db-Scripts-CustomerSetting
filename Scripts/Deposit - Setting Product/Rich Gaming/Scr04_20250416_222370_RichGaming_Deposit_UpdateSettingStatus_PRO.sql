/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created by: Tacy@20250516
	Task: initial data into Company Bet Limit for Rich Gaming  [Redmine:#222370] 
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

UPDATE 
[dbo].[Dep_ProductSettingDetail] WITH (ROWLOCK, UPDLOCK)
SET SettingStatus=0
	,RepUpdateTime=dbo.f_GetDateTime2()
WHERE SportType = 123
AND BetType = 15800 
GO