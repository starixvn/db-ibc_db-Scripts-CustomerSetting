/*<info serverAlias="DBSabaPlay-WalletBridgeDB_Admin"></info>*/
/*
	Created: Helios@20251009
	Task: SabaPlay - Integrate new product Vertex Play (VP) [#240871] 
	DB: DBSabaPlay-WalletBridgeDB_Admin
*/

USE WalletBridgeDB_Admin

GO

-- Adjust OperatorGameSetting
EXEC [dbo].[sabaplay_spbu_BA_OperatorGameSetting_Upd] @OperatorId	   = 1
								    , @SubOperatorID = 0
								    , @vendorid	   = 116
								    , @SettingType   = N'OperatorEndPoint'
								    , @ValidatePwd   = NULL
								    , @ValidateKey   = NULL
								    , @url		   = N'http://saba-wallet-group-005.3rd-party.klt2p.gamora.prod:32280/api/VertexPlay'
								    , @OtherInfo	   = NULL