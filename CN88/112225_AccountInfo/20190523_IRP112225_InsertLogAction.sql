/*
	Created: 20190523@Johnson
	Task: insert log action for unlock access cn88
	DB: DBLOG/bodb_CustomerLog
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
SELECT 1169, 5, 'CS_Acc_CustomerUpdUnlockAccess',N'Unlock access status'	,N'Unlock access status',N'Unlock access status',N'Unlock access status',N'Unlock access status',N'Unlock access status',N'Unlock access status',0,N'Unlock access status',N'Unlock access status'

