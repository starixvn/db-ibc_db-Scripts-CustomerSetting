/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: 20250204@Dave
	Task: Askmeslot - Implement Customer Setting and initial data [RedmineID: #216977]
	DB: DBCUST-CustDB
*/
USE CustDB
GO

DECLARE @Sporttype	SMALLINT = 130,
		@Bettype	SMALLINT = 15000

UPDATE DP
SET SettingStatus = 0,
	RepUpdateTime = SYSDATETIME()
FROM [dbo].[Dep_ProductSettingDetail] DP WITH (ROWLOCK, UPDLOCK)
WHERE ProductSettingID IN (228, 229)
	AND SportType = @Sporttype
	AND BetType = @Bettype

GO