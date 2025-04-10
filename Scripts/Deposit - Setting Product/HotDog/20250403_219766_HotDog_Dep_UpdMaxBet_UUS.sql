/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created by: Tacy@20250403
	Task: Deposit - Update Maxbet for HOTDOG - UUS [Redmine:#219766] 
	DB:	DBGLOB-GlobCustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
USE GlobCustDB
GO

--Dep_ProductStakeLevelGroup
UPDATE TOP (3) Dep_ProductStakeLevelGroup WITH (ROWLOCK, UPDLOCK)
SET MaxBet=2500000
	,RepUpdateTime=dbo.f_Getdatetime2()
WHERE Sporttype=139 AND LicenseeGroupID=6
GO