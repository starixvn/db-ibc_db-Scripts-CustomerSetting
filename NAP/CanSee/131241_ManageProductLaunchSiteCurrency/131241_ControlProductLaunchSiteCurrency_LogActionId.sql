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
	,'Add product, sport type and bettype to site'
	,'Add product, sport type and bettype to site'
	,'Add product, sport type and bettype to site'
	,'Add product, sport type and bettype to site'
	,'Add product, sport type and bettype to site'
	,'Add product, sport type and bettype to site'
	,'Add product, sport type and bettype to site'
	,NULL
	,1
	,'Add product, sport type and bettype to site')
	
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
	,'Update product, sport type and bettype to site'
	,'Update product, sport type and bettype to site'
	,'Update product, sport type and bettype to site'
	,'Update product, sport type and bettype to site'
	,'Update product, sport type and bettype to site'
	,'Update product, sport type and bettype to site'
	,'Update product, sport type and bettype to site'
	,NULL
	,1
	,'Update product, sport type and bettype to site')	

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
	,'Delete product, sport type and bettype to site'
	,'Delete product, sport type and bettype to site'
	,'Delete product, sport type and bettype to site'
	,'Delete product, sport type and bettype to site'
	,'Delete product, sport type and bettype to site'
	,'Delete product, sport type and bettype to site'
	,'Delete product, sport type and bettype to site'
	,NULL
	,1
	,'Delete product, sport type and bettype to site')	