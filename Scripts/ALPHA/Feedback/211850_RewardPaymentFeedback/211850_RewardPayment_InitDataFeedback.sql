/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: 20241004@Virgil
	Task : Init data Reward Payment Feedback [Redmine: #209190]
	DB: DBBOT.bodb_ChatBot 
*/

USE [bodb_ChatBot]
GO

INSERT INTO Age_FeedbackFunc (Type, FuncNameEN, FuncNameCN3, FuncNameCH, FuncNameCS, FuncNameTH, FuncNameJP, FuncNameKO)
SELECT 2,'Reward Payment','Reward Payment','Reward Payment','Reward Payment','Reward Payment','Reward Payment','Reward Payment'
UNION 
SELECT 2,'Reward Detail','Reward Detail','Reward Detail','Reward Detail','Reward Detail','Reward Detail','Reward Detail'


