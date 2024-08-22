/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20240726
	Task: Update EGP setting for VGaming [Redmine:#205654] 
	DB:	DBCUST-CustDB
*/
USE CustDB
GO

UPDATE TOP (2) psl
SET psl.MinBet=0.1
	,psl.RepUpdateTime=SYSDATETIME()
FROM Dep_ProductStakeLevelGroup psl WITH (ROWLOCK, UPDLOCK)
WHERE psl.Sporttype=171 
	AND psl.GameGroupID=2 
	AND psl.LicenseeGroupID=34
GO