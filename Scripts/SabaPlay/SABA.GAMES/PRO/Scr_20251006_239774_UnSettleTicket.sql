/*<info serverAlias="DBSIC-bodb02"></info>*/
/*
	Created: Eden@20251001
	Task: Unsettle SABAPLAY [#239774]
	DB: DBSABAPLAY-WalletBridgeDB_Admin
*/
USE bodb02
GO
-- Unsettle Ticket 
DECLARE @ErrCode INT, @ErrMsg VARCHAR(200);
EXEC [dbo].[Dot_Intg_Unsettlement_VendorRNG_manually]
    @transid_RNG = xxx,
    @custid = xxx,
    @productID = xxx,
    @gameID = xxx,
    @transdesc = N'Test - Unsettle by script',
    @ErrCode = @ErrCode OUTPUT,
    @ErrMsg = @ErrMsg OUTPUT;
SELECT @ErrCode AS ErrCode, @ErrMsg AS ErrMsg;
GO

/*
	SELECT top 10 Transid, CustID, ProductID, gameID,[status], *
    FROM BettransRNG WITH (NOLOCK)
    WHERE Custid = xxx And transid in(xxx,xxx)
*/