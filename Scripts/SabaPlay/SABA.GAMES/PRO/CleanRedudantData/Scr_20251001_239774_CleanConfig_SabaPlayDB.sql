/*<info serverAlias="DBSABAPLAY-WalletBridgeDB_Admin"></info>*/ 
/*
	Created: Eden@20251001
	Task: Clean config for SABA.GAMES on SABAPLAY - redudant data[#239774]
	DB: DBSABAPLAY-WalletBridgeDB_Admin
*/
USE WalletBridgeDB_Admin
GO
--OperatorGameSetting
EXEC [dbo].[BA_OperatorGameSetting_Del] @OperatorId = 1,@SubOperatorID = 0, @VendorId = 42, @SettingType = N'OperatorEndPoint'
EXEC [dbo].[BA_OperatorGameSetting_Del] @OperatorId = 1,@SubOperatorID = 0, @VendorId = 42, @SettingType = N'VendorEndPoint_General'
EXEC [dbo].[BA_OperatorGameSetting_Del] @OperatorId = 1,@SubOperatorID = 0, @VendorId = 42, @SettingType = N'VendorEndPoint_Result'
GO

--VendorAgentInfo
EXEC [dbo].[BA_VendorAgentInfo_Del] @OperatorId = 1, @VendorId = 42, @VendorAgentId = N'', @VendorAgentKey = N'', @VendorAgentCode = N'Credit'
GO

--GameVendorInfo
EXEC [dbo].[BA_GameVendorInfo_Del] @VendorId = 42

--OperatorProductSetting
DECLARE  @ErrCode int, @ErrMsg varchar(100)
EXEC [dbo].[AP_BO_OperatorProductSetting_Del] 
	  @OperatorProductSettingId = 492
	, @ErrCode = @ErrCode OUTPUT, @ErrMsg = @ErrMsg OUTPUT
SELECT @ErrCode, @ErrMsg
GO

--OperatorPositionTaking
DECLARE  @ErrCode int, @ErrMsg varchar(100)
EXEC [dbo].[AP_BO_OperatorPositionTaking_Del] 
  @OperatorPositionTakingId = 531
, @ErrCode = @ErrCode OUTPUT, @ErrMsg = @ErrMsg OUTPUT
GO

