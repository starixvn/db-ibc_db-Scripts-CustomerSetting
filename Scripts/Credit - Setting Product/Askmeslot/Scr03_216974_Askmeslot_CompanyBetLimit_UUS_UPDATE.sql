/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: 20250204@Dave
	Task: Askmeslot - Implement Customer Setting and initial data [RedmineID: #216977]
	DB: DBCUST-CustDB
*/
USE CustDB
GO
----------------------------------------------------------------------------------------------------------------
-- /* BET LIMIT */ --
----------------------------------------------------------------------------------------------------------------
-- Dep_ProductStakeLevelGroup

UPDATE Dep_ProductStakeLevelGroup
SET MaxBet = 2500000, RepUpdateTime = SYSDATETIME()
WHERE Sporttype = 130 AND GameGroupID = 1 and LicenseeGroupID = 6;

UPDATE Dep_ProductStakeLevelGroup
SET MaxBet = 1250000, RepUpdateTime = SYSDATETIME(), Remark='Mapping Vendor''s VND1000'
WHERE Sporttype = 130 AND GameGroupID = 2 and LicenseeGroupID = 6;
