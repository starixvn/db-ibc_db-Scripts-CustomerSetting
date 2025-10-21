/*<info serverAlias="DBSIC-bodb02"></info>*/
/*
	Created: Eden@20251001
	Task: Unsettle SABAPLAY [#239774]
	DB: DBSIC-bodb02
*/
USE bodb02
GO
-- Unsettle Ticket 
DECLARE @transid_RNG BIGINT = 100104374056
DECLARE @custid INT = 1425099  
------------------------------------------
DECLARE @productID SMALLINT           
DECLARE @gameID SMALLINT          
DECLARE @ErrCode INT, @ErrMsg VARCHAR(200)

SELECT @transid_RNG = TransId,
    @custid			= custid,
    @productID		= productID,
    @gameID			= gameID
FROM BettransRNG WITH (NOLOCK)
WHERE custid = @custid 
	AND TransId = @transid_RNG

SELECT @transid_RNG AS TransId,
    @custid			AS custid,
    @productID		AS productID,
    @gameID			AS gameID

EXEC [dbo].[Dot_Intg_Unsettlement_VendorRNG_manually]
    @transid_RNG = @transid_RNG,
    @custid = @custid,
    @productID = @productID,
    @gameID = @gameID,
    @transdesc = N'Test - Unsettle by script',
    @ErrCode = @ErrCode OUTPUT,
    @ErrMsg = @ErrMsg OUTPUT;

SELECT @ErrCode AS ErrCode, @ErrMsg AS ErrMsg;

SELECT TOP 10 Transid, CustID, ProductID, gameID,[status]
FROM BettransRNG WITH (NOLOCK)
WHERE custid = @custid 
	AND TransId = @transid_RNG
GO
