/*
	Created: 20190708@Johnson
	Task: insert log action for unlock access cn88
	DB: DBLOG/bodb_CustomerLog
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
SELECT 160010, 4, 'CS_Age_CustomerPwdUpd2'
			,[ActionNameEN]
           ,[ActionNameCH]
           ,[ActionNameCS]
           ,[ActionNameJP]
           ,[ActionNameIT]
           ,[ActionNameTH]
           ,[ActionNameKO]          
           ,[IsInternal]
           ,[ActionNameVI]
           ,[ActionNameCN]
FROM LogAction WITH(NOLOCK)
WHERE ActionID = 902
UNION 
SELECT 160011, 4, 'CS_Age_CustSubPwdUpd2'
			,[ActionNameEN]
           ,[ActionNameCH]
           ,[ActionNameCS]
           ,[ActionNameJP]
           ,[ActionNameIT]
           ,[ActionNameTH]
           ,[ActionNameKO]          
           ,[IsInternal]
           ,[ActionNameVI]
           ,[ActionNameCN]
FROM LogAction WITH(NOLOCK)
WHERE ActionID = 904

