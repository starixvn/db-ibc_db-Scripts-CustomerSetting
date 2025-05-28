/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created by: {Nickname}@{date}
	Task: initial data for {productName}  [Redmine: #xxx] 
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

DECLARE  @SportType SMALLINT = {SportType}
		,@Bettype	SMALLINT = {Bettype}  
		
UPDATE 
[dbo].[Dep_ProductSettingDetail] WITH (ROWLOCK, UPDLOCK)
SET SettingStatus=0
	,RepUpdateTime=dbo.f_GetDateTime2()
WHERE SportType = @SportType
AND BetType = @Bettype
GO
