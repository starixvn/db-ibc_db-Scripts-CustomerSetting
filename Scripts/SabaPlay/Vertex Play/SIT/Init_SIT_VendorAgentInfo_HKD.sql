/*<info serverAlias="DBSabaPlay-WalletBridgeDB_Admin"></info>*/
/*
	Created: Helios@20251009
	Task: SabaPlay - Integrate new product Vertex Play (VP) - HKD Currency [#240871] 
	DB: DBSabaPlay-WalletBridgeDB_Admin
*/

EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId	     = 1
					    , @VendorId	     = 116
					    , @VendorAgentId   = N'4100200'
					    , @VendorAgentKey  = N'5'
					    , @VendorAgentCode = N'Credit'
					    , @VendorAgentType = N'SABA'
					    , @RefName	     = N'n01hkd'
					    , @RefKey	     = N'kooacd3Hpj5reSZwd22QFKwWKLMktrfl'
					    , @RefCode	     = N'HKD'
					    , @Note		     ='0f2662b9'