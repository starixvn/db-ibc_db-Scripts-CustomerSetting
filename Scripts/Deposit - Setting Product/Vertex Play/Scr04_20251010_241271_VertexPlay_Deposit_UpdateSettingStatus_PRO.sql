/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
    Created by: Virgil@20251010
    Task: initial data for Vertex Play  [Redmine: #241271] 
    DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

DECLARE  @SportType SMALLINT = 115
                ,@Bettype        SMALLINT = 16900  
                
UPDATE 
[dbo].[Dep_ProductSettingDetail] WITH (ROWLOCK, UPDLOCK)
SET SettingStatus=0
        ,RepUpdateTime=dbo.f_GetDateTime2()
WHERE SportType = @SportType
AND BetType = @Bettype
GO
