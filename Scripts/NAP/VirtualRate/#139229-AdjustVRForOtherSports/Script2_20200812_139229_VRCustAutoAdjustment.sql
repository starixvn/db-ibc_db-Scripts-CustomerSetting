/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20200811@Eden
	Task: UPDATE VRCustAutoAdjustment sporttype to 99( other sport)
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO

--Update VRCustAutoAdjustment 
UPDATE t 
SET t.SportType = 99
FROM VRCustAutoAdjustment t WITH(ROWLOCK) 
WHERE SportType = 2