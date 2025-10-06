/*<info serverAlias="DBSABAPLAY-WalletBridgeDB_Admin"></info>*/ 
/*
	Created: Eden@20251001
	Task: Init config for SABA.GAMES on SABAPLAY - PRODUCTION [#239774]
	DB: DBSABAPLAY-WalletBridgeDB_Admin
*/
USE WalletBridgeDB_Admin
GO
--Insert OperatorGameSetting table
EXEC [dbo].[BA_OperatorGameSetting_Upd] @OperatorId = 1, @VendorId = 42, @SettingType = N'VendorEndPoint_General', @ValidatePwd = NULL, @ValidateKey = NULL, @Url = N'http://sg-intapi.vn-sc-klprod.gamora.prod', @OtherInfo = NULL, @SubOperatorId = 0
EXEC [dbo].[BA_OperatorGameSetting_Upd] @OperatorId = 1, @VendorId = 42, @SettingType = N'VendorEndPoint_Result', @ValidatePwd = NULL, @ValidateKey = NULL, @Url = N'http://sg-intresult.vn-sc-klprod.gamora.prod', @OtherInfo = NULL, @SubOperatorId = 0

/*
SELECT * FROM OperatorGameSetting WITH(NOLOCK) WHERE vendorid = 42 AND OperatorId = 1
*/