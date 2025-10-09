/*<info serverAlias="DBSabaPlay-WalletBridgeDB_Admin"></info>*/
/*
	Created: Helios@20251009
	Task: SabaPlay - Integrate new product Vertex Play (VP) [#240871] 
	DB: DBSabaPlay-WalletBridgeDB_Admin
*/

USE WalletBridgeDB_Admin

GO
 ----Insert OperatorPositionTaking : xxx Get values ID identity from param @OperatorProductSettingId Output From Insert OperatorProductSetting
DECLARE
	@OperatorPositionTakingId INT
    , @ErrCode			  INT
    , @ErrMsg			  VARCHAR(100)
EXEC [dbo].[AP_BO_OperatorPositionTaking_Ins] @OperatorProductSettingId = xxx
							  , @CurrencyISO			= N'ALL'
							  , @PositionTaking		= 0.00
							  , @OperatorPositionTakingId = @OperatorPositionTakingId OUTPUT
							  , @ErrCode			= @ErrCode OUTPUT
							  , @ErrMsg				= @ErrMsg OUTPUT
SELECT
	@OperatorPositionTakingId
    , @ErrCode
    , @ErrMsg