/*<info serverAlias="DBBOF-bodb02,DBAGE-bodb02,DBTP-bodb02"></info>*/
/*
	Created: 20231009@Tacy
	Task: In-House
	DB: DB05x-bodb02, DBTP-bodb02
	
	Revisions:
		- 20231009@Tacy: Integration - Parlay Boost Bonus [RedmineID: #186192]
*/
USE bodb02
GO

UPDATE RepInfo WITH (ROWLOCK, UPDLOCK)
SET active=0
WHERE [name]='Dep_CustBonusSharing'
GO