/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created by: Tacy@20250528
	Task: initial data into Company Bet Limit for AI Gaming  [Redmine: #228554] 
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

DECLARE  @SportType SMALLINT = 121
		,@Bettype	SMALLINT = 16200  
		
UPDATE 
[dbo].[Dep_ProductSettingDetail] WITH (ROWLOCK, UPDLOCK)
SET SettingStatus=0
	,RepUpdateTime=dbo.f_GetDateTime2()
WHERE SportType = @SportType
AND BetType = @Bettype 
GO
