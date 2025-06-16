/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created by: Tacy@20250520
	Task: initial data into Company Bet Limit for ClotPlay  [Redmine: #228003] 
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

DECLARE  @SportType SMALLINT = 122
		,@Bettype	SMALLINT = 16100  
		
UPDATE 
[dbo].[Dep_ProductSettingDetail] WITH (ROWLOCK, UPDLOCK)
SET SettingStatus=0
	,RepUpdateTime=dbo.f_GetDateTime2()
WHERE SportType = @SportType
AND BetType = @Bettype 
GO
