/*<info serverAlias="DBSABAPLAY-WalletBridgeDB_Admin"></info>*/ 
/*
	Created: Eden@20251001
	Task: Init config for SABA.GAMES on SABAPLAY - PRODUCTION [#239774]
	DB: DBSABAPLAY-WalletBridgeDB_Admin
*/
USE WalletBridgeDB_Admin
GO
EXEC [dbo].[BA_VendorAgentInfo_Upd] 
@OperatorId = 1, @VendorId = 42, @VendorAgentId = N''
, @VendorAgentKey = N'', @VendorAgentCode = N'Credit'
, @VendorAgentType = N'SABA'
, @RefName = N'ONEworks1'
, @RefKey = N'123ONEworks1%^&uat'
, @RefCode = N''
, @Note='9jg479kb7v9kjv0g'

/*
SELECT * FROM VendorAgentInfo WITH(NOLOCK) WHERE vendorid = 42 AND OperatorId = 1
*/