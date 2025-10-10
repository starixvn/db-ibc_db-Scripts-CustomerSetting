--VendorAPI
DECLARE	@errorCode int, @errorMsg varchar(100)
EXEC [dbo].[Dot_Intg_VendorAPI_Delete_test] @vendorid = 42, @siteid = 0, @servername = N'OneWorksApiCoreServer', @errorCode = @errorCode OUTPUT, @errorMsg = @errorMsg OUTPUT
EXEC [dbo].[Dot_Intg_VendorAPI_Delete_test] @vendorid = 42, @siteid = 0, @servername = N'OwcwApiServer', @errorCode = @errorCode OUTPUT, @errorMsg = @errorMsg OUTPUT

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

