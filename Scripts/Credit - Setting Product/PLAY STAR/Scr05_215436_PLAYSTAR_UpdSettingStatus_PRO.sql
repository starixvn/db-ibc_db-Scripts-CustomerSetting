/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: 20241217@Virgil
	Task: PLAY STAR - Implement setting and initial data [RedmineID: #208021]
	DB: DBCUST-CustDB
*/
USE CustDB
GO

DECLARE @Sporttype	SMALLINT = 143,
		@Bettype	SMALLINT = 11600

UPDATE DP
SET SettingStatus = 0,
	RepUpdateTime = SYSDATETIME()
FROM [dbo].[Dep_ProductSettingDetail] DP WITH (ROWLOCK, UPDLOCK)
WHERE ProductSettingID IN (223, 224)
	AND SportType = @Sporttype
	AND BetType = @Bettype

GO
