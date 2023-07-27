/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: 20230913@Johnson
	Task : Init data into Age_FeedbackFunc for LiteMode creation downlines		
	DB: DBBOT.bodb_ChatBot 
*/

USE [bodb_ChatBot]
GO
UPDATE Age_FeedbackFunc WITH(ROWLOCK)
SET FuncNameTH = N'โหมด Lite'
WHERE FuncNameEN = 'Lite Mode'

/*
INSERT INTO Age_FeedbackFunc (Type,FuncNameEN,FuncNameCN3,FuncNameCH,FuncNameCS,FuncNameTH,FuncNameJP,FuncNameKO)
SELECT 2,'Lite Mode',N'Thiết Lập Rút Gọn',N'Lite Mode',N'Lite Mode',N'Lite Mode',N'Lite Mode',N'Lite Mode'	
UNION ALL SELECT 2,'Position Taking (%) Template',N'Position Taking (%) Template',N'Position Taking (%) Template',N'Position Taking (%) Template',N'Position Taking (%) Template',N'Position Taking (%) Template',N'Position Taking (%) Template'	


UPDATE Age_FeedbackFunc WITH(ROWLOCK)
SET FuncNameCN3 = N'Thiết Lập Rút Gọn'
WHERE FuncNameEN = 'Lite Mode'
*/

/*
UPDATE Age_FeedbackFunc WITH(ROWLOCK)
SET FuncNameCS = N'精简模式',
	FuncNameCH = N'精簡模式'
WHERE FuncNameEN = 'Lite Mode'

UPDATE Age_FeedbackFunc WITH(ROWLOCK)
SET FuncNameEN = 'Position Taking Template',
	FuncNameCN3 = N'Mẫu Position Taking',
	FuncNameCH = N'佔成數模板',
	FuncNameCS = N'占成数模板',
	FuncNameTH = N'เทมเพลตค่าแบ่งสู้',
	FuncNameJP = N'Position Taking Template',
	FuncNameKO = N'Position Taking Template'
WHERE FuncNameEN = 'Position Taking (%) Template'
*/