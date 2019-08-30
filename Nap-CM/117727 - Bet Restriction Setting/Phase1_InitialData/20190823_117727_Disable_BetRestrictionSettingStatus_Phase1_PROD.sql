/*
	Created by: Eden
	Date: 20190830
	Task: Update Disble BetRestriction Setting Status [Redmine:#117727]	
	DB: DBCUST/CustDB
*/

UPDATE BetRestriction_Setting with(rowlock)
SET LiveBetAcceptStatus = 0,
	SeizeBetTicketStatus = 0,
	BetLimitStatus = 0 
WHERE SportType = 1 
	  AND RestrictionLevel = 'BetRestriction_Customer'

GO


