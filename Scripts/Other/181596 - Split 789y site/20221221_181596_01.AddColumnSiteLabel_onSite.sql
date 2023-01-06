/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221221@Tacy
	Task: 01. Add column SiteLabel on table Site
		 https://nexdev.net/issues/181596 [RedmineID: #181596]
	Database: DBCUST/CustDB
*/

USE CustDB
GO

ALTER TABLE [dbo].[Site] ADD SiteLabel VARCHAR(50) NULL;