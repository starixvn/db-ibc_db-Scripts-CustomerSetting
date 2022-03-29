/*<info serverAlias=”DBLOG-bodb_CustomerLog” ></info>*/
/*
    Created: Winfred
    Date: 20221803
    Task: Manage Stakelevel: #167128
    DB: DBLOG/bodb_CustomerLog
*/ 
USE bodb_CustomerLog
GO
DELETE FROM LogAction WHERE SPName = 'Acc_InitializingStake_StakelevelIns' AND ActionID = 6063
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
VALUES (
	6063
	,NULL
	,'Acc_InitializingStake_StakelevelIns'
	,'Update Stake Level'
	,'Update Stake Level'
	,'Update Stake Level'
	,'Update Stake Level'
	,'Update Stake Level'
	,'Update Stake Level'
	,'Update Stake Level'
	,NULL
	,1
	,'Update Stake Level'
	,'Update Stake Level')
