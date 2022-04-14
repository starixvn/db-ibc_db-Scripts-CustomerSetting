/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220303@Johnson
	Task: Update default LeagueGroup for BetLimitControlTypeDetail
	DB: DBCust/CustDB
*/

UPDATE BetLimitControlTypeDetail WITH(ROWLOCK)
SET LeagueGroupID = -1
WHERE LeagueGroupID = 0

