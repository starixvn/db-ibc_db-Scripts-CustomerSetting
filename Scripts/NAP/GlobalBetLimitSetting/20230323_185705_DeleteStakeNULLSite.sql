/*<info serverAliAS="DBCUST-CustDB"></info>*/
/*
	Created: 20230323@Tacy
	Task: Delete - SiteID's Dep_StakeLevel is NULL
		https://nexdev.net/issues/185705
*/
USE CustDB
GO

DELETE FROM Dep_StakeLevel WITH (ROWLOCK, UPDLOCK)
WHERE SiteID IS NULL and GameGroupID=0