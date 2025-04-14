/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created by: Tacy@20250410
	Task: PlayTech RNG - Add bet limit setting for new currencies [Redmine:#223288] 
	DB:	DBGLOB-GlobCustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
USE GlobCustDB
GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--ProductStakeLevelGroup
INSERT INTO ProductStakeLevelGroup (Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, Remark, RepUpdateTime)
	  SELECT 148,		1,		2,		0.01,		35000,		NULL,		dbo.f_Getdatetime2()
UNION SELECT 148,		1,		9,		0.01,		50000,		NULL,		dbo.f_Getdatetime2()
UNION SELECT 148,		2,		2,		0.01,		20000,		NULL,		dbo.f_Getdatetime2()
UNION SELECT 148,		2,		9,		0.01,		25000,		NULL,		dbo.f_Getdatetime2()
GO

--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup (Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID, RepUpdateTime)
	  SELECT 148,		1,		7,		0.01,		35000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 148,		1,		13,		0.01,		50000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 148,		2,		7,		0.01,		20000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 148,		2,		13,		0.01,		25000,		0,		 dbo.f_Getdatetime2()
GO