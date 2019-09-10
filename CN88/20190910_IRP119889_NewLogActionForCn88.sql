/*
	Created: 20190910@Johnson
	DB: DBLOG/bodb_CustomerLog
	Task: add new log action for initial statuses for member cn88
*/

INSERT INTO [dbo].[LogAction]
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
SELECT 165013,	5, 'CS_CustomerIns_Ag'
			,[ActionNameEN]
           ,[ActionNameCH]
           ,[ActionNameCS]
           ,[ActionNameJP]
           ,[ActionNameIT]
           ,[ActionNameTH]
           ,[ActionNameKO]
           ,1
		   ,[ActionNameVI]
           ,[ActionNameCN]
FROM LogAction WITH(NOLOCK)
WHERE ActionID = 1103