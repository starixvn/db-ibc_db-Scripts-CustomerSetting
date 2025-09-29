/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
        Created by: Johnson@20250929
        Task: initial data for Gemini  [Redmine: #239527] 
        DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

DECLARE  @SportType SMALLINT = 117
                ,@Bettype        SMALLINT = 16800  
                
UPDATE [dbo].[Dep_ProductSettingDetail] WITH (ROWLOCK, UPDLOCK)
SET SettingStatus=0
        ,RepUpdateTime=dbo.f_GetDateTime2()
WHERE SportType = @SportType
AND BetType = @Bettype
GO
