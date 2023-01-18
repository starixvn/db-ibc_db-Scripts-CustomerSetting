/*<info serverAlias="DBCUST-NAP_UserControl"></info>*/

/*
	Created: 20221104@Tacy
	Task: Add column ExpiredDate on table AccCustomer
		 https://nexdev.net/issues/179323 [RedmineID: #179323]
	Database: DBCUST/NAP_UserControl
*/

USE NAP_UserControl
GO

ALTER TABLE AccCustomer ADD ExpiredDate [datetime] NULL;