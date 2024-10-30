/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20241030
	Task: initial data into Dep_ProductStakeLevelGroup for VGaming & Virtual Games  [Redmine:#212761] 
	DB:	DBCUST-CustDB
*/
/*
	Vgaming: Need to add PGK and ETB
	Virtual Games: Need to add EGP
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--add new group exchange
UPDATE [exchange] WITH (ROWLOCK, UPDLOCK)
SET 
	LicenseeGroupID = CASE  WHEN currency IN ('PGK') THEN 36
							WHEN currency IN ('ETB') THEN 37
					END,
	RepUpdateTime = dbo.f_GetDateTime2()
WHERE currency IN ('PGK','ETB')
	AND OfferSite IN (2,0) AND IsActive=1
	AND LicenseeGroupID IS NULL
GO
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup (Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID, RepUpdateTime)
--VGaming
	  SELECT 171,	1,		36,		0.01,	4000,		0,		dbo.f_GetDateTime2()
UNION SELECT 171,	1,		37,		0.01,	50000,		0,		dbo.f_GetDateTime2()
UNION SELECT 171,	2,		36,		0.01,	4000,		0,		dbo.f_GetDateTime2()
UNION SELECT 171,	2,		37,		0.01,	50000,		0,		dbo.f_GetDateTime2()
--Virtual Games
UNION SELECT 245,	2,		34,		150,	20000,		0,		dbo.f_GetDateTime2()
GO