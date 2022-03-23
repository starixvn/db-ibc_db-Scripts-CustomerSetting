/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created:	Winfred
	Date:		20211228
	Task:		Update setting SA Gaming for currency INR1 RedmineID:#166295
	DB:			DBCust/CustDB
*/

DECLARE @ToCurrency INT

SELECT	@ToCurrency = 10   -- INR1

----------------StakeLevel -- product SA Gaming
-- 5000-100000
UPDATE StakeLevel WITH(ROWLOCK, UPDLOCK) 
SET MinLabel ='5,000',
	MaxLabel ='100,000',
	MinStake = 5000,
	MaxStake = 100000
WHERE GameTypeID = 3001 AND ExchangeId = @ToCurrency AND MinStake = 3000 AND MaxStake = 110000


