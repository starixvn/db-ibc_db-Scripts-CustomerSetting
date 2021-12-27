/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created:	Winfred
	Date:		20211227
	Task:		Update setting AllBet and BBIN for currency INR1 RedmineID:#166295
	DB:			DBCust/CustDB
*/

DECLARE @ToCurrency INT

SELECT	@ToCurrency = 10   -- INR1

----------------StakeLevel -- product BBIN
-- 100-50,000
UPDATE StakeLevel WITH(ROWLOCK, UPDLOCK) 
SET MinLabel ='100',
	MaxLabel ='50,000',
	MinStake = 100,
	MaxStake = 50000
WHERE GameTypeID = 3300 AND ExchangeId = @ToCurrency


