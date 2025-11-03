/*<info serverAlias="DBSabaPlay-WalletBridgeDB_Admin"></info>*/
/*
	Created: Helios@20251009
	Task: SabaPlay - Integrate new product Vertex Play (VP) - HKD Currency [#240871]  
	DB: DBSabaPlay-WalletBridgeDB_Admin
*/

USE WalletBridgeDB_Admin

GO

EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId	     = 1
					    , @VendorId	     = 116
					    , @VendorAgentId   = N'4200000'
					    , @VendorAgentKey  = N'5'
					    , @VendorAgentCode = N'Cash'
					    , @VendorAgentType = N'SABA'
					    , @RefName	     = N'n01hkd'
					    , @RefKey	     = N'aZwny1vc+5mMGcKYoo2WS/0S/0NqcRjI'
					    , @RefCode	     = N'HKD'
					    , @Note		     ='64bba4fe'