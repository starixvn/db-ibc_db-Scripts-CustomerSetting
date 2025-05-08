/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created by: Tacy@20250505
	Task: Rich Gaming - Implement Setting and Initial data [Redmine:#222370] 
	DB:	DBGLOB-GlobCustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
USE GlobCustDB
GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
UPDATE Dep_ProductStakeLevelGroup WITH (ROWLOCK, UPDLOCK)
SET MaxBet = CASE WHEN GameGroupID=1 THEN 1500000 ELSE 1000000 END
	,Remark=N'mapped to the vendor''s VND(1:1)'
	,RepUpdateTime=dbo.f_GetDateTime2()
WHERE Sporttype=123 AND LicenseeGroupID=6
GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--ProductStakeLevelGroup
-- MMK (MMK), YNG (YNG)
INSERT INTO ProductStakeLevelGroup 
			(Sporttype, GameGroupID, CreditGroupID, MinBet, MaxBet, Remark, RepUpdateTime)
	  SELECT 123,		1,		10,		0.01,		2000,		NULL,		dbo.f_Getdatetime2()
UNION SELECT 123,		2,		10,		0.01,		1000,		NULL,		dbo.f_Getdatetime2()
UNION SELECT 123,		1,		11,		0.01,		2500000,	N'mapped to the vendor''s VND(1:1)',		dbo.f_Getdatetime2()
UNION SELECT 123,		2,		11,		0.01,		1250000,	N'mapped to the vendor''s VND(1:1)',		dbo.f_Getdatetime2()
GO