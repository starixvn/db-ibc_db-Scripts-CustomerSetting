/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20240105
	Task: Virtual Rate - Switch from CSGO to CS2 LeagueGroup [Redmine: #197186]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

--change groupname CSGO to CS2
UPDATE lg 
SET lg.GroupName = 'Counter Strike 2'
FROM VRLeagueGroup lg WITH (ROWLOCK, UPDLOCK)
WHERE lg.GroupID = 3
GO

--map new LeagueGroup with VRLeagueGroupID = 3 (cs2)
INSERT INTO VRLeagueGroupMapping(LeagueGroupID, VRLeagueGroupID)
SELECT 208 AS LeagueGroupID, 3 AS VRLeagueGroupID