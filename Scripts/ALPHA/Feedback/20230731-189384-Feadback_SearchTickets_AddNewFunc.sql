﻿/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: 20230731@Tacy
	Task : Add new Age_FeedbackFunc
		https://nexdev.net/issues/189384
	DB: DBBOT.bodb_ChatBot 
*/
USE [bodb_ChatBot]
GO

INSERT INTO Age_FeedbackFunc (Type,FuncNameEN,FuncNameCN3,FuncNameCS,FuncNameCH,FuncNameTH,FuncNameJP,FuncNameKO)
SELECT 2,'Search Tickets',N'Search Tickets',N'Search Tickets',N'Search Tickets',N'ค้นหาตั๋วเดิมพัน',N'Search Tickets',N'Search Tickets'
GO
