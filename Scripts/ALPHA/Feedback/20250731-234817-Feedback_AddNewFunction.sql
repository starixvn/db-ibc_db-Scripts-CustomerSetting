/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created by: 20250731@Dave
	Task: Alpha - Implement compact feedback [RedmineID: #234817]
	DB: DBBOT.bodb_ChatBot
*/
USE bodb_ChatBot
GO
INSERT INTO Age_FeedbackFunc (Type,FuncNameEN,FuncNameCN3,FuncNameCS,FuncNameCH,FuncNameTH,FuncNameJP,FuncNameKO)
SELECT 4,'Report - Master Outstanding',N'',N'',N'',N'',N'',N''
UNION ALL SELECT 4,'Report - Master Win Loss',N'',N'',N'',N'',N'',N''
UNION ALL SELECT 4,'Report - Master Win Loss Detail',N'',N'',N'',N'',N'',N''
UNION ALL SELECT 4,'Report - Match Win Loss Detail',N'',N'',N'',N'',N'',N''
UNION ALL SELECT 4,'Report - Win Loss Analysis',N'',N'',N'',N'',N'',N''
UNION ALL SELECT 4,'Report - Win Loss Analysis Chart',N'',N'',N'',N'',N'',N''
UNION ALL SELECT 4,'Report - Win Loss By Product',N'',N'',N'',N'',N'',N''
UNION ALL SELECT 4,'Report - Super Win Loss Detail By PT',N'',N'',N'',N'',N'',N''
UNION ALL SELECT 4,'Report - Commission By Bet Type',N'',N'',N'',N'',N'',N''
UNION ALL SELECT 4,'Report - Statement',N'',N'',N'',N'',N'',N''
UNION ALL SELECT 4,'Report - Results',N'',N'',N'',N'',N'',N''
UNION ALL SELECT 4,'Report - Progressive Games Contribution',N'',N'',N'',N'',N'',N''
UNION ALL SELECT 4,'Report - Bet Credit Tracking',N'',N'',N'',N'',N'',N''
UNION ALL SELECT 4,'Report - Consolidation',N'',N'',N'',N'',N'',N''
UNION ALL SELECT 4,'Report - Bonus Detail',N'',N'',N'',N'',N'',N''
UNION ALL SELECT 4,'Report - Entered/Non-Entered Result',N'',N'',N'',N'',N'',N''
UNION ALL SELECT 4,'Report - IP Matching',N'',N'',N'',N'',N'',N''
UNION ALL SELECT 4,'Report - Bet Choice Matching',N'',N'',N'',N'',N'',N''
GO


select * from Age_FeedbackFunc;
