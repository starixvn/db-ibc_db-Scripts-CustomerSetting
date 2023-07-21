/*<info serverAlias="DBCUST-CustDB"></info>*/

/*	
	Created: 20230703@Tacy
	Task: Drop all unused SPs - NG2
	Redmine: https://nexdev.net/issues/189762
	DB: DBCUST-CustDB
*/

USE CUSTDB
GO 


DROP PROCEDURE DEL_Acc_CustSetting_SyncAPICustomerProfileSelect_CustID 
GO

DROP PROCEDURE DEL_Acc_CustSetting_SyncAPICustomerProfileSelect_Site 
GO

DROP PROCEDURE DEL_Acc_CustSetting_SyncAPICustomerProfileSelect_UserName 
GO

DROP PROCEDURE DEL_Acc_ExchangeSel_byCurrencyName 
GO

DROP PROCEDURE DEL_Acc_ExchangeSel_Sync_NG2 
GO
DROP PROCEDURE Acc_ExchangeSel_Sync_NG2_xpre 
GO