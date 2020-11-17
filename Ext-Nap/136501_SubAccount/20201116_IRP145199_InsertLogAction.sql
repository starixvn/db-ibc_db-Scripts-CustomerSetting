/*
	Created: Johnson@20201116
	DB: DBLOG/bodb_CustomerLog
	Task: new logaction for sub group for external group [redmine: #145199]	
*/
INSERT INTO [bodb_CustomerLog].[dbo].[LogAction]
           ([ActionID]
           ,[ActionTypeID]
           ,[SPName]
           ,[ActionNameEN]
           ,[ActionNameCH]
           ,[ActionNameCS]
           ,[ActionNameJP]
           ,[ActionNameIT]
           ,[ActionNameTH]
           ,[ActionNameKO]           
           ,[IsInternal]
           ,[ActionNameVI]
           ,[ActionNameCN])
SELECT 	20302,NULL,'EAS_UserInfoUpdSubGroupAdminPwd','Update sub group admin''s password','Update sub group admin''s password','Update sub group admin''s password','Update sub group admin''s password','Update sub group admin''s password','Update sub group admin''s password','Update sub group admin''s password',1,'Update sub group admin''s password','Update sub group admin''s password'
