/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20230424
	Task:  Update Product profile for YeeBet - Deposit [RedmineID: #186046]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype SMALLINT,
		@Bettype SMALLINT
SET @Sporttype = 159
SET @Bettype = 3151

UPDATE Dep_ProductSettingDetail WITH (ROWLOCK, UPDLOCK)
SET SettingStatus = 0
WHERE SportType = @Sporttype AND BetType = @Bettype
