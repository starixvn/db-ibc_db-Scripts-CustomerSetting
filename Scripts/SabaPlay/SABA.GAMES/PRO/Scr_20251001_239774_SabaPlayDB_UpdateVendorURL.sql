/*<info serverAlias="DBSABAPLAY-WalletBridgeDB_Admin"></info>*/ 
/*
	Created: Eden@20251001
	Task: Init config for SABA.GAMES on SABAPLAY - PRODUCTION [#239774]
	DB: DBSABAPLAY-WalletBridgeDB_Admin
*/
USE WalletBridgeDB_Admin
GO
--Insert OperatorGameSetting table
EXEC [dbo].[BA_OperatorGameSetting_Upd] 
  @OperatorId = 1, @VendorId = 42
, @SettingType = N'VendorEndPoint_General'
, @ValidatePwd = NULL, @ValidateKey = NULL
, @Url = N'http://sg-intapi.vn-sc-klprod.gamora.prod'
, @OtherInfo = NULL, @SubOperatorId = 0

EXEC [dbo].[BA_OperatorGameSetting_Upd] 
  @OperatorId = 1, @VendorId = 42
, @SettingType = N'VendorEndPoint_Result'
, @ValidatePwd = NULL, @ValidateKey = NULL
, @Url = N'http://sg-intresult.vn-sc-klprod.gamora.prod'
, @OtherInfo = NULL, @SubOperatorId = 0

--VendorAgentInfo
EXEC [dbo].[BA_VendorAgentInfo_Upd] 
@OperatorId = 1, @VendorId = 42, @VendorAgentId = N''
, @VendorAgentKey = N'', @VendorAgentCode = N'Credit'
, @VendorAgentType = N'SABA'
, @RefName = N'ONEworks1'
, @RefKey = N'61tSCtQEwZscs93kK324lC0uQShncZmf'
, @RefCode = N''
, @Note='9jg479kb7v9kjv0g'

/*
SELECT OperatorId,VendorId,SettingType,ValidatePwd
	,ValidateKey,Url,OtherInfo,UpdateTime,SubOperatorId 
FROM OperatorGameSetting WITH(NOLOCK) WHERE vendorid = 42 AND OperatorId = 1

SELECT VendorAgentSeq,OperatorId,VendorId,VendorAgentId,VendorAgentKey,VendorAgentCode
	,VendorAgentType,RefName,RefKey,RefCode,Note,UpdateTime	
FROM VendorAgentInfo WITH(NOLOCK) 
WHERE vendorid = 42 AND OperatorId = 1
*/