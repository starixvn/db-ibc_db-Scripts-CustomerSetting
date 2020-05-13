/*
	Created: Johnson@20200513
	DB: DBLOG/bodb_CustomerLog
	Task: new logaction for super's prefix for external group [redmine: #105587]	
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
SELECT 	95017,4,'Acc_SuperPefixIns','Add super''s prefix for external group','Add super''s prefix for external group','Add super''s prefix for external group','Add super''s prefix for external group','Add super''s prefix for external group','Add super''s prefix for external group','Add super''s prefix for external group',1,'Add super''s prefix for external group','Add super''s prefix for external group'
UNION SELECT 95018,4,'Acc_SuperPefixDel','Remove super''s prefix for external group','Remove super''s prefix for external group','Remove super''s prefix for external group','Remove super''s prefix for external group','Remove super''s prefix for external group','Remove super''s prefix for external group','Remove super''s prefix for external group',1,'Remove super''s prefix for external group','Remove super''s prefix for external group'