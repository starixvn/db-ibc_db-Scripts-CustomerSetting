/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: 20240531@Tacy
	Task : Init data into Age_FeedbackFunc
		https://nexdev.net/issues/204089
	DB: DBBOT.bodb_ChatBot 
*/

USE [bodb_ChatBot]
GO

INSERT INTO Age_FeedbackFunc (Type,FuncNameEN,FuncNameCN3,FuncNameCS,FuncNameCH,FuncNameTH,FuncNameJP,FuncNameKO)
SELECT 2,'Member Betting Behavior',N'Hành Vi Đặt Cược Member',N'会员投注模式',N'會員投注模式',N'พฤติกรรมการเดิมพันของสมาชิก',N'Member Betting Behavior',N'Member Betting Behavior'
GO