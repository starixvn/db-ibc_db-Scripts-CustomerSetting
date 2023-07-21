/*<info serverAlias="DBCUST-CustDB"></info>*/
/*	
	Created: 20230703@Tacy
	Task: Rename unused SPs - NG2
	Redmine: https://nexdev.net/issues/189762
	DB: DBCUST-CustDB
*/
USE CustDB
GO 

EXEC sp_rename 'Acc_CustSetting_SyncAPICustomerProfileSelect_CustID',	'DEL_Acc_CustSetting_SyncAPICustomerProfileSelect_CustID','Object'
GO 
EXEC sp_rename 'Acc_CustSetting_SyncAPICustomerProfileSelect_Site',	    'DEL_Acc_CustSetting_SyncAPICustomerProfileSelect_Site','Object'
GO
EXEC sp_rename 'Acc_CustSetting_SyncAPICustomerProfileSelect_UserName', 'DEL_Acc_CustSetting_SyncAPICustomerProfileSelect_UserName','Object'
GO
EXEC sp_rename 'Acc_ExchangeSel_byCurrencyName',						'DEL_Acc_ExchangeSel_byCurrencyName','Object'
GO
EXEC sp_rename 'Acc_ExchangeSel_Sync_NG2',								'DEL_Acc_ExchangeSel_Sync_NG2','Object'
GO