/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20250219
	Task: initial data into Dep_ProductStakeLevelGroup for MaxGame  - PKR, JPY, NGN [Redmine:#218066] 
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--add new group exchange
UPDATE [exchange] WITH (ROWLOCK, UPDLOCK)
SET 
	LicenseeGroupID = 39,
	RepUpdateTime = dbo.f_GetDateTime2()
WHERE currency IN ('NGN')
	AND OfferSite IN (2,0) AND IsActive=1
	AND LicenseeGroupID IS NULL
GO
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup 
	(Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID, RepUpdateTime)
	  SELECT 237,	2,		8,		0.01,	100000,		0,	dbo.f_GetDateTime2()
UNION SELECT 237,	2,		21,		0.01,	300000,		0,	dbo.f_GetDateTime2()
UNION SELECT 237,	2,		39,		0.01,	1000000,	0,	dbo.f_GetDateTime2()