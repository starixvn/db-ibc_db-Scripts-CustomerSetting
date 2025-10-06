/*<info serverAlias="DBSABAPLAY-WalletBridgeDB_Admin"></info>*/ 
/*
	Created: Eden@20251001
	Task: Init config for SABA.GAMES on SABAPLAY[#239774]
	DB: DBSABAPLAY-WalletBridgeDB_Admin
*/
USE WalletBridgeDB_Admin
GO
------------------------SABAPLAY DB----------------------------------------------------
-- Insert GameVendorInfo table
EXEC [dbo].[BA_GameVendorInfo_Ins] @VendorId = 42, @VendorName = N'SabaClub', @GameType = N'SabaClub'
DECLARE @OperatorProductSettingId int, @ErrCode int, @ErrMsg varchar(100) EXEC [dbo].[AP_BO_OperatorProductSetting_Ins] @OperatorInfoId = 1, @OperatorId = 1, @SubOperatorId = 0, @VendorId = 42, @FirstBillingDate = NULL, @BasisOfBilling = NULL, @ChargeTypeId = 1, @ChargeOnId = 1, @FromDate = N'2024-10-23', @ToDate = N'2050-12-31', @OperatorProductSettingId = @OperatorProductSettingId OUTPUT, @ErrCode = @ErrCode OUTPUT, @ErrMsg = @ErrMsg OUTPUT
DECLARE @OperatorPositionTakingId int, @ErrCode2 int, @ErrMsg2 varchar(100) EXEC [dbo].[AP_BO_OperatorPositionTaking_Ins] @OperatorProductSettingId = @OperatorProductSettingId, @CurrencyISO = N'ALL', @PositionTaking = 0, @OperatorPositionTakingId = @OperatorPositionTakingId OUTPUT, @ErrCode = @ErrCode2 OUTPUT, @ErrMsg = @ErrMsg2 OUTPUT
GO

-- Insert VendorAgentInfo table
EXEC [dbo].[BA_VendorAgentInfo_Ins] @OperatorId = 1, @VendorId = 42, @VendorAgentId = N'', @VendorAgentKey = N'', @VendorAgentCode = N'Credit', @VendorAgentType = N'SABA', @RefName = N'ONEworks1',@RefKey = N'61tSCtQEwZscs93kK324lC0uQShncZmf', @RefCode = N'',@Note='9jg479kb7v9kjv0g'
GO

--Insert OperatorGameSetting table
EXEC [dbo].[BA_OperatorGameSetting_Ins] @OperatorId = 1, @VendorId = 42, @SettingType = N'VendorEndPoint_General', @ValidatePwd = NULL, @ValidateKey = NULL, @Url = N'http://l1uatapi.vn-sc-kluat.gamora.prod', @OtherInfo = NULL
EXEC [dbo].[BA_OperatorGameSetting_Ins] @OperatorId = 1, @VendorId = 42, @SettingType = N'VendorEndPoint_Result', @ValidatePwd = NULL, @ValidateKey = NULL, @Url = N'http://l1uatresult.vn-sc-kluat.gamora.prod', @OtherInfo = NULL
EXEC [dbo].[BA_OperatorGameSetting_Ins] @OperatorId = 1, @VendorId = 42, @SettingType = N'OperatorEndPoint', @ValidatePwd = NULL, @ValidateKey = NULL, @Url = N'http://saba-wallet-group-005.3rd-party.klt2p.gamora.prod:32280/api/SabaClub', @OtherInfo = NULL
-- insert VendorGameList by n8n
/*
SELECT * FROM VendorGameList WITH(NOLOCK) WHERE vendorid = 42

SELECT * FROM GameVendorInfo WITH(NOLOCK) WHERE vendorid = 42
SELECT * FROM OperatorProductSetting WITH(NOLOCK) WHERE vendorid = 42
SELECT * 
FROM OperatorPositionTaking WITH(NOLOCK) 
WHERE OperatorProductSettingId IN ( 
									SELECT OperatorProductSettingId 
									FROM OperatorProductSetting WITH(NOLOCK) 
									WHERE vendorid = 42) 

SELECT * FROM VendorAgentInfo WITH(NOLOCK) WHERE vendorid = 42 AND OperatorId = 1

SELECT * FROM OperatorGameSetting WITH(NOLOCK) WHERE vendorid = 42 AND OperatorId = 1
*/