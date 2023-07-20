/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20230704
	Task:  Update Product profile for Virtual Sports 3 - Deposit [RedmineID: #190952]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype SMALLINT,
		@Bettype SMALLINT
SET @Sporttype = 178
SET @Bettype = 5302

UPDATE Dep_ProductSettingDetail WITH (ROWLOCK, UPDLOCK)
SET SettingStatus = 0
WHERE SportType = @Sporttype AND BetType = @Bettype
