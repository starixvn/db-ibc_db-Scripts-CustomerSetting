/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created by: 20250826@Dave
	Task: Alpha - Implement compact feedback [RedmineID: #236712]
	DB: DBBOT.bodb_ChatBot
*/
USE bodb_ChatBot
GO

DELETE FROM dbo.Age_FeedbackFunc WHERE FuncID BETWEEN 42 AND 75;

SET IDENTITY_INSERT dbo.Age_FeedbackFunc ON;

INSERT INTO dbo.Age_FeedbackFunc (FuncID,Type,FuncNameEN,FuncNameCN3,FuncNameCS,FuncNameCH,FuncNameTH,FuncNameJP,FuncNameKO)
VALUES
(42,4,'Bet Lists - Last Bets',N'',N'',N'',N'',N'',N''),
(43,4,'Bet Lists - Search Tickets',N'',N'',N'',N'',N'',N''),
(44,4,'Bet Lists - Cancelled Bets',N'',N'',N'',N'',N'',N''),
(45,4,'Bet Lists - Correct Score',N'',N'',N'',N'',N'',N''),
(46,4,'Bet Lists - Parlay',N'',N'',N'',N'',N'',N''),
(47,4,'Bet Lists - Clean Sheet',N'',N'',N'',N'',N'',N''),
(48,4,'Bet Lists - Double Change',N'',N'',N'',N'',N'',N''),
(49,4,'Bet Lists - Both/One/Neither Team To Score',N'',N'',N'',N'',N'',N''),
(50,4,'Bet Lists - To Win To Nil',N'',N'',N'',N'',N'',N''),
(51,4,'Bet Lists - 3-Way Handicap',N'',N'',N'',N'',N'',N''),
(52,4,'Bet Lists - Member Bet List',N'',N'',N'',N'',N'',N''),
(53,4,'Bet Lists - Running Bet List',N'',N'',N'',N'',N'',N''),
(54,4,'Bet Lists - Win Loss Bet List',N'',N'',N'',N'',N'',N''),
(55,4,'Bet Lists - Win Loss Bet List (NEW)',N'',N'',N'',N'',N'',N''),
(56,4,'Bet Lists - Win Loss By Match',N'',N'',N'',N'',N'',N''),
(57,4,'Bet Lists - Parlay Win Loss By Match',N'',N'',N'',N'',N'',N''),
(58,4,'Bet Lists - Move Statement History Bet List',N'',N'',N'',N'',N'',N''),
(59,4,'Bet Lists - Risk Analysis IP Matching Bet List',N'',N'',N'',N'',N'',N''),
(60,4,'Bet Lists - Bet Type And Match',N'',N'',N'',N'',N'',N''),

(74,4,'Bet Lists - Daily Statement',N'',N'',N'',N'',N'',N''),
(75,4,'Bet Lists - Casino Details',N'',N'',N'',N'',N'',N''),

(61,4,'Bets & Forecast - Soccer',N'',N'',N'',N'',N'',N''),
(62,4,'Bets & Forecast - Handicap/OU/Live - Total Bets',N'',N'',N'',N'',N'',N''),
(63,4,'Bets & Forecast - Handicap/OU/Live - Forecast',N'',N'',N'',N'',N'',N''),
(64,4,'Bets & Forecast - Money Line',N'',N'',N'',N'',N'',N''),
(65,4,'Bets & Forecast - Odd/Even + 1x2 + DND',N'',N'',N'',N'',N'',N''),
(66,4,'Bets & Forecast - FT & HT Total Goal',N'',N'',N'',N'',N'',N''),
(67,4,'Bets & Forecast - Outright',N'',N'',N'',N'',N'',N''),
(68,4,'Bets & Forecast - HT/FT',N'',N'',N'',N'',N'',N''),
(69,4,'Bets & Forecast - FT & HT FG/LG',N'',N'',N'',N'',N'',N''),
(70,4,'Bets & Forecast - Home/Draw/Away No Bet',N'',N'',N'',N'',N'',N''),
(71,4,'Bets & Forecast - Number Game',N'',N'',N'',N'',N'',N''),
(72,4,'Bets & Forecast - 1X2',N'',N'',N'',N'',N'',N''),
(73,4,'Bets & Forecast - Score Map',N'',N'',N'',N'',N'',N'');

SET IDENTITY_INSERT dbo.Age_FeedbackFunc OFF;

DBCC CHECKIDENT ('Age_FeedbackFunc', RESEED, 75);

select * from Age_FeedbackFunc;
