/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20230510@Johnson
	Task: Add new log action
	DB: DBLOG/bodb_CustomerLog
*/

;WITH T AS (
	SELECT 475 as ActionID, 1 ActionTypeID, 'Acc_LiteMode_CustSetting_CustPTTemplateIns' SPName, 'Add the Position Taking (%) Template for master' ActionNameEN, 0 IsInternal
	UNION SELECT 476, 1, 'Acc_LiteMode_CustSetting_CustPTTemplateUpd', 'Update the Position Taking (%) Template for master',0
	UNION SELECT 477, 1, 'Acc_LiteMode_CustSetting_CustPTTemplateDel', 'Delete the Position Taking (%) Template for master',0
	UNION SELECT 480, 1, 'Acc_LiteMode_CustSetting_CustPTTemplateIns', 'Add the Position Taking (%) Template for agent', 0
	UNION SELECT 481, 1, 'Acc_LiteMode_CustSetting_CustPTTemplateUpd', 'Update the Position Taking (%) Template for agent',0
	UNION SELECT 482, 1, 'Acc_LiteMode_CustSetting_CustPTTemplateDel', 'Delete the Position Taking (%) Template for agent',0
	UNION SELECT 483 , 1, 'Acc_LiteMode_CustSetting_CustPTTemplateIns', 'Add the Position Taking (%) Template for member', 0
	UNION SELECT 484, 1, 'Acc_LiteMode_CustSetting_CustPTTemplateUpd', 'Update the Position Taking (%) Template for member',0
	UNION SELECT 485, 1, 'Acc_LiteMode_CustSetting_CustPTTemplateDel', 'Delete the Position Taking (%) Template for member',0
	UNION SELECT 95088,4,'Acc_LiteMode_CustomerInsMember_SAg','Add all products Settings for master',0
	UNION SELECT 95089,4,'Acc_LiteMode_CustomerInsMember_SAg','Add Compact ProductSettings for master',1
	UNION SELECT 95092,4,'Acc_LiteMode_CustomerInsMember_MAg','Add all products Settings for agent',0 	
	UNION SELECT 95093,4,'Acc_LiteMode_CustomerInsMember_MAg','Add Compact ProductSettings for agent',1
	UNION SELECT 95095,4,'Acc_LiteMode_CustomerInsMember_Ag','Add all products Settings for member',0 
	UNION SELECT 95096,4,'Acc_LiteMode_CustomerInsMember_Ag','Add Compact ProductSettings for member',1
)
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
           ,[XsltContent]
           ,[IsInternal]
           ,[ActionNameVI]
           ,[ActionNameCN])
SELECT ActionID,ActionTypeID,SPName,ActionNameEN,ActionNameEN,ActionNameEN,ActionNameEN,ActionNameEN,ActionNameEN,ActionNameEN,NULL,0,ActionNameEN,ActionNameEN
FROM T
GO

;WITH T AS (
	SELECT 95090 ActionID, 601 Old_ActionID, 'Acc_LiteMode_CustomerInsMember_SAg' SPName
	UNION SELECT 1223, 1210, 'Acc_LiteMode_CustomerInsMember_SAg'
	UNION SELECT 1197, 1101, 'Acc_LiteMode_CustomerInsMember_SAg'
	UNION SELECT 95091, 602, 'Acc_LiteMode_CustomerInsMember_MAg'
	UNION SELECT 1224, 1209, 'Acc_LiteMode_CustomerInsMember_MAg'
	UNION SELECT 1198, 1102, 'Acc_LiteMode_CustomerInsMember_MAg'
	UNION SELECT 95094, 603, 'Acc_LiteMode_CustomerInsMember_Ag'
	UNION SELECT 1225, 1207, 'Acc_LiteMode_CustomerInsMember_Ag'
	UNION SELECT 1199, 1103, 'Acc_LiteMode_CustomerInsMember_Ag'
)
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
           ,[XsltContent]
           ,[IsInternal]
           ,[ActionNameVI]
           ,[ActionNameCN])
SELECT t.ActionID,ActionTypeID,t.SPName,ActionNameEN,ActionNameEN,ActionNameEN,ActionNameEN,ActionNameEN,ActionNameEN,ActionNameEN,NULL,0,ActionNameEN,ActionNameEN
FROM LogAction l
	INNER JOIN T on l.ActionID = t.Old_ActionID
