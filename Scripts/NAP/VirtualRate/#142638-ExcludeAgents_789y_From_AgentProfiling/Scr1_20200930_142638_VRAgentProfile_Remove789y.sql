/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20200930@Eden
	Task: Remove 789y from VRAgentProfile [RM#142638]
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO
DELETE t 
FROM VRAgentProfile t WITH(ROWLOCK)
WHERE t.SiteID = 3 AND Type = 1