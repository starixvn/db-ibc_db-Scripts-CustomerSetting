/*
	Created: Winnie
	Date: 20190828
	Task: CRM - Insert 2 status. RedmineID: #119163
	DB: DBCRM/bodb_CRM
*/
DECLARE @ID INT
SELECT @ID=MAX(SettingID) FROM crmSetting WITH(NOLOCK) WHERE SettingName='Status'
INSERT INTO [bodb_CRM].[dbo].[crmSetting]
           ([SettingName]
           ,[SettingID]
           ,[SettingValue]
           ,[DisplayOrder]
           ,[IsActive]
           ,[SiteOffer]
       )
     VALUES
           ('Status'
           ,@ID+1
           ,'Revised'
           ,13
           ,1
           ,2
        )
INSERT INTO [bodb_CRM].[dbo].[crmSetting]
           ([SettingName]
           ,[SettingID]
           ,[SettingValue]
           ,[DisplayOrder]
           ,[IsActive]
           ,[SiteOffer]
       )
     VALUES
           ('Status'
           ,@ID+2
           ,'In Progress'
           ,12
           ,1
           ,2
           )