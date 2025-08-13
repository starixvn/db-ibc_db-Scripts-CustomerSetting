/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created by: 20250731@Dave
	Task: Alpha - Implement compact feedback [RedmineID: #234817]
	DB: DBBOT.bodb_ChatBot
*/
USE bodb_ChatBot
GO

ALTER TABLE dbo.CustFeedback ADD ExtraInfo NVARCHAR(MAX) NULL;
GO