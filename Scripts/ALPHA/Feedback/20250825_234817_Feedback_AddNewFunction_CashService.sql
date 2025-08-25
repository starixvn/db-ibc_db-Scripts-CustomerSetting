/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created by: 20250825@Elodie
	Task: Alpha - Implement compact feedback [RedmineID: #234817]
	DB: DBBOT.bodb_ChatBot
*/
USE bodb_ChatBot
GO

DELETE FROM dbo.Age_FeedbackFunc WHERE FuncID IN (41);

SET IDENTITY_INSERT dbo.Age_FeedbackFunc ON;

INSERT INTO dbo.Age_FeedbackFunc (FuncID,Type,FuncNameEN,FuncNameCN3,FuncNameCS,FuncNameCH,FuncNameTH,FuncNameJP,FuncNameKO)
VALUES
(41,2,'New Cash Member',N'New Cash Member',N'新现金用户',N'新現金用戶',N'สมาชิกเงินสดใหม',N'新規現金会員',N'신규 현금 회원');

SET IDENTITY_INSERT dbo.Age_FeedbackFunc OFF;

DBCC CHECKIDENT ('Age_FeedbackFunc', RESEED, 41);

select * from Age_FeedbackFunc;
