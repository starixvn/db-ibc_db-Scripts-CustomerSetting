/*<info serverAlias="DBCust-CustDB,DBTP-bodb02"></info>*/

/*
	Created: 20241113@Tacy
	Task: CustMaxBetSetting_History -  add [OldMaxPerNumber] column [RedmineID: #199571]
	Database: DBCust/CustDB, DBTP/bodb02
*/

ALTER TABLE CustMaxBetSetting_History ADD [OldMaxPerNumber] [money] NULL
GO

ALTER TABLE Dep_CustMaxBetSetting_History ADD [OldMaxPerNumber] [money] NULL
GO