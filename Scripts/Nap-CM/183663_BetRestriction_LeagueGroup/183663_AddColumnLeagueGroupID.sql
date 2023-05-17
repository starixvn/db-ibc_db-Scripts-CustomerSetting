/*<info serverAlias="DBCUST-NAP_UserControl"></info>*/
/*
	Created by: Helios
	Date: 2023/03/02
	Task: NapCM - Add Column LeagueGroupID [redmine : #183663]
	DB: DBCUST/CustDB
	
	Revisions:  
*/

USE CustDB

-- Add COLUMN
GO
--ALTER TABLE BetRestriction_Customer DROP COLUMN LeagueGroupID;
--GO
ALTER TABLE BetRestriction_Customer  ADD LeagueGroupID varchar(4000) NULL
GO

-- Initial For ALL Data LeagueGroupID = All in table BetRestriction_Customer

UPDATE bc SET LeagueGroupID = 'All'
FROM BetRestriction_Customer bc WITH(ROWLOCK, UPDLOCK)

