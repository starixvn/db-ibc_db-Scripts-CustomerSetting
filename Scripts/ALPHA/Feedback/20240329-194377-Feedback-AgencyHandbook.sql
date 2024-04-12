/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: 20240329@Tacy
	Task : Init data into Age_FeedbackFunc
		https://nexdev.net/issues/194377
	DB: DBBOT.bodb_ChatBot 
*/

USE [bodb_ChatBot]
GO

INSERT INTO Age_FeedbackFunc (Type,FuncNameEN,FuncNameCN3,FuncNameCS,FuncNameCH,FuncNameTH,FuncNameJP,FuncNameKO)
SELECT 2,'Agency Handbook',N'Sổ Tay Đại Lý',N'代理手册',N'代理手冊',N'คู่มือเอเย่นต์',N'Agency Handbook',N'Agency Handbook'
GO