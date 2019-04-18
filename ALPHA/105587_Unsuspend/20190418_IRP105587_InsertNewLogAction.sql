/*
	Created: Johnson@20190418
	DB: DBLOG/bodb_CustomerLog
	Task: new logaction for suspendinfo [redmine: #105587]	
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
SELECT 	65018,5,'Acc_CustomerUpdSuspended',N'Update Suspended status on Super',N'Update Suspended status on Super',N'Update Suspended status on Super',N'Update Suspended status on Super',N'Update Suspended status on Super',N'Update Suspended status on Super',N'Update Suspended status on Super',0,N'Update Suspended status on Super',N'Update Suspended status on Super'
UNION SELECT 70027,5,'Acc_CustomerUpdSuspended',N'Update Suspended status on Super',N'Update Suspended status on Super',N'Update Suspended status on Super',N'Update Suspended status on Super',N'Update Suspended status on Super',N'Update Suspended status on Super',N'Update Suspended status on Super',0,N'Update Suspended status on Super',N'Update Suspended status on Super'
UNION SELECT 70028,5,'Acc_CustomerUpdSuspended',N'Update Suspended status on Master',N'Update Suspended status on Master',N'Update Suspended status on Master',N'Update Suspended status on Master',N'Update Suspended status on Master',N'Update Suspended status on Master',N'Update Suspended status on Master',0,N'Update Suspended status on Master',N'Update Suspended status on Master'
UNION SELECT 75036,5,'Acc_CustomerUpdSuspended',N'Update Suspended status on Super',N'Update Suspended status on Super',N'Update Suspended status on Super',N'Update Suspended status on Super',N'Update Suspended status on Super',N'Update Suspended status on Super',N'Update Suspended status on Super',0,N'Update Suspended status on Super',N'Update Suspended status on Super'
UNION SELECT 75037,5,'Acc_CustomerUpdSuspended',N'Update Suspended status on Master',N'Update Suspended status on Master',N'Update Suspended status on Master',N'Update Suspended status on Master',N'Update Suspended status on Master',N'Update Suspended status on Master',N'Update Suspended status on Master',0,N'Update Suspended status on Master',N'Update Suspended status on Master'
UNION SELECT 75038,5,'Acc_CustomerUpdSuspended',N'Update Suspended status on Agent',N'Update Suspended status on Agent',N'Update Suspended status on Agent',N'Update Suspended status on Agent',N'Update Suspended status on Agent',N'Update Suspended status on Agent',N'Update Suspended status on Agent',0,N'Update Suspended status on Agent',N'Update Suspended status on Agent'
