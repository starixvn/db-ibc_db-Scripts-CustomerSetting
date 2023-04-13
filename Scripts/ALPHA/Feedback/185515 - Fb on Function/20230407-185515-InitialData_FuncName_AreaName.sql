/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: 20230407@Tacy
	Task : Init data into Age_FeedbackFunc & Age_FeedbackArea
		https://nexdev.net/issues/185515
	DB: DBBOT.bodb_ChatBot 
*/

USE [bodb_ChatBot]
GO

DECLARE @FuncID INT

INSERT INTO Age_FeedbackFunc (Type,FuncNameEN,FuncNameCN3,FuncNameCH,FuncNameCS,FuncNameTH,FuncNameJP,FuncNameKO)
SELECT 1,'Search & Copy (new version)','Search & Copy (new version)','Search & Copy (new version)','Search & Copy (new version)','Search & Copy (new version)','Search & Copy (new version)','Search & Copy (new version)'

SELECT @FuncID=@@IDENTITY

INSERT INTO Age_FeedbackArea (FuncID,AreaNameEN,AreaNameCN3,AreaNameCH,AreaNameCS,AreaNameTH,AreaNameJP,AreaNameKO)
SELECT @FuncID,'Select no.of accounts','Select no.of accounts','Select no.of accounts','Select no.of accounts','Select no.of accounts','Select no.of accounts','Select no.of accounts'
UNION ALL 
SELECT @FuncID,'Copy account after creation','Copy account after creation','Copy account after creation','Copy account after creation','Copy account after creation','Copy account after creation','Copy account after creation'
UNION ALL 
SELECT @FuncID,'Choose first available username','Choose first available username','Choose first available username','Choose first available username','Choose first available username','Choose first available username','Choose first available username'
UNION ALL 
SELECT @FuncID,'Input given credit','Input given credit','Input given credit','Input given credit','Input given credit','Input given credit','Input given credit'