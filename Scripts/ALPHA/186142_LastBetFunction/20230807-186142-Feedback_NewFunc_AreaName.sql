/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: 20230807@Tacy
	Task : Init data into Age_FeedbackFunc & Age_FeedbackArea
		https://nexdev.net/issues/186142
	DB: DBBOT.bodb_ChatBot 
*/

USE [bodb_ChatBot]
GO

DECLARE @FuncID INT

INSERT INTO Age_FeedbackFunc (Type,FuncNameEN,FuncNameCN3,FuncNameCH,FuncNameCS,FuncNameTH,FuncNameJP,FuncNameKO)
SELECT 1,'Last Bets (new view)',N'Last Bets (new view)',N'Last Bets (new view)',N'Last Bets (new view)',N'Last Bets (new view)',N'Last Bets (new view)',N'Last Bets (new view)'

SELECT @FuncID=@@IDENTITY

INSERT INTO Age_FeedbackArea (FuncID,AreaNameEN,AreaNameCN3,AreaNameCH,AreaNameCS,AreaNameTH,AreaNameJP,AreaNameKO)
SELECT @FuncID,'Monitoring Page',N'Monitoring Page',N'Monitoring Page',N'Monitoring Page',N'Monitoring Page',N'Monitoring Page',N'Monitoring Page'
UNION ALL 
SELECT @FuncID,'Filter Management',N'Filter Management',N'Filter Management',N'Filter Management',N'Filter Management',N'Filter Management',N'Filter Management'
UNION ALL 
SELECT @FuncID,'Filter Configuration',N'Filter Configuration',N'Filter Configuration',N'Filter Configuration',N'Filter Configuration',N'Filter Configuration',N'Filter Configuration'