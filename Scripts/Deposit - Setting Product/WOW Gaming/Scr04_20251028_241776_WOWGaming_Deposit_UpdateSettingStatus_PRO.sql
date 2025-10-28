/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
        Created by: Virgil@20251028
        Task: initial data for WOW Gaming  [Redmine: #241776] 
        DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

DECLARE		@SportType SMALLINT = 113
			,@Bettype  SMALLINT = 17100  
                
UPDATE 
[dbo].[Dep_ProductSettingDetail] WITH (ROWLOCK, UPDLOCK)
SET SettingStatus=0
        ,RepUpdateTime=dbo.f_GetDateTime2()
WHERE SportType = @SportType
AND BetType = @Bettype
GO
