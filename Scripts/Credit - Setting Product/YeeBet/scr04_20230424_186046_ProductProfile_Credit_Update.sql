/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20230424
	Task:  Update Product profile for YeeBet - Credit [RedmineID: #186046]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @RealProductID SMALLINT

SELECT	@RealProductID = 76

UPDATE ProductSettingDetail WITH (ROWLOCK, UPDLOCK)
SET SettingStatus = 0
WHERE RealProductId = @RealProductID
