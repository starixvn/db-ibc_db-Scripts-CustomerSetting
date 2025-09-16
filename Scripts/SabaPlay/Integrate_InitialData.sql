-- Insert GlobCustDB.dbo.Intg_VendorAPI table
DECLARE @return_value int, @ErrCode int, @ErrMsg varchar(100)
EXEC @return_value = [dbo].[Dot_Intg_VendorAPI_Insert] @vendorid = 42, @siteid = 0, @servername = N'SabaClubApiServer', @url = N'http://l1api.sc-sit.nebula.sit/{0}/{1}', @logincode = 'ONEworks1', @loginpwd = '123licensee1%^&sit', @DesKey = NULL, @MD5Key = NULL, @ErrCode = @ErrCode OUTPUT, @ErrMsg = @ErrMsg OUTPUT
EXEC @return_value = [dbo].[Dot_Intg_VendorAPI_Insert] @vendorid = 42, @siteid = 0, @servername = N'SabaClubResultServer', @url = N'http://l1result.sc-sit.nebula.sit/{0}/{1}', @logincode = 'ONEworks1', @loginpwd = '123licensee1%^&sit', @DesKey = NULL, @MD5Key = NULL, @ErrCode = @ErrCode OUTPUT, @ErrMsg = @ErrMsg OUTPUT
SELECT  @ErrCode as N'@ErrCode', @ErrMsg as N'@ErrMsg'
SELECT  'Return Value' = @return_value

-- Insert GameVendorInfo table
EXEC [dbo].[BA_GameVendorInfo_Ins] @VendorId = 42, @VendorName = N'SabaClub', @GameType = N'SabaClub'
DECLARE @OperatorProductSettingId int, @ErrCode int, @ErrMsg varchar(100) EXEC [dbo].[AP_BO_OperatorProductSetting_Ins] @OperatorInfoId = 1, @OperatorId = 1, @SubOperatorId = 0, @VendorId = 42, @FirstBillingDate = NULL, @BasisOfBilling = NULL, @ChargeTypeId = 1, @ChargeOnId = 1, @FromDate = N'2024-10-23', @ToDate = N'2050-12-31', @OperatorProductSettingId = @OperatorProductSettingId OUTPUT, @ErrCode = @ErrCode OUTPUT, @ErrMsg = @ErrMsg OUTPUT
DECLARE @OperatorPositionTakingId int, @ErrCode int, @ErrMsg varchar(100) EXEC [dbo].[AP_BO_OperatorPositionTaking_Ins] @OperatorProductSettingId = 492, @CurrencyISO = N'ALL', @PositionTaking = 0, @OperatorPositionTakingId = @OperatorPositionTakingId OUTPUT, @ErrCode = @ErrCode OUTPUT, @ErrMsg = @ErrMsg OUTPUT

-- Insert VendorAgentInfo table
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 42, @VendorAgentId = N'', @VendorAgentKey = N'', @VendorAgentCode = N'Credit', @VendorAgentType = N'SABA', @RefName = N'ONEworks1',@RefKey = N'123licensee1%^&sit', @RefCode = N''

-- Insert OperatorGameSetting table
EXEC [dbo].[BA_OperatorGameSetting_Ins] @OperatorId = 1, @VendorId = 42, @SettingType = N'OperatorEndPoint', @ValidatePwd = NULL, @ValidateKey = NULL, @Url = N'http://owapi1.playonesit.com:7133/api/SabaClub', @OtherInfo = NULL
EXEC [dbo].[BA_OperatorGameSetting_Ins] @OperatorId = 1, @VendorId = 42, @SettingType = N'VendorEndPoint_General', @ValidatePwd = NULL, @ValidateKey = NULL, @Url = N'http://l1api.sc-sit.nebula.sit', @OtherInfo = NULL
EXEC [dbo].[BA_OperatorGameSetting_Ins] @OperatorId = 1, @VendorId = 42, @SettingType = N'VendorEndPoint_Result', @ValidatePwd = NULL, @ValidateKey = NULL, @Url = N'http://l1result.sc-sit.nebula.sit', @OtherInfo = NULL


