/*<info serverAlias="DBSabaPlay-WalletBridgeDB_Admin"></info>*/
/*
	Created: Helios@20251009
	Task: SabaPlay - Integrate new product Vertex Play (VP) - HKD Currency - Adjust VendorAgentId - VendorAgentCode [#240871]  
	DB: DBSabaPlay-WalletBridgeDB_Admin 
*/

USE WalletBridgeDB_Admin

GO

IF EXISTS (SELECT 1 FROM VendorAgentInfo vai WITH(NOLOCK) WHERE vai.VendorId = 116 AND vai.VendorAgentId = 4200000 AND vai.VendorAgentKey = 5 AND vai.VendorAgentCode = 'Cash')
BEGIN
	EXEC [dbo].[BA_VendorAgentInfo_Del] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4200000', @VendorAgentKey = N'5', @VendorAgentCode = N'Cash'	
END

EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId	     = 1
					    , @VendorId	     = 116
					    , @VendorAgentId   = N'4100200'
					    , @VendorAgentKey  = N'5'
					    , @VendorAgentCode = N'Credit'
					    , @VendorAgentType = N'SABA'
					    , @RefName	     = N'n01hkd'
					    , @RefKey	     = N'aZwny1vc+5mMGcKYoo2WS/0S/0NqcRjI'
					    , @RefCode	     = N'HKD'
					    , @Note		     ='64bba4fe'