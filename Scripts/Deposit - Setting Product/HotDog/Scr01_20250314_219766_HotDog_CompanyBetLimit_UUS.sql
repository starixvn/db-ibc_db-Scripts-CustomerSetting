/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created by: Tacy@20250314
	Task: initial data into Company Bet Limit for HOTDOG - UUS [Redmine:#219766] 
	DB:	DBGLOB-GlobCustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--ProductStakeLevelGroup
INSERT INTO ProductStakeLevelGroup 
	(Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, Remark, RepUpdateTime)
	  SELECT 139,	1,	6,	0.01,	2500,	NULL,	dbo.f_Getdatetime2()
UNION SELECT 139,	2,	6,	0.01,	1500,	NULL,	dbo.f_Getdatetime2()
GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup 
	(Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID, RepUpdateTime)
	  SELECT 139,	1,	6,	0.01,	2500,	0,	dbo.f_Getdatetime2()
UNION SELECT 139,	2,	6,	0.01,	1500,	0,	dbo.f_Getdatetime2()
GO