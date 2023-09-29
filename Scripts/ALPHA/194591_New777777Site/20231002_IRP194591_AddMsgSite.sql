/*<info serverAlias="DBMSG-bodb_Message"></info>*/
/*
	Created: 20231002@Johnson
	Task: Add MsgSite for 777
	DB: DBMSG/bodb_Message
*/


INSERT INTO [dbo].[MsgSite]
           ([SiteId]
           ,[SiteName]
           ,[enable])
SELECT 3600, '777 All', 1
UNION SELECT 3601, '777 Super', 1
UNION SELECT 3602,  '777 Master', 1
UNION SELECT 3603,  '777 Agent', 1