/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created by: 20250826@Dave
	Task: Alpha - Implement compact feedback [RedmineID: #238065]
	DB: DBBOT.bodb_ChatBot
*/
USE bodb_ChatBot
GO

DELETE FROM dbo.Age_FeedbackFunc WHERE FuncID BETWEEN 76 AND 109;

SET IDENTITY_INSERT dbo.Age_FeedbackFunc ON;

INSERT INTO dbo.Age_FeedbackFunc (FuncID,Type,FuncNameEN,FuncNameCN3,FuncNameCS,FuncNameCH,FuncNameTH,FuncNameJP,FuncNameKO)
VALUES
(76,4,'Member Information - Customer List',N'',N'',N'',N'',N'',N''),
(77,4,'Member Information - Problem Account List Master',N'',N'',N'',N'',N'',N''),
(78,4,'Member Information - Problem Account List Agent',N'',N'',N'',N'',N'',N''),
(79,4,'Member Information - Problem Account List Member',N'',N'',N'',N'',N'',N''),
(80,4,'Member Information - Credit/Balance',N'',N'',N'',N'',N'',N''),
(81,4,'Member Information - Position Taking (%)',N'',N'',N'',N'',N'',N''),
(82,4,'Member Information - Member Commission',N'',N'',N'',N'',N'',N''),
(83,4,'Member Information - Indirect Login Account',N'',N'',N'',N'',N'',N''),
(84,4,'Member Information - Dormant Account List',N'',N'',N'',N'',N'',N''),
(85,4,'Transfer - Transfer',N'',N'',N'',N'',N'',N''),
(86,4,'Transfer - Auto Transfer Monitor',N'',N'',N'',N'',N'',N''),
(87,4,'Transfer - Auto Transfer History',N'',N'',N'',N'',N'',N''),
(88,4,'Transfer - Transfer All & Clear Credit',N'',N'',N'',N'',N'',N''),
(89,4,'Transfer - Transfer To Downline History',N'',N'',N'',N'',N'',N''),
(90,4,'Transfer - Reward Payment',N'',N'',N'',N'',N'',N''),
(91,4,'Transfer - Reward Detail',N'',N'',N'',N'',N'',N''),
(92,4,'View Log - Setting',N'',N'',N'',N'',N'',N''),
(93,4,'View Log - Status',N'',N'',N'',N'',N'',N''),
(94,4,'View Log - Credit',N'',N'',N'',N'',N'',N''),
(95,4,'View Log - Login',N'',N'',N'',N'',N'',N''),
(96,4,'View Log - Cash Service',N'',N'',N'',N'',N'',N''),
(97,4,'Risk Management - Member Win/Loss Limit',N'',N'',N'',N'',N'',N''),
(98,4,'Risk Management - Sportsbook Potential Win Limit',N'',N'',N'',N'',N'',N''),
(99,4,'Risk Management - Reached Threshold',N'',N'',N'',N'',N'',N''),
(100,4,'Risk Management - My Watchlist',N'',N'',N'',N'',N'',N''),
(101,4,'Risk Management - My Threshold',N'',N'',N'',N'',N'',N''),
(102,4,'Risk Management - Member Betting Bahavior',N'',N'',N'',N'',N'',N''),
(103,4,'Announcement - Normal',N'',N'',N'',N'',N'',N''),
(104,4,'Announcement - Special',N'',N'',N'',N'',N'',N''),
(105,4,'Announcement - System',N'',N'',N'',N'',N'',N''),
(106,4,'Announcement - Personal Message',N'',N'',N'',N'',N'',N''),
(107,4,'Available Domains - Agency Domains',N'',N'',N'',N'',N'',N''),
(108,4,'Available Domains - Member Domains',N'',N'',N'',N'',N'',N''),
(109,4,'Reports - Transfer Details',N'',N'',N'',N'',N'',N'');

SET IDENTITY_INSERT dbo.Age_FeedbackFunc OFF;

DBCC CHECKIDENT ('Age_FeedbackFunc', RESEED, 109);

select * from Age_FeedbackFunc;
