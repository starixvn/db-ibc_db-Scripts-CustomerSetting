/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20241031
	Task: initial data into Dep_ProductStakeLevelGroup for Habanero/ Creative Gaming [Redmine:#212948] 
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup (Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID, RepUpdateTime)
	  SELECT 167,	1,		20,		0.01,	100000,		0,		dbo.f_GetDateTime2()
UNION SELECT 238,	1,		20,		0.01,	100000,		0,		dbo.f_GetDateTime2()
GO