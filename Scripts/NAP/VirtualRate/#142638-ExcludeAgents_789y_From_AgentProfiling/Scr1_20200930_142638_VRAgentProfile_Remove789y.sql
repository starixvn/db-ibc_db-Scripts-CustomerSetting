/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20200930@Eden
	Task: Remove 789y from VRAgentProfile [RM#142638]
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO
WHILE 1 = 1
BEGIN
	DELETE TOP (1000) t 
	FROM VRAgentProfile t WITH(ROWLOCK)
	WHERE t.SiteID = 3 AND Type = 1

	IF @@ROWCOUNT = 0
	BREAK;
END