/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created by: 20241217@Virgil
	Task: Smartsoft - Implement Customer Setting and Initial data [RedmineID: #210946]
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

DECLARE @Sporttype	SMALLINT = 135,
		@Bettype	SMALLINT = 12150

UPDATE DP
SET SettingStatus = 0,
	RepUpdateTime = SYSDATETIME()
FROM [dbo].[Dep_ProductSettingDetail] DP WITH (ROWLOCK, UPDLOCK)
WHERE SportType = @Sporttype
	AND BetType = @Bettype

GO
