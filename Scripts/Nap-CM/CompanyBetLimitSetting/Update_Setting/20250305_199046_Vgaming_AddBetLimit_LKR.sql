/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20250305
	Task: initial data into Dep_ProductStakeLevelGroup for VGaming - LKR  [Redmine:#199046] 
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--add new group exchange
DECLARE @LicenseeGroupID INT = 40

UPDATE [exchange] WITH (ROWLOCK, UPDLOCK)
SET 
	LicenseeGroupID = @LicenseeGroupID,
	RepUpdateTime = dbo.f_GetDateTime2()
WHERE currency IN ('LKR')
	AND OfferSite IN (2,0) AND IsActive=1
	AND LicenseeGroupID IS NULL
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup (Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, SiteID, RepUpdateTime)
--VGaming
	  SELECT 171,	1,		@LicenseeGroupID,		0.01,	250000,		0,		dbo.f_GetDateTime2()
UNION SELECT 171,	2,		@LicenseeGroupID,		0.01,	250000,		0,		dbo.f_GetDateTime2()
--Virtual Games
UNION SELECT 245,	2,		@LicenseeGroupID,		1.00,	100000,		0,		dbo.f_GetDateTime2()
GO