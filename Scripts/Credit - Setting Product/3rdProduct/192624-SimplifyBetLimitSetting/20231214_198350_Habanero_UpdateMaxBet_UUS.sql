/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20231214
	Task: Habanero - Support to adjust Maxbet for UUS currency [Redmine:#198350] 
		https://nexdev.net/issues/198350
	DB:	DBCUST-CustDB
*/
USE CustDB
GO

UPDATE ProductStakeLevelGroup WITH(ROWLOCK, UPDLOCK)
SET MaxBet=1400,
	RepUpdateTime = SYSDATETIME()
WHERE Sporttype=238
AND GameGroupID=1 AND CreditGroupID=6
GO

UPDATE Dep_ProductStakeLevelGroup WITH(ROWLOCK, UPDLOCK)
SET MaxBet=1400,
	RepUpdateTime = SYSDATETIME()
WHERE Sporttype=238
AND GameGroupID=1 AND LicenseeGroupID=6
GO