/*
	Created: 20190613@Johnson
	DB: DBLOG/bodb_CustomerLog
	Task: new log action for kickout member
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
SELECT 	1331,NULL,'Age_OnUser_ForceKickedout','Kick out member','Kick out member','Kick out member','Kick out member','Kick out member','Kick out member','Kick out member',0,'Kick out member','Kick out member'

