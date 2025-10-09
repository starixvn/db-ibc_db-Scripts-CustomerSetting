/*<info serverAlias="DBSabaPlay-WalletBridgeDB_Admin"></info>*/
/*
	Created: Helios@20251009
	Task: SabaPlay - Integrate new product Vertex Play (VP) [#240871] 
	DB: DBSabaPlay-WalletBridgeDB_Admin
*/

USE WalletBridgeDB_Admin

GO

-- Insert GameVendorInfo
EXEC [dbo].[BA_GameVendorInfo_Ins] @VendorId   = 116
					   , @VendorName = N'VertexPlay'
					   , @GameType   = N'VertexPlay'


-- Insert OperatorProductSetting
DECLARE
	@OperatorProductSettingId INT
    , @ErrCode			  INT
    , @ErrMsg			  VARCHAR(100)
EXEC [dbo].[AP_BO_OperatorProductSetting_Ins] @OperatorInfoId		= 1
							  , @OperatorId			= 1
							  , @SubOperatorId		= 0
							  , @VendorId			= 116
							  , @FirstBillingDate		= NULL
							  , @BasisOfBilling		= NULL
							  , @ChargeTypeId			= 1
							  , @ChargeOnId			= 1
							  , @FromDate			= N'2024-10-23'
							  , @ToDate				= N'2050-12-31'
							  , @OperatorProductSettingId = @OperatorProductSettingId OUTPUT
							  , @ErrCode			= @ErrCode OUTPUT
							  , @ErrMsg				= @ErrMsg OUTPUT
SELECT
	@OperatorProductSettingId
    , @ErrCode
    , @ErrMsg
