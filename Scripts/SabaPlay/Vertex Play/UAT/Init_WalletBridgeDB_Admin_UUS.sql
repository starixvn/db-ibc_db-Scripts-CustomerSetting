/*<info serverAlias="DBSabaPlay-WalletBridgeDB_Admin"></info>*/
/*
	Created: Helios@20251009
	Task: SabaPlay - Integrate new product Vertex Play (VP) - Adjust UUS for test [#240871] 
	DB: DBSabaPlay-WalletBridgeDB_Admin
*/

USE WalletBridgeDB_Admin

GO

-- Adjust UUS - Credit

EXEC [dbo].[BA_VendorAgentInfo_Upd] @OperatorId	     = 1
					    , @VendorId	     = 116
					    , @VendorAgentId   = N'4100200'
					    , @VendorAgentKey  = N'72'
					    , @VendorAgentCode = N'Credit'
					    , @VendorAgentType = N'SABA'
					    , @RefName	     = N'testvnd1'
					    , @RefKey	     = N'aZwny1vc+5mMS3aBsjFGxw1N4xtLt+V3'
					    , @RefCode	     = N'VND1'
					    , @Note		     ='542af364'
EXEC [dbo].[BA_VendorAgentInfo_Upd] @OperatorId	     = 1
					    , @VendorId	     = 116
					    , @VendorAgentId   = N'4100900'
					    , @VendorAgentKey  = N'72'
					    , @VendorAgentCode = N'Credit'
					    , @VendorAgentType = N'SABA'
					    , @RefName	     = N'testvnd1'
					    , @RefKey	     = N'aZwny1vc+5mMS3aBsjFGxw1N4xtLt+V3'
					    , @RefCode	     = N'VND1'
					    , @Note		     ='542af364'
EXEC [dbo].[BA_VendorAgentInfo_Upd] @OperatorId	     = 1
					    , @VendorId	     = 116
					    , @VendorAgentId   = N'4100300'
					    , @VendorAgentKey  = N'72'
					    , @VendorAgentCode = N'Credit'
					    , @VendorAgentType = N'SABA'
					    , @RefName	     = N'testvnd1'
					    , @RefKey	     = N'aZwny1vc+5mMS3aBsjFGxw1N4xtLt+V3'
					    , @RefCode	     = N'VND1'
					    , @Note		     ='542af364'

-- Add UUS - Cash

EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId	     = 1
					    , @VendorId	     = 116
					    , @VendorAgentId   = N'4200000'
					    , @VendorAgentKey  = N'20'
					    , @VendorAgentCode = N'Cash'
					    , @VendorAgentType = N'SABA'
					    , @RefName	     = N'testvnd1'
					    , @RefKey	     = N'aZwny1vc+5mMS3aBsjFGxw1N4xtLt+V3'
					    , @RefCode	     = N'VND1'
					    , @Note		     ='542af364'