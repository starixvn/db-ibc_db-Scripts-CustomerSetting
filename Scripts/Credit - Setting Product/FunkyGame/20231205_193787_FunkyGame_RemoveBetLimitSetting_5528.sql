/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator: 20231205@Tacy
	Task: Funky Games - Remove Bet Limit Setting for bettype 5528 [Redmine: #193787]
	Database:	DBCUST.CustDB
*/
USE CustDB
GO

DELETE FROM StakeLevelGroupDetail WITH (ROWLOCK)
WHERE GameTypeID=5528
GO