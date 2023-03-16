/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230316@Tacy
	Task: NAP/Alpha/Ext - Saba Games shows on not offer sites
		 https://nexdev.net/issues/185168 [RedmineID: #185168]
	Database: DBCUST/CustDB
*/
/*
	- ProductStatusSiteCurrency
*/
USE CustDB
GO

UPDATE ProductStatusSiteCurrency WITH (ROWLOCK, UPDLOCK)
SET IsHidden=1
WHERE SportType=200 AND SiteID<>3 AND IsHidden=0