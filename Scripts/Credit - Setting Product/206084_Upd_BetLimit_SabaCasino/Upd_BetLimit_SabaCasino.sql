/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 2024-06-04@Helios
	Task: Customer Setting - Support SP to update bet limit [#206084]
		https://nexdev.net/issues/206084
	DB: DBCust/CustDB  
*/

IF EXISTS (SELECT 1 FROM StakeLevel sl WITH (NOLOCK) WHERE sl.GameTypeID = 2101 AND sl.ExchangeId = 43 AND sl.GameGroupID = 34)
BEGIN
	-- Initial for StakeLevel_History to detect ticket
	INSERT INTO StakeLevel_History 
	(
		  StakeLevelID
		, GameTypeID
		, MaxLabel
		, MaxStake
		, UpdateTime
	)
	SELECT
		  StakeLevelID
		, GameTypeID
		, MaxLabel
		, MaxStake
		, GETDATE ()
	FROM StakeLevel sl WITH (NOLOCK) 
	WHERE sl.GameTypeID = 2101 AND sl.ExchangeId = 43 AND sl.GameGroupID = 34

	-- Update Stake Values
	UPDATE sl
		SET 
			sl.MinLabel = '0.1'
		,	sl.MaxLabel = '10,000'
		,	sl.MinStake = 0.1
		,	sl.MaxStake = 10000
	FROM StakeLevel sl WITH (ROWLOCK , UPDLOCK)
	WHERE sl.GameTypeID = 2101 AND sl.ExchangeId = 43 AND sl.GameGroupID = 34
END