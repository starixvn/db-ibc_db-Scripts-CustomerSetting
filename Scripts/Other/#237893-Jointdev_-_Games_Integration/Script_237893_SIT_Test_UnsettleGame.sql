/*<info serverAlias="DBSIC-bodb02"></info>*/
/*
  Created: 20250925@Eden
  Task: Unsettle Ticket
  DB: DBSIC-bodb02
  Revisions:
    - 20250925@Eden: Initial [RedmineID: #237893]
*/
-- Unsettle Ticket 
DECLARE @ErrCode INT, @ErrMsg VARCHAR(200);
EXEC [dbo].[Dot_Intg_Unsettlement_VendorRNG_manually]
    @transid_RNG = 438699444368572416,
    @custid = 25016976,
    @productID = 200,
    @gameID = 1633,
    @transdesc = N'Test - Unsettle by script',
    @ErrCode = @ErrCode OUTPUT,
    @ErrMsg = @ErrMsg OUTPUT;
SELECT @ErrCode AS ErrCode, @ErrMsg AS ErrMsg;
GO

-- Unsettle Ticket 
DECLARE @ErrCode INT, @ErrMsg VARCHAR(200);
EXEC [dbo].[Dot_Intg_Unsettlement_VendorRNG_manually]
    @transid_RNG = 438692679795081216,
    @custid = 25016976,
    @productID = 200,
    @gameID = 13243,
    @transdesc = N'Test - Unsettle by script',
    @ErrCode = @ErrCode OUTPUT,
    @ErrMsg = @ErrMsg OUTPUT;
SELECT @ErrCode AS ErrCode, @ErrMsg AS ErrMsg;
GO

/*
	SELECT Transid, CustID, ProductID, gameID,[status], *
    FROM BettransRNG WITH (NOLOCK)
    WHERE Custid = 25016976 And transid in(438692679795081216,438699444368572416)
*/