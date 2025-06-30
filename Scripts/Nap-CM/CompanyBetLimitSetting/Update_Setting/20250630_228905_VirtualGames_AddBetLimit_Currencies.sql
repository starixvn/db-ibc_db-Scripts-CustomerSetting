/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created by: Tacy@20250630
	Task: Virtual Games - Add Global Bet Setting for Deposit of some Currencies [Redmine:#228905] 
	DB:	DBGLOB-GlobCustDB

	** Currencies: BOB, PYG, UYU, VES, CRC
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup 
		(Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID, RepUpdateTime)
	  SELECT 245,		2,		56,		1,		3000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 245,		2,		54,		1,		3350000,	0,		 dbo.f_Getdatetime2()
UNION SELECT 245,		2,		55,		1,		25000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 245,		2,		53,		1,		33500,		0,		 dbo.f_Getdatetime2()
UNION SELECT 245,		2,		57,		1,		200000,		0,		 dbo.f_Getdatetime2()
GO