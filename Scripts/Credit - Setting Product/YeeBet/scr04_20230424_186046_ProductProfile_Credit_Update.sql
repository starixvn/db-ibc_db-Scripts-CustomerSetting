/*
	Created: Luke
	Date: 20230424
	Task:  Update Product profile for YeeBet - Credit [RedmineID: #186046]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype SMALLINT
SET @Sporttype = 159

UPDATE ProductSettingDetail WITH (ROWLOCK, UPDLOCK)
SET SettingStatus = 0
WHERE SportType = @Sporttype
