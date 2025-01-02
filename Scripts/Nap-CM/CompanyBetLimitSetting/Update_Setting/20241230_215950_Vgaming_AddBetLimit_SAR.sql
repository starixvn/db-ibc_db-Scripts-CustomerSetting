/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20241230
	Task: initial data into Dep_ProductStakeLevelGroup for VGaming - SAR [Redmine:#215950] 
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--add new group exchange
UPDATE [exchange] WITH (ROWLOCK, UPDLOCK)
SET 
	LicenseeGroupID = 38,
	RepUpdateTime = dbo.f_GetDateTime2()
WHERE currency IN ('SAR')
	AND OfferSite IN (2,0) AND IsActive=1
	AND LicenseeGroupID IS NULL
GO
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup (Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID, RepUpdateTime)
--VGaming
	  SELECT 171,	1,		38,		0.01,	4000,		0,		dbo.f_GetDateTime2()
UNION SELECT 171,	2,		38,		0.01,	4000,		0,		dbo.f_GetDateTime2()
GO