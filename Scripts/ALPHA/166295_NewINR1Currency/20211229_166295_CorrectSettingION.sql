/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created:	Winfred
	Date:		20211229
	Task:		Update setting ION for currency INR1 RedmineID:#166295
	DB:			DBCust/CustDB
*/

DECLARE @ToCurrency INT

SELECT	@ToCurrency = 10   -- INR1

----------------StakeLevel -- product SA Gaming
-- 5-50,000
UPDATE StakeLevel WITH(ROWLOCK, UPDLOCK) 
SET MinLabel ='5',
	MaxLabel ='50,000',
	MinStake = 5,
	MaxStake = 50000
WHERE GameTypeID = 5601 AND ExchangeId = @ToCurrency AND MinStake = 5 AND MaxStake = 150000


