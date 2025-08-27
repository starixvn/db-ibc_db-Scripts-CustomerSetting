/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
        Created by: Tacy@20250827
        Task: initial data for BGaming  [Redmine: #236998] 
        DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

DECLARE  @SportType SMALLINT = 118
                ,@Bettype        SMALLINT = 16400  
                
UPDATE 
[dbo].[Dep_ProductSettingDetail] WITH (ROWLOCK, UPDLOCK)
SET SettingStatus=0
        ,RepUpdateTime=dbo.f_GetDateTime2()
WHERE SportType = @SportType
AND BetType = @Bettype
GO