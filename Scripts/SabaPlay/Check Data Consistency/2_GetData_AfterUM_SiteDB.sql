/*<info serverAlias="DBSIC-bodb02"></info>*/ 
/*
	Created: Helios@20251008
	Task: Check data Consistency from SiteDb03 with WalletBridgeDB - CHECK BEFORE UM [#239774]
	DB: DBSIC-bodb02
*/

DECLARE
      @FromDate				DATETIME	,
	@ToDate				DATETIME	,
	@ProductID				SMALLINT	= 200,		-- SportType : SABA.games
	@VendorID				INT		= 42			-- ProductID : SABA.games

	SET NOCOUNT ON

	SELECT @FromDate = 'xxxxxx' -- TimeCheck Before UM
	SELECT @ToDate   = GETDATE();

	
	-- Get All Ticket of Saba.Games
	SELECT 
		'''' + TranId3rd + ''',' AS TicketNo ,
		transid,
		custid,
		transdate,
		odds,
		stake,
		status,
		apositiontaking,
		mpositiontaking,
		tpositiontaking,
		spositiontaking,
		playerdiscount,
		discount,
		adiscount,
		sdiscount,
		creator,
		winlostdate,
		betfrom,
		virtualrate,
		actualrate,
		actual_stake,
		currency,
		CurrencyName,
		recommend,
		mrecommend,
		srecommend,
		ip,
		statusID,
		balance,
		Username,
		transdesc,
		productID,
		gameID,
		vendorID,
		GameId3rd,
		TranId3rd,
		RefNo,
		IsSum,
		winlost,
		awinlost,
		mwinlost,
		swinlost,
		playercomm,
		comm,
		acomm,
		scomm,
		Transdate3rd,
		tstamp,
		SiteID,
		Additional,
		JackpotInfo,
		RefNo2,
		ContributionRate,
		BetStake,
		ContributionStake3rd,
		epositiontaking,
		RepUpdateTime,
		SiteDBGroupID,
		ExtraInfo,
		DeviceType
	FROM	dbo.bettransRnG b WITH (NOLOCK)
	WHERE	productID = @ProductID
		AND vendorID = @VendorID
		AND custid <> 0
		AND transdate BETWEEN @FromDate AND @ToDate
