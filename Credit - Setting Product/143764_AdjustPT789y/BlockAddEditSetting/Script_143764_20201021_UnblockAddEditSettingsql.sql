/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20201103@Eden
	Task: Unblock Edit setting and add new customer for 789y [Redmine:#143764]	
	DB: DBCUST/CustDB
*/

USE [CustDB]
GO
DELETE FROM [UMconfig] WITH(ROWLOCK) WHERE ProductID = 0 AND SportType = 0 AND SiteID = 3