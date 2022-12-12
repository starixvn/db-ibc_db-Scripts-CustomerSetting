/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 202211085@Winfred
	Task : CRM - Support Tool for Internal to Update Setting/Config [redmine:#158258]
	DB: DBCRM/bodb_CRM
*/

USE [bodb_CRM]
GO

ALTER TABLE SystemSetting ADD DataType VARCHAR(50) 

UPDATE SystemSetting WITH(ROWLOCK,UPDLOCK) 
SET DataType = CASE  WHEN  CHARINDEX('BatchSize', SettingName) > 0 
						OR CHARINDEX('MsgID', SettingName) > 0 
						OR CHARINDEX('Seq', SettingName) > 0 
						OR CHARINDEX('LogID', SettingName) > 0 
					THEN 'Int32' 
				 WHEN  CHARINDEX('Config', SettingName) > 0 
						OR CHARINDEX('isCredit', SettingName) > 0 
						OR CHARINDEX('isDeposit', SettingName) > 0 
						OR CHARINDEX('ServiceFlag', SettingName) > 0 
						OR CHARINDEX('IncludeUUS', SettingName) > 0 
						OR CHARINDEX('IsSync', SettingName) > 0 
					THEN 'Boolean'
				 WHEN  CHARINDEX('Status', SettingName) > 0 THEN 'String'
				 WHEN  CHARINDEX('Template', SettingName) > 0 THEN 'String'
				 WHEN  CHARINDEX('Runtime', SettingName) > 0 
						OR CHARINDEX('Date', SettingName) > 0
					THEN 'DateTime'
				 ELSE '' END

