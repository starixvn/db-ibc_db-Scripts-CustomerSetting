﻿﻿/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: 20230810@Tacy
	Task : Update function name
		https://nexdev.net/issues/189384
	DB: DBBOT.bodb_ChatBot 
*/
USE [bodb_ChatBot]
GO

UPDATE Age_FeedbackFunc WITH (ROWLOCK, UPDLOCK)
SET	 FuncNameCS=N'搜索注单'
	,FuncNameCH=N'搜索注單'
	,FuncNameCN3=N'Tìm Vé Cược'
WHERE FuncNameEN=N'Search Tickets'
GO