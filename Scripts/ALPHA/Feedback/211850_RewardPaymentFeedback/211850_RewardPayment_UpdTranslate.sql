﻿/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: 20241010@Virgil
	Task : Update Reward Payment Feedback translate [Redmine: #209190]
	DB: DBBOT.bodb_ChatBot 
*/

USE [bodb_ChatBot]
GO

UPDATE Age_FeedbackFunc WITH (ROWLOCK, UPDLOCK)
SET	FuncNameCH = N'獎金支付'
	,FuncNameCS = N'奖金支付'
	,FuncNameTH = N'การจ่ายเงินรางวัล'
WHERE FuncNameEN = N'Reward Payment'

UPDATE Age_FeedbackFunc WITH (ROWLOCK, UPDLOCK)
SET	FuncNameCH = N'奖金詳情'
	,FuncNameCS = N'奖金详情'
	,FuncNameTH = N'รายละเอียดเงินรางวัล'
WHERE FuncNameEN = N'Reward Detail'
