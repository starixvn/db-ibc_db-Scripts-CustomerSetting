/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 202112088@Winfred
	Task : config setting for Enable service voingding CRM UAT [redmine:#163833]
	DB: DBCRM/bodb_CRM
*/



USE [bodb_CRM]
GO

UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = '0'
WHERE SettingName = 'ConfigUAT'
	AND ServiceName = 'AutoVoidFB'	


	
UPDATE SystemSetting WITH(UPDLOCK,ROWLOCK)
SET Value = CONVERT( VARCHAR(20),GETDATE(),20)
WHERE SettingName = 'LastDateUAT'
	AND ServiceName = 'AutoVoidFB'		
	
GRANT SELECT ON crmCustomer TO bodbAdminNet;	

