/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*	
	Created: 20230720@Helios
	Task: Add Acction Log For VR+ Accumulate Balance [#189649]
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
           ,[XsltContent]
           ,[IsInternal]
           ,[ActionNameVI]
           ,[ActionNameCN])

SELECT  '839',
		'4',
		'Acc_VRCustLockStatusUpd',
		'Update VR Accumulated Balance Status',
		'Update VR Accumulated Balance Status',
		'Update VR Accumulated Balance Status',
		'Update VR Accumulated Balance Status',
		'NULL',
		'Update VR Accumulated Balance Status',
		'Update VR Accumulated Balance Status',
		'NULL',
		'1',
		'Update VR Accumulated Balance Status',
		'Update VR Accumulated Balance Status'