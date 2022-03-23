/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created:	Winfred
	Date:		20220121
	Task:		Update setting 172	AdvantPlay,174	AdvantPlay Mini (AdvantPlay , AdvantPlay Mini) for currency INR1 RedmineID:#166295
	DB:			DBCust/CustDB
*/

DECLARE @ToCurrency INT

SELECT	@ToCurrency = 10   -- INR1

----------------StakeLevel -- product AdvantPlay
-- 3-4,500
UPDATE slgd  
SET slgd.MinLabel ='3',
	slgd.MaxLabel ='4,500',
	slgd.MinStake = 3,
	slgd.MaxStake = 4500
FROM StakeLevelGroupDetail slgd WITH(ROWLOCK, UPDLOCK)
INNER JOIN StakeLevel sl WITH(NOLOCK) ON slgd.StakeLevelID = sl.StakeLevelID
WHERE sl.GameTypeID = 7701 AND ExchangeId = @ToCurrency

--SELECT b.* FROM StakeLevel a WITH(NOLOCK)
--INNER JOIN StakeLevelGroupDetail b WITH(NOLOCK) ON a.StakeLevelID = b.StakeLevelID  
--WHERE  a.GameTypeID = 7701 AND ExchangeId = 10

----------------StakeLevel -- product AdvantPlay Mini
-- 15	8,000
UPDATE slgd  
SET slgd.MinLabel ='15',
	slgd.MaxLabel ='8,000',
	slgd.MinStake = 15,
	slgd.MaxStake = 8000
FROM StakeLevelGroupDetail slgd WITH(ROWLOCK, UPDLOCK)
INNER JOIN StakeLevel sl WITH(NOLOCK) ON slgd.StakeLevelID = sl.StakeLevelID
WHERE sl.GameTypeID = 7801 AND ExchangeId = @ToCurrency

--SELECT b.* FROM StakeLevel a WITH(NOLOCK)
--INNER JOIN StakeLevelGroupDetail b WITH(NOLOCK) ON a.StakeLevelID = b.StakeLevelID  
--WHERE  a.GameTypeID = 7801 AND ExchangeId = 10