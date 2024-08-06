/*<info serverAlias="DBTP-bodb02"></info>*/
/*
	Created: 20240724@Johnson
	Task: Database structure change to scale out dbcust [redmine: #199915]
	DB: DBTP-bodb02
*/ 

ALTER TABLE BetSetting_Agent ADD IsDeleted BIT NULL
GO

ALTER TABLE BetSetting_Member ADD IsDeleted BIT NULL
GO