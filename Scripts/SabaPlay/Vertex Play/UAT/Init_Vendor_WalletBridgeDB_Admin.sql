/*<info serverAlias="DBSabaPlay-WalletBridgeDB_Admin"></info>*/
/*
	Created: Helios@20251009
	Task: SabaPlay - Integrate new product Vertex Play (VP) [#240871] 
	DB: DBSabaPlay-WalletBridgeDB_Admin
*/

USE WalletBridgeDB_Admin

GO

-- Insert VendorAgentInfo
/* Waiting Vendor */

-- Insert OperatorGameSetting
EXEC [dbo].[BA_OperatorGameSetting_Ins] @OperatorId  = 1
						  , @VendorId    = 116
						  , @SettingType = N'OperatorEndPoint'
						  , @ValidatePwd = NULL
						  , @ValidateKey = NULL
						  , @Url	     = N'http://saba-wallet-group-preprod.3rd-party.klt2p.gamora.prod:32280/api/VertexPlay'
						  , @OtherInfo   = NULL

/* Waiting Vendor 
EXEC [dbo].[BA_OperatorGameSetting_Ins] @OperatorId  = 1
						  , @VendorId    = 116
						  , @SettingType = N'VendorEndPoint_General_Credit'
						  , @ValidatePwd = NULL
						  , @ValidateKey = NULL
						  , @Url	     = N''
						  , @OtherInfo   = NULL
EXEC [dbo].[BA_OperatorGameSetting_Ins] @OperatorId  = 1
						  , @VendorId    = 116
						  , @SettingType = N'VendorEndPoint_General_Cash'
						  , @ValidatePwd = NULL
						  , @ValidateKey = NULL
						  , @Url	     = N''
						  , @OtherInfo   = NULL

Waiting Vendor */
