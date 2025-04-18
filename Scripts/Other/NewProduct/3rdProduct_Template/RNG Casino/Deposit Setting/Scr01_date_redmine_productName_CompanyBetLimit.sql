/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created by: {Nickname}@{date}
	Task: initial data into Company Bet Limit for {productName} [Redmine: #xxx] 
	DB:	DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--ProductStakeLevelGroup
INSERT INTO ProductStakeLevelGroup 
	(Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, RepUpdateTime)
	  SELECT 123,		1,		1,		0.01,		5000,		dbo.f_Getdatetime2()
UNION SELECT 123,		1,		2,		0.01,		15000,		dbo.f_Getdatetime2()
UNION SELECT 123,		1,		3,		0.01,		1500,		dbo.f_Getdatetime2()
UNION SELECT 123,		1,		4,		0.01,		5000,		dbo.f_Getdatetime2()
UNION SELECT 123,		1,		5,		0.01,		5000,		dbo.f_Getdatetime2()
UNION SELECT 123,		1,		6,		0.01,		1500,		dbo.f_Getdatetime2()
UNION SELECT 123,		1,		7,		0.01,		35000,		dbo.f_Getdatetime2()
UNION SELECT 123,		1,		8,		0.01,		700000,		dbo.f_Getdatetime2()
UNION SELECT 123,		1,		9,		0.01,		25000,		dbo.f_Getdatetime2()
UNION SELECT 123,		1,		12,		0.01,		50000,		dbo.f_Getdatetime2()
UNION SELECT 123,		1,		13,		0.01,		1500,		dbo.f_Getdatetime2()
UNION SELECT 123,		2,		1,		0.01,		2500,		dbo.f_Getdatetime2()
UNION SELECT 123,		2,		2,		0.01,		7500,		dbo.f_Getdatetime2()
UNION SELECT 123,		2,		3,		0.01,		1000,		dbo.f_Getdatetime2()
UNION SELECT 123,		2,		4,		0.01,		2500,		dbo.f_Getdatetime2()
UNION SELECT 123,		2,		5,		0.01,		2500,		dbo.f_Getdatetime2()
UNION SELECT 123,		2,		6,		0.01,		1000,		dbo.f_Getdatetime2()
UNION SELECT 123,		2,		7,		0.01,		15000,		dbo.f_Getdatetime2()
UNION SELECT 123,		2,		8,		0.01,		350000,		dbo.f_Getdatetime2()
UNION SELECT 123,		2,		9,		0.01,		15000,		dbo.f_Getdatetime2()
UNION SELECT 123,		2,		12,		0.01,		25000,		dbo.f_Getdatetime2()
UNION SELECT 123,		2,		13,		0.01,		1000,		dbo.f_Getdatetime2()
GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup 
	(Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID, RepUpdateTime)
	  SELECT 123,		1,		2,		0.01,		1500,		0,		 dbo.f_Getdatetime2()
UNION SELECT 123,		1,		4,		0.01,		1500,		0,		 dbo.f_Getdatetime2()
UNION SELECT 123,		1,		7,		0.01,		15000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 123,		1,		13,		0.01,		25000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 123,		1,		6,		0.01,		1500,		0,		 dbo.f_Getdatetime2()
UNION SELECT 123,		2,		2,		0.01,		1000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 123,		2,		4,		0.01,		1000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 123,		2,		7,		0.01,		7500,		0,		 dbo.f_Getdatetime2()
UNION SELECT 123,		2,		13,		0.01,		15000,		0,		 dbo.f_Getdatetime2()
UNION SELECT 123,		2,		6,		0.01,		1000,		0,		 dbo.f_Getdatetime2()
GO
