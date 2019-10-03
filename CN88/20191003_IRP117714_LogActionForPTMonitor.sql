/*
	Created: 20191003@Johnson
	DB: DBLOG/bodb_CustomerLog
	Task: add new log action for initial statuses for member cn88
*/

INSERT INTO [dbo].[LogAction]ss
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
SELECT 1171, 5, 'CS_Customer_MonitorPT_Upd', N'Update possess monitor status', N'Update possess monitor status', N'Update possess monitor status', N'Update possess monitor status', N'Update possess monitor status', N'Update possess monitor status', N'Update possess monitor status',	1, N'Update possess monitor status', N'Update possess monitor status'		   

