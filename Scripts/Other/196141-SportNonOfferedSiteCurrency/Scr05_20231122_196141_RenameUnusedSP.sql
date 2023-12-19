/*<info serverAlias="DBCUST-CustDB,DBACC-bodb02"></info>*/

/*
	Created: 20231219@Tacy
	Task: Rename unused SP
		 https://nexdev.net/issues/196141
	Database: DBCUST-CustDB,DBACC-bodb02
*/
EXEC sp_rename 'Acc_CustSetting_CheckMacauEnable', 'DEL_Acc_CustSetting_CheckMacauEnable', 'Object'
GO 