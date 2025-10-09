/*<info serverAlias="DBSabaPlay-WalletBridgeDB_Admin"></info>*/ 
/*
	Created: Helios@20251009
	Task: SabaPlay - Integrate new product Vertex Play (VP) [#240871]
	DB: DBSabaPlay-WalletBridgeDB_Admin
*/

USE WalletBridgeDB_Admin

GO
-- Insert VendorAgentInfo
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100200', @VendorAgentKey = N'20', @VendorAgentCode = N'Credit', @VendorAgentType = N'n01usd', @RefName = N'SABAN01',@RefKey = N'kooacd3Hpj4OPWr48eDLRHzGQBZ3zhW1', @RefCode = N'USD'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100200', @VendorAgentKey = N'2', @VendorAgentCode = N'Credit', @VendorAgentType = N'n01myr', @RefName = N'SABAN01',@RefKey = N'kooacd3Hpj5n3qEBIdQQ1thDuaEP+xrn', @RefCode = N'MYR'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100200', @VendorAgentKey = N'67', @VendorAgentCode = N'Credit', @VendorAgentType = N'n01myr', @RefName = N'SABAN01',@RefKey = N'kooacd3Hpj5n3qEBIdQQ1thDuaEP+xrn', @RefCode = N'MYR'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100200', @VendorAgentKey = N'3', @VendorAgentCode = N'Credit', @VendorAgentType = N'n01usd', @RefName = N'SABAN01',@RefKey = N'kooacd3Hpj4OPWr48eDLRHzGQBZ3zhW1', @RefCode = N'USD'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100200', @VendorAgentKey = N'6', @VendorAgentCode = N'Credit', @VendorAgentType = N'n01eur', @RefName = N'SABAN01',@RefKey = N'kooacd3Hpj5ky8mJJmuOQn8ZLTPnQ74D', @RefCode = N'EUR'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100200', @VendorAgentKey = N'13', @VendorAgentCode = N'Credit', @VendorAgentType = N'n01cny', @RefName = N'SABAN01',@RefKey = N'kooacd3Hpj5Hu6VKnUfLva/c6lxCpPIi', @RefCode = N'CNY'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100200', @VendorAgentKey = N'15', @VendorAgentCode = N'Credit', @VendorAgentType = N'n01idr', @RefName = N'SABAN01',@RefKey = N'kooacd3Hpj5nsEo8eyFHxMPjzvjvo1jH', @RefCode = N'IDR'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100200', @VendorAgentKey = N'22', @VendorAgentCode = N'Credit', @VendorAgentType = N'n01idr', @RefName = N'SABAN01',@RefKey = N'kooacd3Hpj5nsEo8eyFHxMPjzvjvo1jH', @RefCode = N'IDR'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100200', @VendorAgentKey = N'33', @VendorAgentCode = N'Credit', @VendorAgentType = N'n01idr', @RefName = N'SABAN01',@RefKey = N'kooacd3Hpj5nsEo8eyFHxMPjzvjvo1jH', @RefCode = N'IDR'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100200', @VendorAgentKey = N'47', @VendorAgentCode = N'Credit', @VendorAgentType = N'n01idr', @RefName = N'SABAN01',@RefKey = N'kooacd3Hpj5nsEo8eyFHxMPjzvjvo1jH', @RefCode = N'IDR'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100200', @VendorAgentKey = N'43', @VendorAgentCode = N'Credit', @VendorAgentType = N'n01thb', @RefName = N'SABAN01',@RefKey = N'kooacd3Hpj5Zo+vx0VfBzdK7ZYpZ3+1T', @RefCode = N'THB'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100200', @VendorAgentKey = N'45', @VendorAgentCode = N'Credit', @VendorAgentType = N'n01krw', @RefName = N'SABAN01',@RefKey = N'kooacd3Hpj4wlf/vbHduM/2mA5Dsu2yP', @RefCode = N'KRW'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100200', @VendorAgentKey = N'51', @VendorAgentCode = N'Credit', @VendorAgentType = N'n01vnd', @RefName = N'SABAN01',@RefKey = N'kooacd3Hpj7A1rQAR1Q1kZzkYbSs5d2X', @RefCode = N'VND'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4100200', @VendorAgentKey = N'69', @VendorAgentCode = N'Credit', @VendorAgentType = N'n01mmk', @RefName = N'SABAN01',@RefKey = N'kooacd3Hpj5n3qEBIdQQ1pfV0G8fU3v7', @RefCode = N'MMK'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4200000', @VendorAgentKey = N'20', @VendorAgentCode = N'Cash', @VendorAgentType = N'l01usd', @RefName = N'SABAL01',@RefKey = N'kooacd3Hpj6hldGwrBpxOFdonFDKitwM', @RefCode = N'USD'
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 116, @VendorAgentId = N'4200000', @VendorAgentKey = N'51', @VendorAgentCode = N'Cash', @VendorAgentType = N'l01vnd', @RefName = N'SABAL01',@RefKey = N'kooacd3Hpj757txImEt+CXWnDNGJ4yDR', @RefCode = N'VND'


-- Insert OperatorGameSetting
EXEC [dbo].[BA_OperatorGameSetting_Ins] @OperatorId = 1, @VendorId = 116, @SettingType = N'OperatorEndPoint', @ValidatePwd = NULL, @ValidateKey = NULL, @Url = N'http://172.16.4.41:7137/api/VertexPlay', @OtherInfo = NULL
EXEC [dbo].[BA_OperatorGameSetting_Ins] @OperatorId = 1, @VendorId = 116, @SettingType = N'VendorEndPoint_General_Credit', @ValidatePwd = NULL, @ValidateKey = NULL, @Url = N'https://0f2662b9.xprogame.com/', @OtherInfo = NULL
EXEC [dbo].[BA_OperatorGameSetting_Ins] @OperatorId = 1, @VendorId = 116, @SettingType = N'VendorEndPoint_General_Cash', @ValidatePwd = NULL, @ValidateKey = NULL, @Url = N'https://ac4c632a.xprogame.com/', @OtherInfo = NULL


-- Insert GameVendorInfo
EXEC [dbo].[BA_GameVendorInfo_Ins] @VendorId = 116, @VendorName = N'Vertex Play', @GameType = N'Vertex Play'


-- Insert OperatorProductSetting
DECLARE @OperatorProductSettingId int, @ErrCode int, @ErrMsg varchar(100)
EXEC [dbo].[AP_BO_OperatorProductSetting_Ins] @OperatorInfoId = 1, @OperatorId = 1, @SubOperatorId = 0, @VendorId = 116, @FirstBillingDate = NULL, @BasisOfBilling = NULL, @ChargeTypeId = 1, @ChargeOnId = 1, @FromDate = N'2024-10-23', @ToDate = N'2050-12-31', @OperatorProductSettingId = @OperatorProductSettingId OUTPUT, @ErrCode = @ErrCode OUTPUT, @ErrMsg = @ErrMsg OUTPUT
SELECT @ErrCode , @ErrMsg , @OperatorProductSettingId

-- Insert OperatorPositionTaking : xxx Get values ID identity from param @OperatorProductSettingId Output From Insert OperatorProductSetting
DECLARE @OperatorPositionTakingId int, @ErrCode int, @ErrMsg varchar(100)
EXEC [dbo].[AP_BO_OperatorPositionTaking_Ins] @OperatorProductSettingId = xxx, @CurrencyISO = N'ALL', @PositionTaking = 0.00, @OperatorPositionTakingId = @OperatorPositionTakingId OUTPUT, @ErrCode = @ErrCode OUTPUT, @ErrMsg = @ErrMsg OUTPUT
SELECT @ErrCode , @ErrMsg , @OperatorPositionTakingId