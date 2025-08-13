/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created by: 20250731@Dave
	Task: Alpha - Implement compact feedback [RedmineID: #234817]
	DB: DBBOT.bodb_ChatBot
*/
USE bodb_ChatBot
GO

DELETE FROM dbo.Age_FeedbackFunc WHERE Type = 4;

SET IDENTITY_INSERT dbo.Age_FeedbackFunc ON;

INSERT INTO dbo.Age_FeedbackFunc (FuncID,Type,FuncNameEN,FuncNameCN3,FuncNameCS,FuncNameCH,FuncNameTH,FuncNameJP,FuncNameKO)
VALUES
(13,4,'Report - Outstanding',N'',N'',N'',N'',N'',N''),
(14,4,'Report - Win Loss',N'',N'',N'',N'',N'',N''),
(15,4,'Report - Win Loss Detail',N'',N'',N'',N'',N'',N''),
(16,4,'Report - Match Win Loss Detail',N'',N'',N'',N'',N'',N''),
(17,4,'Report - Win Loss Analysis',N'',N'',N'',N'',N'',N''),
(18,4,'Report - Win Loss Analysis Chart',N'',N'',N'',N'',N'',N''),
(19,4,'Report - Win Loss By Product',N'',N'',N'',N'',N'',N''),
(20,4,'Report - Super Win Loss Detail By PT',N'',N'',N'',N'',N'',N''),
(21,4,'Report - Commission By Bet Type',N'',N'',N'',N'',N'',N''),
(22,4,'Report - SMA Statement',N'',N'',N'',N'',N'',N''),
(23,4,'Report - Member Statement',N'',N'',N'',N'',N'',N''),
(24,4,'Report - Progressive Games Contribution',N'',N'',N'',N'',N'',N''),
(25,4,'Report - Bet Credit History',N'',N'',N'',N'',N'',N''),
(26,4,'Report - Move Statement History',N'',N'',N'',N'',N'',N''),
(27,4,'Report - Consolidation',N'',N'',N'',N'',N'',N''),
(28,4,'Report - Bonus Detail',N'',N'',N'',N'',N'',N''),
(29,4,'Report - Entered/Non-Entered Result',N'',N'',N'',N'',N'',N''),
(30,4,'Risk Analysis - IP Matching',N'',N'',N'',N'',N'',N''),
(31,4,'Risk Analysis - Bet Choice Matching',N'',N'',N'',N'',N'',N''),
(32,4,'Report - Cash Service Billing',N'',N'',N'',N'',N'',N'');

SET IDENTITY_INSERT dbo.Age_FeedbackFunc OFF;

DBCC CHECKIDENT ('Age_FeedbackFunc', RESEED, 32);

select * from Age_FeedbackFunc;
