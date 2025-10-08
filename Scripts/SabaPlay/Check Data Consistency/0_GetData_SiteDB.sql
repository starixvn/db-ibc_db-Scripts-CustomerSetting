/*<info serverAlias="DBSIC-bodb02"></info>*/ 
/*
	Created: Helios@20251008
	Task: Check data Consistency from SiteDb03 with WalletBridgeDB - CHECK BEFORE UM [#239774]
	DB: DBSIC-bodb02
*/

DECLARE
      @CurrentTime			DATETIME	= GETDATE(),
	@ProductID				SMALLINT	= 200,		-- SportType : SABA.games
	@VendorID				INT		= 42			-- ProductID : SABA.games

	SET NOCOUNT ON

	DECLARE @CountTicket	INT

	-- Count Ticket Still Running
	SELECT	@CountTicket = COUNT(1) 
	FROM	dbo.bettransRnG b WITH (NOLOCK)
	WHERE	transdate < @CurrentTime
		AND productID = @ProductID
		AND vendorID = @VendorID
		--AND currency <> 20
		AND custid <> 0
		AND statusID = 0  --'running'
	
    SELECT @CountTicket AS CountTicket , @CurrentTime AS TimeCheck

    IF @CountTicket > 0
    BEGIN
		SELECT b.TranId3rd ,  b.custid , b.CurrencyName , b.stake , b.statusID, b.gameID , b.vendorID , b.GameId3rd , b.RefNo ,  b.TranId3rd , '''' + TranId3rd + ''',' AS TicketNo , LOWER(b.Status) AS Status 
		FROM	dbo.bettransRnG b WITH (NOLOCK)
		WHERE	transdate < @CurrentTime
			AND productID = @ProductID
			AND vendorID = @VendorID
			--AND currency <> 20
			AND custid <> 0
			AND statusID = 0  --'running'
    END
