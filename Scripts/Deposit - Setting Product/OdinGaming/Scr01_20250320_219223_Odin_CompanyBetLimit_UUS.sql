/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created by: Tacy@20250320
	Task: initial data into Company Bet Limit for Odin Gaming - UUS  [Redmine:#219223] 
	DB:	DBGLOB-GlobCustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--ProductStakeLevelGroup
INSERT INTO ProductStakeLevelGroup 
	(Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, Remark, RepUpdateTime)
   	  SELECT 128,		1,		6,		0.01,		2500,		NULL,		dbo.f_Getdatetime2()
UNION SELECT 128,		2,		6,		0.01,		1500,		NULL,		dbo.f_Getdatetime2()
GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup 
	(Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID, RepUpdateTime)
	  SELECT 128,		1,		6,		0.01,		2500,		0,		 dbo.f_Getdatetime2()
UNION SELECT 128,		2,		6,		0.01,		1500,		0,		 dbo.f_Getdatetime2()
GO