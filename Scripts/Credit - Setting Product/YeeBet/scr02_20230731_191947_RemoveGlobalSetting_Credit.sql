/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20230731
	Task: YeeBet - Change Bet Limit [Redmine: #191947]
	DB: DBCUST/CustDB
*/
USE CustDB 
GO

CREATE TABLE #rmStakeLevel(MinStake DECIMAL(19,8), MaxStake DECIMAL(19,8), ExchangeID INT)
INSERT INTO #rmStakeLevel(MinStake, MaxStake, ExchangeID) VALUES
	(100, 40000, 67),		--'HKK'
	(100, 40000, 5),		--'HK$'
	(100, 40000, 2),		--'RM'
	(100, 40000, 13),		--'RMB'
	(50, 10000,	16),		--'Yen'
	(50, 10000, 64),		--'UT'
	(50, 10000,	3),			--'US$'
	(50, 10000,	69),		--'MMK'
	(30000, 10000000, 45)	--'Won'

DELETE s
FROM StakeLevel s WITH (ROWLOCK, UPDLOCK)
	INNER JOIN #rmStakeLevel r WITH (NOLOCK) ON s.ExchangeId = r.ExchangeID AND s.MinStake = r.MinStake AND s.MaxStake = r.MaxStake
WHERE s.GameTypeID = 3151