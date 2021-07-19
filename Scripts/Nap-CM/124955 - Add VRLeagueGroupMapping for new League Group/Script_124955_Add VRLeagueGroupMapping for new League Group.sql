/*
	Created by: Eden
	Date: 20191204
	Task: Add VRLeagueGroupMapping for new League Group [Redmine:#124955]	
	DB: DBCUST/CustDB
*/
USE CustDB	
INSERT INTO dbo.VRLeagueGroupMapping(LeagueGroupID, VRLeagueGroupID)
VALUES(40, 5)-- New games --> Other Games