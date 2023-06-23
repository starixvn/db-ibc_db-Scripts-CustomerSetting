/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: 20230623@Tacy
	Task : Add new Age_FeedbackFunc
		https://nexdev.net/issues/185308
	DB: DBBOT.bodb_ChatBot 
*/
/*
	- Type: 1 ~ fb control 1
			2 ~ fb control 2
	(https://nexdev.net/issues/185515)
*/

USE [bodb_ChatBot]
GO

INSERT INTO Age_FeedbackFunc (Type,FuncNameEN,FuncNameCN3,FuncNameCS,FuncNameCH,FuncNameTH,FuncNameJP,FuncNameKO)
SELECT 2,'Win Loss Report',N'Báo Cáo Thắng Thua',N'输赢报告',N'輸贏報告',N'รายงานยอดได้เสีย',N'Win Loss Report',N'Win Loss Report'
GO