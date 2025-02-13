/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created By: 20250213@Virgil
	Task: MaxGame - MXN - Add Global Bet Settings [RedmineID: #217857]
	DB: DBCUST-CustDB
*/

----------------------------------------------------------------------------------------------------------------
-- /* BET LIMIT */ --
-- Dep_ProductStakeLevelGroup
INSERT INTO Dep_ProductStakeLevelGroup (Sporttype, GameGroupID, LicenseeGroupID, MinBet, MaxBet, RepUpdateTime, SiteID)
SELECT 237,	2,	12,	0.01, 20000, SYSDATETIME(), 0

GO
