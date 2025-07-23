/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20250627
	Task: SIT - Clean old data - YOLO [Redmine: #231521] 
	DB: DBCUST-CustDB
*/
USE CustDB
GO

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
--Delete setting:
DELETE d --> 39 Rows
OUTPUT deleted.AgentID, deleted.Sporttype, deleted.Bettype, deleted.IsLive, dbo.f_GetDateTime2()
INTO Dep_CustPTGroupSetting_Member_Del_InHouse (AgentID, Sporttype, Bettype, IsLive, RepUpdateTime)
FROM Dep_CustPTGroupSetting_Member d WITH (ROWLOCK)
WHERE Sporttype=189
GO 

--> 303 Rows
DELETE d
OUTPUT deleted.CustID, deleted.Sporttype, deleted.Bettype, deleted.IsLive, dbo.f_GetDateTime2()
INTO Dep_CustPTSetting_Member_Del_InHouse (CustID, Sporttype, Bettype, IsLive, RepUpdateTime)
FROM Dep_CustPTSetting_Member d WITH (ROWLOCK)
WHERE Sporttype=189
GO

--> 714 Rows
DELETE d
OUTPUT deleted.CustID, deleted.Sporttype, deleted.Bettype, deleted.IsLive, dbo.f_GetDateTime2()
INTO Dep_CustPTSetting_Agent_Del_InHouse (CustID, Sporttype, Bettype, IsLive, RepUpdateTime)
FROM Dep_CustPTSetting_Agent d WITH (ROWLOCK)
WHERE Sporttype=189
GO