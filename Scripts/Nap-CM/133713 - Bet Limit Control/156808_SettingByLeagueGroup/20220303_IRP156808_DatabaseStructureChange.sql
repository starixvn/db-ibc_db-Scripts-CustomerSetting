/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220303@Johnson
	Task: Database Structure change for bet limit control
	DB: DBCust/CustDB
*/

ALTER TABLE BetLimitControlType ADD ExcludedLeagueGroupList VARCHAR(4000)