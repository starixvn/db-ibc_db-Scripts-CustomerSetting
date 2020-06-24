/*<info serverAlias=”DBLOG-bodb_CustomerLog” ></info>*/
/*
    Created: Winfred
    Date: 20200623
    Task: Manage ProductLaunchSiteCurrency / Can See : #131241
    DB: DBLOG/bodb_CustomerLog
*/ 
USE bodb_CustomerLog
GO

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
	,[ActionNameVI])
VALUES (
	6060
	,NULL
	,'Acc_ManageCansee_Ins'
	,'Insert Cansee'
	,'Insert Cansee'
	,'Insert Cansee'
	,'Insert Cansee'
	,'Insert Cansee'
	,'Insert Cansee'
	,'Insert Cansee'
	,NULL
	,1
	,'Insert Cansee')
	
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
	,[ActionNameVI])
VALUES (
	6061
	,NULL
	,'Acc_ManageCansee_Upd'
	,'Update Cansee'
	,'Update Cansee'
	,'Update Cansee'
	,'Update Cansee'
	,'Update Cansee'
	,'Update Cansee'
	,'Update Cansee'
	,NULL
	,1
	,'Update Cansee')	

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
	,[ActionNameVI])
VALUES (
	6062
	,NULL
	,'Acc_ManageCansee_Del'
	,'Delete Cansee'
	,'Delete Cansee'
	,'Delete Cansee'
	,'Delete Cansee'
	,'Delete Cansee'
	,'Delete Cansee'
	,'Delete Cansee'
	,NULL
	,1
	,'Delete Cansee')	