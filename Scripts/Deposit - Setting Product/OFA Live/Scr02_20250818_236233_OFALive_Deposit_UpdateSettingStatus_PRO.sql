/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
        Created by: Tacy@20250818
        Task: initial data for OFA Live  [Redmine: #236233] 
        DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

DECLARE  @SportType SMALLINT = 119
                ,@Bettype        SMALLINT = 12250  
                
UPDATE 
[dbo].[Dep_ProductSettingDetail] WITH (ROWLOCK, UPDLOCK)
SET SettingStatus=0
        ,RepUpdateTime=dbo.f_GetDateTime2()
WHERE SportType = @SportType
AND BetType = @Bettype
GO
