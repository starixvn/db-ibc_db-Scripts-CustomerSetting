/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20240909
	Task: Update UUS setting for VGaming [Redmine:#210408] 
	DB:	DBCUST-CustDB
*/
USE CustDB
GO

UPDATE TOP (3) psl
SET psl.MaxBet=1000000
	,psl.RepUpdateTime=dbo.f_GetDateTime2()
FROM Dep_ProductStakeLevelGroup psl WITH (ROWLOCK, UPDLOCK)
WHERE psl.Sporttype=171 
	AND psl.LicenseeGroupID=6
	AND psl.SiteID=0 AND psl.isDeleted=0
GO