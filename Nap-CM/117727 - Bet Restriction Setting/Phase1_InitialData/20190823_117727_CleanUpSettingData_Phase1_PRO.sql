/*
	Created by: Eden
	Date: 20190830
	Task: Cleanup setting for Site/Currency , turn on SeizeBetTicketStatus for Credit of Customer level [Redmine:#117727]	
	DB: DBCUST/CustDB
*/
--Turn on SeizeBetTicketStatus for Credit of Customer level
UPDATE BetRestriction_Setting WITH(ROWLOCK,UPDLOCK)
SET SeizeBetTicketStatus = 1
WHERE SportType= 1 
	AND RestrictionLevel = 'BetRestriction_Customer'  
	AND IsLicensee = 0

--Cleanup setting for Site/Currency
DELETE FROM BetRestriction_Currency WITH(ROWLOCK,UPDLOCK)
DELETE FROM BetRestriction_Site WITH(ROWLOCK,UPDLOCK) 

