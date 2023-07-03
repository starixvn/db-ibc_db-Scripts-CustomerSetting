﻿/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: 20230703@Tacy
	Task : Update function name
		https://nexdev.net/issues/185308
	DB: DBBOT.bodb_ChatBot 
*/
USE [bodb_ChatBot]
GO

UPDATE Age_FeedbackFunc WITH (ROWLOCK, UPDLOCK)
SET	 FuncNameEN=N'Win Loss Detail Report'
	,FuncNameCN3=N'Báo Cáo Chi Tiết Thắng Thua'
	,FuncNameCS=N'输赢细节报告'
	,FuncNameCH=N'輸贏細節報告'
	,FuncNameTH=N'รายงานรายละเอียดการแพ้ชนะ'
	,FuncNameJP=N'Win Loss Detail Report'
	,FuncNameKO=N'Win Loss Detail Report'
WHERE FuncNameEN=N'Win Loss Report'
GO